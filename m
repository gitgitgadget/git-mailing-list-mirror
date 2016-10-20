Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E19120986
	for <e@80x24.org>; Thu, 20 Oct 2016 06:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbcJTGQp (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:16:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:59854 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbcJTGQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:16:44 -0400
Received: (qmail 18411 invoked by uid 109); 20 Oct 2016 06:16:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 06:16:44 +0000
Received: (qmail 21001 invoked by uid 111); 20 Oct 2016 06:17:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:17:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 02:16:41 -0400
Date:   Thu, 20 Oct 2016 02:16:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/7] read info/{attributes,exclude} only when in repository
Message-ID: <20161020061641.3enppkoxfzr76has@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The low-level attribute and gitignore code will try to look
in $GIT_DIR/info for any repo-level configuration files,
even if we have not actually determined that we are in a
repository (e.g., running "git grep --no-index"). In such a
case they end up looking for ".git/info/attributes", etc.

This is generally harmless, as such a file is unlikely to
exist outside of a repository, but it's still conceptually
the wrong thing to do.

Let's detect this situation explicitly and skip reading the
file (i.e., the same behavior we'd get if we were in a
repository and the file did not exist).

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c |  6 +++++-
 dir.c  | 12 ++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index eec5d7d..1fcf042 100644
--- a/attr.c
+++ b/attr.c
@@ -531,7 +531,11 @@ static void bootstrap_attr_stack(void)
 		debug_push(elem);
 	}
 
-	elem = read_attr_from_file(git_path_info_attributes(), 1);
+	if (startup_info->have_repository)
+		elem = read_attr_from_file(git_path_info_attributes(), 1);
+	else
+		elem = NULL;
+
 	if (!elem)
 		elem = xcalloc(1, sizeof(*elem));
 	elem->origin = NULL;
diff --git a/dir.c b/dir.c
index 3bad1ad..6cde773 100644
--- a/dir.c
+++ b/dir.c
@@ -2195,8 +2195,6 @@ static GIT_PATH_FUNC(git_path_info_exclude, "info/exclude")
 
 void setup_standard_excludes(struct dir_struct *dir)
 {
-	const char *path;
-
 	dir->exclude_per_dir = ".gitignore";
 
 	/* core.excludefile defaulting to $XDG_HOME/git/ignore */
@@ -2207,10 +2205,12 @@ void setup_standard_excludes(struct dir_struct *dir)
 					 dir->untracked ? &dir->ss_excludes_file : NULL);
 
 	/* per repository user preference */
-	path = git_path_info_exclude();
-	if (!access_or_warn(path, R_OK, 0))
-		add_excludes_from_file_1(dir, path,
-					 dir->untracked ? &dir->ss_info_exclude : NULL);
+	if (startup_info->have_repository) {
+		const char *path = git_path_info_exclude();
+		if (!access_or_warn(path, R_OK, 0))
+			add_excludes_from_file_1(dir, path,
+						 dir->untracked ? &dir->ss_info_exclude : NULL);
+	}
 }
 
 int remove_path(const char *name)
-- 
2.10.1.619.g16351a7

