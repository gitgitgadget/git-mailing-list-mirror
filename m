From: larsxschneider@gmail.com
Subject: [PATCH v6 3/6] git-p4: retry kill/cleanup operations in tests with timeout
Date: Thu, 19 Nov 2015 09:58:08 +0100
Message-ID: <1447923491-15330-4-git-send-email-larsxschneider@gmail.com>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 09:58:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzL3K-0002cR-E1
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 09:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034AbbKSI6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 03:58:45 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36584 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321AbbKSI6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 03:58:44 -0500
Received: by wmww144 with SMTP id w144so229296308wmw.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 00:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7JNMQ+X9/QsSJMGlijxve4hZzhzVXX5QwfryWLUOKJ0=;
        b=sSO+Xi7W5YEiib6LTfvTOZA60Ek9eHZSBji5NM9lYE+WL3pNBKeBQVcpmvQL5g2SDa
         6L2oXdGDc62yN+Q0a9TRGGATH58v8QDmz7AHHnB0sKKn3elbUCVU/WQjQCS/40efDB7U
         6KsYiAw2kKnTRTzZC2nQhOGU51HM1mJKpDhkW9R1Uv0cB+C6Mzz3pzIJMVE/scLF7KRE
         1+ydiWAJfx/5sP0NsGGVW9rNzH2Z2AAPTxI79KDVCQ7IpHQK5Km/2itSnYn+qKnRCapo
         +asT1gQP/prSm1j1OaOgGlDoO3sA2gaN4vZt5qZqWT2cXGRlPKXRGgRs+Z2q3kJic1Jb
         3Gww==
X-Received: by 10.194.63.142 with SMTP id g14mr6760036wjs.161.1447923523564;
        Thu, 19 Nov 2015 00:58:43 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB77F3.dip0.t-ipconnect.de. [93.219.119.243])
        by smtp.gmail.com with ESMTPSA id m64sm7237965wmf.14.2015.11.19.00.58.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Nov 2015 00:58:17 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281471>

From: Lars Schneider <larsxschneider@gmail.com>

In rare cases kill/cleanup operations in tests fail. Retry these
operations with a timeout to make the test less flaky.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/lib-git-p4.sh | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 7548225..3c9ad9a 100644
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
@@ -36,6 +40,15 @@ native_path() {
 	echo "$path"
 }
 
+# On Solaris the 'date +%s' function is not supported and therefore we
+# need this replacement.
+# Attention: This function is not safe again against time offset updates
+# at runtime (e.g. via NTP). The 'clock_gettime(CLOCK_MONOTONIC)'
+# function could fix that but it is not in Python until 3.3.
+time_in_seconds() {
+	python -c 'import time; print int(time.time())'
+}
+
 # Try to pick a unique port: guess a large number, then hope
 # no more than one of each test is running.
 #
@@ -121,22 +134,35 @@ p4_add_user() {
 	EOF
 }
 
+retry_until_success() {
+	timeout=$(($(time_in_seconds) + $RETRY_TIMEOUT))
+	until "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
+	do
+		sleep 1
+	done
+}
+
+retry_until_fail() {
+	timeout=$(($(time_in_seconds) + $RETRY_TIMEOUT))
+	until ! "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
+	do
+		sleep 1
+	done
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
