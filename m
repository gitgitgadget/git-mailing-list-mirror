From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] commit.c: add in_merge_bases_many()
Date: Tue,  5 Mar 2013 14:47:17 -0800
Message-ID: <1362523639-30566-3-git-send-email-gitster@pobox.com>
References: <1362523639-30566-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 23:47:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD0eE-0004uP-8G
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 23:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab3CEWr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 17:47:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052Ab3CEWrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 17:47:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7C4AD4F
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=NFYh
	A+BHN3knpWevX5OgwA0KiGI=; b=k24/ByjiCRejUkcDcMXxtgAFn1zIhDDjlXOs
	vBbyRPwotdP6RL+cjAUFRvmo2hnIUp9J6zsP0MeI5q3LJSdGO3bRa8MJdBQiHM9g
	9Obe/6z/NdYg87HT02vvQMc5sklDguyHBLdM9+n7/23IqyIO/4xh7O7ogFyWVQAS
	5sfcgdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=n0VrWw
	rvd/z5nTmxDd6TAT0JaCHymfPVHd0Kqm1JIBkxr5tfPv4Jp+iOkO6liDMo8kI7IE
	4Mj1OiFYA+hGJjYtb1Nq9DtPnq8AdWP40n3WTBBDyMoEgjdfzJVdbRx3pAlzN7G0
	mJTqaq9B9uY6ozvjzMIz8YlerVz16O0EOYYMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8058CAD4A
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE1D0AD47 for
 <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:24 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc2-194-g549a9ef
In-Reply-To: <1362523639-30566-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A609BAC2-85E6-11E2-A2E5-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217491>

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
index 4757e50..d12e799 100644
--- a/commit.c
+++ b/commit.c
@@ -859,25 +859,37 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 }
 
 /*
- * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
+ * Is "commit" an ancestor of one of the "references"?
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
index b997eea..5057f14 100644
--- a/commit.h
+++ b/commit.h
@@ -171,6 +171,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
+int in_merge_bases_many(struct commit *, int, struct commit **);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
-- 
1.8.2-rc2-194-g549a9ef
