From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v3 1/2] rev-parse: add option --is-well-formed-git-dir [path]
Date: Fri, 12 Aug 2011 21:55:12 +0200
Message-ID: <1313178913-25617-2-git-send-email-iveqy@iveqy.com>
References: <1313178913-25617-1-git-send-email-iveqy@iveqy.com>
Cc: iveqy@iveqy.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 21:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrxpE-0007zM-N8
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 21:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab1HLTzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 15:55:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab1HLTzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 15:55:06 -0400
Received: by fxh19 with SMTP id 19so2518436fxh.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 12:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+2oJJnE+kVQpOnzt52IVHjvP9kKu/KSjjMT3w/PtwwA=;
        b=SiSHS2KYz/p5Bqjqona26f6J/3nqZDgAdFWdQZ1lYYN0aOPVtVhWXsDGmGfTplun/q
         t1wQezENMlrGuauzHqB8PXr7SM0XHEaudgKQ0AaKm31pVAvvhaPNqdgDCPVuD4+8JelV
         uAUDlAhgqGZv5BvOsbjL1QgQ2aZOkn0rIRN7I=
Received: by 10.223.15.81 with SMTP id j17mr1791299faa.20.1313178904573;
        Fri, 12 Aug 2011 12:55:04 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id q3sm2242209faa.39.2011.08.12.12.55.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 12:55:03 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qrxp6-0006fo-Ew; Fri, 12 Aug 2011 21:55:16 +0200
X-Mailer: git-send-email 1.7.6.403.g1fd2f.dirty
In-Reply-To: <1313178913-25617-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179245>

Check if [path] is a valid git-dir or a valid git-file that points
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
 t/t7407-submodule-foreach.sh    |   97 ++++++++++++++++++++-------------------
 7 files changed, 75 insertions(+), 51 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 42c9676..3ce81c0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -180,6 +180,10 @@ print a message to stderr and exit with nonzero status.
 <args>...::
 	Flags and parameters to be parsed.
 
+--is-well-formed-git-dir [path]::
+	Check if [path] is a valid git-dir or a git-file pointing to a valid
+	git-dir. If [path] is a valid git-dir the resolved path to git-dir will
+	be printed.
 
 include::revisions.txt[]
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4c19f84..21ac43f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -468,6 +468,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	if (argc > 2 && !strcmp(argv[1], "--is-well-formed-git-dir")) {
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
index 14dc927..4df53e5 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -360,10 +360,10 @@ test_expect_success 'update --init' '
 	git submodule update init > update.out &&
 	cat update.out &&
 	test_i18ngrep "not initialized" update.out &&
-	! test -d init/.git &&
+	test_must_fail git rev-parse --is-well-formed-git-dir init/.git &&
 
 	git submodule update --init init &&
-	test -d init/.git
+	git rev-parse --is-well-formed-git-dir init/.git
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
index be745fb..1a974e2 100755
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
+		test_must_fail git rev-parse --is-well-formed-git-dir sub1/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir sub2/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir sub3/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir nested1/.git &&
 		git submodule update --init &&
-		test -d sub1/.git &&
-		test -d sub2/.git &&
-		test -d sub3/.git &&
-		test -d nested1/.git &&
-		test ! -d nested1/nested2/.git &&
+		git rev-parse --is-well-formed-git-dir sub1/.git &&
+		git rev-parse --is-well-formed-git-dir sub2/.git &&
+		git rev-parse --is-well-formed-git-dir sub3/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir nested1/nested2/.git &&
 		git submodule foreach "git submodule update --init" &&
-		test -d nested1/nested2/.git &&
-		test ! -d nested1/nested2/nested3/.git
+		git rev-parse --is-well-formed-git-dir nested1/nested1/nested2/.git
+		test_must_fail git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/.git
 	)
 '
 
@@ -138,8 +138,8 @@ test_expect_success 'use "foreach --recursive" to checkout all submodules' '
 	(
 		cd clone2 &&
 		git submodule foreach --recursive "git submodule update --init" &&
-		test -d nested1/nested2/nested3/.git &&
-		test -d nested1/nested2/nested3/submodule/.git
+		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/submodule/.git
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
+		test_must_fail git rev-parse --is-well-formed-git-dir sub1/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir sub2/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir sub3/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir nested1/.git &&
 		git submodule update --init --recursive &&
-		test -d sub1/.git &&
-		test -d sub2/.git &&
-		test -d sub3/.git &&
-		test -d nested1/.git &&
-		test -d nested1/nested2/.git &&
-		test -d nested1/nested2/nested3/.git &&
-		test -d nested1/nested2/nested3/submodule/.git
+		git rev-parse --is-well-formed-git-dir sub1/.git &&
+		git rev-parse --is-well-formed-git-dir sub2/.git &&
+		git rev-parse --is-well-formed-git-dir sub3/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/submodule/.git
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
+		git rev-parse --is-well-formed-git-dir .git &&
+		git rev-parse --is-well-formed-git-dir sub1/.git &&
+		git rev-parse --is-well-formed-git-dir sub2/.git &&
+		git rev-parse --is-well-formed-git-dir sub3/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/submodule/.git
+	)
 '
 
 test_expect_success 'test "update --recursive" with a flag with spaces' '
@@ -262,11 +265,11 @@ test_expect_success 'test "update --recursive" with a flag with spaces' '
 	git clone super clone5 &&
 	(
 		cd clone5 &&
-		test ! -d nested1/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir d nested1/.git &&
 		git submodule update --init --recursive --reference="$(dirname "$PWD")/common objects" &&
-		test -d nested1/.git &&
-		test -d nested1/nested2/.git &&
-		test -d nested1/nested2/nested3/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/.git &&
 		test -f nested1/.git/objects/info/alternates &&
 		test -f nested1/nested2/.git/objects/info/alternates &&
 		test -f nested1/nested2/nested3/.git/objects/info/alternates
@@ -277,18 +280,18 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
 	git clone super clone6 &&
 	(
 		cd clone6 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test ! -d nested1/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir sub1/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir sub2/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir sub3/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir nested1/.git &&
 		git submodule update --init --recursive -- nested1 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test -d nested1/.git &&
-		test -d nested1/nested2/.git &&
-		test -d nested1/nested2/nested3/.git &&
-		test -d nested1/nested2/nested3/submodule/.git
+		test_must_fail git rev-parse --is-well-formed-git-dir sub1/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir sub2/.git &&
+		test_must_fail git rev-parse --is-well-formed-git-dir sub3/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/.git &&
+		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/submodule/.git
 	)
 '
 
-- 
1.7.6.403.g1fd2f.dirty
