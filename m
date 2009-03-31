From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 22:24:05 -0700
Message-ID: <7vy6um6z9m.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain>
 <7vk5668g55.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWTq-0004bz-Ln
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104AbZCaFYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZCaFYQ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:24:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbZCaFYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 01:24:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC019A61AE;
	Tue, 31 Mar 2009 01:24:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 04D94A61AD; Tue,
 31 Mar 2009 01:24:06 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain>
 (Linus Torvalds's message of "Mon, 30 Mar 2009 22:09:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B7540D6-1DB4-11DE-BE8F-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115214>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 30 Mar 2009, Junio C Hamano wrote:
>> 
>> Most of your reflog entries are expected to be reachable from the tip, so
>> one optimization would be to mark all commits reachable from the tip
>> upfront, and omit the in_merge_bases() computation for the ones that are
>> already marked.  Perhaps something like this...
>
> This if anything makes things just go slower.
>
> Not much, but some. It went from 36.566s to 38.070s. That may be in the 
> noise, I've not done any sensitivity analysis.

I actually think that the cutoff for history traversal is bogus.  You may
have a 30-day old reflog entry that pulled in a 45-day old commit, and
giving up the smudging at the expiry cutoff timestamp does not make much
sense.

I do have a lot of reflog entries kept around, as my main repository has
these:

        [gc]
                reflogexpire = '2005-01-01 00:00:00 +0000'
                reflogexpireunreachable = '2005-01-01 00:00:00 +0000'

so let me experiment a bit more.

 builtin-reflog.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index d95f515..ef02b5a 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -36,6 +36,7 @@ struct expire_reflog_cb {
 	FILE *newlog;
 	const char *ref;
 	struct commit *ref_commit;
+	int commit_marked;
 	struct cmd_reflog_expire_cb *cmd;
 	unsigned char last_kept_sha1[20];
 };
@@ -52,6 +53,7 @@ struct collect_reflog_cb {
 
 #define INCOMPLETE	(1u<<10)
 #define STUDYING	(1u<<11)
+#define REACHABLE	(1u<<12)
 
 static int tree_is_complete(const unsigned char *sha1)
 {
@@ -209,6 +211,43 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
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
+			if (commit->date < expire_limit)
+				continue;
+			commit_list_insert(commit, &pending);
+		}
+	}
+}
+
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
@@ -230,12 +269,28 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	if (timestamp < cb->cmd->expire_unreachable) {
 		if (!cb->ref_commit)
 			goto prune;
+
 		if (!old && !is_null_sha1(osha1))
 			old = lookup_commit_reference_gently(osha1, 1);
 		if (!new && !is_null_sha1(nsha1))
 			new = lookup_commit_reference_gently(nsha1, 1);
-		if ((old && !in_merge_bases(old, &cb->ref_commit, 1)) ||
-		    (new && !in_merge_bases(new, &cb->ref_commit, 1)))
+
+		if (!cb->commit_marked) {
+			if (old) {
+				mark_reachable(cb->ref_commit, old->date);
+				cb->commit_marked = 1;
+			} else if (new) {
+				mark_reachable(cb->ref_commit, new->date);
+				cb->commit_marked = 1;
+			}
+		}
+
+		if ((old &&
+		     !(old->object.flags & REACHABLE) &&
+		     !in_merge_bases(old, &cb->ref_commit, 1)) ||
+		    (new &&
+		     !(new->object.flags & REACHABLE) &&
+		     !in_merge_bases(new, &cb->ref_commit, 1)))
 			goto prune;
 	}
 
@@ -289,6 +344,8 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	cb.ref = ref;
 	cb.cmd = cmd;
 	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+	if (cb.ref_commit && cb.commit_marked)
+		clear_commit_marks(cb.ref_commit, REACHABLE);
  finish:
 	if (cb.newlog) {
 		if (fclose(cb.newlog)) {
