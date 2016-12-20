Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983DC1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 23:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934069AbcLTXUd (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 18:20:33 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36439 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934112AbcLTXUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 18:20:24 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so31035310pfz.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 15:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJdDbEaVNX1jyW92iTJnKCnwJWgBaLKYBEQe7X9/Etk=;
        b=I/869t2g6AVoVhODVTis3NtRq+IJ9VsitxxBBUiHD4f5pHuhvWBFj1VwmaSf8ZrpGR
         5mG8rk/o16EwsIlAwjKLy9uH9QavOQF6V0sgBbOZET6slPuxRNJ2maMFezPLD7GUR96/
         tIg/YgkSklHVpNexrJmGkm2d1tLvr7cuBReiDYGDhK+XwS5KckNdyS37XG6RdBJdT8cY
         3pQ/+k4Qx+CKuRkau4pv87XaaFc8BjlNsafi2lFJmJRmER6DZmuaxN8uWx/uV5eRtqcI
         /tnmLY3lvOa6PQwEB+ZReDIIu0BL+ToUp0gLb5tRVBDinlEoK7UEIQcdiCfesFF4bQGw
         oP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJdDbEaVNX1jyW92iTJnKCnwJWgBaLKYBEQe7X9/Etk=;
        b=W6LsVH1Q3za8Nemn8jo223hlV0kNyR/cCOf9f3g18pQYN/omxfJTm0fxJdBBxm9AHq
         HKN2g8gAQ+Mn1wSWDeWmTMk3ZtfPJq/73jbTmzuh8XnXZ7jJBiFALwCncLR6OiOZqgwV
         chvro0N8G97khOULa4A/O34KtDb9R//IZyrIB/TrfLr6znvx9nxfAcnoqgscs/9yMt08
         gsHA3pXigXx3sN7mLlNioL6H0SuwEOTxXjBfgEqCvU5BpKtmzBFBfVS0nCyFwCLMAu7V
         ArOodcmfz6lSccsji8UM4pKg7OLNH0dyZy4bJ6fo2hAGzUhIjdIqds2Hdk9z1zuEMoJd
         wSJA==
X-Gm-Message-State: AIkVDXL14p/M9mZnAQsoEzQfEgv8RxgrRZpc/aWPx13xpkTW1ZmCig0eP5ehPQDnOKbfeO4f
X-Received: by 10.98.0.143 with SMTP id 137mr1425141pfa.183.1482276022573;
        Tue, 20 Dec 2016 15:20:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6c5b:c771:3806:a807])
        by smtp.gmail.com with ESMTPSA id 64sm41566896pfu.17.2016.12.20.15.20.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Dec 2016 15:20:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, David.Turner@twosigma.com,
        sandals@crustytoothpaste.net, j6t@kdbg.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 4/4] rm: absorb a submodules git dir before deletion
Date:   Tue, 20 Dec 2016 15:20:12 -0800
Message-Id: <20161220232012.15997-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161220232012.15997-1-sbeller@google.com>
References: <20161220232012.15997-1-sbeller@google.com>
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
`depopulate_submodule`. That would couple the check for its git directory
and possible relocation before the the removal, such that it is less
likely to miss the check in the future.  But the indirection with such
a function added seemed also complex. The reason for that was that this
possible move of the git directory was also implemented in
`ok_to_remove_submodule`, such that this function could truthfully
answer whether it is ok to remove the submodule.

The solution proposed here defers all these checks to the caller.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/rm.c  | 79 ++++++++++++++---------------------------------------------
 t/t3600-rm.sh | 39 ++++++++++++-----------------
 2 files changed, 33 insertions(+), 85 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 5a5a66272b..6f2001b0eb 100644
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
@@ -219,13 +197,8 @@ static int check_local_mod(struct object_id *head, int index_only)
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
@@ -247,8 +220,6 @@ static int check_local_mod(struct object_id *head, int index_only)
 			  &errs);
 	string_list_clear(&files_cached, 0);
 
-	error_removing_concrete_submodules(&files_submodule, &errs);
-
 	print_error_files(&files_local,
 			  Q_("the following file has local modifications:",
 			     "the following files have local modifications:",
@@ -342,6 +313,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			exit(0);
 	}
 
+	submodules_absorb_gitdir_if_needed(prefix);
+
 	/*
 	 * If not forced, the file, the index and the HEAD (if exists)
 	 * must match; but the file can already been removed, since
@@ -358,9 +331,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			oidclr(&oid);
 		if (check_local_mod(&oid, index_only))
 			exit(1);
-	} else if (!index_only) {
-		if (check_submodules_use_gitfiles())
-			exit(1);
 	}
 
 	/*
@@ -389,32 +359,20 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 */
 	if (!index_only) {
 		int removed = 0, gitmodules_modified = 0;
-		struct strbuf buf = STRBUF_INIT;
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
+				struct strbuf buf = STRBUF_INIT;
+
+				strbuf_addstr(&buf, path);
+				if (remove_dir_recursively(&buf, 0))
+					die(_("could not remove '%s'"), path);
+				strbuf_release(&buf);
+
+				removed = 1;
+				if (!remove_path_from_gitmodules(path))
+					gitmodules_modified = 1;
+				continue;
 			}
 			if (!remove_path(path)) {
 				removed = 1;
@@ -423,7 +381,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			if (!removed)
 				die_errno("git rm: '%s'", path);
 		}
-		strbuf_release(&buf);
 		if (gitmodules_modified)
 			stage_updated_gitmodules();
 	}
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
2.11.0.rc2.53.gb7b3fba.dirty

