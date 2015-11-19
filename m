From: larsxschneider@gmail.com
Subject: [PATCH v6 4/6] git-p4: add p4d timeout in tests
Date: Thu, 19 Nov 2015 09:58:09 +0100
Message-ID: <1447923491-15330-5-git-send-email-larsxschneider@gmail.com>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 09:58:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzL3O-0002hI-5G
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 09:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758062AbbKSI6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 03:58:47 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33804 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419AbbKSI6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 03:58:45 -0500
Received: by wmvv187 with SMTP id v187so14426932wmv.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 00:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fBBlamfuUYCOD5fyKlpoXnJyGvJL8BRb4uf1QZlIVBY=;
        b=h7lD4WNVfUWYcH1IRtK+AZkwaqqghxxFpt10GUJAv/xC6BoStTkQ+XhXyXoHH5WPOR
         OAdsEuwswOfxwrfLq6G1PXpfYIurLWL4bAabxIbRE3EJvDiCXnCyq1f/mKukg8joktz3
         r4NJhBQN+iLRCmHTMwu4ALV/gn9SJJsBTy3SwE/F6S+/k/iRI0JfKogvUHGXMKSwb9QO
         wM89la15wwSaqQnldeQRv/hiOKEDrP5GscHy0b8Y2eYOhm7WN/TGI/Ir+BrvTH227kxZ
         9Go6GIdcZhF7wKsClHn78MjoNf3NHuBR8JhfQlqfFInky9CD1bsrOn7RqGDoqiTV8NQz
         L6jg==
X-Received: by 10.28.131.84 with SMTP id f81mr8804226wmd.57.1447923524568;
        Thu, 19 Nov 2015 00:58:44 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB77F3.dip0.t-ipconnect.de. [93.219.119.243])
        by smtp.gmail.com with ESMTPSA id m64sm7237965wmf.14.2015.11.19.00.58.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Nov 2015 00:58:44 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281469>

From: Lars Schneider <larsxschneider@gmail.com>

In rare cases p4d seems to hang. This watchdog will kill the p4d
process after 300s in any case. That means each individual git p4 test
needs to finish before 300s or it will fail.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Acked-by: Luke Diamand <luke@diamand.org>
---
 t/lib-git-p4.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 3c9ad9a..acd5578 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -10,6 +10,10 @@ TEST_NO_CREATE_REPO=NoThanks
 # here the maximal retry timeout in seconds.
 RETRY_TIMEOUT=60
 
+# Sometimes p4d seems to hang. Terminate the p4d process automatically after
+# the defined timeout in seconds.
+P4D_TIMEOUT=300
+
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON
@@ -94,6 +98,19 @@ start_p4d() {
 	# will be caught with the "kill -0" check below.
 	i=${P4D_START_PATIENCE:-300}
 	pid=$(cat "$pidfile")
+
+	timeout=$(($(time_in_seconds) + $P4D_TIMEOUT))
+	while true
+	do
+		if test $(time_in_seconds) -gt $timeout
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
@@ -156,7 +173,8 @@ kill_p4d() {
 	retry_until_fail kill -9 $pid
 	# complain if it would not die
 	test_must_fail kill $pid >/dev/null 2>&1 &&
-	rm -rf "$db" "$cli" "$pidfile"
+	rm -rf "$db" "$cli" "$pidfile" &&
+	retry_until_fail kill -9 $watchdog_pid
 }
 
 cleanup_git() {
-- 
2.5.1
