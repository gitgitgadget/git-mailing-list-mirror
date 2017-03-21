Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5C420958
	for <e@80x24.org>; Tue, 21 Mar 2017 00:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755830AbdCUATn (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:19:43 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:32858 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754143AbdCUATm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:19:42 -0400
Received: by mail-pg0-f42.google.com with SMTP id n190so85105202pga.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 17:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0HxXFCVYTnfJtlXPtSsB7lY9VGFGDzyx3qF147YbEk=;
        b=vHxPuROewzffGdKpjbKshEBeaEk1mDLa8x+XDt7eNKqymNYAX6Sj+sZwf7v/80mnK2
         8agjKpYiq7zoRUtm30tkjlhPXj/4ThcEN5n+TTDoZAh4t926G8Z3kJKiv/PFQ1Xf5x35
         7DIeF3IzxnWOxIl8VAbTCpofyJ/CCpW95n8G214n3+v/6XajLv9SboeAhXSgzWMRdOuu
         ObAJj3f4jCsS0gChIDjqtvnFgPvKo0g0zKzHkQnCgQO4CwDpD8XtuQleROMIn39tjh/r
         zIvtg2Hqd+ajFCKpKp7Tbuf8dLt0nIUznT05JgnJ6aFz7rkBiP45NeFjrVdKOsOJ8oPr
         6BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0HxXFCVYTnfJtlXPtSsB7lY9VGFGDzyx3qF147YbEk=;
        b=KMFWUhJw2paThXtmRzDRu86CX5RhaCsLAH453Krwg9pZt0+Z1D5Kp2khRLNeYvke4i
         7Oj1X+tHAhR16XUpiQe0504IU1V2ZPnX0GjBVCnuw+yz3uMXkVN7vi5k3UKPUoA4IywZ
         0HD+nLsfU5f25vNuqyhEXqZLgE3R/f68tFVnY+PQFNIj+1f5WgO/4CtrBAeoFR+ndaoL
         flN3nKTJ71lVkNK+dzI7p/xJ1hs/G53mggR7+lU4uMm0SkcGruBXqTbgO2IgJdIow14v
         dzFkhebWqDr3uJqQ4Slt3CzhMfaFubrcsgPzK76/w9biGP0LECagX0T8nDzUGneDqq9f
         3z2g==
X-Gm-Message-State: AFeK/H3Rqxonk+asAfY/5pQxGlwNAZsy8SFzaUWWrribefLe5xUFDtzzw1DDFiHpcgMKS5+k
X-Received: by 10.99.167.9 with SMTP id d9mr33911789pgf.19.1490055125053;
        Mon, 20 Mar 2017 17:12:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:38a6:f549:ebc4:4d51])
        by smtp.gmail.com with ESMTPSA id 9sm8114003pfn.108.2017.03.20.17.12.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 17:12:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, mfick@codeaurora.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] revision machinery: gentle submodule errors
Date:   Mon, 20 Mar 2017 17:11:55 -0700
Message-Id: <20170321001156.21915-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.402.g0501f7a28e
In-Reply-To: <20170321001156.21915-1-sbeller@google.com>
References: <20170321001156.21915-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is broken (e.g. its git directory is deleted or is not
pointed to via the .git linking file), commands that deal with submodules
error out reporting the submodule error.

Sometimes users rather want to see the rest of the command succeed,
ignoring the submodule that is severely broken.

Introduce a flag for the revision machinery '--gentle-submodule-errors'
that will ask 'is_submodule_modified' to return the broken flag instead
of dying().

By switching the argument of is_submodule_modified to an unsigned bit
vector, we can signal more flags, such as the gentle bit introduced
in this patch. When this flag is given, avoid dying inside
'is_submodule_modified' for severe errors and return
DIRTY_SUBMODULE_BROKEN instead.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff-lib.c                                   | 10 ++++++++--
 diff.h                                       |  1 +
 diffcore.h                                   |  3 ++-
 revision.c                                   |  2 ++
 submodule.c                                  |  9 ++++++++-
 submodule.h                                  | 10 +++++++++-
 t/t4060-diff-submodule-option-diff-format.sh | 22 ++++++++++++++++++++++
 7 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 52447466b5..61d33b6d26 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -77,8 +77,14 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 		if (DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES))
 			changed = 0;
 		else if (!DIFF_OPT_TST(diffopt, IGNORE_DIRTY_SUBMODULES)
-		    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES)))
-			*dirty_submodule = is_submodule_modified(ce->name, DIFF_OPT_TST(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES));
+		    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES))) {
+			unsigned flags = 0;
+			if (DIFF_OPT_TST(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES))
+				flags |= IS_SUBMODULE_MODIFIED_IGNORE_UNTRACKED;
+			if (diffopt->gentle_submodule_errors)
+				flags |= IS_SUBMODULE_MODIFIED_GENTLY;
+			*dirty_submodule = is_submodule_modified(ce->name, flags);
+		}
 		diffopt->flags = orig_flags;
 	}
 	return changed;
diff --git a/diff.h b/diff.h
index e9ccb38c26..d1e48de43c 100644
--- a/diff.h
+++ b/diff.h
@@ -164,6 +164,7 @@ struct diff_options {
 	const char *word_regex;
 	enum diff_words_type word_diff;
 	enum diff_submodule_format submodule_format;
+	int gentle_submodule_errors;
 
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
diff --git a/diffcore.h b/diffcore.h
index 6230241354..ceef783570 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -40,9 +40,10 @@ struct diff_filespec {
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
-	unsigned dirty_submodule : 2;  /* For submodules: its work tree is dirty */
+	unsigned dirty_submodule : 3;  /* For submodules: its work tree is dirty */
 #define DIRTY_SUBMODULE_UNTRACKED 1
 #define DIRTY_SUBMODULE_MODIFIED  2
+#define DIRTY_SUBMODULE_BROKEN 4
 	unsigned is_stdin : 1;
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	/* data should be considered "binary"; -1 means "don't know yet" */
diff --git a/revision.c b/revision.c
index 7ff61ff5f7..8ae1179b8d 100644
--- a/revision.c
+++ b/revision.c
@@ -2014,6 +2014,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
+	} else if (!strcmp(arg, "--gentle-submodule-errors")) {
+		revs->diffopt.gentle_submodule_errors = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
 		if (!opts)
diff --git a/submodule.c b/submodule.c
index 81d44cb7e9..d477297fab 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1039,13 +1039,18 @@ int fetch_populated_submodules(const struct argv_array *options,
 	return spf.result;
 }
 
-unsigned is_submodule_modified(const char *path, int ignore_untracked)
+/*
+ * Inspects a submodule and returns its state using flags
+ */
+unsigned is_submodule_modified(const char *path, unsigned flags)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	unsigned dirty_submodule = 0;
 	const char *git_dir;
 	int error_code = 0;
+	int ignore_untracked = flags & IS_SUBMODULE_MODIFIED_IGNORE_UNTRACKED;
+	int gently = flags & IS_SUBMODULE_MODIFIED_GENTLY;
 
 	strbuf_addf(&buf, "%s/.git", path);
 	git_dir = resolve_gitdir_gently(buf.buf, &error_code);
@@ -1069,6 +1074,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 			 * right here. Resolve again triggering die()
 			 * inside of the parsing.
 			 */
+			if (gently)
+				return DIRTY_SUBMODULE_BROKEN;
 			read_gitfile_gently(buf.buf, NULL);
 			die("BUG: read_gitfile_gently should have died.");
 		}
diff --git a/submodule.h b/submodule.h
index c8a0c9cb29..b7afac5e87 100644
--- a/submodule.h
+++ b/submodule.h
@@ -62,7 +62,15 @@ extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet, int max_parallel_jobs);
-extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
+
+/* Ignore untracked files */
+#define IS_SUBMODULE_MODIFIED_IGNORE_UNTRACKED 1
+/*
+ * Report severe errors in the submodule (e.g. missing git dir) via
+ * DIRTY_SUBMODULE_BROKEN instead of dying.
+ */
+#define IS_SUBMODULE_MODIFIED_GENTLY 2
+extern unsigned is_submodule_modified(const char *path, unsigned flags);
 extern int submodule_uses_gitfile(const char *path);
 
 #define SUBMODULE_REMOVAL_DIE_ON_ERROR (1<<0)
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 7e23b55ea4..e5e11a8378 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -746,4 +746,26 @@ test_expect_success 'diff --submodule=diff with .git file' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup -- break submodule' '
+	# the gitlink in sm2 points at a missing git dir now
+	mv .real .moved_real
+'
+
+test_expect_success 'diff with severely broken submodule' '
+	test_must_fail git diff &&
+
+	sm_hash=$(git rev-parse HEAD:sm2) &&
+	cat >expect <<-EOF &&
+	diff --git a/sm2 b/sm2
+	--- a/sm2
+	+++ b/sm2
+	@@ -1 +1 @@
+	-Subproject commit $sm_hash
+	+Subproject commit $sm_hash-dirty
+	EOF
+
+	git diff --gentle-submodule-errors -- sm2 >out &&
+	test_cmp expect out
+'
+
 test_done
-- 
2.12.0.402.g4b3201c2d6.dirty

