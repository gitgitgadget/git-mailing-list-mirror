Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB06C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2841A206D4
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 14:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDDO6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:58:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:33482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725837AbgDDO6a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 10:58:30 -0400
Received: (qmail 5371 invoked by uid 109); 4 Apr 2020 14:58:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 Apr 2020 14:58:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29670 invoked by uid 111); 4 Apr 2020 15:08:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Apr 2020 11:08:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Apr 2020 10:58:29 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] Makefile: avoid running curl-config unnecessarily
Message-ID: <20200404145829.GB679473@coredump.intra.peff.net>
References: <20200326080540.GA2200522@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2004041535360.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2004041535360.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 04, 2020 at 03:38:00PM +0200, Johannes Schindelin wrote:

> >   [1/2]: Makefile: avoid running curl-config multiple times
> >   [2/2]: Makefile: use curl-config --cflags
> 
> I _suspect_ that this is responsible for the build failure
> 
> 	make: curl-config: Command not found
> 
> at https://github.com/git/git/runs/556459415#step:4:674
> 
> Do we need this to fix this?

Hmm, yeah. It's an unfortunate side effect of the ":=" assignment to
stop repeatedly invoking curl-config. Now it's only invoked once, but
it's _always_ once, even if we're not building anything that needs it.

I wonder if there's a way to expand a Makefile variable lazily, but only
once...aha, with some help from the Internet, I came up with the patch
below.

> -- snip --
> diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> index de41888430a..325b4cc6185 100755
> --- a/ci/test-documentation.sh
> +++ b/ci/test-documentation.sh
> @@ -11,6 +11,7 @@ filter_log () {
>  	    -e '/^    \* new asciidoc flags$/d' \
>  	    -e '/stripped namespace before processing/d' \
>  	    -e '/Attributed.*IDs for element/d' \
> +	    -e '/curl-config: Command not found/d' \
>  	    "$1"
>  }

Yes, this works, but it's rather unfortunate that we're invoking
curl-config when it's not needed. Perhaps using NO_CURL in the
documentation job would be better. But if the patch below isn't too
disgusting, I think I prefer that approach (because it helps _any_
top-level make invocation that isn't actually building http binaries).

Junio, you may want to hold off on moving jk/build-with-right-curl to
next until we resolve this one way or the other.

-- >8 --
Subject: [PATCH] Makefile: avoid running curl-config unnecessarily

Commit 94a88e2524 (Makefile: avoid running curl-config multiple times,
2020-03-26) put the call to $(CURL_CONFIG) into a "simple" variable
which is expanded immediately, rather than expanding it each time it's
needed. However, that also means that we expand it whenever the Makefile
is parsed, whether we need it or not.

This is wasteful, but also breaks the ci/test-documentation.sh job, as
it does not have curl at all and complains about the extra messages to
stderr. An easy way to see it is just:

  $ make CURL_CONFIG=does-not-work check-builtins
  make: does-not-work: Command not found
  make: does-not-work: Command not found
  GIT_VERSION = 2.26.0.108.gb3f3f45f29
  make: does-not-work: Command not found
  make: does-not-work: Command not found
  ./check-builtins.sh

We can get the best of both worlds if we're willing to accept a little
Makefile hackery. Courtesy of the article at:

  http://make.mad-scientist.net/deferred-simple-variable-expansion/

this patch uses a lazily-evaluated recursive variable which replaces its
contents with an immediately assigned simple one on first use.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
This is our first use of eval in the Makefile, but that goes back to GNU
make v3.80, which is from 2002. I think that should be OK.

If this inlining is too gross, we could probably contain it in a
function where callers would do something like:

  $(eval lazy-shell-var, CURL_LDFLAGS, $(CURL_CONFIG) --libs)

That's better in the sense that there's less gobbledygook at each
callsite, but worse in that it obscures the fact that it's a variable
assignment. I'd probably consider going that direction if we started
growing more use-cases than these two.

We could probably also stuff this into a sh
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5099f6a8f8..97dbdcd201 100644
--- a/Makefile
+++ b/Makefile
@@ -1366,12 +1366,12 @@ else
 	endif
 
 	ifndef CURL_LDFLAGS
-		CURL_LDFLAGS := $(shell $(CURL_CONFIG) --libs)
+		CURL_LDFLAGS = $(eval CURL_LDFLAGS := $$(shell $$(CURL_CONFIG) --libs))$(CURL_LDFLAGS)
 	endif
 	CURL_LIBCURL += $(CURL_LDFLAGS)
 
 	ifndef CURL_CFLAGS
-		CURL_CFLAGS := $(shell $(CURL_CONFIG) --cflags)
+		CURL_CFLAGS = $(eval CURL_CFLAGS := $$(shell $$(CURL_CONFIG) --cflags))$(CURL_CFLAGS)
 	endif
 	BASIC_CFLAGS += $(CURL_CFLAGS)
 
-- 
2.26.0.410.gc279fb3cbd

