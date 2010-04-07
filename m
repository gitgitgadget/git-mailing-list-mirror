From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: Extremely slow progress during 'git reflog expire --all'
Date: Wed, 07 Apr 2010 11:39:15 -0700
Message-ID: <7vochvcdkc.fsf_-_@alter.siamese.dyndns.org>
References: <201004022154.14793.elendil@planet.nl>
 <201004022350.20999.elendil@planet.nl>
 <20100402224100.GA997@coredump.intra.peff.net>
 <201004031629.01970.elendil@planet.nl>
 <20100403203507.GA12262@coredump.intra.peff.net>
 <7vy6h36pt1.fsf@alter.siamese.dyndns.org>
 <20100405062621.GA30934@coredump.intra.peff.net>
 <7v1vetpw63.fsf@alter.siamese.dyndns.org>
 <20100406060217.GF3901@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Pop <elendil@planet.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 20:39:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzaA3-0005ps-W2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757909Ab0DGSja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 14:39:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473Ab0DGSj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 14:39:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4462CA80B1;
	Wed,  7 Apr 2010 14:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MgyLq1FDlxW4fVu3SJy474RGpTk=; b=KFUrw8
	a4d+3/C8g/D+ugh9CaJTp1oCVxHCjyhcQnlGWkWrKAvDDwmPf0CAjFzrJNWnK9qt
	tpulQfnrGBE1EGvun9SszFGPp8+Z6hU54itSvh3go8go0Vj8R11/jZfmA+R3Ed6s
	A96O0vF+vQ3I3VcllFr3/WVIpsfeOjSPiUnMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a31CyESvio+9CAjPzo4AKXD6bUJpjCCU
	IxuVblIQsaqIg/vGCQk4oWy3KxeeAaE6gPBpA9c4KEBgzVqA6jYECaQsqzh1jhD0
	/8oE8ViSbreR4hwu6bg1oSJ1Pha1D5B3rU9u9vhPBHalTiUIzdp/Oa4a+gafEm0v
	TW/21PxqO6E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01C4EA80AC;
	Wed,  7 Apr 2010 14:39:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF3FDA80AA; Wed,  7 Apr
 2010 14:39:16 -0400 (EDT)
In-Reply-To: <20100406060217.GF3901@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 6 Apr 2010 02\:02\:17 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1FDDDBE-4274-11DF-93BE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144265>

Jeff King <peff@peff.net> writes:

> True. With the technique you mentioned above, you would reverse your
> test and do:
>
>   if (flags & REACHABLE)
>     return 0;
>   if (expanded_reachable_to_root)
>     return 1; /* we know it's not */
>   expand_reachable_to_root();
>   return !(flags & REACHABLE);
>
> I don't think I care enough to do a patch, though. I don't have a
> problem with you applying what you posted earlier.

Actually I do; I think it breaks correctness a big way (the second
paragraph of the proposed log message of the following).

-- >8 --
Subject: [PATCH] reflog --expire-unreachable: avoid merge-base computation

The option tells the command to expire older reflog entries that refer to
commits that are no longer reachable from the tip of the ref the reflog is
associated with.  To avoid repeated merge_base() invocations, we used to
mark commits that are known to be reachable by walking the history from
the tip until we hit commits that are older than expire-total (which is
the timestamp before which all the reflog entries are expired).

However, it is a different matter if a commit is _not_ known to be
reachable and the commit is known to be unreachable.  Because you can
rewind a ref to an ancient commit and then reset it back to the original
tip, a recent reflog entry can point at a commit that older than the
expire-total timestamp and we shouldn't expire it.  For that reason, we
had to run merge-base computation when a commit is _not_ known to be
reachable.

This introduces a lazy/on-demand traversal of the history to mark
reachable commits in steps.  As before, we mark commits that are newer
than expire-total to optimize the normal case before walking reflog, but
we dig deeper from the commits the initial step left off when we encounter
a commit that is not known to be reachable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * By the way, the following diff is extremely hard to read, as for some
   reason "diff" failed to notice that the only change is that we have
   added lines at the beginning of mark_reachable(), modified only the
   latter half of unreachable(), and moved mark_reachable() from after
   unreachable() to before.  Neither "git diff --patience" nor running GNU
   diff on to blobs helps.  Hmph...

 builtin-reflog.c |   96 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 7498210..9792090 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -36,6 +36,8 @@ struct expire_reflog_cb {
 	FILE *newlog;
 	const char *ref;
 	struct commit *ref_commit;
+	struct commit_list *mark_list;
+	unsigned long mark_limit;
 	struct cmd_reflog_expire_cb *cmd;
 	unsigned char last_kept_sha1[20];
 };
@@ -210,46 +212,23 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
 	return 1;
 }
 
-static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsigned char *sha1)
+/*
+ * Starting from commits in the cb->mark_list, mark commits that are
+ * reachable from them.  Stop the traversal at commits older than
+ * the expire_limit and queue them back, so that the caller can call
+ * us again to restart the traversal with longer expire_limit.
+ */
+static void mark_reachable(struct expire_reflog_cb *cb)
 {
-	/*
-	 * We may or may not have the commit yet - if not, look it
-	 * up using the supplied sha1.
-	 */
-	if (!commit) {
-		if (is_null_sha1(sha1))
-			return 0;
-
-		commit = lookup_commit_reference_gently(sha1, 1);
-
-		/* Not a commit -- keep it */
-		if (!commit)
-			return 0;
-	}
-
-	/* Reachable from the current ref?  Don't prune. */
-	if (commit->object.flags & REACHABLE)
-		return 0;
-	if (in_merge_bases(commit, &cb->ref_commit, 1))
-		return 0;
-
-	/* We can't reach it - prune it. */
-	return 1;
-}
+	struct commit *commit;
+	struct commit_list *pending;
+	unsigned long expire_limit = cb->mark_limit;
+	struct commit_list *leftover = NULL;
 
-static void mark_reachable(struct commit *commit, unsigned long expire_limit)
-{
-	/*
-	 * We need to compute whether the commit on either side of a reflog
-	 * entry is reachable from the tip of the ref for all entries.
-	 * Mark commits that are reachable from the tip down to the
-	 * time threshold first; we know a commit marked thusly is
-	 * reachable from the tip without running in_merge_bases()
-	 * at all.
-	 */
-	struct commit_list *pending = NULL;
+	for (pending = cb->mark_list; pending; pending = pending->next)
+		pending->item->object.flags &= ~REACHABLE;
 
-	commit_list_insert(commit, &pending);
+	pending = cb->mark_list;
 	while (pending) {
 		struct commit_list *entry = pending;
 		struct commit_list *parent;
@@ -261,8 +240,11 @@ static void mark_reachable(struct commit *commit, unsigned long expire_limit)
 		if (parse_commit(commit))
 			continue;
 		commit->object.flags |= REACHABLE;
-		if (commit->date < expire_limit)
+		if (commit->date < expire_limit) {
+			commit_list_insert(commit, &leftover);
 			continue;
+		}
+		commit->object.flags |= REACHABLE;
 		parent = commit->parents;
 		while (parent) {
 			commit = parent->item;
@@ -272,6 +254,36 @@ static void mark_reachable(struct commit *commit, unsigned long expire_limit)
 			commit_list_insert(commit, &pending);
 		}
 	}
+	cb->mark_list = leftover;
+}
+
+static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsigned char *sha1)
+{
+	/*
+	 * We may or may not have the commit yet - if not, look it
+	 * up using the supplied sha1.
+	 */
+	if (!commit) {
+		if (is_null_sha1(sha1))
+			return 0;
+
+		commit = lookup_commit_reference_gently(sha1, 1);
+
+		/* Not a commit -- keep it */
+		if (!commit)
+			return 0;
+	}
+
+	/* Reachable from the current ref?  Don't prune. */
+	if (commit->object.flags & REACHABLE)
+		return 0;
+
+	if (cb->mark_list && cb->mark_limit) {
+		cb->mark_limit = 0; /* dig down to the root */
+		mark_reachable(cb);
+	}
+
+	return !(commit->object.flags & REACHABLE);
 }
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
@@ -348,8 +360,12 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	cb.ref_commit = lookup_commit_reference_gently(sha1, 1);
 	cb.ref = ref;
 	cb.cmd = cmd;
-	if (cb.ref_commit)
-		mark_reachable(cb.ref_commit, cmd->expire_total);
+	if (cb.ref_commit) {
+		cb.mark_list = NULL;
+		commit_list_insert(cb.ref_commit, &cb.mark_list);
+		cb.mark_limit = cmd->expire_total;
+		mark_reachable(&cb);
+	}
 	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
 	if (cb.ref_commit)
 		clear_commit_marks(cb.ref_commit, REACHABLE);
-- 
1.7.1.rc0.212.gbd88f
