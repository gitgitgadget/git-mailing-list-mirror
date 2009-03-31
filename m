From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 21:34:14 -0700
Message-ID: <7vk5668g55.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 06:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoVhf-0003Tr-BP
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 06:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761101AbZCaEeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 00:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761067AbZCaEeY
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 00:34:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863AbZCaEeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 00:34:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 46E27A0D8;
	Tue, 31 Mar 2009 00:34:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4DBFBA0D7; Tue,
 31 Mar 2009 00:34:16 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain>
 (Linus Torvalds's message of "Mon, 30 Mar 2009 18:43:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 345DC076-1DAD-11DE-9BEB-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115208>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I have not checked if there is anything really obvious going on that could 
> change that whole logic that causes us to do merge-bases into something 
> saner, since the reflog code is not a part of git I'm familiar with. 

When we look at one reflog entry with old and new commit, we decide to
prune an old entry if either side is unreachable from the tip of the
branch:

	if (timestamp < cb->cmd->expire_unreachable) {
		if (!cb->ref_commit)
			goto prune;
		if (!old && !is_null_sha1(osha1))
			old = lookup_commit_reference_gently(osha1, 1);
		if (!new && !is_null_sha1(nsha1))
			new = lookup_commit_reference_gently(nsha1, 1);
		if ((old && !in_merge_bases(old, &cb->ref_commit, 1)) ||
		    (new && !in_merge_bases(new, &cb->ref_commit, 1)))
			goto prune;
	}

Most of your reflog entries are expected to be reachable from the tip, so
one optimization would be to mark all commits reachable from the tip
upfront, and omit the in_merge_bases() computation for the ones that are
already marked.  Perhaps something like this...

 builtin-reflog.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index d95f515..f0d61bd 100644
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
@@ -234,8 +272,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 			old = lookup_commit_reference_gently(osha1, 1);
 		if (!new && !is_null_sha1(nsha1))
 			new = lookup_commit_reference_gently(nsha1, 1);
-		if ((old && !in_merge_bases(old, &cb->ref_commit, 1)) ||
-		    (new && !in_merge_bases(new, &cb->ref_commit, 1)))
+		if ((old &&
+		     !(old->object.flags & REACHABLE) &&
+		     !in_merge_bases(old, &cb->ref_commit, 1)) ||
+		    (new &&
+		     !(new->object.flags & REACHABLE) &&
+		     !in_merge_bases(new, &cb->ref_commit, 1)))
 			goto prune;
 	}
 
@@ -288,7 +330,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	cb.ref_commit = lookup_commit_reference_gently(sha1, 1);
 	cb.ref = ref;
 	cb.cmd = cmd;
+
+	mark_reachable(cb.ref_commit, cmd->expire_unreachable);
 	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+	clear_commit_marks(cb.ref_commit, REACHABLE);
  finish:
 	if (cb.newlog) {
 		if (fclose(cb.newlog)) {
