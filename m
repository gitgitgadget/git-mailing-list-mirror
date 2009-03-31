From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 23:08:02 -0700
Message-ID: <7vd4by6x8d.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain>
 <7vk5668g55.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903302231370.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903302244580.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 08:09:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoXAa-0004q1-4k
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 08:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758555AbZCaGIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 02:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762073AbZCaGIQ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 02:08:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760983AbZCaGIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 02:08:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D6E5CA63F5;
	Tue, 31 Mar 2009 02:08:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 96325A63F3; Tue,
 31 Mar 2009 02:08:06 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0903302244580.4093@localhost.localdomain>
 (Linus Torvalds's message of "Mon, 30 Mar 2009 22:50:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 510BFCDA-1DBA-11DE-9DC5-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115224>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 30 Mar 2009, Linus Torvalds wrote:
>> 
>> If I do
>> 
>> 	mark_reachable(cb.ref_commit, 0);
>
> Ok, I think I got it.
>
> You had
>
> 	mark_reachable(cb.ref_commit, cmd->expire_unreachable);
>
> but we care about the commits that are younger than 'expire_total' (older 
> than that, and they are pruned unconditionally), but older than 
> 'expire_unreachable' (younger than that and the date doesn't matter).
>
> So making it do
>
> 	mark_reachable(cb.ref_commit, cmd->expire_total);
>
> marks the right parts reachable. Not the whole tree, but also not just the 
> commits we're not going to expire regardless.
>
> With that change, it's all basically instantaneous. We don't need to 
> traverse the whole kernel history, and with that change to your patch, I 
> get
>
> 	[torvalds@nehalem linux]$ time ~/git/git reflog expire --all
>
> 	real	0m1.715s
> 	user	0m1.676s
> 	sys	0m0.040s
>
> which is still slower than I'd wish for, but is a whole lot faster than 
> over half a minute.

Actually, the initial pruning I showed (around 23 seconds) is not helped
with the expire_total change at all, but if I mark everything and get rid
of in_merge_bases(), it goes down to 1.15 seconds.

But subsequent pruning, which is what we should be optimizing for, gets
much faster with your approach of not traversing down the history all the
way.

By the way, I suspect I might be making the same mistake of traversing
both sides of the merge twice while marking, but I am tired already, so
I'll throw out the final patch for tonight and go to bed.

 builtin-reflog.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index d95f515..b67272a 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -52,6 +52,7 @@ struct collect_reflog_cb {
 
 #define INCOMPLETE	(1u<<10)
 #define STUDYING	(1u<<11)
+#define REACHABLE	(1u<<12)
 
 static int tree_is_complete(const unsigned char *sha1)
 {
@@ -209,6 +210,43 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
 	return 1;
 }
 
+static void mark_reachable(struct commit *commit, unsigned long expire_limit)
+{
+	/*
+	 * We need to compute if commit on either side of an reflog
+	 * entry is reachable from the tip of the ref for all entries.
+	 * Mark commits that are reachable from the tip down to the
+	 * time threashold first; we know a commit marked thusly is
+	 * reachable from the tip without running in_merge_bases()
+	 * at all.
+	 */
+	struct commit_list *pending = NULL;
+
+	commit_list_insert(commit, &pending);
+	while (pending) {
+		struct commit_list *entry = pending;
+		struct commit_list *parent;
+		pending = entry->next;
+		commit = entry->item;
+		free(entry);
+		if (commit->object.flags & REACHABLE)
+			continue;
+		commit->object.flags |= REACHABLE;
+		parent = commit->parents;
+		while (parent) {
+			commit = parent->item;
+			parent = parent->next;
+			if (commit->object.flags & REACHABLE)
+				continue;
+			if (parse_commit(commit))
+				continue;
+			if (expire_limit && commit->date < expire_limit)
+				continue;
+			commit_list_insert(commit, &pending);
+		}
+	}
+}
+
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
@@ -234,8 +272,10 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 			old = lookup_commit_reference_gently(osha1, 1);
 		if (!new && !is_null_sha1(nsha1))
 			new = lookup_commit_reference_gently(nsha1, 1);
-		if ((old && !in_merge_bases(old, &cb->ref_commit, 1)) ||
-		    (new && !in_merge_bases(new, &cb->ref_commit, 1)))
+		if ((old && !(old->object.flags & REACHABLE) &&
+		     !in_merge_bases(old, &cb->ref_commit, 1)) ||
+		    (new && !(new->object.flags & REACHABLE) &&
+		     !in_merge_bases(new, &cb->ref_commit, 1)))
 			goto prune;
 	}
 
@@ -288,7 +328,11 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	cb.ref_commit = lookup_commit_reference_gently(sha1, 1);
 	cb.ref = ref;
 	cb.cmd = cmd;
+	if (cb.ref_commit)
+		mark_reachable(cb.ref_commit, cmd->expire_total);
 	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+	if (cb.ref_commit)
+		clear_commit_marks(cb.ref_commit, REACHABLE);
  finish:
 	if (cb.newlog) {
 		if (fclose(cb.newlog)) {
