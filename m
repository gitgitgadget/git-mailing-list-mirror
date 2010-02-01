From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 1/2] configure: Allow GIT_ARG_SET_PATH to handle --without-PROGRAM
Date: Sun, 31 Jan 2010 21:15:04 -0500
Message-ID: <1264990505-29578-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <1264990505-29578-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 01 03:15:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nblp3-00005P-G2
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 03:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab0BACPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 21:15:13 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:44660 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab0BACPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 21:15:12 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:48750 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Nbloj-0003Yi-Oi; Sun, 31 Jan 2010 21:15:09 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Nbloj-0007hm-MJ; Sun, 31 Jan 2010 21:15:09 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id o112F9r3029618;
	Sun, 31 Jan 2010 21:15:09 -0500
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1264990505-29578-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138573>

Add an optional second argument to both GIT_ARG_SET_PATH and
GIT_CONF_APPEND_PATH such that any value of the second argument will
enable configure to set NO_$PROGRAM in addition to an empty
$PROGRAM_PATH.  This is initially useful for allowing configure to
disable the use of python, as the remote helper code has nothing
leveraging it yet.

The Makefile already recognizes NO_PYTHON, but configure provided no
way to set it appropriately.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 229140e..9eaae7d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,21 +23,32 @@ AC_DEFUN([GIT_CONF_APPEND_LINE],
 # GIT_ARG_SET_PATH(PROGRAM)
 # -------------------------
 # Provide --with-PROGRAM=PATH option to set PATH to PROGRAM
+# Optional second argument allows setting NO_PROGRAM=YesPlease if
+# --without-PROGRAM version used.
 AC_DEFUN([GIT_ARG_SET_PATH],
 [AC_ARG_WITH([$1],
  [AS_HELP_STRING([--with-$1=PATH],
                  [provide PATH to $1])],
- [GIT_CONF_APPEND_PATH($1)],[])
+ [GIT_CONF_APPEND_PATH($1,$2)],[])
 ])# GIT_ARG_SET_PATH
 #
 # GIT_CONF_APPEND_PATH(PROGRAM)
 # ------------------------------
 # Parse --with-PROGRAM=PATH option to set PROGRAM_PATH=PATH
 # Used by GIT_ARG_SET_PATH(PROGRAM)
+# Optional second argument allows setting NO_PROGRAM=YesPlease if
+# --without-PROGRAM is used.
 AC_DEFUN([GIT_CONF_APPEND_PATH],
 [PROGRAM=m4_toupper($1); \
 if test "$withval" = "no"; then \
-	AC_MSG_ERROR([You cannot use git without $1]); \
+	if test -n "$2"; then \
+		m4_toupper($1)_PATH=$withval; \
+		AC_MSG_NOTICE([Disabling use of ${PROGRAM}]); \
+		GIT_CONF_APPEND_LINE(NO_${PROGRAM}=YesPlease); \
+		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=); \
+	else \
+		AC_MSG_ERROR([You cannot use git without $1]); \
+	fi; \
 else \
 	if test "$withval" = "yes"; then \
 		AC_MSG_WARN([You should provide path for --with-$1=PATH]); \
-- 
1.6.5.3
