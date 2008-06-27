From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 09/15] Introduce get_merge_bases_many()
Date: Fri, 27 Jun 2008 18:22:02 +0200
Message-ID: <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
 <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
 <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
 <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk6-0004E3-Jp
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761181AbYF0QWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760999AbYF0QWe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:34 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45343 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760339AbYF0QWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:12 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id AF6131DDC64;
	Fri, 27 Jun 2008 18:22:06 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 518D818E830; Fri, 27 Jun 2008 18:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86587>

From: Junio C Hamano <gitster@pobox.com>

This introduces a new function get_merge_bases_many() which is a natural
extension of two commit merge base computation.  It is given one commit
(one) and a set of other commits (twos), and computes the merge base of
one and a merge across other commits.

This is mostly useful to figure out the common ancestor when iterating
over heads during an octopus merge.  When making an octopus between
commits A, B, C and D, we first merge tree of A and B, and then try to
merge C with it.  If we were making pairwise merge, we would be recording
the tree resulting from the merge between A and B as a commit, say M, and
then the next round we will be computing the merge base between M and C.

         o---C...*
        /       .
       o---B...M
      /       .
     o---o---A

But during an octopus merge, we actually do not create a commit M.  In
order to figure out that the common ancestor to use for this merge,
instead of computing the merge base between C and M, we can call
merge_bases_many() with one set to C and twos containing A and B.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c |   56 ++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/commit.c b/commit.c
index 6052ca3..cafed26 100644
--- a/commit.c
+++ b/commit.c
@@ -533,26 +533,34 @@ static struct commit *interesting(struct commit_list *list)
 	return NULL;
 }
 
-static struct commit_list *merge_bases(struct commit *one, struct commit *two)
+static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
+	int i;
 
-	if (one == two)
-		/* We do not mark this even with RESULT so we do not
-		 * have to clean it up.
-		 */
-		return commit_list_insert(one, &result);
+	for (i = 0; i < n; i++) {
+		if (one == twos[i])
+			/*
+			 * We do not mark this even with RESULT so we do not
+			 * have to clean it up.
+			 */
+			return commit_list_insert(one, &result);
+	}
 
 	if (parse_commit(one))
 		return NULL;
-	if (parse_commit(two))
-		return NULL;
+	for (i = 0; i < n; i++) {
+		if (parse_commit(twos[i]))
+			return NULL;
+	}
 
 	one->object.flags |= PARENT1;
-	two->object.flags |= PARENT2;
 	insert_by_date(one, &list);
-	insert_by_date(two, &list);
+	for (i = 0; i < n; i++) {
+		twos[i]->object.flags |= PARENT2;
+		insert_by_date(twos[i], &list);
+	}
 
 	while (interesting(list)) {
 		struct commit *commit;
@@ -627,21 +635,26 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
-struct commit_list *get_merge_bases(struct commit *one,
-					struct commit *two, int cleanup)
+struct commit_list *get_merge_bases_many(struct commit *one,
+					 int n,
+					 struct commit **twos,
+					 int cleanup)
 {
 	struct commit_list *list;
 	struct commit **rslt;
 	struct commit_list *result;
 	int cnt, i, j;
 
-	result = merge_bases(one, two);
-	if (one == two)
-		return result;
+	result = merge_bases_many(one, n, twos);
+	for (i = 0; i < n; i++) {
+		if (one == twos[i])
+			return result;
+	}
 	if (!result || !result->next) {
 		if (cleanup) {
 			clear_commit_marks(one, all_flags);
-			clear_commit_marks(two, all_flags);
+			for (i = 0; i < n; i++)
+				clear_commit_marks(twos[i], all_flags);
 		}
 		return result;
 	}
@@ -659,12 +672,13 @@ struct commit_list *get_merge_bases(struct commit *one,
 	free_commit_list(result);
 
 	clear_commit_marks(one, all_flags);
-	clear_commit_marks(two, all_flags);
+	for (i = 0; i < n; i++)
+		clear_commit_marks(twos[i], all_flags);
 	for (i = 0; i < cnt - 1; i++) {
 		for (j = i+1; j < cnt; j++) {
 			if (!rslt[i] || !rslt[j])
 				continue;
-			result = merge_bases(rslt[i], rslt[j]);
+			result = merge_bases_many(rslt[i], 1, &rslt[j]);
 			clear_commit_marks(rslt[i], all_flags);
 			clear_commit_marks(rslt[j], all_flags);
 			for (list = result; list; list = list->next) {
@@ -686,6 +700,12 @@ struct commit_list *get_merge_bases(struct commit *one,
 	return result;
 }
 
+struct commit_list *get_merge_bases(struct commit *one, struct commit *two,
+				    int cleanup)
+{
+	return get_merge_bases_many(one, 1, &two, cleanup);
+}
+
 int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 {
 	struct commit_list *bases, *b;
-- 
1.5.6
