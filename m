From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: Check for perl script errors with perl -c
Date: Sat, 17 Apr 2010 03:27:21 -0400
Message-ID: <20100417072721.GD10365@coredump.intra.peff.net>
References: <1271471380-17701-1-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 09:28:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O32Ra-0006dX-4i
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 09:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab0DQH1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 03:27:53 -0400
Received: from peff.net ([208.65.91.99]:53565 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826Ab0DQH1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 03:27:52 -0400
Received: (qmail 15184 invoked by uid 107); 17 Apr 2010 07:27:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 03:27:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 03:27:21 -0400
Content-Disposition: inline
In-Reply-To: <1271471380-17701-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145120>

On Fri, Apr 16, 2010 at 08:29:40PM -0600, Matthew Ogilvie wrote:

> I'm not sure anyone will think this is worth including, but I'm
> used to "make" (and the compiler) detecting trivial errors
> in compiled langauges, and was getting annoyed that it wasn't
> doing something similar for perl scripts (especially since in git you
> are really expected to "make" the scripts anyway).

I usually do the same thing in my perl makefiles, so I would find it
useful.

> The whole tradeoff between noise ("{script} syntax OK"), portability
> (PIPESTATUS is a bashism), or really ugly contortions with redirecting
> extra file descriptors (to avoid PIPESTATUS) seems to be the biggest
> downside of the idea behind this patch.

Why do you need to run it through grep? Doesn't:

  echo 'use strict; bogosity' >foo.pl
  perl -wc foo.pl

properly set the exit code? I get:

  $ perl -wc foo.pl
  Bareword "bogosity" not allowed while "strict subs" in use at foo.pl line 1.
  foo.pl had compilation errors.
  $ echo $?
  255

> @@ -1553,6 +1557,14 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
>  	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>  	    $@.perl >$@+ && \
>  	chmod +x $@+ && \
> +	if test x"$(USE_PERL_CHECK)" != x"" ; then \
> +	    '$(PERL_PATH_SQ)' -cw $@+ 2>&1 | grep -v '^$@+ syntax OK$$' 1>&2 ; \
> +	    perlStat="$${PIPESTATUS[0]}" && \
> +	    if test x"$$perlStat" != x"0" ; then \
> +	        echo '"$(PERL_PATH_SQ) -c $@+" failed' 1>&2 ; \
> +	        exit "$$perlStat" ; \
> +	    fi ; \
> +	fi && \
>  	mv $@+ $@

So something like:

diff --git a/Makefile b/Makefile
index 87c90d6..d9b6613 100644
--- a/Makefile
+++ b/Makefile
@@ -1545,6 +1545,10 @@ $(SCRIPT_LIB) : % : %.sh
 ifndef NO_PERL
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 
+ifdef USE_PERL_CHECK
+PERL_CHECK = perl -wc $@+ &&
+endif
+
 perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
@@ -1562,6 +1566,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@+ && \
 	chmod +x $@+ && \
+	$(PERL_CHECK) \
 	mv $@+ $@
 
 

You could even just make it unconditional. I don't know that we have an
official policy, but we usually strive for strict, warnings-free perl.

-Peff
