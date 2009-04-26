From: Matthias Andree <matthias.andree@gmx.de>
Subject: [PATCH] To make GIT-VERSION-FILE, search for git more widely
Date: Sun, 26 Apr 2009 13:59:50 +0200
Message-ID: <1240747190-12005-1-git-send-email-matthias.andree@gmx.de>
Cc: Matthias Andree <matthias.andree@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 12:35:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly33J-0006Mr-Qy
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 14:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZDZMAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 08:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbZDZMAJ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 08:00:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:59481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751019AbZDZMAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 08:00:07 -0400
Received: (qmail invoked by alias); 26 Apr 2009 12:00:06 -0000
Received: from g226233177.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.226.233.177]
  by mail.gmx.net (mp034) with SMTP; 26 Apr 2009 14:00:06 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/NKdI43dfN1W5wVKAiTlTcf6ioK6/0jA89iJWQTY
	ePOL8jLq6gh/5s
Received: by merlin.emma.line.org (Postfix, from userid 1000)
	id 3F99B944C8; Sun, 26 Apr 2009 14:00:05 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.9.g97ad0
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117646>

Problem: when git is installed into /usr/local/bin, running 'sudo make
install' won't find git in $PATH (because sudo strips PATH, for instance
on openSUSE 11.1, and doesn't include /usr/local/whatever).

This causes GIT-VERSION-FILE to not find git for git describe, and fall
back to DEF_VER.

This in turn causes rebuilds of major parts of the system.

This patch passes GIT through to the shell script, and additionally
looks for the current version and in ${prefix}/bin.

Signed-off-by: Matthias Andree <matthias.andree@gmx.de>
---
 GIT-VERSION-GEN |    7 ++++---
 Makefile        |    6 +++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 97fc1e0..22661c0 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -2,6 +2,7 @@
 
 GVF=GIT-VERSION-FILE
 DEF_VER=v1.6.2.GIT
+test -x "$GIT" || GIT=git
 
 LF='
 '
@@ -12,12 +13,12 @@ if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d .git -o -f .git &&
-	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
+	VN=$(${GIT} describe --abbrev=4 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
-		git update-index -q --refresh
-		test -z "$(git diff-index --name-only HEAD --)" ||
+		${GIT} update-index -q --refresh
+		test -z "$(${GIT} diff-index --name-only HEAD --)" ||
 		VN="$VN-dirty" ;;
 	esac
 then
diff --git a/Makefile b/Makefile
index 5c8e83a..408228e 100644
--- a/Makefile
+++ b/Makefile
@@ -177,7 +177,11 @@ all::
 # away (some NTFS drivers seem to zero the contents in that scenario).
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@{ GIT=./git$X ; type $$GIT >/dev/null 2>&1 ; } \
+	    || { GIT=$(prefix)/bin/git$X ; type $$GIT >/dev/null 2>&1 ; }\
+	    || GIT=git ; \
+	    export GIT ; \
+	    $(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-- 
1.6.3.rc2.9.g97ad0
