From: Johan Herland <johan@herland.net>
Subject: [RFCv3 1/4] Basic build infrastructure for Python scripts
Date: Wed, 12 Aug 2009 02:13:48 +0200
Message-ID: <1250036031-32272-2-git-send-email-johan@herland.net>
References: <1250036031-32272-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 02:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb1U7-00078w-C4
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 02:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbZHLAOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 20:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbZHLAOJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 20:14:09 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58225 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754232AbZHLAOH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 20:14:07 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO8009AZLZK5X60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 12 Aug 2009 02:14:08 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO8000BCLZHU410@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 12 Aug 2009 02:14:08 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.12.47
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1250036031-32272-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125627>

This patch adds basic boilerplate support (based on corresponding Perl
sections) for enabling the building and installation Python scripts.

There are currently no Python scripts being built, and when Python
scripts are added in future patches, their building and installation
can be disabled by defining NO_PYTHON.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Makefile      |   13 +++++++++++++
 configure.ac  |    3 +++
 t/test-lib.sh |    1 +
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 189aee5..969cef5 100644
--- a/Makefile
+++ b/Makefile
@@ -166,6 +166,8 @@ all::
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
+# Define NO_PYTHON if you do not want Python scripts or libraries at all.
+#
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
 # The TCL_PATH variable governs the location of the Tcl interpreter
@@ -311,6 +313,7 @@ LIB_H =
 LIB_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
+SCRIPT_PYTHON =
 SCRIPT_SH =
 TEST_PROGRAMS =
 
@@ -349,6 +352,7 @@ SCRIPT_PERL += git-svn.perl
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
+	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-instaweb
 
 # Empty...
@@ -404,8 +408,12 @@ endif
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
+ifndef PYTHON_PATH
+	PYTHON_PATH = /usr/bin/python
+endif
 
 export PERL_PATH
+export PYTHON_PATH
 
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
@@ -1259,6 +1267,10 @@ ifeq ($(PERL_PATH),)
 NO_PERL=NoThanks
 endif
 
+ifeq ($(PYTHON_PATH),)
+NO_PYTHON=NoThanks
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -1306,6 +1318,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
diff --git a/configure.ac b/configure.ac
index 3f1922d..3749e5c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -241,6 +241,9 @@ GIT_ARG_SET_PATH(shell)
 # Define PERL_PATH to provide path to Perl.
 GIT_ARG_SET_PATH(perl)
 #
+# Define PYTHON_PATH to provide path to Python.
+GIT_ARG_SET_PATH(python)
+#
 # Define ZLIB_PATH to provide path to zlib.
 GIT_ARG_SET_PATH(zlib)
 #
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a5b8d03..01ea386 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -714,6 +714,7 @@ case $(uname -s) in
 esac
 
 test -z "$NO_PERL" && test_set_prereq PERL
+test -z "$NO_PYTHON" && test_set_prereq PYTHON
 
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
-- 
1.6.4.rc3.138.ga6b98.dirty
