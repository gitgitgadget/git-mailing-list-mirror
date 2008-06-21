From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Introduce get_merge_bases_many()
Date: Sat, 21 Jun 2008 02:45:50 -0700
Message-ID: <7vlk0zazox.fsf@gitster.siamese.dyndns.org>
References: <7vabhgq02p.fsf@gitster.siamese.dyndns.org>
 <1214007784-4801-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 21 11:47:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9zga-0006Hk-8u
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 11:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYFUJp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 05:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbYFUJp6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 05:45:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbYFUJp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 05:45:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B0C8A708;
	Sat, 21 Jun 2008 05:45:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 83DC7A707; Sat, 21 Jun 2008 05:45:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D81EE674-3F76-11DD-9769-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85697>

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
index e2d8624..4ee234d 100644
--- a/commit.c
+++ b/commit.c
@@ -525,26 +525,34 @@ static struct commit *interesting(struct commit_list *list)
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
@@ -592,21 +600,26 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 	return result;
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
@@ -624,12 +637,13 @@ struct commit_list *get_merge_bases(struct commit *one,
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
@@ -651,6 +665,12 @@ struct commit_list *get_merge_bases(struct commit *one,
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
1.5.6.6.gd3e97
