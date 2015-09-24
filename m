From: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 1/1] configure: make curl-config path configurable
Date: Thu, 24 Sep 2015 21:50:43 +0200
Message-ID: <1443124243-15134-1-git-send-email-repk@triplefau.lt>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bdwalton@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Remi Pommarel <repk@triplefau.lt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 22:52:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDV2-00022e-1u
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 22:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbbIXUwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 16:52:12 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44485 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbbIXUwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 16:52:10 -0400
Received: from mfilter30-d.gandi.net (mfilter30-d.gandi.net [217.70.178.161])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id B0235FB86F;
	Thu, 24 Sep 2015 22:52:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter30-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter30-d.gandi.net (mfilter30-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id TQ9pikjTB3cY; Thu, 24 Sep 2015 22:52:07 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C07ACFB877;
	Thu, 24 Sep 2015 22:52:06 +0200 (CEST)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278558>

There are situations, ie during cross compilation, where curl-config program
is not present in the PATH.

Make configure check that a custom curl-config program is passed by the user
through ac_cv_prog_CURL_CONFIG then set CURL_CONFIG variable accordingly in
config.mak.autogen. Makefile uses this variable to get the target's curl
configuration program.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 Makefile     |  5 +++--
 configure.ac | 10 ++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ce0cfe2..81ac5bb 100644
--- a/Makefile
+++ b/Makefile
@@ -374,6 +374,7 @@ LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
+CURL_CONFIG=curl-config
 
 # Among the variables below, these:
 #   gitexecdir
@@ -1059,13 +1060,13 @@ else
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
index 14012fa..acc23fb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -525,6 +525,16 @@ GIT_UNSTASH_FLAGS($CURLDIR)
 
 GIT_CONF_SUBST([NO_CURL])
 
+if test -z "$NO_CURL"; then
+
+AC_CHECK_PROG([CURL_CONFIG], [curl-config], [curl-config], [no])
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
