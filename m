Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8CC208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbdIENFE (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:05:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750955AbdIENFD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:05:03 -0400
Received: (qmail 2160 invoked by uid 109); 5 Sep 2017 13:05:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:05:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12842 invoked by uid 111); 5 Sep 2017 13:05:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:05:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:05:01 -0400
Date:   Tue, 5 Sep 2017 09:05:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/10] set_git_dir: handle feeding gitdir to itself
Message-ID: <20170905130501.xwc2ud2pwpbhqsli@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ideally we'd free the existing gitdir field before assigning
the new one, to avoid a memory leak. But we can't do so
safely because some callers do the equivalent of:

  set_git_dir(get_git_dir());

We can detect that case as a noop, but there are even more
complicated cases like:

  set_git_dir(remove_leading_path(worktree, get_git_dir());

where we really do need to do some work, but the original
string must remain valid.

Rather than put the burden on callers to make a copy of the
string (only to free it later, since we'll make a copy of it
ourselves), let's solve the problem inside set_git_dir(). We
can make a copy of the pointer for the old gitdir, and then
avoid freeing it until after we've made our new copy.

Signed-off-by: Jeff King <peff@peff.net>
---
 repository.c | 10 +++-------
 setup.c      |  5 -----
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/repository.c b/repository.c
index 52f1821c6b..97c732bd48 100644
--- a/repository.c
+++ b/repository.c
@@ -56,16 +56,12 @@ static void repo_setup_env(struct repository *repo)
 void repo_set_gitdir(struct repository *repo, const char *path)
 {
 	const char *gitfile = read_gitfile(path);
+	char *old_gitdir = repo->gitdir;
 
-	/*
-	 * NEEDSWORK: Eventually we want to be able to free gitdir and the rest
-	 * of the environment before reinitializing it again, but we have some
-	 * crazy code paths where we try to set gitdir with the current gitdir
-	 * and we don't want to free gitdir before copying the passed in value.
-	 */
 	repo->gitdir = xstrdup(gitfile ? gitfile : path);
-
 	repo_setup_env(repo);
+
+	free(old_gitdir);
 }
 
 /*
diff --git a/setup.c b/setup.c
index 23950173fc..6d8380acd2 100644
--- a/setup.c
+++ b/setup.c
@@ -399,11 +399,6 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
 
-	/*
-	 * NEEDSWORK: this call can essentially be set_git_dir(get_git_dir())
-	 * which can cause some problems when trying to free the old value of
-	 * gitdir.
-	 */
 	set_git_dir(remove_leading_path(git_dir, work_tree));
 	initialized = 1;
 }
-- 
2.14.1.721.gc5bc1565f1

