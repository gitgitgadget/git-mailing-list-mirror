From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/3] mergetool: simplify conditionals
Date: Thu, 20 Nov 2014 17:20:29 -0800
Message-ID: <1416532829-68662-4-git-send-email-davvid@gmail.com>
References: <1416532829-68662-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 02:20:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrcuA-0006Ek-0K
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 02:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544AbaKUBUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 20:20:49 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:64976 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757517AbaKUBUr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 20:20:47 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so3662671pab.26
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 17:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SAzQAgM2+bCi7G8o6zNGO3RHSbylTNLVKlO1bBuS6Ek=;
        b=VU8JDfOzVODhCRnjnh5SR4ru6PRFZce3CcagcQ/xxXTOuQc/O+53UBo4HgyR1gSbs+
         UNsqqqmZCFjJ2gs5/YUl7NvloNH+XknpEEF2lrRfqKMBIyuWzzDHmbHb8rT2FHKbITVF
         k5r3a8s/53OmjTt6t89MGqlEkmRviKX2RdM1viMdIQPfcbh60hGNzuGmTLUTiNxYgdSS
         D2PnxNiqXzaxsT/5GUDRob8pw+YDkFt5UzpLYiplter8Dbfq7ZmX9KRWhnbwAQ8NNyr1
         1zA3+5rquHX9fYKJcUsl4xjvdZVKtueVRvvHdSI7+EQO2gQeZBB2KaoB+USRQHVoNhKR
         NxoQ==
X-Received: by 10.70.94.197 with SMTP id de5mr1780630pdb.161.1416532847183;
        Thu, 20 Nov 2014 17:20:47 -0800 (PST)
Received: from lustrous.local.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by mx.google.com with ESMTPSA id w5sm3151439pds.25.2014.11.20.17.20.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 17:20:46 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.26.g3e3388f
In-Reply-To: <1416532829-68662-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Combine the $last_status checks into a single conditional.
Replace $last_status and $rollup_status with a single variable.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index ff050e5..d20581c 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -426,8 +426,6 @@ fi
 merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
-last_status=0
-rollup_status=0
 files=
 
 if test $# -eq 0
@@ -455,19 +453,15 @@ printf "%s\n" "$files"
 
 IFS='
 '
+rc=0
 for i in $files
 do
-	if test $last_status -ne 0
-	then
-		prompt_after_failed_merge || exit 1
-	fi
 	printf "\n"
-	merge_file "$i"
-	last_status=$?
-	if test $last_status -ne 0
+	if ! merge_file "$i"
 	then
-		rollup_status=1
+		rc=1
+		prompt_after_failed_merge || exit 1
 	fi
 done
 
-exit $rollup_status
+exit $rc
-- 
2.2.0.rc2.26.g3e3388f
