From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 2/2] mergetool: honor tempfile configuration when resolving delete conflicts
Date: Wed,  9 Mar 2016 23:13:59 -0800
Message-ID: <1457594039-22629-2-git-send-email-davvid@gmail.com>
References: <1457594039-22629-1-git-send-email-davvid@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Joe Einertson <joe@kidblog.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 08:14:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adunW-0003fA-L6
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 08:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbcCJHOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 02:14:08 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33097 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742AbcCJHOE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 02:14:04 -0500
Received: by mail-pf0-f176.google.com with SMTP id 124so62176722pfg.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 23:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4BsQWg51fklMu0GJ1XSU5VweOigsxWOgu88VB863Wp8=;
        b=wXzKRvhcNbKWzvxR/wde/lVlrDDAMjhg7gyoBl4yPDklWV/jOzAKEP+MvDedB7ISH9
         8Sxxl/1tlbrz0pY4SqKc9kIYsfmkjlxI9ZcWT40LVbNrUjGKk/P8xgt0Hq/1Gih/a2tI
         N4+KUVgkybq/ns8jSX4+mA9hbMAEhOVm6eHYc5Eg8JHlv8ytuiXISgjmcztyJLm6eRk5
         XDX2fe06DN/P35+vk0EImj9GLjmDwCCgiXIBWIxZVM7FoyM9EZR5A2C6vf4x5BOtSCM7
         6dboD9FntTecZTnv4RtDnJOa9o9OkK4gXk36/q4pR7DlQ10RZb0qJFx+ezTDL9I6/1qj
         6ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4BsQWg51fklMu0GJ1XSU5VweOigsxWOgu88VB863Wp8=;
        b=MVTMB5oGmKJoia7ccM5UwY9eNO70n1tgkFuQP+Qn+c6JETnukyRDN3U7doDUJuLhDR
         WZzgSy/tuOsmfm83DOeL1EE2CLg0JWRbF9OZdd50dSs9pNLDqhAct68S9LmIf6vC/DBS
         LzurBsrS3b1FBpFlNeod83K/IfVrN6UoaOm0I8/+Uf/tq4chP+XKJ8m2d7iiTaphGfqY
         D03u/zNKs9p+p8FYrq3qBomIaUp2C3GCBuUxh56YU7I858XSzyq+XgU77AsAvlebVHi8
         16ddGhLJIJCllhNi5fK91YdatLWWmOujZ7KMd7VJidYacelQmPhb7mtnDokdQoV19CYa
         1TCQ==
X-Gm-Message-State: AD7BkJKcudzwMMQgovN2ve3xp3cqAdHIxBeXqSx3KpSlLxiKg/HxAMHharmGzPsJpfrLpQ==
X-Received: by 10.98.12.153 with SMTP id 25mr2776863pfm.27.1457594043657;
        Wed, 09 Mar 2016 23:14:03 -0800 (PST)
Received: from raptor.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by smtp.gmail.com with ESMTPSA id 9sm2929872pfm.10.2016.03.09.23.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 23:14:02 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.2.gb8cabf0
In-Reply-To: <1457594039-22629-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288597>

Teach resolve_deleted_merge() to honor the mergetool.keepBackup and
mergetool.keepTemporaries configuration knobs.

This ensures that the worktree is kept pristine when resolving deletion
conflicts with the variables both set to false.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Rebased to include tests and test fixes.

 git-mergetool.sh     | 11 ++++++++++-
 t/t7610-mergetool.sh | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index b06ae78..f67bab5 100755
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
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 39469d9..db723e8 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -279,6 +279,31 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
 	: >expect &&
 	echo d | git mergetool a/a/file.txt 2>actual &&
 	test_cmp expect actual &&
+	! test -d a &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'mergetool honors tempfile config for deleted files' '
+	test_config mergetool.keepTemporaries false &&
+	test_must_fail git merge move-to-b &&
+	echo d | git mergetool a/a/file.txt &&
+	! test -d a &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
+	test_config mergetool.keepTemporaries true &&
+	test_must_fail git merge move-to-b &&
+	! (echo a; echo n) | git mergetool a/a/file.txt &&
+	test -d a/a &&
+	cat  >expect <<-\EOF &&
+	file_BASE_.txt
+	file_LOCAL_.txt
+	file_REMOTE_.txt
+	EOF
+	ls -1 a/a | sed -e "s/[0-9]*//g" >actual &&
+	test_cmp expect actual &&
+	git clean -fdx &&
 	git reset --hard HEAD
 '
 
-- 
2.8.0.rc1.2.gb8cabf0
