From: Lea Wiemann <lewiemann@gmail.com>
Subject: [RFC/PATCH v3] gitweb: respect $GITPERLLIB
Date: Sun, 22 Jun 2008 00:40:38 +0200
Message-ID: <1214088038-8408-1-git-send-email-LeWiemann@gmail.com>
References: <7vabhfazok.fsf@gitster.siamese.dyndns.org>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 00:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KABm6-0001hg-BY
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 00:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbYFUWkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 18:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbYFUWkn
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 18:40:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:44773 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbYFUWkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 18:40:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so885068fgg.17
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=Q/CYPOFKGoUeJfw4dOWDnBbfsqXPeA7OH5GP6NMTSE8=;
        b=sQBF+fHK2ULhni44zffSBTtqdFq8oesL5VowNV6ygJlsGgii5tjxhDlssLuGb8LVeK
         viI7O0rkxud/8VXunrQY9Yvkjv7ZbB5sEO7PXrX6MfssC1MelKueB7QazUW4feuqsUGH
         jo16w8kuFxRlF9VOqRqbOJGwY/mEruPPD665M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=Mm0/5jLww0A0VlsCB5kGYU1ZMcrhAtM1xx+M1TptVyq2uDuVxyvReZVobxFEgAVwmG
         XipcWsqe5a1558/Azgtylnub5pnk0LuFU0WjInJu6v0VKIqK4+4SHT2kxAmR09WN2Lsj
         V/n5hSisnYH60NCdx0uHHigjMRT5YLJDiXEEc=
Received: by 10.86.52.6 with SMTP id z6mr6049549fgz.48.1214088041259;
        Sat, 21 Jun 2008 15:40:41 -0700 (PDT)
Received: from fly ( [91.33.251.200])
        by mx.google.com with ESMTPS id 12sm7036334fgg.0.2008.06.21.15.40.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Jun 2008 15:40:40 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KABl8-0002Bz-9k; Sun, 22 Jun 2008 00:40:38 +0200
X-Mailer: git-send-email 1.5.6.86.g8dde5d
In-Reply-To: <7vabhfazok.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85737>

gitweb/gitweb.cgi now respects $GITPERLLIB, like the Perl-based Git
commands.

This patch is not for inclusion, it'll be squashed with a larger
commit.
---
Junio C Hamano wrote:
> This part seems to duplicate quite a bit of sed insn used elsewhere, and
> we may want to factor the common part out, perhaps like this...

Thanks!  This needs some tender loving quoting though; diff to your
version:

   diff --git a/Makefile b/Makefile
   index e6fd8ac..92a802f 100644
   --- a/Makefile
   +++ b/Makefile
   @@ -1065,13 +1065,13 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
    perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
    	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
    PERL_USE_LIB_REWRITE = \
    	-e '1{' \
   -	-e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
   +	-e '	s|\#!.*perl|\#!$(PERL_PATH_SQ)|' \
    	-e '	h' \
   -	-e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
   +	-e '	s=.*=use lib (split(/:/, \$$ENV{GITPERLLIB} || \"@@INSTLIBDIR@@\"));=' \
    	-e '	H' \
    	-e '	x' \
    	-e '}' \
    	-e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
    	-e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g'

I wonder though if that's too brittle or unmaintainable and we should
rather use the explicit version in v2 (even if it duplicated code);
I'd prefer v2 off the top of my head.

Also, note that I really only did trial-and-error quoting here. ;-)

-- Lea

 Makefile |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index fda9133..92a802f 100644
--- a/Makefile
+++ b/Makefile
@@ -1065,25 +1065,28 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
+PERL_USE_LIB_REWRITE = \
+	-e '1{' \
+	-e '	s|\#!.*perl|\#!$(PERL_PATH_SQ)|' \
+	-e '	h' \
+	-e '	s=.*=use lib (split(/:/, \$$ENV{GITPERLLIB} || \"@@INSTLIBDIR@@\"));=' \
+	-e '	H' \
+	-e '	x' \
+	-e '}' \
+	-e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
+	-e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g'
+
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
-	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	h' \
-	    -e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
-	    -e '	H' \
-	    -e '	x' \
-	    -e '}' \
-	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@+ && \
+	sed $(PERL_USE_LIB_REWRITE) $@.perl >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	sed $(PERL_USE_LIB_REWRITE) \
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
 	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
-- 
1.5.6.85.g0a2e.dirty
