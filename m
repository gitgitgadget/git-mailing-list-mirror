Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CBFD1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933341AbcLSX3o (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:29:44 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:38491 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932826AbcLSX2v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:28:51 -0500
Received: by mail-it0-f46.google.com with SMTP id x2so8467283itf.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M7upMmtZVZuRc8K/EeerQNAMRqPO4Ook3pi7ASyQjWM=;
        b=j84N5gDdF4Ismzv6X5n8bG/RKy9RxIO+0G+XwI4+f7YYh0JKVkqkLvSp2lSz/wLWVQ
         VjuaoipQE4MeILCa1ufVy/L6JPlzWcV2zyuHQtNssJ240GmunfEcmYds+CmdrnOYgpp/
         hDikhHaLs5jQvVyTLQo4BncrYKFd15ZWy8UURjn1fo+jDcDFhxK1nHItOwIPA8e5R9be
         H/Bwe0vrfsPFDr0z0VtfEIaq3tticJQWFuKewmE6G65wBcZ/9KsnY3WFO7GG0LX3Awkp
         T40Kw2ed5PIxNb1T2JN4X4SW5Zqc0/XUApPWpVCyeHnEluTgkHzybJHNn2B9Yp+te7Fk
         nXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M7upMmtZVZuRc8K/EeerQNAMRqPO4Ook3pi7ASyQjWM=;
        b=qKtlkHM7MOEUMomFk18mGq+/qPY/keno73ajJz7MnNuk+pqbh6CfaiE89B3+ArAff2
         O4EIc55IPjnRwvLTpU9tklX8C8GrEPjscbEjqOKe1xwi2xgO1lD57JniG6T/DSlfvva+
         Qof9u3tfpvHa3cQclW8yf/f4mEUPuZhVpNgdym/VO+DWPDNnf1Hj1zuSDLLepaz1OFry
         JwROYDliE7p0CywVNqWlJ+zMAWi+et28ngUDc5DFyoSv4RRHVqBHJkiG0muU90dUeE7R
         XJ0eysEluXfO84uzhYc5IiCja2FlKXQdrgBEEkDRMszySllOH2geRwnPpHl9rL2l5/i0
         McgA==
X-Gm-Message-State: AKaTC03X745nmhiIet1Jyhr2qm2BMWU97y0K/NT7ml7S+37n/KDSBIWV9o8jwAayITIh78uA
X-Received: by 10.36.83.3 with SMTP id n3mr19176350itb.95.1482190130747;
        Mon, 19 Dec 2016 15:28:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2c2e:3e21:f7c2:2ccc])
        by smtp.gmail.com with ESMTPSA id y125sm7859302ity.13.2016.12.19.15.28.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 15:28:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        sandals@crustytoothpaste.net, David.Turner@twosigma.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 5/5] rm: absorb a submodules git dir before deletion
Date:   Mon, 19 Dec 2016 15:28:28 -0800
Message-Id: <20161219232828.5075-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161219232828.5075-1-sbeller@google.com>
References: <20161219232828.5075-1-sbeller@google.com>
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
index fdd7183f61..ed758f7144 100644
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
@@ -388,32 +358,20 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
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
@@ -422,7 +380,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
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

