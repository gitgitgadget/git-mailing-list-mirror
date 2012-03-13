From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 4/4] contrib/diffall: eliminate duplicate while loops
Date: Tue, 13 Mar 2012 13:45:33 -0400
Message-ID: <1331660734-10538-4-git-send-email-tim.henigan@gmail.com>
References: <1331660734-10538-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@poxbox.com
X-From: git-owner@vger.kernel.org Tue Mar 13 18:47:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7VoK-0000Mf-G3
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 18:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759097Ab2CMRqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 13:46:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64904 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758385Ab2CMRqy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 13:46:54 -0400
Received: by yhmm54 with SMTP id m54so812776yhm.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wzlsiA4ipkV61olyr0SOQXEpx51efIvEDlMOuJ+vPcs=;
        b=jNO9ep7NeisQ4lJkYjBJhdaFOW4quPZ243brHe1kJW2V7erC2d/A1WL78Eglf1PauG
         ePbCsdTuOiyyzYOrxCu9Y97b1iQzffCGFDLxFqOlFApzGPwue8XeBWgJkNtqJfyIU6Dn
         BA1i7x3gVP8RYZRFmItH4DKldGFxbqDnAmQGgvk9Oz5cRz4Yi/8GQXH9qabGBNeDu+m0
         LgKRdK2nK9hmRjIquZsKRwPSzbtnht2k1YZov2+w5PyiLKBlwN9R+4yqDylQg50LIOPR
         QR0qtUqleLmQW/p/O0+WG7JZ1eEAXaJALPAnQVh/vMpuH29LAHeJxUG7wwKiQW4Helnc
         eSGw==
Received: by 10.224.187.137 with SMTP id cw9mr12728783qab.19.1331660814062;
        Tue, 13 Mar 2012 10:46:54 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id f12sm4430016qan.1.2012.03.13.10.46.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 10:46:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <1331660734-10538-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193044>

There were 3 instances of a 'while read; do' that used identical logic
to populate '/tmp/right_dir'. This commit groups them into a single loop.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 contrib/diffall/git-diffall |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
index 8d243c7..b1afefe 100755
--- a/contrib/diffall/git-diffall
+++ b/contrib/diffall/git-diffall
@@ -179,38 +179,32 @@ fi
 mkdir -p "$tmp/$left_dir" "$tmp/$right_dir"
 
 # Populate the tmp/right_dir directory with the files to be compared
-if test -n "$right"
-then
-	while read name
-	do
+while read name
+do
+	if test -n "$right"
+	then
 		ls_list=$(git ls-tree $right "$name")
 		if test -n "$ls_list"
 		then
 			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
 			git show "$right":"$name" >"$tmp/$right_dir/$name" || true
 		fi
-	done < "$tmp/filelist"
-elif test -n "$compare_staged"
-then
-	while read name
-	do
+	elif test -n "$compare_staged"
+	then
 		ls_list=$(git ls-files -- "$name")
 		if test -n "$ls_list"
 		then
 			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
 			git show :"$name" >"$tmp/$right_dir/$name"
 		fi
-	done < "$tmp/filelist"
-else
-	while read name
-	do
+	else
 		if test -e "$name"
 		then
 			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
 			cp "$name" "$tmp/$right_dir"
 		fi
-	done < "$tmp/filelist"
-fi
+	fi
+done < "$tmp/filelist"
 
 # Populate the tmp/left_dir directory with the files to be compared
 while read name
-- 
1.7.10.rc0
