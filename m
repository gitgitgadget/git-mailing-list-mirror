From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Clean up reflog unreachability pruning decision
Date: Tue, 31 Mar 2009 10:09:55 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903311003490.4093@localhost.localdomain>
References: <alpine.LFD.2.00.0903310958000.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:13:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LohWD-0005WW-Vp
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 19:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764AbZCaRL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 13:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756707AbZCaRL0
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 13:11:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48084 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755279AbZCaRLZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 13:11:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2VH9uoG016086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Mar 2009 10:10:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2VH9tcw004055;
	Tue, 31 Mar 2009 10:09:55 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0903310958000.4093@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115288>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2009 09:45:22 -0700

This clarifies the pruning rules for unreachable commits by having a 
separate helpder function for the unreachability decision.

It's preparation for actual bigger changes to come to speed up the
decision when the reachability calculations become a bottleneck.

In the process it also _does_ change behavior, although in a way that I 
think is much saner than the old behavior (which was in my opinion not 
designed, just a result of how the tests were written). It now will prune 
reflog entries that are older than that 'prune_unreacable' time _and_ that 
have commit references that can't be even looked up.

Of course, "--stale-fix" also does that, and does it regardless of the age 
of the reflog entry is, but I really think this is the right thing to do. 
If we can't even look it up, we should consider it to be unreachable.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-reflog.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

Note the behavioural change. I think it's sane and "ObviouslyCorrect(tm)", 
but maybe somebody disagrees.

diff --git a/builtin-reflog.c b/builtin-reflog.c
index d95f515..0355ce6 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -209,6 +209,31 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
 	return 1;
 }
 
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
+		/* We can't even look it up - consider it unreachable */
+		if (!commit)
+			return 1;
+	}
+
+	/* Reachable from the current reflog top? Don't prune */
+	if (in_merge_bases(commit, &cb->ref_commit, 1))
+		return 0;
+
+	/* We can't reach it - prune it. */
+	return 1;
+}
+
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
@@ -230,12 +255,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	if (timestamp < cb->cmd->expire_unreachable) {
 		if (!cb->ref_commit)
 			goto prune;
-		if (!old && !is_null_sha1(osha1))
-			old = lookup_commit_reference_gently(osha1, 1);
-		if (!new && !is_null_sha1(nsha1))
-			new = lookup_commit_reference_gently(nsha1, 1);
-		if ((old && !in_merge_bases(old, &cb->ref_commit, 1)) ||
-		    (new && !in_merge_bases(new, &cb->ref_commit, 1)))
+		if (unreachable(cb, old, osha1) || unreachable(cb, new, nsha1))
 			goto prune;
 	}
 
-- 
1.6.2.1.404.gb0085.dirty
