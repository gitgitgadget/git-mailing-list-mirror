Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7622D208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdIENE7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:04:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:57328 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750959AbdIENE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:04:59 -0400
Received: (qmail 2111 invoked by uid 109); 5 Sep 2017 13:04:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:04:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12837 invoked by uid 111); 5 Sep 2017 13:05:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:05:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:04:57 -0400
Date:   Tue, 5 Sep 2017 09:04:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/10] repository: free fields before overwriting them
Message-ID: <20170905130456.ecf72u4u4mbljavo@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible that the repository data may be initialized
twice (e.g., after doing a chdir() to the top of the
worktree we may have to adjust a relative git_dir path). We
should free() any existing fields before assigning to them
to avoid leaks.

This should be safe, as the fields are set based on the
environment or on other strings like the gitdir or
commondir. That makes it impossible that we are feeding an
alias to the just-freed string.

Signed-off-by: Jeff King <peff@peff.net>
---
 environment.c | 4 +++-
 repository.c  | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 3fd4b10845..f1f934b6fd 100644
--- a/environment.c
+++ b/environment.c
@@ -97,7 +97,7 @@ int ignore_untracked_cache_config;
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 
-static const char *namespace;
+static char *namespace;
 
 static const char *super_prefix;
 
@@ -152,8 +152,10 @@ void setup_git_env(void)
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs = 0;
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
+	free(git_replace_ref_base);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	free(namespace);
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
diff --git a/repository.c b/repository.c
index f107af7d76..52f1821c6b 100644
--- a/repository.c
+++ b/repository.c
@@ -40,11 +40,15 @@ static void repo_setup_env(struct repository *repo)
 
 	repo->different_commondir = find_common_dir(&sb, repo->gitdir,
 						    !repo->ignore_env);
+	free(repo->commondir);
 	repo->commondir = strbuf_detach(&sb, NULL);
+	free(repo->objectdir);
 	repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
 					    "objects", !repo->ignore_env);
+	free(repo->graft_file);
 	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
 					     "info/grafts", !repo->ignore_env);
+	free(repo->index_file);
 	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
 					     "index", !repo->ignore_env);
 }
-- 
2.14.1.721.gc5bc1565f1

