From: larsxschneider@gmail.com
Subject: [PATCH v4 2/4] git-p4: add p4d timeout in tests
Date: Fri,  6 Nov 2015 09:58:41 +0100
Message-ID: <1446800323-2914-3-git-send-email-larsxschneider@gmail.com>
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
	id 1ZucrK-0007cS-W7
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 09:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032930AbbKFI6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 03:58:51 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33026 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031997AbbKFI6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 03:58:49 -0500
Received: by wijp11 with SMTP id p11so25802394wij.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 00:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MkZZm2ZdPzV1DATl9xAQaMsBilaXU3PBBKOmDv+8O3Q=;
        b=nZSxHSwcjykB+Gxt+M7v8VIFv/VMvg9dMyQpMpaMRGU/uOiZ+p2v+G3/x7ODdye3Je
         73GouoTwn5nHvbhJcFR3jSID13dGZ3kYB25hPZvOoHLt/TUGi/+i8QWD7/UMXuAlECxk
         2L+yqo70HIBd5BAaG0U6r++9VWSistZWrrl9cYdHT8WDO1RtPgJjZKfz9q2u9m+vBk2X
         w4DGVOeqP1hmlDIEm6KG/BvOYwsdD/hMvp5o6o0zmkzC/6Je8DXsqr2LzB8j0jw7n4C0
         Uz+C4Yond8gWhYHXFyNI5cSQMUBE4G2vEZZJidD608JfZVuozLxRR8tA6MabKhf/ptzd
         YKLg==
X-Received: by 10.194.115.69 with SMTP id jm5mr1823806wjb.156.1446800328388;
        Fri, 06 Nov 2015 00:58:48 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB59AE.dip0.t-ipconnect.de. [93.219.89.174])
        by smtp.gmail.com with ESMTPSA id cr5sm11098003wjb.16.2015.11.06.00.58.47
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 00:58:47 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280967>

From: Lars Schneider <larsxschneider@gmail.com>

In rare cases p4d seems to hang. This watchdog will kill the p4d
process after 300s in any case. That means each individual git p4 test
needs to finish before 300s or it will fail.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/lib-git-p4.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 7548225..b1660f6 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -6,6 +6,10 @@
 # a subdirectory called "$git"
 TEST_NO_CREATE_REPO=NoThanks
 
+# Sometimes p4d seems to hang. Terminate the p4d process automatically after
+# the defined timeout in seconds.
+P4D_TIMEOUT=300
+
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON
@@ -81,6 +85,19 @@ start_p4d() {
 	# will be caught with the "kill -0" check below.
 	i=${P4D_START_PATIENCE:-300}
 	pid=$(cat "$pidfile")
+
+	timeout=$(($(date +%s) + $P4D_TIMEOUT))
+    while true
+	do
+		if test $(date +%s) -gt $timeout
+		then
+			kill -9 $pid
+			exit 1
+		fi
+		sleep 1
+	done &
+	watchdog_pid=$!
+
 	ready=
 	while test $i -gt 0
 	do
@@ -131,7 +148,8 @@ kill_p4d() {
 	done &&
 	# complain if it would not die
 	test_must_fail kill $pid >/dev/null 2>&1 &&
-	rm -rf "$db" "$cli" "$pidfile"
+	rm -rf "$db" "$cli" "$pidfile" &&
+	retry_until_fail kill -9 $watchdog_pid
 }
 
 cleanup_git() {
-- 
2.5.1
