Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7EDC71153
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjH1Vqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjH1Vqd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:46:33 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF76186
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:46:30 -0700 (PDT)
Received: (qmail 513 invoked by uid 109); 28 Aug 2023 21:46:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:46:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4513 invoked by uid 111); 28 Aug 2023 21:46:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:46:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:46:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/22] sequencer: use repository parameter in
 short_commit_name()
Message-ID: <20230828214629.GA3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of just using the_repository, we can take a repository parameter
from the caller. Most of them already have one, and doing so clears up a
few -Wunused-parameter warnings. There are still a few callers which use
the_repository, but this pushes us one small step forward to eventually
getting rid of those.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 48475d1cc6..82dc3e160e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -433,10 +433,9 @@ struct commit_message {
 	const char *message;
 };
 
-static const char *short_commit_name(struct commit *commit)
+static const char *short_commit_name(struct repository *r, struct commit *commit)
 {
-	return repo_find_unique_abbrev(the_repository, &commit->object.oid,
-				       DEFAULT_ABBREV);
+	return repo_find_unique_abbrev(r, &commit->object.oid, DEFAULT_ABBREV);
 }
 
 static int get_message(struct commit *commit, struct commit_message *out)
@@ -446,7 +445,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
 
 	out->message = repo_logmsg_reencode(the_repository, commit, NULL,
 					    get_commit_output_encoding());
-	abbrev = short_commit_name(commit);
+	abbrev = short_commit_name(the_repository, commit);
 
 	subject_len = find_commit_subject(out->message, &subject);
 
@@ -2383,7 +2382,7 @@ static int do_pick_commit(struct repository *r,
 		error(command == TODO_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
-		      short_commit_name(commit), msg.subject);
+		      short_commit_name(r, commit), msg.subject);
 		print_advice(r, res == 1, opts);
 		repo_rerere(r, opts->allow_rerere_auto);
 		goto leave;
@@ -3172,7 +3171,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
-			short_commit_name(commit), subject_len, subject);
+			short_commit_name(opts->revs->repo, commit),
+			subject_len, subject);
 		repo_unuse_commit_buffer(the_repository, commit,
 					 commit_buffer);
 	}
@@ -3593,7 +3593,7 @@ static int error_with_patch(struct repository *r,
 	} else if (exit_code) {
 		if (commit)
 			fprintf_ln(stderr, _("Could not apply %s... %.*s"),
-				   short_commit_name(commit), subject_len, subject);
+				   short_commit_name(r, commit), subject_len, subject);
 		else
 			/*
 			 * We don't have the hash of the parent so
@@ -4728,7 +4728,7 @@ static int pick_commits(struct repository *r,
 						term_clear_line();
 					fprintf(stderr,
 						_("Stopped at %s...  %.*s\n"),
-						short_commit_name(commit),
+						short_commit_name(r, commit),
 						item->arg_len, arg);
 				}
 				return error_with_patch(r, commit,
@@ -5564,7 +5564,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		if (!is_empty && (commit->object.flags & PATCHSAME)) {
 			if (flags & TODO_LIST_WARN_SKIPPED_CHERRY_PICKS)
 				warning(_("skipped previously applied commit %s"),
-					short_commit_name(commit));
+					short_commit_name(revs->repo, commit));
 			skipped_commit = 1;
 			continue;
 		}
@@ -5800,7 +5800,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 		if (!is_empty && (commit->object.flags & PATCHSAME)) {
 			if (flags & TODO_LIST_WARN_SKIPPED_CHERRY_PICKS)
 				warning(_("skipped previously applied commit %s"),
-					short_commit_name(commit));
+					short_commit_name(r, commit));
 			skipped_commit = 1;
 			continue;
 		}
@@ -5892,7 +5892,8 @@ static void todo_list_add_exec_commands(struct todo_list *todo_list,
 	todo_list->alloc = alloc;
 }
 
-static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
+static void todo_list_to_strbuf(struct repository *r,
+				struct todo_list *todo_list,
 				struct strbuf *buf, int num, unsigned flags)
 {
 	struct todo_item *item;
@@ -5921,7 +5922,7 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
 		/* add commit id */
 		if (item->commit) {
 			const char *oid = flags & TODO_LIST_SHORTEN_IDS ?
-					  short_commit_name(item->commit) :
+					  short_commit_name(r, item->commit) :
 					  oid_to_hex(&item->commit->object.oid);
 
 			if (item->command == TODO_FIXUP) {
-- 
2.42.0.505.g4c6fb48dec

