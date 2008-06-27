From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 10/15] Introduce reduce_heads()
Date: Fri, 27 Jun 2008 18:22:03 +0200
Message-ID: <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
 <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
 <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
 <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org>
 <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk5-0004E3-Vi
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760570AbYF0QWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759830AbYF0QW3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:29 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45344 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760327AbYF0QWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:12 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id AD8D81DDC63;
	Fri, 27 Jun 2008 18:22:06 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 4F98E18E82C; Fri, 27 Jun 2008 18:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86581>

From: Junio C Hamano <gitster@pobox.com>

The new function reduce_heads() is given a list of commits, and removes
ones that can be reached from other commits in the list.  It is useful for
reducing the commits randomly thrown at the git-merge command and remove
redundant commits that the user shouldn't have given to it.

The implementation uses the get_merge_bases_many() introduced in the
previous commit.  If the merge base between one commit taken from the list
and the remaining commits is the commit itself, that means the commit is
reachable from some of the other commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 commit.h |    2 ++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index cafed26..d20b14e 100644
--- a/commit.c
+++ b/commit.c
@@ -725,3 +725,48 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	free_commit_list(bases);
 	return ret;
 }
+
+struct commit_list *reduce_heads(struct commit_list *heads)
+{
+	struct commit_list *p;
+	struct commit_list *result = NULL, **tail = &result;
+	struct commit **other;
+	size_t num_head, num_other;
+
+	if (!heads)
+		return NULL;
+
+	/* Avoid unnecessary reallocations */
+	for (p = heads, num_head = 0; p; p = p->next)
+		num_head++;
+	other = xcalloc(sizeof(*other), num_head);
+
+	/* For each commit, see if it can be reached by others */
+	for (p = heads; p; p = p->next) {
+		struct commit_list *q, *base;
+
+		num_other = 0;
+		for (q = heads; q; q = q->next) {
+			if (p == q)
+				continue;
+			other[num_other++] = q->item;
+		}
+		if (num_other) {
+			base = get_merge_bases_many(p->item, num_other, other, 1);
+		} else
+			base = NULL;
+		/*
+		 * If p->item does not have anything common with other
+		 * commits, there won't be any merge base.  If it is
+		 * reachable from some of the others, p->item will be
+		 * the merge base.  If its history is connected with
+		 * others, but p->item is not reachable by others, we
+		 * will get something other than p->item back.
+		 */
+		if (!base || (base->item != p->item))
+			tail = &(commit_list_insert(p->item, tail)->next);
+		free_commit_list(base);
+	}
+	free(other);
+	return result;
+}
diff --git a/commit.h b/commit.h
index dcec7fb..2acfc79 100644
--- a/commit.h
+++ b/commit.h
@@ -140,4 +140,6 @@ static inline int single_parent(struct commit *commit)
 	return commit->parents && !commit->parents->next;
 }
 
+struct commit_list *reduce_heads(struct commit_list *heads);
+
 #endif /* COMMIT_H */
-- 
1.5.6
