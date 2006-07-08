From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Replace sed with perl when setting up perl scripts.
Date: Sat, 8 Jul 2006 15:37:17 -0400
Message-ID: <20060708193717.GA17905@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 21:37:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzIcP-0002xL-Qw
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 21:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWGHThb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 15:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWGHThb
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 15:37:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42404 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030269AbWGHTha (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 15:37:30 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FzIc7-0004fZ-Mm; Sat, 08 Jul 2006 15:37:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 36FD020E482; Sat,  8 Jul 2006 15:37:17 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23501>

next appears to be broken on MacOS X:

  INSTLIBDIR=`make -C perl -s --no-print-directory instlibdir` && \
  sed -e '1s|#!.*perl|#!/usr/bin/perl|1' \
      -e '2i\
          use lib (split(/:/, $ENV{GITPERLLIB} || '\'"$INSTLIBDIR"\''));' \
      -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
      -e 's/@@GIT_VERSION@@/1.4.1.g659a/g' \
      git-archimport.perl >git-archimport+
  sed: 1: "2i use lib (split(/:/,  ...": command i expects \ followed by text
  make: *** [git-archimport] Error 1

I just spent half an hour messing around with the relevant Makefile
rule to try and get sed to be happy with this and I can't find the
magic necessary.  So I ported the sed to perl.  :-)

-->>-
Replace sed with perl when setting up perl scripts.

The sed magic to insert 'use lib' at the start of all
GIT Perl scripts wasn't working correctly on Mac OS X.
Replacing the sed invocations with perl invocations is
much more portable.

The replacement also has no negative impact on the build
as GIT cannot be compiled without the Git perl module,
which implies that perl is available and works.
---
 Makefile |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 8d429a0..e83d298 100644
--- a/Makefile
+++ b/Makefile
@@ -557,11 +557,12 @@ common-cmds.h: Documentation/git-*.txt
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	rm -f $@ $@+
 	INSTLIBDIR=`$(MAKE) -C perl -s --no-print-directory instlibdir` && \
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|1' \
-	    -e '2i\
-	        use lib (split(/:/, $$ENV{GITPERLLIB} || '\'"$$INSTLIBDIR"\''));' \
-	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	$(PERL_PATH) -e '$$_=<>;print q{#!$(PERL_PATH_SQ)},qq{\n};' \
+	    -e 'print q{use lib (split(/:/, $$ENV{GITPERLLIB} || '\'"$$INSTLIBDIR"\''));},qq{\n};' \
+	    -e 'while(<>){' \
+	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g;' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g;' \
+	    -e 'print;}' \
 	    $@.perl >$@+
 	chmod +x $@+
 	mv $@+ $@
-- 
1.4.1.gc48f
