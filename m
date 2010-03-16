From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 04/15] diff-export.patch
Date: Tue, 16 Mar 2010 05:42:24 +0000
Message-ID: <20100316054316.503338000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPjL-00038F-AY
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991Ab0CPFx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:26 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:64525 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757623Ab0CPFw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:58 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 987475CCB
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:02:38 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 987475CCB
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id A3845DE5;
	Tue, 16 Mar 2010 05:43:16 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 9AFA611D4D5; Tue, 16 Mar 2010 05:43:16 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=diff-export.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142312>

Some of the flags used with the first diff found in PATH cause the
vendor diff to choke.
---
 Documentation/install-webdoc.sh |    2 +-
 Makefile                        |    4 +++-
 config.mak.in                   |    1 +
 configure.ac                    |    1 +
 git-merge-one-file.sh           |    2 +-
 t/Makefile                      |    1 +
 6 files changed, 8 insertions(+), 3 deletions(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -280,6 +280,7 @@ export prefix bindir sharedir sysconfdir
 CC = gcc
 AR = ar
 RM = rm -f
+DIFF = diff
 TAR = tar
 FIND = find
 INSTALL = install
@@ -1408,7 +1409,7 @@ endif
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
-export TAR INSTALL DESTDIR SHELL_PATH
+export DIFF TAR INSTALL DESTDIR SHELL_PATH
 
 
 ### Build rules
@@ -1698,6 +1699,7 @@ GIT-CFLAGS: FORCE
 GIT-BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@
+	@echo DIFF=\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
Index: b/configure.ac
===================================================================
--- a/configure.ac
+++ b/configure.ac
@@ -342,6 +342,7 @@ fi
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOLS(AR, [gar ar], :)
 AC_CHECK_PROGS(TAR, [gtar tar])
+AC_CHECK_PROGS(DIFF, [gnudiff gdiff diff])
 # TCLTK_PATH will be set to some value if we want Tcl/Tk
 # or will be empty otherwise.
 if test -z "$NO_TCLTK"; then
Index: b/Documentation/install-webdoc.sh
===================================================================
--- a/Documentation/install-webdoc.sh
+++ b/Documentation/install-webdoc.sh
@@ -12,7 +12,7 @@ do
 	then
 		: did not match
 	elif test -f "$T/$h" &&
-	   diff -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
+	   $DIFF -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
 	then
 		:; # up to date
 	else
Index: b/git-merge-one-file.sh
===================================================================
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -107,7 +107,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		# remove lines that are unique to ours.
 		orig=`git-unpack-file $2`
 		sz0=`wc -c <"$orig"`
-		diff -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
+		$DIFF -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
 		sz1=`wc -c <"$orig"`
 
 		# If we do not have enough common material, it is not
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -8,6 +8,7 @@ LDFLAGS = @LDFLAGS@
 CC_LD_DYNPATH = @CC_LD_DYNPATH@
 AR = @AR@
 TAR = @TAR@
+DIFF = @DIFF@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
 TCLTK_PATH = @TCLTK_PATH@
 

-- 
Gary V. Vaughan (gary@thewrittenword.com)
