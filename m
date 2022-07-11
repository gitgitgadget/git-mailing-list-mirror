Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E96ACCA480
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 09:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiGKJpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 05:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiGKJoM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 05:44:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F035A2E79
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 02:21:54 -0700 (PDT)
Received: (qmail 6845 invoked by uid 109); 11 Jul 2022 09:21:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Jul 2022 09:21:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16994 invoked by uid 111); 11 Jul 2022 09:21:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Jul 2022 05:21:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Jul 2022 05:21:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 4/3] clone: move unborn head creation to update_head()
Message-ID: <YsvrsOH1jg559yVt@coredump.intra.peff.net>
References: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
 <YsdzZxS48u8sk9QD@coredump.intra.peff.net>
 <xmqq8rp3wovj.fsf@gitster.g>
 <YsiF6+RjEsmwviuS@coredump.intra.peff.net>
 <xmqqlet3uyxc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlet3uyxc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2022 at 01:33:51PM -0700, Junio C Hamano wrote:

> > Your next thought may be: why does the unborn head code do its own
> > branch config setup here, and not also rely on update_head()? I think
> > it's just that update_head() is expecting to see an actual ref object,
> > and we don't have one. It could probably be taught to handle this case,
> > like the patch below. I'm not sure if that is more readable or not. On
> > one hand, it is putting all of the HEAD symref creation and config in
> > one spot. On the other, it is adding to the pile of widely scoped
> > variables that have subtle precedence interactions later on in the
> > function.
> 
> The necessary change does not look all that bad, either ;-)

Having slept on this, I think it is worth it as a small cleanup on top.
See the patch below.

I'm pretty sure this _could_ be done earlier in the series, which would
have preempted your question about the "!option_bare && !our_head_points_at"
logic. But at this point I don't think it's worth the review effort (and
possibility of screwing something up) to go back again. The motivation
still makes sense on top.

-- >8 --
Subject: [PATCH] clone: move unborn head creation to update_head()

Prior to 4f37d45706 (clone: respect remote unborn HEAD, 2021-02-05),
creation of the local HEAD was always done in update_head(). That commit
added code to handle an unborn head in an empty repository, and just did
all symref creation and config setup there.

This makes the code flow a little bit confusing, especially as new
corner cases have been covered (like the previous commit to match our
default branch name to a non-HEAD remote branch).

Let's move the creation of the unborn symref into update_head(). This
matches the other HEAD-creation cases, and now the logic is consistently
separated: the main cmd_clone() function only examines the situation and
sets variables based on what it finds, and update_head() actually
performs the update.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0912d268a1..9e0b2b45ca 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -606,7 +606,7 @@ static void update_remote_refs(const struct ref *refs,
 }
 
 static void update_head(const struct ref *our, const struct ref *remote,
-			const char *msg)
+			const char *unborn, const char *msg)
 {
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
@@ -632,6 +632,15 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		 */
 		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
+	} else if (unborn && skip_prefix(unborn, "refs/heads/", &head)) {
+		/*
+		 * Unborn head from remote; same as "our" case above except
+		 * that we have no ref to update.
+		 */
+		if (create_symref("HEAD", unborn, NULL) < 0)
+			die(_("unable to update HEAD"));
+		if (!option_bare)
+			install_branch_config(0, head, remote_name, unborn);
 	}
 }
 
@@ -876,6 +885,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *refs, *remote_head;
 	struct ref *remote_head_points_at = NULL;
 	const struct ref *our_head_points_at;
+	char *unborn_head = NULL;
 	struct ref *mapped_refs = NULL;
 	const struct ref *ref;
 	struct strbuf key = STRBUF_INIT;
@@ -1282,8 +1292,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		our_head_points_at = NULL;
 	} else {
 		const char *branch;
-		const char *ref;
-		char *ref_free = NULL;
 
 		if (!mapped_refs) {
 			warning(_("You appear to have cloned an empty repository."));
@@ -1293,12 +1301,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (transport_ls_refs_options.unborn_head_target &&
 		    skip_prefix(transport_ls_refs_options.unborn_head_target,
 				"refs/heads/", &branch)) {
-			ref = transport_ls_refs_options.unborn_head_target;
-			create_symref("HEAD", ref, reflog_msg.buf);
+			unborn_head  = xstrdup(transport_ls_refs_options.unborn_head_target);
 		} else {
 			branch = git_default_branch_name(0);
-			ref_free = xstrfmt("refs/heads/%s", branch);
-			ref = ref_free;
+			unborn_head = xstrfmt("refs/heads/%s", branch);
 		}
 
 		/*
@@ -1313,10 +1319,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		 * a match.
 		 */
 		our_head_points_at = find_remote_branch(mapped_refs, branch);
-
-		if (!option_bare && !our_head_points_at)
-			install_branch_config(0, branch, remote_name, ref);
-		free(ref_free);
 	}
 
 	write_refspec_config(src_ref_prefix, our_head_points_at,
@@ -1336,7 +1338,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
 
-	update_head(our_head_points_at, remote_head, reflog_msg.buf);
+	update_head(our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
 
 	/*
 	 * We want to show progress for recursive submodule clones iff
@@ -1363,6 +1365,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&key);
 	free_refs(mapped_refs);
 	free_refs(remote_head_points_at);
+	free(unborn_head);
 	free(dir);
 	free(path);
 	UNLEAK(repo);
-- 
2.37.0.424.g982e2d45d0

