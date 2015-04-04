From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 3/3] git-p4: fix filetype detection on files opened exclusively
Date: Sat,  4 Apr 2015 09:46:03 +0100
Message-ID: <1428137163-13219-4-git-send-email-luke@diamand.org>
References: <1428137163-13219-1-git-send-email-luke@diamand.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>,
	Blair Holloway <blair_holloway@playstation.sony.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 10:47:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeJjK-0008Lm-BE
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 10:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbbDDIqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 04:46:53 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36083 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbbDDIqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 04:46:45 -0400
Received: by wgra20 with SMTP id a20so126451549wgr.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XqLNuwfv9YXP7ssMxJoOiGta+DyvT498VZpZvsIRzEI=;
        b=bHXu9sTEA3NwFD+365DrMBXu6VVlbZP/vwf/8kAI2etv7M8Wz+2coXy0lAgRvfLrOg
         CSz/vvWDm8EtJbKHIbXf1EflJnfOIjTp+N30eX8jMniGCTCrPi8Awa6txwheaffdLCjK
         ALprdYXj2X8PIJGWyFl9koxL4ayv/iKqFXzlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XqLNuwfv9YXP7ssMxJoOiGta+DyvT498VZpZvsIRzEI=;
        b=VFIG1IcTE9KygFLtx7fvuKvdHZuqiSGEHkbVVbXmFGMFArGkii82RJmE7eXTH+/B6u
         0cpUWZUeLFdIvXcI+yGX3zdxjkh3I0NBw3cQdLSrpNsfhKD7tMXee5kup6fWFWLDEmNa
         CH0jLDtiTz5u6sglrpCBjrTGU5R+z5VEvU1+tDeJkzqTfybMRYerhR/kkJ14ewL5NU5E
         ZPyETKDrmkUHztk6Ahhgp1qwEy6boYlT5jETbw8/QxfKo86yhNCje7zyeGwwXLLomWpm
         WLnX54mwgLqMCzWYUKocjJZCsG15t8gpDZ9Y6NxrZvEoBrs8rDaWYqC8KuZcXKs8Ln8o
         rBJw==
X-Gm-Message-State: ALoCoQkChb38bU84QRH1wM5CmyqsSAROi4/Fyrfw+tNWkKvDPo12+LeKlEiqbe7KBBoWX0V+UOxY
X-Received: by 10.194.83.66 with SMTP id o2mr12425705wjy.55.1428137204630;
        Sat, 04 Apr 2015 01:46:44 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id s7sm2455742wjy.2.2015.04.04.01.46.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2015 01:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1428137163-13219-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266772>

From: "Holloway, Blair" <Blair_Holloway@playstation.sony.com>

If a Perforce server is configured to automatically set +l (exclusive lock) on
add of certain file types, git p4 submit will fail during getP4OpenedType, as
the regex doesn't expect the trailing '*exclusive*' from p4 opened:

//depot/file.png#1 - add default change (binary+l) *exclusive*

Signed-off-by: Blair Holloway <blair_holloway@playstation.sony.com>
Acked-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                | 2 +-
 t/t9816-git-p4-locked.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index ff132b2..d43482a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -368,7 +368,7 @@ def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
     result = p4_read_pipe(["opened", wildcard_encode(file)])
-    match = re.match(".*\((.+)\)\r?$", result)
+    match = re.match(".*\((.+)\)( \*exclusive\*)?\r?$", result)
     if match:
         return match.group(1)
     else:
diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index 464f10b..d048bd3 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -35,7 +35,7 @@ test_expect_success 'edit with lock not taken' '
 	)
 '
 
-test_expect_failure 'add with lock not taken' '
+test_expect_success 'add with lock not taken' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
@@ -107,7 +107,7 @@ test_expect_failure 'chmod with lock taken' '
 	)
 '
 
-test_expect_failure 'copy with lock taken' '
+test_expect_success 'copy with lock taken' '
 	lock_in_another_client &&
 	test_when_finished cleanup_git &&
 	test_when_finished "cd \"$cli\" && p4 revert file2 && rm -f file2" &&
-- 
2.3.4.48.g223ab37
