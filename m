From: larsxschneider@gmail.com
Subject: [PATCH v2 3/4] git-p4: Fix t9815 git-p4-submit-fail test case on OS X
Date: Sun,  4 Oct 2015 11:06:16 -0700
Message-ID: <1443981977-64604-4-git-send-email-larsxschneider@gmail.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 04 20:06:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZingA-0000bK-JJ
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbbJDSGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:06:30 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32820 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbbJDSG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:06:28 -0400
Received: by wiclk2 with SMTP id lk2so91888131wic.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qsr6F5EQBGScT55/6eUjJflqy212T2RPdDyvpH04xcY=;
        b=R9KhxR6IAoxbE+/PaXkrKA5vbBbLwddXAa1o7cd7Z0RbQIKWww+AQ4nrLqZ4LqhJbK
         /Lm8drEVBjVDrQoZX4wUKS++lOwpWH1vUZQ+ohmbwnaeQa5BY5EwarcMQpxCYKkWa+B2
         UaTVjPZtX0z7BRZZMX3zxnXHbtrHdiTuIW4+KukCbofnbpnypkkEYIsddK7EC3/unUDK
         6bKDFcwWfO452PJVN6yn11hzug1eGBCBtExcb8U58OBFKHi6OQdw5kZew9j7+86ZW281
         MT2GiUGfywcXQRydQc7ZwamVQWBLzhfGKrbEUTlF7lze/8AcF8eK+5086qS+CowcFTS9
         4YWw==
X-Received: by 10.180.39.193 with SMTP id r1mr7007212wik.57.1443981987365;
        Sun, 04 Oct 2015 11:06:27 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsk-nat-ip3.autodesk.com. [132.188.71.3])
        by smtp.gmail.com with ESMTPSA id o3sm10378607wif.22.2015.10.04.11.06.25
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Oct 2015 11:06:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279013>

From: Lars Schneider <larsxschneider@gmail.com>

The stats command works differently on OS X compared to Linux. Detect
OS X and execute the appropriate assertions.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t9815-git-p4-submit-fail.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 4cff6a7..520b812 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -417,8 +417,12 @@ test_expect_success 'cleanup chmod after submit cancel' '
 		! p4 fstat -T action text &&
 		test_path_is_file text+x &&
 		! p4 fstat -T action text+x &&
-		if test_have_prereq !CYGWIN
-		then
+		if test_have_prereq CYGWIN; then
+			: # NOOP
+		elif test_have_prereq DARWIN; then
+			stat -f %Sp text | egrep ^-r-- &&
+			stat -f %Sp text+x | egrep ^-r-x
+		else
 			stat --format=%A text | egrep ^-r-- &&
 			stat --format=%A text+x | egrep ^-r-x
 		fi
-- 
2.5.1
