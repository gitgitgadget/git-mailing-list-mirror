From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/2] mergetool: honor tempfile configuration when resolving delete conflicts
Date: Sat,  5 Mar 2016 14:56:26 -0800
Message-ID: <1457218586-18654-1-git-send-email-davvid@gmail.com>
Cc: Joe Einertson <joe@kidblog.org>,
	Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 05 23:56:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acL7k-0004nt-Mb
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 23:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbcCEW4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 17:56:32 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36049 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbcCEW4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 17:56:31 -0500
Received: by mail-pf0-f170.google.com with SMTP id 63so56480991pfe.3
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 14:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=60AYhthUGmigor5BSIjZxsMEx7PNHE0yCW0V6d2vpmc=;
        b=PkSYwe0FvkHxpnOXkzQEwpCyX1zxMq8yrR8PymCV9BQbsrKz2tb0vmTLfep8Y0Tlg8
         TQgsKWAfrAmPChMBA/NbXTT2I9LOma9UC+hPQ5FWsG5qTAtMwCa/Bf0L3tP5LMArNvNC
         FdJvkHSqsSMIJVcqi2J/r5fTNw9Ed2oCfWbKfxLL+R3+qWM7u6eMr2vPZEXRKS2gDG8G
         WEOrDr12FwdlEIVDtF/ubs7NmqCxJORdT7+jlMgNITSbRq6i4jfrPl5FpTNVFX3rCAA2
         0nkjO8CfkoB0IaBMpQ5Tf4giH2OcSDmafzZHuEKNS4yIlwB4B5Ax5vyu8zvytT+jipZp
         2Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=60AYhthUGmigor5BSIjZxsMEx7PNHE0yCW0V6d2vpmc=;
        b=Qdd1IqTz027FvunLLdqNRwQ/Ir//S6iJJc2oI8oIdEmr899XUajnPAKxI9enix63UV
         lrRjRxPQ0FBN22RL41sbQD11RzlihX5ktTFdtV6zQUGs1rZRD+NmvEfCDD5aiigyjmFD
         6/r7C5aPasgtWLmM1nlApH3y+EUO+Pqi2wbhxD9eYMntOWU3Y5kKmt5QIIYYjP51Lb3P
         xyQ9ovfDeVPJ1ivliNn0ulZKENRKm6Jf8aY2CmyD6ZeqvRDDiNqAK9c+YUuXMLKMpGCe
         Ctm3i9xqjplpun073cv2fhyw2UPRJe25N2tvuOTufYTHFzisiEy5Lh6a/pfNHQYxhysU
         PfEA==
X-Gm-Message-State: AD7BkJJIb2qe7LZEbK2CJuO1QWthS+OvHMMb5nEzyOMCRRCA63LJcck4hW8v7R0NBeauMA==
X-Received: by 10.98.87.90 with SMTP id l87mr22958971pfb.70.1457218590662;
        Sat, 05 Mar 2016 14:56:30 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id p5sm14492209pfi.94.2016.03.05.14.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Mar 2016 14:56:29 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.2.g28ba210
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288335>

Teach resolve_deleted_merge() to honor the mergetool.keepBackup and
mergetool.keepTemporaries configuration knobs.

This ensures that the worktree is kept pristine when resolving deletion
conflicts with the variables both set to false.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
v2 uses test.  2/2 is the same as before, and was not sent this round.

 git-mergetool.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9f77e3a..4a9e9ca 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -126,7 +126,12 @@ resolve_deleted_merge () {
 		case "$ans" in
 		[mMcC]*)
 			git add -- "$MERGED"
-			cleanup_temp_files --save-backup
+			if test "$merge_keep_backup" = "true"
+			then
+				cleanup_temp_files --save-backup
+			else
+				cleanup_temp_files
+			fi
 			return 0
 			;;
 		[dD]*)
@@ -135,6 +140,10 @@ resolve_deleted_merge () {
 			return 0
 			;;
 		[aA]*)
+			if test "$merge_keep_temporaries" = "false"
+			then
+				cleanup_temp_files
+			fi
 			return 1
 			;;
 		esac
-- 
2.8.0.rc1.2.g28ba210
