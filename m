From: larsxschneider@gmail.com
Subject: [PATCH v5 4/6] git-p4: add p4d timeout in tests
Date: Sun, 15 Nov 2015 14:08:38 +0100
Message-ID: <1447592920-89228-5-git-send-email-larsxschneider@gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 14:09:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zxx3p-00033m-OL
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 14:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbbKONJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 08:09:26 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35307 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbbKONIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 08:08:47 -0500
Received: by wmdw130 with SMTP id w130so79931729wmd.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 05:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F4XqBiWNQEVVAwVLevtsLkHLuQ+saq/gVbvK+553K94=;
        b=f0Nfu/tJHVodFQ5s1Ts48jWCt134On0Yiy2XFz60fjnNwt7H010AUeMWsvQF/0vjUI
         gVpXMAWwTYh33zmS01odYvXpeV+Rh2tX/lxOJ6kyVETY9QLA/bbmgCuP6G9/EEY+5dEo
         9iQkqeUzn4AIaRLUanPYgUm/l0Y7V3JAUNVD+Q3H7JxB6+eo1BIyl5ajhMUHvOhR3r/0
         YUjIluHY700YEIdLF/00CD2KusXDpPtvUl61MTfQdgYoeHHKON6lT3/aR2ctYRWz0Yu5
         G9JWNV6IzTIigl80FLjdwUct4E2rDmKpQVY+V82iwIdthD3lsbe2tHjPj+n4sERUvNbT
         0nAQ==
X-Received: by 10.194.87.99 with SMTP id w3mr8134278wjz.76.1447592926535;
        Sun, 15 Nov 2015 05:08:46 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id t2sm13472567wme.0.2015.11.15.05.08.45
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Nov 2015 05:08:46 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281318>

From: Lars Schneider <larsxschneider@gmail.com>

In rare cases p4d seems to hang. This watchdog will kill the p4d
process after 300s in any case. That means each individual git p4 test
needs to finish before 300s or it will fail.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/lib-git-p4.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 8d6b48f..f2a009c 100644
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
@@ -85,6 +89,19 @@ start_p4d() {
 	# will be caught with the "kill -0" check below.
 	i=${P4D_START_PATIENCE:-300}
 	pid=$(cat "$pidfile")
+
+	timeout=$(($(date +%s) + $P4D_TIMEOUT))
+	while true
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
@@ -145,7 +162,8 @@ kill_p4d() {
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
