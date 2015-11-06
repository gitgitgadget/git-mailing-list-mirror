From: larsxschneider@gmail.com
Subject: [PATCH v4 3/4] git-p4: retry kill/cleanup operations in tests with timeout
Date: Fri,  6 Nov 2015 09:58:42 +0100
Message-ID: <1446800323-2914-4-git-send-email-larsxschneider@gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, sschuberth@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, avila.jn@gmail.com, luke@diamand.org,
	dturner@twopensource.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 09:59:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZucrM-0007cS-6n
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 09:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032965AbbKFI6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 03:58:55 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36572 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032817AbbKFI6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 03:58:50 -0500
Received: by wimw2 with SMTP id w2so25927637wim.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 00:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3LCFAsF8N7F4lc+qNuPwT5g/2nATvzP6dwffMm5DOaY=;
        b=uOn0TjN24Xuy4BqPEkli67V2nJwItJGiXrCoSGbarh1BDqsSjlKasY5G2/ip9ywmWF
         /G80J0KXQ7CGLrc8/h+8PXVYQWZdpd5MyWgZ/24rtivF4zR6q9FjI7qucy+VBmod+L2J
         x5Dq85UEoXDu/W6aNLjoko86QMKWy3oUs/DirUU51KeU/V6nS2pAgZN4NxUlCCmP5qt5
         zVpHqP6yRD3Bhy5NKQpdrJHW0heUIY5tyEyg03MwwY8lXRoIsIj9NaRupTFzv7JmsbJY
         UQQGYQYBXkiG8ag1mNXd+IQOoocWFVRju6fSz9WIl2/i48HE4HgT7naUaT8U2pg30SiQ
         Ln2A==
X-Received: by 10.194.134.72 with SMTP id pi8mr13105225wjb.34.1446800329411;
        Fri, 06 Nov 2015 00:58:49 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB59AE.dip0.t-ipconnect.de. [93.219.89.174])
        by smtp.gmail.com with ESMTPSA id cr5sm11098003wjb.16.2015.11.06.00.58.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 00:58:48 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280966>

From: Lars Schneider <larsxschneider@gmail.com>

In rare cases kill/cleanup operations in tests fail. Retry these
operations with a timeout to make the test less flaky.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/lib-git-p4.sh | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index b1660f6..9043b51 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -10,6 +10,10 @@ TEST_NO_CREATE_REPO=NoThanks
 # the defined timeout in seconds.
 P4D_TIMEOUT=300
 
+# Some operations require multiple attempts to be successful. Define
+# here the maximal retry timeout in seconds.
+RETRY_TIMEOUT=60
+
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON
@@ -138,14 +142,24 @@ p4_add_user() {
 	EOF
 }
 
+retry_until_success() {
+    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
+    until "$@" 2>/dev/null || test $(date +%s) -gt $timeout
+    do :
+    done
+}
+
+retry_until_fail() {
+    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
+    until ! "$@" 2>/dev/null || test $(date +%s) -gt $timeout
+    do :
+    done
+}
+
 kill_p4d() {
 	pid=$(cat "$pidfile")
-	# it had better exist for the first kill
-	kill $pid &&
-	for i in 1 2 3 4 5 ; do
-		kill $pid >/dev/null 2>&1 || break
-		sleep 1
-	done &&
+	retry_until_fail kill $pid
+	retry_until_fail kill -9 $pid
 	# complain if it would not die
 	test_must_fail kill $pid >/dev/null 2>&1 &&
 	rm -rf "$db" "$cli" "$pidfile" &&
@@ -153,8 +167,9 @@ kill_p4d() {
 }
 
 cleanup_git() {
-	rm -rf "$git" &&
-	mkdir "$git"
+	retry_until_success rm -r "$git"
+	test_must_fail test -d "$git" &&
+	retry_until_success mkdir "$git"
 }
 
 marshal_dump() {
-- 
2.5.1
