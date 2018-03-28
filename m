Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA281F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeC1Rij (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:38:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:46232 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752639AbeC1Rih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:38:37 -0400
Received: (qmail 13528 invoked by uid 109); 28 Mar 2018 17:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 17:38:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10502 invoked by uid 111); 28 Mar 2018 17:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 13:39:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 13:38:35 -0400
Date:   Wed, 28 Mar 2018 13:38:35 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/4] set_git_dir: die when setenv() fails
Message-ID: <20180328173835.GA16274@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328173656.GA29094@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The set_git_dir() function returns an error if setenv()
fails, but there are zero callers who pay attention to this
return value. If this ever were to happen, it could cause
confusing results, as sub-processes would see a potentially
stale GIT_DIR (e.g., if it is relative and we chdir()-ed to
the root of the working tree).

We _could_ try to fix each caller, but there's really
nothing useful to do after this failure except die. Let's
just lump setenv() failure into the same category as malloc
failure: things that should never happen and cause us to
abort catastrophically.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h       | 2 +-
 environment.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index a61b2d3f0d..5c24394d84 100644
--- a/cache.h
+++ b/cache.h
@@ -477,7 +477,7 @@ extern const char *get_git_common_dir(void);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
-extern int set_git_dir(const char *path);
+extern void set_git_dir(const char *path);
 extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
 extern const char *get_git_namespace(void);
diff --git a/environment.c b/environment.c
index d6dd64662c..e01acf8b11 100644
--- a/environment.c
+++ b/environment.c
@@ -296,13 +296,12 @@ char *get_graft_file(void)
 	return the_repository->graft_file;
 }
 
-int set_git_dir(const char *path)
+void set_git_dir(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
-		return error("Could not set GIT_DIR to '%s'", path);
+		die("could not set GIT_DIR to '%s'", path);
 	repo_set_gitdir(the_repository, path);
 	setup_git_env();
-	return 0;
 }
 
 const char *get_log_output_encoding(void)
-- 
2.17.0.rc1.515.g3cc84c0ca4

