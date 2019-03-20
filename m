Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6748B20248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfCTIPu (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:15:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:57440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726049AbfCTIPu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:15:50 -0400
Received: (qmail 19674 invoked by uid 109); 20 Mar 2019 08:15:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:15:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6365 invoked by uid 111); 20 Mar 2019 08:16:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:16:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:15:48 -0400
Date:   Wed, 20 Mar 2019 04:15:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/13] report_path_error(): drop unused prefix parameter
Message-ID: <20190320081548.GH10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This hasn't been used since 17ddc66e70 (convert report_path_error to
take struct pathspec, 2013-07-14), as the names in the struct will have
already been prefixed when they were parsed.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c          | 2 +-
 builtin/commit.c            | 6 +++---
 builtin/ls-files.c          | 2 +-
 builtin/submodule--helper.c | 2 +-
 dir.c                       | 3 +--
 dir.h                       | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6037b296..72f7110fd8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -376,7 +376,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 							ps_matched,
 							opts);
 
-	if (report_path_error(ps_matched, &opts->pathspec, opts->prefix)) {
+	if (report_path_error(ps_matched, &opts->pathspec)) {
 		free(ps_matched);
 		return 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index f17537474a..a138ff85b0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -235,7 +235,7 @@ static int commit_index_files(void)
  * and return the paths that match the given pattern in list.
  */
 static int list_paths(struct string_list *list, const char *with_tree,
-		      const char *prefix, const struct pathspec *pattern)
+		      const struct pathspec *pattern)
 {
 	int i, ret;
 	char *m;
@@ -264,7 +264,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 			item->util = item; /* better a valid pointer than a fake one */
 	}
 
-	ret = report_path_error(m, pattern, prefix);
+	ret = report_path_error(m, pattern);
 	free(m);
 	return ret;
 }
@@ -454,7 +454,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			die(_("cannot do a partial commit during a cherry-pick."));
 	}
 
-	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, &pathspec))
+	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
 		exit(1);
 
 	discard_cache();
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 29a8762d46..37a08c714b 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -680,7 +680,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	if (ps_matched) {
 		int bad;
-		bad = report_path_error(ps_matched, &pathspec, prefix);
+		bad = report_path_error(ps_matched, &pathspec);
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bcc4f1bd7..8342b78add 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -348,7 +348,7 @@ static int module_list_compute(int argc, const char **argv,
 			i++;
 	}
 
-	if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
+	if (ps_matched && report_path_error(ps_matched, pathspec))
 		result = -1;
 
 	free(ps_matched);
diff --git a/dir.c b/dir.c
index b2cabadf25..5286f710cc 100644
--- a/dir.c
+++ b/dir.c
@@ -502,8 +502,7 @@ int submodule_path_match(const struct index_state *istate,
 }
 
 int report_path_error(const char *ps_matched,
-		      const struct pathspec *pathspec,
-		      const char *prefix)
+		      const struct pathspec *pathspec)
 {
 	/*
 	 * Make sure all pathspec matched; otherwise it is an error.
diff --git a/dir.h b/dir.h
index e3ec26143d..823bae628b 100644
--- a/dir.h
+++ b/dir.h
@@ -220,7 +220,7 @@ extern int match_pathspec(const struct index_state *istate,
 			  const struct pathspec *pathspec,
 			  const char *name, int namelen,
 			  int prefix, char *seen, int is_dir);
-extern int report_path_error(const char *ps_matched, const struct pathspec *pathspec, const char *prefix);
+extern int report_path_error(const char *ps_matched, const struct pathspec *pathspec);
 extern int within_depth(const char *name, int namelen, int depth, int max_depth);
 
 extern int fill_directory(struct dir_struct *dir,
-- 
2.21.0.701.g4401309e11

