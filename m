Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3BD91FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934824AbcLNWla (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:41:30 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36570 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934162AbcLNWl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:41:28 -0500
Received: by mail-pg0-f53.google.com with SMTP id f188so12457271pgc.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WWUiL2kk5XtzTYm90N6T9KV1wMsa9VzL6wiBSVi7Aq0=;
        b=gh60qoeupiW9Popuw4jS/nYmcs3NdGwOZFK2ViemTFGIp0JPBEytMkrob71E0muzDk
         hGY0nH1MZpLku30khA02Nd3uFSRx0zFhlBusLU/gUIQd2+NeeQqwQfAovoXFsCiIOpAt
         0Mff/blV/iv7WoJnkbWflqFAdcProSKG/dmvF1rrBKcprkVEZ9HOctQs4h2e0AFarYW+
         B2R9y071PL8qE9907yssE8u6Xk0d5OJnFkTIDQshBgpwcvg7OJ+K56XStH/liOm90s2H
         tFAzwHa3qjmcQkiNOVmeiitaf0DnrFazxUzoHZUZyfb7dIu3joUWrmb2PrTLDfexx1g3
         LuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WWUiL2kk5XtzTYm90N6T9KV1wMsa9VzL6wiBSVi7Aq0=;
        b=aK9L5OnkRUxIhMjpqFcGOBxkAeLftQRXpTbcDpolcjYYhQvslqQcUOLkRBUJQZMg7J
         vFMtJU2yTNF33FyGhwvI1/5fEKo0oqMCC0Ax4VexFoaB+cEGxteuJpAEXgWOZpXi+d5f
         Vx3A8oHMaG5Q0CLe9wIWPqeHEX7iXDdYxJBNBTSd5wFlq1mTwvs7tNZc+qY1hDgt+YB6
         m8W6WK7aFHLdnywB3vWxSNC6pz4p5nxay6gHx+7ndl+WFv9RXMIbLcIVq3DlKn3kRSLl
         MiWaL0deAVi5HoojpfwIsW/CFnuED3BwVc6lp/iWTLsIqvWnShyeTq9IDmqqKDa5fpD4
         nkOw==
X-Gm-Message-State: AKaTC01L2g070dnRlO/s6peSC4ka9QFOTxkSSwdM+wLZ9I62VaxYaama09jwsV9vOjhMnXH9
X-Received: by 10.84.197.1 with SMTP id m1mr213095087pld.159.1481755273160;
        Wed, 14 Dec 2016 14:41:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:8d0f:31e2:8611:d98a])
        by smtp.gmail.com with ESMTPSA id o29sm90147313pgn.28.2016.12.14.14.41.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:41:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/4] rm: add absorb a submodules git dir before deletion
Date:   Wed, 14 Dec 2016 14:41:01 -0800
Message-Id: <20161214224101.6211-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161214224101.6211-1-sbeller@google.com>
References: <20161214224101.6211-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When deleting a submodule, we need to keep the actual git directory around,
such that we do not lose local changes in there and at a later checkout
of the submodule we don't need to clone it again.

Now that the functionality is available to absorb the git directory of a
submodule, rewrite the checking in git-rm to not complain, but rather
relocate the git directories inside the superproject.

An alternative solution was discussed to have a function
`depopulate_submodule`, that couples the check for its git directory and
possible relocation before the the removal, such that it is less likely to
miss the check in the future, but the indirection with such a function
added seemed also complex. The reason for that was that this possible
move of the git directory was also implemented in `ok_to_remove_submodule`,
such that this function could truthfully answer whether it is ok to remove
the submodule.

The solution proposed here defers all these checks to the caller.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/rm.c  | 75 ++++++++++++++---------------------------------------------
 cache.h       |  2 ++
 entry.c       |  8 +++++++
 t/t3600-rm.sh | 39 ++++++++++++-------------------
 4 files changed, 42 insertions(+), 82 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index fdd7183f61..025ef4c735 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -59,27 +59,9 @@ static void print_error_files(struct string_list *files_list,
 	}
 }
 
-static void error_removing_concrete_submodules(struct string_list *files, int *errs)
-{
-	print_error_files(files,
-			  Q_("the following submodule (or one of its nested "
-			     "submodules)\n"
-			     "uses a .git directory:",
-			     "the following submodules (or one of their nested "
-			     "submodules)\n"
-			     "use a .git directory:", files->nr),
-			  _("\n(use 'rm -rf' if you really want to remove "
-			    "it including all of its history)"),
-			  errs);
-	string_list_clear(files, 0);
-}
-
-static int check_submodules_use_gitfiles(void)
+static void submodules_absorb_gitdir_if_needed(const char *prefix)
 {
 	int i;
-	int errs = 0;
-	struct string_list files = STRING_LIST_INIT_NODUP;
-
 	for (i = 0; i < list.nr; i++) {
 		const char *name = list.entry[i].name;
 		int pos;
@@ -99,12 +81,9 @@ static int check_submodules_use_gitfiles(void)
 			continue;
 
 		if (!submodule_uses_gitfile(name))
-			string_list_append(&files, name);
+			absorb_git_dir_into_superproject(prefix, name,
+				ABSORB_GITDIR_RECURSE_SUBMODULES);
 	}
-
-	error_removing_concrete_submodules(&files, &errs);
-
-	return errs;
 }
 
 static int check_local_mod(struct object_id *head, int index_only)
@@ -120,7 +99,6 @@ static int check_local_mod(struct object_id *head, int index_only)
 	int errs = 0;
 	struct string_list files_staged = STRING_LIST_INIT_NODUP;
 	struct string_list files_cached = STRING_LIST_INIT_NODUP;
-	struct string_list files_submodule = STRING_LIST_INIT_NODUP;
 	struct string_list files_local = STRING_LIST_INIT_NODUP;
 
 	no_head = is_null_oid(head);
@@ -218,13 +196,8 @@ static int check_local_mod(struct object_id *head, int index_only)
 		else if (!index_only) {
 			if (staged_changes)
 				string_list_append(&files_cached, name);
-			if (local_changes) {
-				if (S_ISGITLINK(ce->ce_mode) &&
-				    !submodule_uses_gitfile(name))
-					string_list_append(&files_submodule, name);
-				else
-					string_list_append(&files_local, name);
-			}
+			if (local_changes)
+				string_list_append(&files_local, name);
 		}
 	}
 	print_error_files(&files_staged,
@@ -246,8 +219,6 @@ static int check_local_mod(struct object_id *head, int index_only)
 			  &errs);
 	string_list_clear(&files_cached, 0);
 
-	error_removing_concrete_submodules(&files_submodule, &errs);
-
 	print_error_files(&files_local,
 			  Q_("the following file has local modifications:",
 			     "the following files have local modifications:",
@@ -341,6 +312,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			exit(0);
 	}
 
+	submodules_absorb_gitdir_if_needed(prefix);
+
 	/*
 	 * If not forced, the file, the index and the HEAD (if exists)
 	 * must match; but the file can already been removed, since
@@ -357,9 +330,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			oidclr(&oid);
 		if (check_local_mod(&oid, index_only))
 			exit(1);
-	} else if (!index_only) {
-		if (check_submodules_use_gitfiles())
-			exit(1);
 	}
 
 	/*
@@ -393,27 +363,16 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			const char *path = list.entry[i].name;
 			if (list.entry[i].is_submodule) {
 				if (is_empty_dir(path)) {
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
+					if (rmdir(path))
+						die_errno("git rm: '%s'", path);
+				} else if (file_exists(path))
+					/* non empty directory: */
+					remove_directory_or_die(path);
+
+				removed = 1;
+				if (!remove_path_from_gitmodules(path))
+					gitmodules_modified = 1;
+				continue;
 			}
 			if (!remove_path(path)) {
 				removed = 1;
diff --git a/cache.h b/cache.h
index a50a61a197..3a423af59b 100644
--- a/cache.h
+++ b/cache.h
@@ -2018,4 +2018,6 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+extern void remove_directory_or_die(const char *path);
+
 #endif /* CACHE_H */
diff --git a/entry.c b/entry.c
index c6eea240b6..ddd4cfb2bf 100644
--- a/entry.c
+++ b/entry.c
@@ -73,6 +73,14 @@ static void remove_subtree(struct strbuf *path)
 		die_errno("cannot rmdir '%s'", path->buf);
 }
 
+void remove_directory_or_die(const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_addstr(&sb, path);
+	remove_subtree(&sb);
+	strbuf_release(&sb);
+}
+
 static int create_file(const char *path, unsigned int mode)
 {
 	mode = (mode & 0100) ? 0777 : 0666;
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

