From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] commit: add in_merge_bases_many()
Date: Mon, 04 Mar 2013 16:48:19 -0800
Message-ID: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 01:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCg3l-0004o2-B7
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 01:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631Ab3CEAsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 19:48:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569Ab3CEAsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 19:48:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B86EA4B5;
	Mon,  4 Mar 2013 19:48:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	sJ3smXzmRm6BtvLTyGSIDpp/H4=; b=gt5SIqMuoEAEgEjD/KYKmWa9jt2FtLiYm
	N+LSGKc0YaBg7miVTwnjfUqdszEdTP9KnA2RUO9bce6iG7Mp1gYZySK6qfgUwcv3
	Fh+23uURlHddLSz1kutSpYSj7Eucq0m25OsfegJzjcVFKy44kZkIYyS6PURFBQSL
	3h1Ivi+yVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Tgz
	v1gumOlJ1npZiCsq1kAio8vCqSKoL/tN89r8FaQtuaoLMoyFZqhDk2H3yLPcBQXv
	q4mWdjvpybMxDDrBSv9EBiJzlCKhgIHHagi54xsfxBtEeY7cz8IevMdzn0beA5bG
	pel9fVA4TIrmO7AntW1l6PaRjxZNNZISy9sJ2sGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD7DA4B4;
	Mon,  4 Mar 2013 19:48:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53F09A4B0; Mon,  4 Mar 2013
 19:48:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60CBFF5A-852E-11E2-B934-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217421>

Similar to in_merge_bases(commit, other) that returns true when
commit is an ancestor (i.e. in the merge bases between the two) of
the other commit, in_merge_bases_many(commit, n_other, other[])
checks if commit is an ancestor of any of the other[] commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 24 ++++++++++++++++++------
 commit.h |  1 +
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index e8eb0ae..3a201e0 100644
--- a/commit.c
+++ b/commit.c
@@ -852,25 +852,37 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 }
 
 /*
- * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
+ * Is "commit" an ancestor of one of the "reference"s?
  */
-int in_merge_bases(struct commit *commit, struct commit *reference)
+int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference)
 {
 	struct commit_list *bases;
-	int ret = 0;
+	int ret = 0, i;
 
-	if (parse_commit(commit) || parse_commit(reference))
+	if (parse_commit(commit))
 		return ret;
+	for (i = 0; i < nr_reference; i++)
+		if (parse_commit(reference[i]))
+			return ret;
 
-	bases = paint_down_to_common(commit, 1, &reference);
+	bases = paint_down_to_common(commit, nr_reference, reference);
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
-	clear_commit_marks(reference, all_flags);
+	for (i = 0; i < nr_reference; i++)
+		clear_commit_marks(reference[i], all_flags);
 	free_commit_list(bases);
 	return ret;
 }
 
+/*
+ * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
+ */
+int in_merge_bases(struct commit *commit, struct commit *reference)
+{
+	return in_merge_bases_many(commit, 1, &reference);
+}
+
 struct commit_list *reduce_heads(struct commit_list *heads)
 {
 	struct commit_list *p;
diff --git a/commit.h b/commit.h
index b6ad8f3..d5b9712 100644
--- a/commit.h
+++ b/commit.h
@@ -170,6 +170,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
+int in_merge_bases_many(struct commit *, int, struct commit **);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
-- 
1.8.2-rc2-182-g857a7fa
