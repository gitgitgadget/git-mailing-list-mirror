From: larsxschneider@gmail.com
Subject: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests with timeout
Date: Sun, 15 Nov 2015 14:08:37 +0100
Message-ID: <1447592920-89228-4-git-send-email-larsxschneider@gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 14:09:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zxx3Z-0002cC-Ah
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 14:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbbKONJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 08:09:18 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33227 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbKONIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 08:08:47 -0500
Received: by wmec201 with SMTP id c201so140152020wme.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 05:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wrN4FCxoS+jU/8LGwIjasFwZiWy5tpq6f6V7/SDwIuY=;
        b=rkJ6DQHxEYpHxxlGpL3hC4l5LFcrwC6u5onxeVR4iP6sfk5dg1BomQ98Dmn2Dx6VHa
         6AMqpBk/xn+cAwN5CArTnY8cY2Q1JrzD0wf5uoYu+5Lr3rH9mTrPAMbaHB3yLlOfea3R
         QjN/0sdsI/1ZsIzkgvs63I8XbWK7PnXvydbqzchIKvIzvoYjMcVBQk1Y9SRVXbQvXxzL
         la6Rn8vVDKoE0sw9D8xTa48Cb1HU76AcWvJ1io5syesFlzgNIW6jSdBXrY8wD4N8VHre
         gawsXDT58v/6uLgQz1qem7ZxwYSHd58kdzFEXIFnGqjPVWr9ZGpBgXELHVjryk65ELJS
         tU8A==
X-Received: by 10.28.212.18 with SMTP id l18mr14801543wmg.93.1447592925562;
        Sun, 15 Nov 2015 05:08:45 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id t2sm13472567wme.0.2015.11.15.05.08.44
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Nov 2015 05:08:45 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281314>

From: Lars Schneider <larsxschneider@gmail.com>

In rare cases kill/cleanup operations in tests fail. Retry these
operations with a timeout to make the test less flaky.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/lib-git-p4.sh | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 7548225..8d6b48f 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -6,6 +6,10 @@
 # a subdirectory called "$git"
 TEST_NO_CREATE_REPO=NoThanks
 
+# Some operations require multiple attempts to be successful. Define
+# here the maximal retry timeout in seconds.
+RETRY_TIMEOUT=60
+
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON
@@ -121,22 +125,33 @@ p4_add_user() {
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
 	rm -rf "$db" "$cli" "$pidfile"
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
