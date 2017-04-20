Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB127207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947465AbdDTVI7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:08:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:37260 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947077AbdDTVI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:08:57 -0400
Received: (qmail 2040 invoked by uid 109); 20 Apr 2017 21:08:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 21:08:56 +0000
Received: (qmail 9670 invoked by uid 111); 20 Apr 2017 21:09:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 17:09:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:08:54 -0400
Date:   Thu, 20 Apr 2017 17:08:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] use git_path_* helper functions
Message-ID: <20170420210854.npnbs6rfbtc4ohgx@sigill.intra.peff.net>
References: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Long ago we added functions like git_path_merge_msg() to
replace the more dangerous git_path("MERGE_MSG"). Over time
some new calls to the latter have crept it. Let's convert
them to use the safer form.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c |  6 +++---
 builtin/pull.c   |  4 ++--
 sequencer.c      | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc51..98927d962 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -821,9 +821,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 					"If this is not correct, please remove the file\n"
 					"	%s\n"
 					"and try again.\n"),
-				git_path(whence == FROM_MERGE
-					 ? "MERGE_HEAD"
-					 : "CHERRY_PICK_HEAD"));
+				whence == FROM_MERGE ?
+					git_path_merge_head() :
+					git_path_cherry_pick_head());
 		}
 
 		fprintf(s->fp, "\n");
diff --git a/builtin/pull.c b/builtin/pull.c
index d8aa26d8a..dd1a4a94e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -332,7 +332,7 @@ static int git_pull_config(const char *var, const char *value, void *cb)
  */
 static void get_merge_heads(struct oid_array *merge_heads)
 {
-	const char *filename = git_path("FETCH_HEAD");
+	const char *filename = git_path_fetch_head();
 	FILE *fp;
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
@@ -791,7 +791,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
-	if (file_exists(git_path("MERGE_HEAD")))
+	if (file_exists(git_path_merge_head()))
 		die_conclude_merge();
 
 	if (get_oid("HEAD", &orig_head))
diff --git a/sequencer.c b/sequencer.c
index 77afecaeb..130cc868e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1065,12 +1065,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			flags |= CLEANUP_MSG;
 			msg_file = rebase_path_fixup_msg();
 		} else {
-			const char *dest = git_path("SQUASH_MSG");
+			const char *dest = git_path_squash_msg();
 			unlink(dest);
 			if (copy_file(dest, rebase_path_squash_msg(), 0666))
 				return error(_("could not rename '%s' to '%s'"),
 					     rebase_path_squash_msg(), dest);
-			unlink(git_path("MERGE_MSG"));
+			unlink(git_path_merge_msg());
 			msg_file = dest;
 			flags |= EDIT_MSG;
 		}
@@ -1820,10 +1820,10 @@ static int error_failed_squash(struct commit *commit,
 		return error(_("could not rename '%s' to '%s'"),
 			rebase_path_squash_msg(), rebase_path_message());
 	unlink(rebase_path_fixup_msg());
-	unlink(git_path("MERGE_MSG"));
-	if (copy_file(git_path("MERGE_MSG"), rebase_path_message(), 0666))
+	unlink(git_path_merge_msg());
+	if (copy_file(git_path_merge_msg(), rebase_path_message(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
-			     rebase_path_message(), git_path("MERGE_MSG"));
+			     rebase_path_message(), git_path_merge_msg());
 	return error_with_patch(commit, subject, subject_len, opts, 1, 0);
 }
 
@@ -2167,7 +2167,7 @@ static int commit_staged_changes(struct replay_opts *opts)
 	if (has_unstaged_changes(1))
 		return error(_("cannot rebase: You have unstaged changes."));
 	if (!has_uncommitted_changes(0)) {
-		const char *cherry_pick_head = git_path("CHERRY_PICK_HEAD");
+		const char *cherry_pick_head = git_path_cherry_pick_head();
 
 		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
 			return error(_("could not remove CHERRY_PICK_HEAD"));
-- 
2.13.0.rc0.363.g8726c260e

