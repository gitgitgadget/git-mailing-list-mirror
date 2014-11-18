From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t0090: mark add-interactive test with PERL prerequisite
Date: Tue, 18 Nov 2014 10:38:38 -0800
Message-ID: <20141118183838.GD6527@google.com>
References: <20141118172231.GA16387@peff.net>
 <20141118174309.GB31672@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:38:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqnfn-0006OK-Va
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbaKRSij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 13:38:39 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36754 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbaKRSih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:38:37 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so7848975ier.14
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 10:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bPZUPSoElbwcD3qsRF7+foqOF7dN8Yg0VAWpydSUUUs=;
        b=L4WPap4L1TcAlN0p8/Q8ZgB8pTAXTa7xdoVihp2SZxQvICfKnURmjNBSCvu1QwScXz
         1zA6OKptiGKunst1Z4WSCsyIggnMdlKz+/VCT/P5p3ceUhvfKSw6mfBXzbDds0xyGy4f
         y18tbORdpFVTARMjmFiQ05DlXIguUxBRhoeZBDppS7FaUHfbFvbBSlH1utEGPtp9DYRf
         x1oGYTu1yYOYVeZC8sTjI9Cxy6BIOMttJHxu98jf8mMfpZQ8vMUCbLRdKGCtQC/jlmI3
         NHWBwF7DAYMl6ZFJhinNsdoFlo3SQR/JJdLED4nZSnRCAHEg5FW/eDTGnEPKIwfpkQFI
         Ma0Q==
X-Received: by 10.107.12.34 with SMTP id w34mr6076029ioi.3.1416335917124;
        Tue, 18 Nov 2014 10:38:37 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id fy5sm8101732igd.3.2014.11.18.10.38.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 10:38:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118174309.GB31672@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Subject: Makefile: have perl scripts depend on NO_PERL setting
[...]
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)

Gah.  Good catch.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> --- a/Makefile
> +++ b/Makefile
> @@ -1676,6 +1676,9 @@ git.res: git.rc GIT-VERSION-FILE
>  	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>  	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
>  
> +# This makes sure we depend on the NO_PERL setting itself.
> +$(patsubst %.perl,%,$(SCRIPT_PERL)): GIT-BUILD-OPTIONS
> +
>  ifndef NO_PERL
>  $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak

Why do these repeat the 'patsubst ...' expression instead of using
SCRIPT_PERL_GEN, by the way?

-- >8 --
Subject: Makefile: simplify by using SCRIPT_{PERL,SH}_GEN macros

SCRIPT_PERL_GEN is defined as $(patsubst %.perl,%,$(SCRIPT_PERL)) for
use in targets like build-perl-script used by makefiles in
subdirectories that override SCRIPT_PERL (see v1.8.2-rc0~17^2,
"git-remote-mediawiki: use toplevel's Makefile", 2013-02-08).

The same expression is used in the rules that actually write the
generated perl scripts, and since this rules were introduced before
SCRIPT_PERL_GEN, they use the longhand instead of that macro.  Use the
macro to make reading easier.

Likewise for SCRIPT_SH_GEN.  The Python rules already got the same
simplification in v1.8.4-rc0~162^2~8 (2013-05-24).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 0fa02ff..8f980e0 100644
--- a/Makefile
+++ b/Makefile
@@ -1662,7 +1662,7 @@ GIT-SCRIPT-DEFINES: FORCE
             fi
 
 
-$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh GIT-SCRIPT-DEFINES
+$(SCRIPT_SH_GEN) : % : %.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -1677,10 +1677,10 @@ git.res: git.rc GIT-VERSION-FILE
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
 
 # This makes sure we depend on the NO_PERL setting itself.
-$(patsubst %.perl,%,$(SCRIPT_PERL)): GIT-BUILD-OPTIONS
+$(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
 ifndef NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
+$(SCRIPT_PERL_GEN): perl/perl.mak
 
 perl/perl.mak: perl/PM.stamp
 
@@ -1693,7 +1693,7 @@ perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
 PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
-$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
+$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
@@ -1727,7 +1727,7 @@ git-instaweb: git-instaweb.sh gitweb GIT-SCRIPT-DEFINES
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
+$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
-- 
2.1.0.rc2.206.gedb03e5
