From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Speed up reflog pruning of unreachable commits
Date: Tue, 31 Mar 2009 10:11:56 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903311010050.4093@localhost.localdomain>
References: <alpine.LFD.2.00.0903310958000.4093@localhost.localdomain> <alpine.LFD.2.00.0903311003490.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:16:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LohYe-0006mH-Sr
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 19:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695AbZCaRNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756872AbZCaRNd
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 13:13:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54416 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757047AbZCaRNc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 13:13:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2VHBvFg016241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Mar 2009 10:12:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2VHBu0c004576;
	Tue, 31 Mar 2009 10:11:56 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0903311003490.4093@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115289>


From: Junio Hamano <gitster@pobox.com>
Date: Mon, 30 Mar 2009 21:34:14 -0700

Instead of doing the (potentially very expensive) "in_merge_base()"
check for each commit that might be pruned if it is unreachable, do a
preparatory reachability graph of the commit space, so that the common
case of being reachable can be tested directly.

[ Cleaned up a bit and tweaked to actually work.  - Linus ]
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-reflog.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 0355ce6..f29ab2f 100644
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
+		if (parse_commit(commit))
+			continue;
+		commit->object.flags |= REACHABLE;
+		if (commit->date < expire_limit)
+			continue;
+		parent = commit->parents;
+		while (parent) {
+			commit = parent->item;
+			parent = parent->next;
+			if (commit->object.flags & REACHABLE)
+				continue;
+			commit_list_insert(commit, &pending);
+		}
+	}
+}
+
 static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsigned char *sha1)
 {
 	/*
@@ -227,6 +265,8 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
 	}
 
 	/* Reachable from the current reflog top? Don't prune */
+	if (commit->object.flags & REACHABLE)
+		return 0;
 	if (in_merge_bases(commit, &cb->ref_commit, 1))
 		return 0;
 
@@ -308,7 +348,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	cb.ref_commit = lookup_commit_reference_gently(sha1, 1);
 	cb.ref = ref;
 	cb.cmd = cmd;
+
+	mark_reachable(cb.ref_commit, cmd->expire_total);
 	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+	clear_commit_marks(cb.ref_commit, REACHABLE);
  finish:
 	if (cb.newlog) {
 		if (fclose(cb.newlog)) {
-- 
1.6.2.1.404.gb0085.dirty
