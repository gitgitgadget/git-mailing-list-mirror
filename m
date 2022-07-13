Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB2C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiGMNK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiGMNKu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:10:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D80AC1B
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so15460486wrh.3
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gI835caINGX5JrD/1LW0PGVcj2NTdLr/tKFjIRcWZUo=;
        b=XoeS1JTGFndhF/HBf4Iw6hHWGFqfAU2cc5s9mmwp7eoD3QhT1uIaiS1I3mdxJVHHyo
         U1lGatGfWDPQHh818CGdkYQm9kPsCYtm5/XDSeAKqpAL0IqXkxcQI81KRFWRfa6pSOxM
         u8hD5Eg4KeI6fqYadTFzSKc40SCwhmlIOhZM0C71CIyooyeMMm66FFihqueNr96sacma
         scajyJ1yEi7dSozLjGDznnH27E3DaTOsBjhoACrg7ck9o0HqdFph+fAhpP/7AozEagpR
         S0ox3CM6P6q0ZMObbWVNJNRndNYa/QirPPtmyrR3kxAzCc04weMquVoCaFRQlvv79TMh
         /HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gI835caINGX5JrD/1LW0PGVcj2NTdLr/tKFjIRcWZUo=;
        b=hwwSicUuU3YGf49bxvk5M2gatN/30wpCvTzll8O4ivzTpScdJGnDgYyWJTF6OhswWY
         7/2FDBpCoRm1462HTlARL00Bc6OAS6fvY+HY5nlP0JJ/SgxbygLmUM10xHaiH7zdUXl5
         vl++EZOpKi4P0ef3kHz2vtoqTXG90bkBgPNL0vXRBFhPBT20C4SFGluDkDpERoW4poMv
         nwh9+kwRroUyTAlvTsYMGaREsboajHxbI/n7bx18VJKE+ulm1sx47d5/aIpZZZXWd+ob
         ti526ArHVZhPAhpLkqQi+DGRld39NF7poqqPeYuRn9cXVzS+ZKgz4jhIsXznXK01XOdx
         afPA==
X-Gm-Message-State: AJIora+LNpDMgXNh63Q3Z7tP8q8LBl8xieJQ3cGAQebn06iMNjy8Egli
        nUB1P/3BSudhNE0z1xCz7v080kXFSaQGCA==
X-Google-Smtp-Source: AGRyM1tNkt9Lb/tQanGwZRFZ8mM+3yb5kT0oIxlZVrQTO1i+26F3UvDeiC3phUmye08+/V6vv/C47Q==
X-Received: by 2002:a05:6000:144f:b0:21d:a3cc:a6fa with SMTP id v15-20020a056000144f00b0021da3cca6famr3256817wrx.191.1657717847505;
        Wed, 13 Jul 2022 06:10:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0039c4d022a44sm2183653wmq.1.2022.07.13.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:10:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] revisions API: don't leak memory on argv elements that need free()-ing
Date:   Wed, 13 Jul 2022 15:10:35 +0200
Message-Id: <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "free_removed_argv_elements" member to "struct
setup_revision_opt", and use it to fix several memory leaks, e.g. the
one with a "XXX" comment added in 8a534b61241 (bisect: use argv_array
API, 2011-09-13).

We have various memory leaks in APIs that take and munge "const
char **argv", e.g. parse_options(). Sometimes these APIs are given the
"argv" we get to the "main" function, in which case we don't leak
memory, but other times we're giving it the "v" member of a "struct
strvec" we created.

There's several potential ways to fix those sort of leaks, we could
add a "nodup" mode to "struct strvec", which would work for the cases
where we push constant strings to it. But that wouldn't work as soon
as we used strvec_pushf(), or otherwise needed to duplicate or create
a string for that "struct strvec".

Let's instead make it the responsibility of the revisions API. If it's
going to clobber elements of argv it can also free() them, which it
will now do if instructed to do so via "free_removed_argv_elements".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c                    | 6 ++++--
 builtin/submodule--helper.c | 5 ++++-
 remote.c                    | 5 ++++-
 revision.c                  | 2 ++
 revision.h                  | 3 ++-
 t/t2020-checkout-detach.sh  | 1 +
 6 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6afb98be7a1..38b3891f3a6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -653,6 +653,9 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
 {
+	struct setup_revision_opt opt = {
+		.free_removed_argv_elements = 1,
+	};
 	int i;
 
 	repo_init_revisions(r, revs, prefix);
@@ -669,8 +672,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	if (read_paths)
 		read_bisect_paths(rev_argv);
 
-	setup_revisions(rev_argv->nr, rev_argv->v, revs, NULL);
-	/* XXX leak rev_argv, as "revs" may still be pointing to it */
+	setup_revisions(rev_argv->nr, rev_argv->v, revs, &opt);
 }
 
 static void bisect_common(struct rev_info *revs)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c597df7528e..c4e47c1b15a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1114,6 +1114,9 @@ static int compute_summary_module_list(struct object_id *head_oid,
 {
 	struct strvec diff_args = STRVEC_INIT;
 	struct rev_info rev;
+	struct setup_revision_opt opt = {
+		.free_removed_argv_elements = 1,
+	};
 	struct module_cb_list list = MODULE_CB_LIST_INIT;
 	int ret = 0;
 
@@ -1131,7 +1134,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	init_revisions(&rev, info->prefix);
 	rev.abbrev = 0;
 	precompose_argv_prefix(diff_args.nr, diff_args.v, NULL);
-	setup_revisions(diff_args.nr, diff_args.v, &rev, NULL);
+	setup_revisions(diff_args.nr, diff_args.v, &rev, &opt);
 	rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = submodule_summary_callback;
 	rev.diffopt.format_callback_data = &list;
diff --git a/remote.c b/remote.c
index b19e3a2f015..f05b50b1dd1 100644
--- a/remote.c
+++ b/remote.c
@@ -2169,6 +2169,9 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	struct object_id oid;
 	struct commit *ours, *theirs;
 	struct rev_info revs;
+	struct setup_revision_opt opt = {
+		.free_removed_argv_elements = 1,
+	};
 	struct strvec argv = STRVEC_INIT;
 
 	/* Cannot stat if what we used to build on no longer exists */
@@ -2203,7 +2206,7 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	strvec_push(&argv, "--");
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	setup_revisions(argv.nr, argv.v, &revs, NULL);
+	setup_revisions(argv.nr, argv.v, &revs, &opt);
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
diff --git a/revision.c b/revision.c
index 211352795c5..3fa84247d33 100644
--- a/revision.c
+++ b/revision.c
@@ -2748,6 +2748,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			const char *arg = argv[i];
 			if (strcmp(arg, "--"))
 				continue;
+			if (opt && opt->free_removed_argv_elements)
+				free((char *)argv[i]);
 			argv[i] = NULL;
 			argc = i;
 			if (argv[i + 1])
diff --git a/revision.h b/revision.h
index e576845cdd1..bb91e7ed914 100644
--- a/revision.h
+++ b/revision.h
@@ -375,7 +375,8 @@ struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
 	unsigned int	assume_dashdash:1,
-			allow_exclude_promisor_objects:1;
+			allow_exclude_promisor_objects:1,
+			free_removed_argv_elements:1;
 	unsigned revarg_opt;
 };
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index bc46713a43e..2eab6474f8d 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -4,6 +4,7 @@ test_description='checkout into detached HEAD state'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_detached () {
-- 
2.37.0.932.g7b7031e73bc

