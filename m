From: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 1/1] Makefile: make curl-config path configurable
Date: Mon,  5 Oct 2015 22:32:39 +0200
Message-ID: <1444077159-3268-1-git-send-email-repk@triplefau.lt>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Remi Pommarel <repk@triplefau.lt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 22:32:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCRJ-0001fE-7Q
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbbJEUcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:32:48 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41169 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbbJEUcs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:32:48 -0400
Received: from mfilter31-d.gandi.net (mfilter31-d.gandi.net [217.70.178.162])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id BE22941C062;
	Mon,  5 Oct 2015 22:32:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter31-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter31-d.gandi.net (mfilter31-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 7cRsy4AfjRTu; Mon,  5 Oct 2015 22:32:44 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8351C41C060;
	Mon,  5 Oct 2015 22:32:43 +0200 (CEST)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279083>

There are situations, e.g. during cross compilation, where curl-config
program is not present in the PATH.

Make the makefile use a configurable curl-config program passed through
CURL_CONFIG variable which can be set through config.mak.

Also make this variable tunable through use of autoconf/configure. Configure
will set CURL_CONFIG variable in config.mak.autogen to whatever value has been
passed to ac_cv_prog_CURL_CONFIG.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 Makefile     |  9 +++++++--
 configure.ac | 13 +++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ce0cfe2..3cba678 100644
--- a/Makefile
+++ b/Makefile
@@ -39,6 +39,10 @@ all::
 # Define CURLDIR=/foo/bar if your curl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+# Define CURL_CONFIG to curl's configuration program that gives informations
+# about the library (ie curl's version, cflags, ...) . If not set it defaults
+# to 'curl-config'.
+#
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports (dumb).
 #
@@ -425,6 +429,7 @@ TCL_PATH = tclsh
 TCLTK_PATH = wish
 XGETTEXT = xgettext
 MSGFMT = msgfmt
+CURL_CONFIG = curl-config
 PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
 GCOV = gcov
@@ -1059,13 +1064,13 @@ else
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
-	curl_check := $(shell (echo 070908; curl-config --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
+	curl_check := $(shell (echo 070908; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
 			PROGRAM_OBJS += http-push.o
 		endif
 	endif
-	curl_check := $(shell (echo 072200; curl-config --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
+	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "072200"
 		USE_CURL_FOR_IMAP_SEND = YesPlease
 	endif
diff --git a/configure.ac b/configure.ac
index 14012fa..01b07ad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -525,6 +525,19 @@ GIT_UNSTASH_FLAGS($CURLDIR)
 
 GIT_CONF_SUBST([NO_CURL])
 
+if test -z "$NO_CURL"; then
+
+AC_CHECK_PROG([CURL_CONFIG], [curl-config],
+[curl-config],
+[no])
+
+if test $CURL_CONFIG != no; then
+    GIT_CONF_SUBST([CURL_CONFIG])
+fi
+
+fi
+
+
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
-- 
2.0.1
