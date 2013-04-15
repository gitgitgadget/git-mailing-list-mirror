From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 07/14] dir.c: git-clean -d -X: don't delete tracked directories
Date: Mon, 15 Apr 2013 21:10:05 +0200
Message-ID: <516C508D.2050200@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Apr 15 21:10:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URonA-00034D-IL
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934940Ab3DOTKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:10:09 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:56366 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892Ab3DOTKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:10:07 -0400
Received: by mail-ea0-f176.google.com with SMTP id h10so2406620eaj.35
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BbWwCBBDE6vwdbt2UO6UB7xalrg8hxvWK8QSMqFOJOs=;
        b=fzERrjEvps48wM4BPhFAfXMKiChis+EZO8UMqRTzF1rvqN3NGsvYF4oglu4IJMEJFg
         tr06z1wNaZEpcajvIvInDoJlq6jJ+qqmYAYoN0tr43Y56FVrMXxLImYxfsmy14fgduVY
         14Vwjpw6ME3lxhLIx1NT7KYdClx0z1FzlunMycoiColt5XP+8raHhSjqksE3PH5CSv0v
         4FFaBnAhbSg3LxTiL+OsXxRCoP+o9g8lqukeVaaqymPAC+25T9Al5/ROyo3sqfLdur7r
         oHLRXT5Yjn7pi6jgADZQk0YsZNNmRaycL/8iBjqFUzKO4zFM9k2HFnQFFTwiIBeVpuK4
         IwXg==
X-Received: by 10.15.36.2 with SMTP id h2mr65674939eev.2.1366053005906;
        Mon, 15 Apr 2013 12:10:05 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id bk42sm28398098eeb.3.2013.04.15.12.10.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:10:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221296>

The notion of "ignored tracked" directories introduced in 721ac4ed "dir.c:
Make git-status --ignored more consistent" has a few unwanted side effects:

 - git-clean -d -X: deletes ignored tracked directories. git-clean should
   never delete tracked content.

 - git-ls-files --ignored --other --directory: lists ignored tracked
   directories instead of "other" directories.

 - git-status --ignored: lists ignored tracked directories while contained
   files may be listed as modified. Paths listed by git-status should be
   disjoint (except in long format where a path may be listed in both the
   staged and unstaged section).

Additionally, the current behaviour violates documentation in gitignore(5)
("Specifies intentionally *untracked* files to ignore") and Documentation/
technical/api-directory-listing.txt ("DIR_SHOW_OTHER_DIRECTORIES: Include
a directory that is *not tracked*.").

In dir.c::treat_directory, remove the special handling of ignored tracked
directories, so that the DIR_SHOW_OTHER_DIRECTORIES flag only affects
"other" (i.e. untracked) directories. In dir.c::dir_add_name, check that
added paths are untracked even if DIR_SHOW_IGNORED is set.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c                              | 11 +++--------
 t/t3001-ls-files-others-exclude.sh | 26 ++++++++++++++++++++++++++
 t/t7061-wtstatus-ignore.sh         |  6 +++---
 t/t7300-clean.sh                   | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index 822e501..f10fb69 100644
--- a/dir.c
+++ b/dir.c
@@ -897,8 +897,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (!(dir->flags & DIR_SHOW_IGNORED) &&
-	    cache_name_exists(pathname, len, ignore_case))
+	if (cache_name_exists(pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
@@ -1000,9 +999,8 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  * traversal routine.
  *
  * Case 1: If we *already* have entries in the index under that
- * directory name, we recurse into the directory to see all the files,
- * unless the directory is excluded and we want to show ignored
- * directories
+ * directory name, we always recurse into the directory to see
+ * all the files.
  *
  * Case 2: If we *already* have that directory name as a gitlink,
  * we always continue to see it as a gitlink, regardless of whether
@@ -1037,9 +1035,6 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(dirname, len-1)) {
 	case index_directory:
-		if ((dir->flags & DIR_SHOW_OTHER_DIRECTORIES) && exclude)
-			break;
-
 		return recurse_into_directory;
 
 	case index_gitdir:
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 859da35..ec4fae2 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -237,6 +237,32 @@ test_expect_success 'hide empty ignored directory with --no-empty-directory' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show/hide empty ignored sub-directory (setup)' '
+	> top/l1/tracked &&
+	(
+		cd top &&
+		git add -f l1/tracked
+	)
+'
+
+test_expect_success 'show empty ignored sub-directory with --directory' '
+	(
+		cd top &&
+		git ls-files -o -i --exclude l1 --directory
+	) >actual &&
+	echo l1/l2/ >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'hide empty ignored sub-directory with --no-empty-directory' '
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
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 4c6f145..460789b 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -186,7 +186,7 @@ cat >expected <<\EOF
 ?? .gitignore
 ?? actual
 ?? expected
-!! tracked/
+!! tracked/uncommitted
 EOF
 
 test_expect_success 'status ignored tracked directory and uncommitted file with --ignore' '
@@ -212,7 +212,7 @@ cat >expected <<\EOF
 ?? .gitignore
 ?? actual
 ?? expected
-!! tracked/
+!! tracked/ignored/
 EOF
 
 test_expect_success 'status ignored tracked directory with uncommitted file in untracked subdir with --ignore' '
@@ -239,7 +239,7 @@ cat >expected <<\EOF
 ?? .gitignore
 ?? actual
 ?? expected
-!! tracked/
+!! tracked/ignored/uncommitted
 EOF
 
 test_expect_success 'status ignored tracked directory with uncommitted file in tracked subdir with --ignore' '
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index ccfb54d..710be90 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -298,6 +298,23 @@ test_expect_success 'git clean -d -x' '
 
 '
 
+test_expect_success 'git clean -d -x with ignored tracked directory' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	git clean -d -x -e src &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f src/part3.c &&
+	test ! -d docs &&
+	test ! -f obj.o &&
+	test ! -d build
+
+'
+
 test_expect_success 'git clean -X' '
 
 	mkdir -p build docs &&
@@ -332,6 +349,23 @@ test_expect_success 'git clean -d -X' '
 
 '
 
+test_expect_success 'git clean -d -X with ignored tracked directory' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	git clean -d -X -e src &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f src/part3.c &&
+	test -f docs/manual.txt &&
+	test ! -f obj.o &&
+	test ! -d build
+
+'
+
 test_expect_success 'clean.requireForce defaults to true' '
 
 	git config --unset clean.requireForce &&
-- 
1.8.1.2.8026.g2b66448.dirty
