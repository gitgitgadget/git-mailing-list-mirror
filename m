From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] mergetool: honor tempfile configuration when resolving delete conflicts
Date: Fri,  4 Mar 2016 22:39:07 -0800
Message-ID: <1457159948-10645-1-git-send-email-davvid@gmail.com>
Cc: Joe Einertson <joe@kidblog.org>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 05 07:39:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac5ry-0004Pq-3J
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 07:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbcCEGjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 01:39:13 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33241 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbcCEGjN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 01:39:13 -0500
Received: by mail-pf0-f175.google.com with SMTP id 124so48022623pfg.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 22:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3tQWb+igNn8BBRLPjN4TFUAMNFPQwEto+jy2jBUA2cM=;
        b=EAfMSTbk4ISduHkp2Mr867GzoSaHImqTOwBWpLb/L/Z79hrmlTA9FiVWEfB9r5dEiX
         JO3+IBMI3mkSrtYQbL4Pjqi79a9l24HJRWGYkX9luBIvpd04htgOG9834J0E7tiBMlMg
         S/oQRV1/gVeISDB27FoNfu0jI4f+eQA1OWuIo16pTMn5idnqc8oXLLypcBoz3yqyMtQQ
         F5x/qWsvJRvaAvV5Co4IkXcDmK25BhEaQbPmr3nw7pP9qRzqGAzi/GH11bt85IULVhWw
         3WeAHTkNSg2/UhviQirDaA3MOooAgEu4YKt0VTKztfJO+41w/psEST3pcIvYt8yTaK1K
         bPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3tQWb+igNn8BBRLPjN4TFUAMNFPQwEto+jy2jBUA2cM=;
        b=g5QT+Tz33RUW6wXo7Z8FYt3TYdJS9uQD3KtMf1x9ao2hRvit1vOHXSlW0OMsSuMd/f
         V6QxZhi1DMcos17NPDnD9HTQHkmOD5pxaAjEcLH8A4m9DJQ3jcgLwuaqSfnfgOxqcLZ1
         MqpLHhCctCMUgE8rOEs3uJ0dN+Gmq1ASJv9juGly61Lub+kOKC3cMEqiS65VVCFy/IhG
         qS2+xAWPDiAFW2mKv5yFmQF23X3FPcJ2XPk1D9cMByAO9ssZRnHlEv87yOgVF9qPb1mO
         HEifdy7F5oN5jRVHQm4TLzAnZA+aNthLuAJGct4uE9gVfkyhS6O87F03JPt+YpvybAk5
         B/Lg==
X-Gm-Message-State: AD7BkJLg6z9rK05UtEfyEXCh2cXDI3Eu77+kZATNlNNIV2l+MMeEPxvpuwVwLvSKfPGlQA==
X-Received: by 10.98.72.218 with SMTP id q87mr17918479pfi.152.1457159952596;
        Fri, 04 Mar 2016 22:39:12 -0800 (PST)
Received: from localhost.localdomain ([166.170.36.242])
        by smtp.gmail.com with ESMTPSA id xn8sm9759612pab.15.2016.03.04.22.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 22:39:11 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.2.g28ba210
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288296>

Teach resolve_deleted_merge() to honor the mergetool.keepBackup and
mergetool.keepTemporaries configuration knobs.

This ensures that the worktree is kept pristine when resolving deletion
conflicts with the variables both set to false.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9f77e3a..615265d 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -126,7 +126,12 @@ resolve_deleted_merge () {
 		case "$ans" in
 		[mMcC]*)
 			git add -- "$MERGED"
-			cleanup_temp_files --save-backup
+			if "$merge_keep_backup" = "true"
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
