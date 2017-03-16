Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D7420951
	for <e@80x24.org>; Thu, 16 Mar 2017 11:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdCPLY4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 07:24:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:45058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751353AbdCPLYz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 07:24:55 -0400
Received: (qmail 25478 invoked by uid 109); 16 Mar 2017 11:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 11:24:50 +0000
Received: (qmail 24368 invoked by uid 111); 16 Mar 2017 11:25:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 07:25:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 07:24:47 -0400
Date:   Thu, 16 Mar 2017 07:24:47 -0400
From:   Jeff King <peff@peff.net>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: escape ' in bin-wrappers rule
Message-ID: <20170316112447.meosrjddumkjrfiu@sigill.intra.peff.net>
References: <20170316061738.26760-1-lehmacdj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316061738.26760-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 02:17:38AM -0400, Devin Lehmacher wrote:

> If the pwd contains a ' escape it as '\'' so that git will not fail
> while building on a path containing '.

I think this only fixes half the problem...

> diff --git a/Makefile b/Makefile
> index ed68700ac..5cf5d8537 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2276,7 +2276,7 @@ all:: $(NO_INSTALL)
>  bin-wrappers/%: wrap-for-bin.sh
>  	@mkdir -p bin-wrappers
>  	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> -	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
> +	     -e 's|@@BUILD_DIR@@|$(shell pwd | sed -e "s/'/'\\\''/g")|' \

This escapes the single-quote against the shell run by make. But it does
a blind text substitution inside the wrap-for-bin script itself, which
means it's subject to another round of expansion. E.g.:

  $ git clone git foo\'git
  $ cd foo\'git
  $ make bin-wrappers/git
  GIT_VERSION = 2.12.0.623.g86ec6c963
  /bin/sh: 4: Syntax error: Unterminated quoted string
  Makefile:2296: recipe for target 'bin-wrappers/git' failed
  make: *** [bin-wrappers/git] Error 2

  $ git am /your/patch
  $ make bin-wrappers/git
  GIT_VERSION = 2.12.0.624.gc9787fbf0
      GEN bin-wrappers/git
  $ bin-wrappers/git
  bin-wrappers/git: 16: bin-wrappers/git: Syntax error: "fi" unexpected

So you'd need an extra layer of quoting. And then to top it all off,
passing backslashes through sed requires _another_ layer of quoting.
Something like this:

diff --git a/Makefile b/Makefile
index 17e381f0c..9c1357a77 100644
--- a/Makefile
+++ b/Makefile
@@ -2292,10 +2292,15 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 all:: $(NO_INSTALL)
 
+PWD = $(shell pwd)
+PWD_SQ = $(subst ','\'',$(PWD))
+PWD_SQ_SED = $(subst \,\\,$(PWD_SQ))
+PWD_SQ_SED_SQ = $(subst ','\'',$(PWD_SQ_SED))
+
 bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
+	     -e 's|@@BUILD_DIR@@|$(PWD_SQ_SED_SQ)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< > $@ && \
 	chmod +x $@
 

That at least gets me as far as building a runnable git. I wouldn't be
surprised if there are other gotchas, though. Running "make test" dies
in t0060 due to similar substitutions.

I guess if somebody is really determined they can try to fix every spot.
But at some point I wonder if the answer is "if it hurts, don't do it".

-Peff
