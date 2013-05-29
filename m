From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] dir.c: fix ignore processing within not-ignored directories
Date: Wed, 29 May 2013 22:32:36 +0200
Message-ID: <51A665E4.9080307@gmail.com>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com> <CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com> <CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com> <51A62A96.6040009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Misty De Meo <misty@brew.sh>,
	=?UTF-8?B?w5h5c3RlaW4gV2FsbGU=?= <oystwa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 22:32:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhn35-0008C6-6T
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 22:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966793Ab3E2Uck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 16:32:40 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:43162 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966083Ab3E2Uci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 16:32:38 -0400
Received: by mail-ea0-f181.google.com with SMTP id a11so5551951eae.26
        for <git@vger.kernel.org>; Wed, 29 May 2013 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TixsqtxC6jcjfZlKjeYHf+kuNqoVikU7mB24C1h24vM=;
        b=OuIsCebXb8c8GEXA05js6NIzojSHYxLHavcX67qPVOnhMo7TtLyvNz6Y4oSTxQulmM
         fav1MDeUjAhUxbvgc43PIwomNCfsZGB+rtHyRKf63ZczBSE9vqTUC4I9edYMGV/EXiHf
         ilHixQ3beo0VUOXXQZwW2b3xIADX2juF1VdupYTZ+UeusMwOwKUJo2lW92hWfdOazGqB
         WkTi7q9R5Tt/rQxOURGAeOhI7Yu+wrGB1KLS3+e0OigWeGJ5hfPRnLLa5l1CnkDbzOPa
         NpXJV4wSJfV6erHp7zLapiP+tGQCBIHMwBAz5y8g3VQ2B14zqtinyx31VqTFRNvnWfb2
         nZvQ==
X-Received: by 10.15.91.66 with SMTP id r42mr6284805eez.48.1369859557516;
        Wed, 29 May 2013 13:32:37 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id e1sm21816065eem.10.2013.05.29.13.32.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 13:32:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <51A62A96.6040009@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225888>

As of 95c6f271 "dir.c: unify is_excluded and is_path_excluded APIs", the
is_excluded API no longer recurses into directories that match an ignore
pattern, and returns the directory's ignored state for all contained paths.

This is OK for normal ignore patterns, i.e. ignoring a directory affects
the entire contents recursively.

Unfortunately, this also "works" for negated ignore patterns ('!dir'), i.e.
the entire contents is "not-ignored" recursively, regardless of ignore
patterns that match the contents directly.

In prep_exclude, skip recursing into a directory only if it is really
ignored (i.e. the ignore pattern is not negated).

Signed-off-by: Karsten Blees <blees@dcon.de>
---

Also available here:
https://github.com/kblees/git/tree/kb/ignore-within-not-ignored-dir
git pull git://github.com/kblees/git.git kb/ignore-within-not-ignored-dir

 dir.c                              |  3 +++
 t/t3001-ls-files-others-exclude.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/dir.c b/dir.c
index a5926fb..13858fe 100644
--- a/dir.c
+++ b/dir.c
@@ -821,6 +821,9 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 				dir->basebuf, stk->baselen - 1,
 				dir->basebuf + current, &dt);
 			dir->basebuf[stk->baselen - 1] = '/';
+			if (dir->exclude &&
+			    dir->exclude->flags & EXC_FLAG_NEGATIVE)
+				dir->exclude = NULL;
 			if (dir->exclude) {
 				dir->basebuf[stk->baselen] = 0;
 				dir->exclude_stack = stk;
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 4e3735f..f0421c0 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -175,6 +175,24 @@ test_expect_success 'negated exclude matches can override previous ones' '
 	grep "^a.1" output
 '
 
+test_expect_success 'excluded directory overrides content patterns' '
+
+	git ls-files --others --exclude="one" --exclude="!one/a.1" >output &&
+	if grep "^one/a.1" output
+	then
+		false
+	fi
+'
+
+test_expect_success 'negated directory doesn'\''t affect content patterns' '
+
+	git ls-files --others --exclude="!one" --exclude="one/a.1" >output &&
+	if grep "^one/a.1" output
+	then
+		false
+	fi
+'
+
 test_expect_success 'subdirectory ignore (setup)' '
 	mkdir -p top/l1/l2 &&
 	(
-- 
1.8.3.8097.gdc25f02.dirty
