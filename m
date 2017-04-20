Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D7C5207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031098AbdDTVJd (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:09:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:37266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947612AbdDTVJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:09:32 -0400
Received: (qmail 2098 invoked by uid 109); 20 Apr 2017 21:09:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 21:09:32 +0000
Received: (qmail 9703 invoked by uid 111); 20 Apr 2017 21:09:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 17:09:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:09:30 -0400
Date:   Thu, 20 Apr 2017 17:09:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] replace strbuf_addstr(git_path()) with git_path_buf()
Message-ID: <20170420210930.uh4kirjqs4x2zwhg@sigill.intra.peff.net>
References: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Writing directly into the strbuf avoids a useless copy of
the data, and dropping calls to git_path() makes it easier
to audit for dangerous calls.

Note that git_path() does an implicit strbuf_reset(), but in
each of these cases we were either already doing that reset,
or writing into a fresh strbuf anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/worktree.c | 6 ++----
 notes-merge.c      | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9993ded41..57caa0855 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -106,8 +106,7 @@ static void prune_worktrees(void)
 			printf("%s\n", reason.buf);
 		if (show_only)
 			continue;
-		strbuf_reset(&path);
-		strbuf_addstr(&path, git_path("worktrees/%s", d->d_name));
+		git_path_buf(&path, "worktrees/%s", d->d_name);
 		ret = remove_dir_recursively(&path, 0);
 		if (ret < 0 && errno == ENOTDIR)
 			ret = unlink(path.buf);
@@ -215,8 +214,7 @@ static int add_worktree(const char *path, const char *refname,
 	}
 
 	name = worktree_basename(path, &len);
-	strbuf_addstr(&sb_repo,
-		      git_path("worktrees/%.*s", (int)(path + len - name), name));
+	git_path_buf(&sb_repo, "worktrees/%.*s", (int)(path + len - name), name);
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
diff --git a/notes-merge.c b/notes-merge.c
index 5998605ac..32caaaff7 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -676,7 +676,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 	const char *msg = strstr(buffer, "\n\n");
 	int baselen;
 
-	strbuf_addstr(&path, git_path(NOTES_MERGE_WORKTREE));
+	git_path_buf(&path, NOTES_MERGE_WORKTREE);
 	if (o->verbosity >= 3)
 		printf("Committing notes in notes merge worktree at %s\n",
 			path.buf);
@@ -741,7 +741,7 @@ int notes_merge_abort(struct notes_merge_options *o)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 
-	strbuf_addstr(&buf, git_path(NOTES_MERGE_WORKTREE));
+	git_path_buf(&buf, NOTES_MERGE_WORKTREE);
 	if (o->verbosity >= 3)
 		printf("Removing notes merge worktree at %s/*\n", buf.buf);
 	ret = remove_dir_recursively(&buf, REMOVE_DIR_KEEP_TOPLEVEL);
-- 
2.13.0.rc0.363.g8726c260e

