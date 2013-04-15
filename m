From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 04/14] dir.c: git-ls-files --directories: don't hide empty
 directories
Date: Mon, 15 Apr 2013 21:08:02 +0200
Message-ID: <516C5012.80306@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 15 21:08:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URol8-0000IG-Va
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934898Ab3DOTIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:08:06 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:55587 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab3DOTIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:08:05 -0400
Received: by mail-ea0-f174.google.com with SMTP id m14so2322206eaj.5
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Ve7diMJa4mdz3VeWjc1GUOYh7LlxdCZ0REndbCn3irs=;
        b=bFWovcG1sn+vJvWDwlCDJLtDRjPiWkmSSL28+7U02DfLmsjCd7PY6GQxloNcH6QSgw
         cor1rA0Okjex2EUDbuhhAVi6jGzi4Dp+ZV93FD+XkvO96avopig6UXiYbui86Ybi2m+7
         h6p8ww1kaf3u5psKyloSeT0Bep93DbZU35oDcWkOtVwCmV+cGr16nS3O846CKNwqa2UG
         tudCmLlYfo0RIinIsGs1NC68s7VY1+/s362/3Km+Q4nLHDuQKcqRY6ycISaUoLP1fWPy
         ZZVWc31goj6EvEHwYIJXgu9XFb8nvy1LjTzkxZmtLAkPR4MHHtWcp3vmWPwVjUDvZ7lx
         LdAg==
X-Received: by 10.14.107.69 with SMTP id n45mr65066652eeg.23.1366052883309;
        Mon, 15 Apr 2013 12:08:03 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id b47sm8814510eez.2.2013.04.15.12.08.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:08:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221293>

'git-ls-files --ignored --directories' hides empty directories even though
--no-empty-directory was not specified.

Treat the DIR_HIDE_EMPTY_DIRECTORIES flag independently from
DIR_SHOW_IGNORED to make all git-ls-files options work as expected.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c                              |  6 ++----
 t/t3001-ls-files-others-exclude.sh | 23 +++++++++++++++++++++++
 wt-status.c                        |  2 +-
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index fd1f088..1112b05 100644
--- a/dir.c
+++ b/dir.c
@@ -1076,15 +1076,13 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 	if ((dir->flags & DIR_SHOW_IGNORED) && !exclude) {
 		int ignored;
 		dir->flags &= ~DIR_SHOW_IGNORED;
-		dir->flags |= DIR_HIDE_EMPTY_DIRECTORIES;
 		ignored = read_directory_recursive(dir, dirname, len, 1, simplify);
-		dir->flags &= ~DIR_HIDE_EMPTY_DIRECTORIES;
 		dir->flags |= DIR_SHOW_IGNORED;
 
 		return ignored ? ignore_directory : show_directory;
 	}
-	if (!(dir->flags & DIR_SHOW_IGNORED) &&
-	    !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
+
+	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return show_directory;
 	if (!read_directory_recursive(dir, dirname, len, 1, simplify))
 		return ignore_directory;
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index efb7ebc..859da35 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -214,6 +214,29 @@ test_expect_success 'subdirectory ignore (l1)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show/hide empty ignored directory (setup)' '
+	rm top/l1/l2/l1 &&
+	rm top/l1/.gitignore
+'
+
+test_expect_success 'show empty ignored directory with --directory' '
+	(
+		cd top &&
+		git ls-files -o -i --exclude l1 --directory
+	) >actual &&
+	echo l1/ >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'hide empty ignored directory with --no-empty-directory' '
+	(
+		cd top &&
+		git ls-files -o -i --exclude l1 --directory --no-empty-directory
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pattern matches prefix completely' '
 	: >expect &&
 	git ls-files -i -o --exclude "/three/a.3[abc]" >actual &&
diff --git a/wt-status.c b/wt-status.c
index ef405d0..79eb124 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -518,7 +518,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		dir.nr = 0;
 		dir.flags = DIR_SHOW_IGNORED;
 		if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
-			dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
+			dir.flags |= DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 		fill_directory(&dir, s->pathspec);
 		for (i = 0; i < dir.nr; i++) {
 			struct dir_entry *ent = dir.entries[i];
-- 
1.8.1.2.8026.g2b66448.dirty
