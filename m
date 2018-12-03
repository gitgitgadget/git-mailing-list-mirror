Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F691211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 22:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLCWKn (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 17:10:43 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:37788 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeLCWKm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 17:10:42 -0500
Received: by mail-oi1-f201.google.com with SMTP id s140so9171292oih.4
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 14:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ac+IBfJI7IEScNH+/LJZ+bFcMx2fMXIIeKC7iCIeRdg=;
        b=KFU0rZxh1UzSBPwVbcCCk473NjrDL3FhDexvkLT3NQtDpKBoJRlZ0LPxZT9LA21IUx
         HJhmWXjDj8vdr+F8RbN8XYy2j087jGbASUByE05uXE6jWdlzhuz+sqw568LGkqd3wRGF
         tRkNhnTmsMZmK25jGMFk+9sjOGLLldz21Z1gfzG73GvHBgQYsvdsQe2tOTYkqA+hQV4M
         TuCCMd4S+tOu7wHvX8RxDu+fCbrsAsQp+a0hkcqnQNNGLpWQKmIzUVWldcolEg690bTK
         TibZfZt7fR4IhN41juZOQAvrF5yIr3BMyScafdUdYCnBxZkOkIFG9gZbKhevBRu9KU+i
         1c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ac+IBfJI7IEScNH+/LJZ+bFcMx2fMXIIeKC7iCIeRdg=;
        b=BrrrwC45m8dfTdQN0rqnKHuOGdUuYZnlfYmIhTiUQfBU5V+VzHJQjK/nwIslCEMYHM
         jZA2ot1JSxYbw02GaXJQpbr+iHOo7qhEoIJjz0pqa0Ph2BxgfH4HYVqGgIFpZgqCOprC
         wTq4tcCKMmxkiAvbF+P6Yr6OgONTWEozUuHzoTScILeXeCMnrc2Pn3Obo0Z4OX6q/WjM
         czHcEmIV3HJ35fWq4fOyRC9Aq4b6/g1liKDmy+cWLlhRys7VMClQixKwsQ+SvL4oPG3f
         AE6JFrQptVD3U8L8M3sIALVMN3ZI4Ko9x1Xnv2wtCsWWvw3X8iXHSSpE+5MTs1G54u8n
         Y/Tg==
X-Gm-Message-State: AA+aEWbztEwH7adbgFZ7Kl59hqJFogk+73k9jajZARtsjjIK1B2tefYE
        89e/zwMO8Y9EhL9Ta2hQD9TPbwZdaMk=
X-Google-Smtp-Source: AFSGD/XyiNp+CdNu1GMMyYYWkcCu39/pQr8a1K2DdHoSNIv0XCLmrQi55By52vlNNaxvqQ2KxqFCQ8cmNGip
X-Received: by 2002:a9d:5549:: with SMTP id h9mr14196453oti.62.1543875041716;
 Mon, 03 Dec 2018 14:10:41 -0800 (PST)
Date:   Mon,  3 Dec 2018 14:10:19 -0800
Message-Id: <20181203221019.237034-1-matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH v2] revisions.c: put promisor option in specialized struct
From:   Matthew DeVore <matvore@google.com>
To:     peff@peff.net, git@vger.kernel.org, gitster@pobox.com
Cc:     Matthew DeVore <matvore@google.com>, pclouds@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Put the allow_exclude_promisor_objects flag in setup_revision_opt. When
it was in rev_info, it was unclear when it was used, since rev_info is
passed to functions that don't use the flag. This resulted in
unnecessary setting of the flag in prune.c, so fix that as well.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 builtin/pack-objects.c |  6 ++++--
 builtin/prune.c        |  1 -
 builtin/rev-list.c     |  6 ++++--
 revision.c             | 10 ++++++----
 revision.h             |  4 ++--
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 24bba8147f..889df2c755 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3084,14 +3084,16 @@ static void record_recent_commit(struct commit *commit, void *data)
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
+	struct setup_revision_opt s_r_opt = {
+		.allow_exclude_promisor_objects = 1,
+	};
 	char line[1000];
 	int flags = 0;
 	int save_warning;
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	revs.allow_exclude_promisor_objects_opt = 1;
-	setup_revisions(ac, av, &revs, NULL);
+	setup_revisions(ac, av, &revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
diff --git a/builtin/prune.c b/builtin/prune.c
index e42653b99c..1ec9ddd751 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -120,7 +120,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	read_replace_refs = 0;
 	ref_paranoia = 1;
-	revs.allow_exclude_promisor_objects_opt = 1;
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3a2c0c23b6..14ef659c12 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -362,6 +362,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct rev_list_info info;
+	struct setup_revision_opt s_r_opt = {
+		.allow_exclude_promisor_objects = 1,
+	};
 	int i;
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
@@ -375,7 +378,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
-	revs.allow_exclude_promisor_objects_opt = 1;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 	revs.do_not_die_on_missing_tree = 1;
 
@@ -407,7 +409,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	argc = setup_revisions(argc, argv, &revs, NULL);
+	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
 
 	memset(&info, 0, sizeof(info));
 	info.revs = &revs;
diff --git a/revision.c b/revision.c
index 13e0519c02..f6b32e6a42 100644
--- a/revision.c
+++ b/revision.c
@@ -1791,7 +1791,8 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 }
 
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
-			       int *unkc, const char **unkv)
+			       int *unkc, const char **unkv,
+			       const struct setup_revision_opt* opt)
 {
 	const char *arg = argv[0];
 	const char *optarg;
@@ -2151,7 +2152,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
-	} else if (revs->allow_exclude_promisor_objects_opt &&
+	} else if (opt && opt->allow_exclude_promisor_objects &&
 		   !strcmp(arg, "--exclude-promisor-objects")) {
 		if (fetch_if_missing)
 			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
@@ -2173,7 +2174,7 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const char * const usagestr[])
 {
 	int n = handle_revision_opt(revs, ctx->argc, ctx->argv,
-				    &ctx->cpidx, ctx->out);
+				    &ctx->cpidx, ctx->out, NULL);
 	if (n <= 0) {
 		error("unknown option `%s'", ctx->argv[0]);
 		usage_with_options(usagestr, options);
@@ -2391,7 +2392,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				continue;
 			}
 
-			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
+			opts = handle_revision_opt(revs, argc - i, argv + i,
+						   &left, argv, opt);
 			if (opts > 0) {
 				i += opts - 1;
 				continue;
diff --git a/revision.h b/revision.h
index 7987bfcd2e..52e5a88ff5 100644
--- a/revision.h
+++ b/revision.h
@@ -161,7 +161,6 @@ struct rev_info {
 			do_not_die_on_missing_tree:1,
 
 			/* for internal use only */
-			allow_exclude_promisor_objects_opt:1,
 			exclude_promisor_objects:1;
 
 	/* Diff flags */
@@ -297,7 +296,8 @@ struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
 	const char *submodule;	/* TODO: drop this and use rev_info->repo */
-	int assume_dashdash;
+	unsigned int	assume_dashdash:1,
+			allow_exclude_promisor_objects:1;
 	unsigned revarg_opt;
 };
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

