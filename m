X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH] move Git.pm build instructions into perl/Makefile
Date: Tue, 21 Nov 2006 23:59:11 +0100
Message-ID: <20061121225911.GA24201@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 22:59:43 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: Gv6gdvZTQeVmYkZvCEXfCxI-dkmydJynWHEQRBv7Gc-uBuTVzpvAYQ
X-TOI-MSGID: d598f2d8-613b-467c-a550-1e55f0abe333
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32053>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmeaT-0007mp-Pa for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031301AbWKUW72 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031362AbWKUW72
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:59:28 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:36024 "EHLO
 mailout03.sul.t-online.com") by vger.kernel.org with ESMTP id
 S1031301AbWKUW71 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006
 17:59:27 -0500
Received: from fwd30.aul.t-online.de  by mailout03.sul.t-online.com with smtp
  id 1GmeaH-0004sG-04; Tue, 21 Nov 2006 23:59:21 +0100
Received: from tigra.home
 (Gv6gdvZTQeVmYkZvCEXfCxI-dkmydJynWHEQRBv7Gc-uBuTVzpvAYQ@[84.163.106.68]) by
 fwd30.sul.t-online.de with esmtp id 1Gmea9-0jOAW80; Tue, 21 Nov 2006 23:59:13
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 30F73277AF; Tue, 21 Nov 2006 23:59:13 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1Gmea7-0006IU-Dv; Tue, 21 Nov 2006 23:59:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

...so that I can disable MakeMaker stuff as soon as I get to work,
which is the only windows+cygwin+activestate system available to me.
Alas, it is also the system where I use git most.
The MakeMaker killing patch should follow.

 Makefile        |   19 +++++++++----------
 perl/.gitignore |    3 ++-
 perl/Makefile   |   23 +++++++++++++++++++++++
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 36ce8cd..c849227 100644
--- a/Makefile
+++ b/Makefile
@@ -592,8 +592,8 @@ export prefix TAR INSTALL DESTDIR SHELL_
 
 all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi
 
-all: perl/Makefile
-	$(MAKE) -C perl
+all:
+	$(MAKE) -C perl PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 	$(MAKE) -C templates
 
 strip: $(PROGRAMS) git$X
@@ -627,7 +627,11 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.
 	chmod +x $@+
 	mv $@+ $@
 
-$(patsubst %.perl,%,$(SCRIPT_PERL)): perl/Makefile
+$(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
+
+perl/perl.mak: GIT-CFLAGS
+	$(MAKE) -C perl PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
+
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	rm -f $@ $@+
 	INSTLIBDIR=`$(MAKE) -C perl -s --no-print-directory instlibdir` && \
@@ -767,10 +771,6 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 	rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
 
-perl/Makefile: perl/Git.pm perl/Makefile.PL GIT-CFLAGS
-	(cd perl && $(PERL_PATH) Makefile.PL \
-		PREFIX='$(prefix_SQ)')
-
 doc:
 	$(MAKE) -C Documentation all
 
@@ -833,7 +833,7 @@ install: all
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) git$X gitk '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
-	$(MAKE) -C perl install
+	$(MAKE) -C perl prefix='$(prefix_SQ)' install
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(GIT_PYTHON_DIR_SQ)'
 	$(INSTALL) $(PYMODULES) '$(DESTDIR_SQ)$(GIT_PYTHON_DIR_SQ)'
 	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
@@ -905,8 +905,7 @@ clean:
 	rm -f $(htmldocs).tar.gz $(manpages).tar.gz
 	rm -f gitweb/gitweb.cgi
 	$(MAKE) -C Documentation/ clean
-	[ ! -f perl/Makefile ] || $(MAKE) -C perl/ clean || $(MAKE) -C perl/ clean
-	rm -f perl/ppport.h perl/Makefile.old
+	$(MAKE) -C perl clean
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 	rm -f GIT-VERSION-FILE GIT-CFLAGS
diff --git a/perl/.gitignore b/perl/.gitignore
index e990cae..98b2477 100644
--- a/perl/.gitignore
+++ b/perl/.gitignore
@@ -1,4 +1,5 @@
-Makefile
+perl.mak
+perl.mak.old
 blib
 blibdirs
 pm_to_blib
diff --git a/perl/Makefile b/perl/Makefile
new file mode 100644
index 0000000..cff24dd
--- /dev/null
+++ b/perl/Makefile
@@ -0,0 +1,23 @@
+#
+# Makefile for perl support modules and routine
+#
+makfile:=perl.mak
+
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+prefix_SQ = $(subst ','\'',$(prefix))
+
+all install instlibdir: $(makfile)
+	$(MAKE) -f $(makfile) $@
+
+clean:
+	test -f $(makfile) && $(MAKE) -f $(makfile) $@ || exit 0
+	$(RM) ppport.h
+	$(RM) $(makfile)
+
+$(makfile): Makefile.PL ../GIT-CFLAGS
+	'$(PERL_PATH_SQ)' $< FIRST_MAKEFILE='$@' PREFIX='$(prefix_SQ)'
+
+# this is just added comfort for calling make directly in perl dir
+# (even though GIT-CFLAGS aren't used yet. If ever)
+../GIT-CFLAGS:
+	$(MAKE) -C .. GIT-CFLAGS
-- 
