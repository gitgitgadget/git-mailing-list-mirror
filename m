From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v4 1/2] rev-parse: add option --resolve-git-dir <path>
Date: Mon, 15 Aug 2011 23:17:46 +0200
Message-ID: <1313443067-2642-2-git-send-email-iveqy@iveqy.com>
References: <1313443067-2642-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	iveqy@iveqy.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 23:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt4Xb-0004xy-Qg
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 23:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab1HOVRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 17:17:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61755 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab1HOVRk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 17:17:40 -0400
Received: by bke11 with SMTP id 11so3270151bke.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=H+q3Ort+W9TZYFFlpYQxJs6+VC5UrWPo1q0nyFXLHkA=;
        b=bzPfzXz1LvFIXRROSmH9mgpQdzpdg1terMueqLwPF9Q6Md6UsiBcbq7PouUM+9e2av
         QjR49kYm83k5FOUfIX9oSGwUnJu3TWpHSVV29U7hbOV5OyC6ZjEh5CYLyJVLe236I/Hc
         GaagSJLHHmk/5TGSt4On+CE1fkzfhtUTz+50w=
Received: by 10.204.232.202 with SMTP id jv10mr945896bkb.233.1313443058735;
        Mon, 15 Aug 2011 14:17:38 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id r24sm1666364bkr.26.2011.08.15.14.17.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Aug 2011 14:17:37 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qt4Xd-0000hK-FB; Mon, 15 Aug 2011 23:17:49 +0200
X-Mailer: git-send-email 1.7.6.399.gb7922a.dirty
In-Reply-To: <1313443067-2642-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179389>

Check if <path> is a valid git-dir or a valid git-file that points
to a valid git-dir.

We want tests to be independent from the fact that a git-dir may
be a git-file. Thus we changed tests to use this feature.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-rev-parse.txt |    4 ++
 builtin/rev-parse.c             |    8 +++
 cache.h                         |    1 +
 setup.c                         |    7 +++
 t/t7400-submodule-basic.sh      |    4 +-
 t/t7403-submodule-sync.sh       |    5 +-
 t/t7407-submodule-foreach.sh    |  103 ++++++++++++++++++++-------------------
 7 files changed, 78 insertions(+), 54 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 42c9676..8023dc0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -180,6 +180,10 @@ print a message to stderr and exit with nonzero status.
 <args>...::
 	Flags and parameters to be parsed.
 
+--resolve-git-dir <path>::
+	Check if <path> is a valid git-dir or a git-file pointing to a valid
+	git-dir. If <path> is a valid git-dir the resolved path to git-dir will
+	be printed.
 
 include::revisions.txt[]
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4c19f84..98d1cbe 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -468,6 +468,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	if (argc > 2 && !strcmp(argv[1], "--resolve-git-dir")) {
+		const char *gitdir = resolve_gitdir(argv[2]);
+		if (!gitdir)
+			die("not a gitdir '%s'", argv[2]);
+		puts(gitdir);
+		return 0;
+	}
+
 	if (argc > 1 && !strcmp("-h", argv[1]))
 		usage(builtin_rev_parse_usage);
 
diff --git a/cache.h b/cache.h
index 9e12d55..550f632 100644
--- a/cache.h
+++ b/cache.h
@@ -436,6 +436,7 @@ extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile_gently(const char *path);
+extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
diff --git a/setup.c b/setup.c
index 5ea5502..efad002 100644
--- a/setup.c
+++ b/setup.c
@@ -808,3 +808,10 @@ const char *setup_git_directory(void)
 {
 	return setup_git_directory_gently(NULL);
 }
+
+const char *resolve_gitdir(const char *suspect)
+{
+	if (is_git_directory(suspect))
+		return suspect;
+	return read_gitfile_gently(suspect);
+}
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 14dc927..270a7d5 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -360,10 +360,10 @@ test_expect_success 'update --init' '
 	git submodule update init > update.out &&
 	cat update.out &&
 	test_i18ngrep "not initialized" update.out &&
-	! test -d init/.git &&
+	test_must_fail git rev-parse --resolve-git-dir init/.git &&
 
 	git submodule update --init init &&
-	test -d init/.git
+	git rev-parse --resolve-git-dir init/.git
 '
 
 test_expect_success 'do not add files from a submodule' '
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 95ffe34..3620215 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -56,8 +56,9 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	 git pull --no-recurse-submodules &&
 	 git submodule sync
 	) &&
-	test -d "$(git config -f super-clone/submodule/.git/config \
-	                        remote.origin.url)" &&
+	test -d "$(cd super-clone/submodule &&
+	 git config remote.origin.url
+	)" &&
 	(cd super-clone/submodule &&
 	 git checkout master &&
 	 git pull
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index be745fb..9b69fe2 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -118,19 +118,19 @@ test_expect_success 'use "submodule foreach" to checkout 2nd level submodule' '
 	git clone super clone2 &&
 	(
 		cd clone2 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test ! -d nested1/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub1/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub2/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub3/.git &&
+		test_must_fail git rev-parse --resolve-git-dir nested1/.git &&
 		git submodule update --init &&
-		test -d sub1/.git &&
-		test -d sub2/.git &&
-		test -d sub3/.git &&
-		test -d nested1/.git &&
-		test ! -d nested1/nested2/.git &&
+		git rev-parse --resolve-git-dir sub1/.git &&
+		git rev-parse --resolve-git-dir sub2/.git &&
+		git rev-parse --resolve-git-dir sub3/.git &&
+		git rev-parse --resolve-git-dir nested1/.git &&
+		test_must_fail git rev-parse --resolve-git-dir nested1/nested2/.git &&
 		git submodule foreach "git submodule update --init" &&
-		test -d nested1/nested2/.git &&
-		test ! -d nested1/nested2/nested3/.git
+		git rev-parse --resolve-git-dir nested1/nested1/nested2/.git
+		test_must_fail git rev-parse --resolve-git-dir nested1/nested2/nested3/.git
 	)
 '
 
@@ -138,8 +138,8 @@ test_expect_success 'use "foreach --recursive" to checkout all submodules' '
 	(
 		cd clone2 &&
 		git submodule foreach --recursive "git submodule update --init" &&
-		test -d nested1/nested2/nested3/.git &&
-		test -d nested1/nested2/nested3/submodule/.git
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.git
 	)
 '
 
@@ -183,18 +183,18 @@ test_expect_success 'use "update --recursive" to checkout all submodules' '
 	git clone super clone3 &&
 	(
 		cd clone3 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test ! -d nested1/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub1/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub2/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub3/.git &&
+		test_must_fail git rev-parse --resolve-git-dir nested1/.git &&
 		git submodule update --init --recursive &&
-		test -d sub1/.git &&
-		test -d sub2/.git &&
-		test -d sub3/.git &&
-		test -d nested1/.git &&
-		test -d nested1/nested2/.git &&
-		test -d nested1/nested2/nested3/.git &&
-		test -d nested1/nested2/nested3/submodule/.git
+		git rev-parse --resolve-git-dir sub1/.git &&
+		git rev-parse --resolve-git-dir sub2/.git &&
+		git rev-parse --resolve-git-dir sub3/.git &&
+		git rev-parse --resolve-git-dir nested1/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.git
 	)
 '
 
@@ -247,14 +247,17 @@ test_expect_success 'ensure "status --cached --recursive" preserves the --cached
 
 test_expect_success 'use "git clone --recursive" to checkout all submodules' '
 	git clone --recursive super clone4 &&
-	test -d clone4/.git &&
-	test -d clone4/sub1/.git &&
-	test -d clone4/sub2/.git &&
-	test -d clone4/sub3/.git &&
-	test -d clone4/nested1/.git &&
-	test -d clone4/nested1/nested2/.git &&
-	test -d clone4/nested1/nested2/nested3/.git &&
-	test -d clone4/nested1/nested2/nested3/submodule/.git
+	(
+		cd clone4 &&
+		git rev-parse --resolve-git-dir .git &&
+		git rev-parse --resolve-git-dir sub1/.git &&
+		git rev-parse --resolve-git-dir sub2/.git &&
+		git rev-parse --resolve-git-dir sub3/.git &&
+		git rev-parse --resolve-git-dir nested1/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.git
+	)
 '
 
 test_expect_success 'test "update --recursive" with a flag with spaces' '
@@ -262,14 +265,14 @@ test_expect_success 'test "update --recursive" with a flag with spaces' '
 	git clone super clone5 &&
 	(
 		cd clone5 &&
-		test ! -d nested1/.git &&
+		test_must_fail git rev-parse --resolve-git-dir d nested1/.git &&
 		git submodule update --init --recursive --reference="$(dirname "$PWD")/common objects" &&
-		test -d nested1/.git &&
-		test -d nested1/nested2/.git &&
-		test -d nested1/nested2/nested3/.git &&
-		test -f nested1/.git/objects/info/alternates &&
-		test -f nested1/nested2/.git/objects/info/alternates &&
-		test -f nested1/nested2/nested3/.git/objects/info/alternates
+		git rev-parse --resolve-git-dir nested1/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/.git &&
+		test -f .git/modules/nested1/objects/info/alternates &&
+		test -f .git/modules/nested1/modules/nested2/objects/info/alternates &&
+		test -f .git/modules/nested1/modules/nested2/modules/nested3/objects/info/alternates
 	)
 '
 
@@ -277,18 +280,18 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
 	git clone super clone6 &&
 	(
 		cd clone6 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test ! -d nested1/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub1/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub2/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub3/.git &&
+		test_must_fail git rev-parse --resolve-git-dir nested1/.git &&
 		git submodule update --init --recursive -- nested1 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test -d nested1/.git &&
-		test -d nested1/nested2/.git &&
-		test -d nested1/nested2/nested3/.git &&
-		test -d nested1/nested2/nested3/submodule/.git
+		test_must_fail git rev-parse --resolve-git-dir sub1/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub2/.git &&
+		test_must_fail git rev-parse --resolve-git-dir sub3/.git &&
+		git rev-parse --resolve-git-dir nested1/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.git
 	)
 '
 
-- 
1.7.6.398.gb3f84
