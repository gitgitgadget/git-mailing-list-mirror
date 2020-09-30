Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9052C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3DA20789
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgI3M3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:29:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:45316 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3M3c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:29:32 -0400
Received: (qmail 23951 invoked by uid 109); 30 Sep 2020 12:29:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:29:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27998 invoked by uid 111); 30 Sep 2020 12:29:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:29:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:29:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/10] sequencer: drop repository argument from
 run_git_commit()
Message-ID: <20200930122931.GF1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we switched to using an external git-commit call in b0a3186140
(sequencer: simplify root commit creation, 2019-08-19), this function
didn't need to care about the repository object any more.

Arguably we could be passing along the repository path to the external
git-commit by using "--git-dir=r->path" here. But for the most part the
sequencer code relies on sub-process finding the same repository we're
already in (using the same environment variables or discovery process we
did). But we don't have a convenient interface for doing so, and there's
no indication that we need to. Let's just drop the unused parameter for
now.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e8676e965f..6e9aabaac1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -934,8 +934,7 @@ static int run_command_silent_on_success(struct child_process *cmd)
  * interactive rebase: in that case, we will want to retain the
  * author metadata.
  */
-static int run_git_commit(struct repository *r,
-			  const char *defmsg,
+static int run_git_commit(const char *defmsg,
 			  struct replay_opts *opts,
 			  unsigned int flags)
 {
@@ -1545,7 +1544,7 @@ static int do_commit(struct repository *r,
 		if (is_rebase_i(opts) && oid)
 			if (write_rebase_head(oid))
 			    return -1;
-		return run_git_commit(r, msg_file, opts, flags);
+		return run_git_commit(msg_file, opts, flags);
 	}
 
 	return res;
@@ -2060,7 +2059,7 @@ static int do_pick_commit(struct repository *r,
 		*check_todo = !!(flags & EDIT_MSG);
 		if (!res && reword) {
 fast_forward_edit:
-			res = run_git_commit(r, NULL, opts, EDIT_MSG |
+			res = run_git_commit(NULL, opts, EDIT_MSG |
 					     VERIFY_MSG | AMEND_MSG |
 					     (flags & ALLOW_EMPTY));
 			*check_todo = 1;
@@ -3748,7 +3747,7 @@ static int do_merge(struct repository *r,
 		 * command needs to be rescheduled).
 		 */
 	fast_forward_edit:
-		ret = !!run_git_commit(r, git_path_merge_msg(r), opts,
+		ret = !!run_git_commit(git_path_merge_msg(r), opts,
 				       run_commit_flags);
 
 leave_merge:
@@ -4437,7 +4436,7 @@ static int commit_staged_changes(struct repository *r,
 			return 0;
 	}
 
-	if (run_git_commit(r, final_fixup ? NULL : rebase_path_message(),
+	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
 			   opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
-- 
2.28.0.1173.gad90222cf0

