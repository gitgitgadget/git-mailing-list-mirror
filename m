From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 05/18] Do not use "diff" found on PATH while building and installing
Date: Fri, 14 May 2010 09:31:36 +0000
Message-ID: <20100514093746.689775000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:38:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrLF-0001iG-Sf
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754Ab0ENJhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:37:51 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:51410 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab0ENJhr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:37:47 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 032D35C48
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:54:39 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 032D35C48
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id CE614CA0;
	Fri, 14 May 2010 09:37:46 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id C4F7F11D4D1; Fri, 14 May 2010 09:37:46 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=diff-export.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147063>

Some of the flags used with the first diff found in PATH cause the
vendor diff to choke.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Documentation/install-webdoc.sh |    2 +-
 Makefile                        |    4 +++-
 config.mak.in                   |    1 +
 configure.ac                    |    1 +
 git-merge-one-file.sh           |    2 +-
 5 files changed, 7 insertions(+), 3 deletions(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -287,6 +287,7 @@ export prefix bindir sharedir sysconfdir
 CC = gcc
 AR = ar
 RM = rm -f
+DIFF = diff
 TAR = tar
 FIND = find
 INSTALL = install
@@ -1460,7 +1461,7 @@ endif
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
-export TAR INSTALL DESTDIR SHELL_PATH
+export DIFF TAR INSTALL DESTDIR SHELL_PATH
 
 
 ### Build rules
@@ -1877,6 +1878,7 @@ GIT-CFLAGS: FORCE
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
@@ -362,6 +362,7 @@ fi
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
