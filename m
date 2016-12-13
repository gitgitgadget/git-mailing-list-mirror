Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B20209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 20:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941136AbcLMU5j (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:57:39 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34192 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934864AbcLMU5f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:57:35 -0500
Received: by mail-pg0-f47.google.com with SMTP id x23so51404744pgx.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=piDuMCyOj4kyDK2eAoxgibAKSYBri3voBYFjUNgT/xo=;
        b=GqI5QPvQtDL7YuzaTUJkcRE83YIoy5RDz8wQj/fkvQ3u73LJa9a8qNrBiimA/W+OIo
         oXVq8mYM+Jv9JjmWl6YQ7la0gGAl4cMKmOYMWvbMGPvq6RsNfe/MFrQhqoaS80ip6P2S
         Bobe+eyfYZJnzBvMkMyKE7qj8rYAxHNWrsMGOetk9C75wKHzCU5u6va8XJS3nNtdb1b4
         AgjUZBjPzw2uq4tu41ESyCum6tQ4fRtfG601RBuxHQHsSslirYf5fpdKXU4yrZLRhPYt
         X2PZZDCcyOvPVt5LyJeJ6h5BR8fFRm9Ry/P27OMqqHuCzFOABEDwfDqsBXGC5TnlDEpa
         mwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=piDuMCyOj4kyDK2eAoxgibAKSYBri3voBYFjUNgT/xo=;
        b=WsQdcuiyA4qmEzBvEu2rTS+V7fFS4bk06IMUGfS/ul3j1gv2td+mml+LQRmG61G899
         m+M/pHPmKKxw2x8eC28EXv2kTksj1gIwkz/NJZIpQuA8xH3nTbagXERzgfJDOXD97Of8
         xEFa57lGTg3ETnBZp82ywzL/mGXawA3bqwWN2x81lQiGqI1/v1BsMLmndbLVdqK6vM7D
         UoS15rDhb5d3ERZO0DMClS89b0vDCyPtKKVWWaBW6bxRtuFK00N1FTubZvDkwYOxt3wn
         4BV04VaofvSMjv7fW9ioQRpLynVzGGMDFJTc11+yHhagDxQ/o3GYr875wYl6lXY8R8Ud
         0xng==
X-Gm-Message-State: AKaTC00ynYz/qRG1mP98zKULmgZ5naj2gKy1Q2DS/b71hiXZW1uqDz6KKTLYYIiiZtu4PRAf
X-Received: by 10.99.115.82 with SMTP id d18mr176536800pgn.56.1481662595888;
        Tue, 13 Dec 2016 12:56:35 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:5b5:8785:ab45:d22f])
        by smtp.gmail.com with ESMTPSA id 65sm82075430pfn.12.2016.12.13.12.56.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 12:56:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/5] rm: add absorb a submodules git dir before deletion
Date:   Tue, 13 Dec 2016 12:56:22 -0800
Message-Id: <20161213205622.841-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161213205622.841-1-sbeller@google.com>
References: <20161213205622.841-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When deleting a submodule, we need to keep the actual git directory around,
such that we do not lose local changes in there and at a later checkout
of the submodule we don't need to clone it again.

Implement `depopulate_submodule`, that migrates the git directory before
deletion of a submodule and afterwards the equivalent of "rm -rf", which
is already found in entry.c, so expose that and for clarity add a suffix
"_or_die" to it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/rm.c  | 30 ++++++++----------------------
 cache.h       |  2 ++
 entry.c       |  5 +++++
 submodule.c   | 31 +++++++++++++++++++++++++++++++
 submodule.h   |  6 ++++++
 t/t3600-rm.sh | 39 +++++++++++++++------------------------
 6 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index fdd7183f61..8c9c535a88 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -392,28 +392,14 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.entry[i].name;
 			if (list.entry[i].is_submodule) {
-				if (is_empty_dir(path)) {
-					if (!rmdir(path)) {
-						removed = 1;
-						if (!remove_path_from_gitmodules(path))
-							gitmodules_modified = 1;
-						continue;
-					}
-				} else {
-					strbuf_reset(&buf);
-					strbuf_addstr(&buf, path);
-					if (!remove_dir_recursively(&buf, 0)) {
-						removed = 1;
-						if (!remove_path_from_gitmodules(path))
-							gitmodules_modified = 1;
-						strbuf_release(&buf);
-						continue;
-					} else if (!file_exists(path))
-						/* Submodule was removed by user */
-						if (!remove_path_from_gitmodules(path))
-							gitmodules_modified = 1;
-					/* Fallthrough and let remove_path() fail. */
-				}
+				if (is_empty_dir(path) && rmdir(path))
+					die_errno("git rm: '%s'", path);
+				if (file_exists(path))
+					depopulate_submodule(path);
+				removed = 1;
+				if (!remove_path_from_gitmodules(path))
+					gitmodules_modified = 1;
+				continue;
 			}
 			if (!remove_path(path)) {
 				removed = 1;
diff --git a/cache.h b/cache.h
index a50a61a197..b645ca2f9a 100644
--- a/cache.h
+++ b/cache.h
@@ -2018,4 +2018,6 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+extern void remove_directory_or_die(struct strbuf *path);
+
 #endif /* CACHE_H */
diff --git a/entry.c b/entry.c
index c6eea240b6..02c4ac9f22 100644
--- a/entry.c
+++ b/entry.c
@@ -73,6 +73,11 @@ static void remove_subtree(struct strbuf *path)
 		die_errno("cannot rmdir '%s'", path->buf);
 }
 
+void remove_directory_or_die(struct strbuf *path)
+{
+	remove_subtree(path);
+}
+
 static int create_file(const char *path, unsigned int mode)
 {
 	mode = (mode & 0100) ? 0777 : 0666;
diff --git a/submodule.c b/submodule.c
index e42efa2337..3770ecb7b9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -308,6 +308,37 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
+void depopulate_submodule(const char *path)
+{
+	struct strbuf pathbuf = STRBUF_INIT;
+	char *dot_git = xstrfmt("%s/.git", path);
+
+	/* Is it populated? */
+	if (!resolve_gitdir(dot_git))
+		goto out;
+
+	/* Does it have a .git directory? */
+	if (!submodule_uses_gitfile(path)) {
+		absorb_git_dir_into_superproject("", path,
+			ABSORB_GITDIR_RECURSE_SUBMODULES);
+
+		if (!submodule_uses_gitfile(path)) {
+			/*
+			 * We should be using a gitfile by now. Let's double
+			 * check as losing the git dir would be fatal.
+			 */
+			die("BUG: could not absorb git directory for '%s'", path);
+		}
+	}
+
+	strbuf_addstr(&pathbuf, path);
+	remove_directory_or_die(&pathbuf);
+
+out:
+	strbuf_release(&pathbuf);
+	free(dot_git);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
diff --git a/submodule.h b/submodule.h
index 3ed3aa479a..516e377a12 100644
--- a/submodule.h
+++ b/submodule.h
@@ -53,6 +53,12 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
+
+/*
+ * Removes a submodule from a given path. When the submodule contains its
+ * git directory instead of a gitlink, migrate that first into the superproject.
+ */
+extern void depopulate_submodule(const char *path);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index bcbb680651..5aa6db584c 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -569,26 +569,22 @@ test_expect_success 'rm of a conflicted unpopulated submodule succeeds' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rm of a populated submodule with a .git directory fails even when forced' '
+test_expect_success 'rm of a populated submodule with a .git directory migrates git dir' '
 	git checkout -f master &&
 	git reset --hard &&
 	git submodule update &&
 	(cd submod &&
 		rm .git &&
 		cp -R ../.git/modules/sub .git &&
-		GIT_WORK_TREE=. git config --unset core.worktree
+		GIT_WORK_TREE=. git config --unset core.worktree &&
+		rm -r ../.git/modules/sub
 	) &&
-	test_must_fail git rm submod &&
-	test -d submod &&
-	test -d submod/.git &&
-	git status -s -uno --ignore-submodules=none >actual &&
-	! test -s actual &&
-	test_must_fail git rm -f submod &&
-	test -d submod &&
-	test -d submod/.git &&
+	git rm submod 2>output.err &&
+	! test -d submod &&
+	! test -d submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	! test -s actual &&
-	rm -rf submod
+	test -s actual &&
+	test_i18ngrep Migrating output.err
 '
 
 cat >expect.deepmodified <<EOF
@@ -667,24 +663,19 @@ test_expect_success 'rm of a populated nested submodule with a nested .git direc
 	git submodule update --recursive &&
 	(cd submod/subsubmod &&
 		rm .git &&
-		cp -R ../../.git/modules/sub/modules/sub .git &&
+		mv ../../.git/modules/sub/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
-	test_must_fail git rm submod &&
-	test -d submod &&
-	test -d submod/subsubmod/.git &&
-	git status -s -uno --ignore-submodules=none >actual &&
-	! test -s actual &&
-	test_must_fail git rm -f submod &&
-	test -d submod &&
-	test -d submod/subsubmod/.git &&
+	git rm submod 2>output.err &&
+	! test -d submod &&
+	! test -d submod/subsubmod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	! test -s actual &&
-	rm -rf submod
+	test -s actual &&
+	test_i18ngrep Migrating output.err
 '
 
 test_expect_success 'checking out a commit after submodule removal needs manual updates' '
-	git commit -m "submodule removal" submod &&
+	git commit -m "submodule removal" submod .gitmodules &&
 	git checkout HEAD^ &&
 	git submodule update &&
 	git checkout -q HEAD^ &&
-- 
2.11.0.rc2.35.g26e18c9

