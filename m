From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] in_merge_bases(): support only one "other" commit
Date: Mon, 27 Aug 2012 16:11:59 -0700
Message-ID: <1346109123-12357-2-git-send-email-gitster@pobox.com>
References: <1346109123-12357-1-git-send-email-gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 01:12:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68Th-0007JL-22
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 01:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab2H0XMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 19:12:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab2H0XMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 19:12:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48C099160;
	Mon, 27 Aug 2012 19:12:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=jRgL
	+EsN3y5hJtCwDZ6bLIDi+4o=; b=jOtv3g8pHW9HxzT1JcD5koowFatqZ4HKHsIW
	Ku19Zkapha4zBuMyV6bpktItJjUm6oL7n5d54ASSlRQDnhJ8Q6JgjWQR5rwi9FxQ
	ZYFWye+bUdi+wKjPAlFSt8yviN8bEfOagP8HMe3S9/Xgcju4bd86r0xa+oiNO/Gv
	kfeju+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ZZIg4DcEeeurl1s0D+1ry433P06n1OVvIu/b7Tuh6aWLNXWA3B3EAD7JGUXMbhO7
	AYKgKoI+DmeTjvCvwGRe2iRYc/DEsLc1l5i0Sy3RKQI0JdEhx2yfI5qAemqDSynR
	c0PiyzI8h1ThNoVdM6YWREodEltvzAq9MYyH48jTqxY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 358B1915F;
	Mon, 27 Aug 2012 19:12:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AFB5915D; Mon, 27 Aug 2012
 19:12:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.270.g724661d
In-Reply-To: <1346109123-12357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9F175704-F09C-11E1-A16B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204387>

In early days of its life, I planned to make it possible to compute
"is a commit contained in all of these other commits?" with this
function, but it turned out that no caller needed it.

Just make it take two commit objects and add a comment to say what
these two functions do.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c                       |  4 ++--
 builtin/fetch.c                        |  2 +-
 commit.c                               | 15 +++++++++------
 commit.h                               |  2 +-
 contrib/examples/builtin-fetch--tool.c |  2 +-
 fast-import.c                          |  2 +-
 submodule.c                            | 12 ++++++------
 7 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..0360774 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -129,7 +129,7 @@ static int branch_merged(int kind, const char *name,
 	if (!reference_rev)
 		reference_rev = head_rev;
 
-	merged = in_merge_bases(rev, &reference_rev, 1);
+	merged = in_merge_bases(rev, reference_rev);
 
 	/*
 	 * After the safety valve is fully redefined to "check with
@@ -139,7 +139,7 @@ static int branch_merged(int kind, const char *name,
 	 * a gentle reminder is in order.
 	 */
 	if ((head_rev != reference_rev) &&
-	    in_merge_bases(rev, &head_rev, 1) != merged) {
+	    in_merge_bases(rev, head_rev) != merged) {
 		if (merged)
 			warning(_("deleting branch '%s' that has been merged to\n"
 				"         '%s', but not yet merged to HEAD."),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb9a074..723072f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -323,7 +323,7 @@ static int update_local_ref(struct ref *ref,
 		return r;
 	}
 
-	if (in_merge_bases(current, &updated, 1)) {
+	if (in_merge_bases(current, updated)) {
 		char quickref[83];
 		int r;
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
diff --git a/commit.c b/commit.c
index 42af4c1..74ec5f1 100644
--- a/commit.c
+++ b/commit.c
@@ -780,6 +780,9 @@ struct commit_list *get_merge_bases(struct commit *one, struct commit *two,
 	return get_merge_bases_many(one, 1, &two, cleanup);
 }
 
+/*
+ * Is "commit" a decendant of one of the elements on the "with_commit" list?
+ */
 int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 {
 	if (!with_commit)
@@ -789,21 +792,21 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 
 		other = with_commit->item;
 		with_commit = with_commit->next;
-		if (in_merge_bases(other, &commit, 1))
+		if (in_merge_bases(other, commit))
 			return 1;
 	}
 	return 0;
 }
 
-int in_merge_bases(struct commit *commit, struct commit **reference, int num)
+/*
+ * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
+ */
+int in_merge_bases(struct commit *commit, struct commit *reference)
 {
 	struct commit_list *bases, *b;
 	int ret = 0;
 
-	if (num == 1)
-		bases = get_merge_bases(commit, *reference, 1);
-	else
-		die("not yet");
+	bases = get_merge_bases(commit, reference, 1);
 	for (b = bases; b; b = b->next) {
 		if (!hashcmp(commit->object.sha1, b->item->object.sha1)) {
 			ret = 1;
diff --git a/commit.h b/commit.h
index d617fa3..6edce87 100644
--- a/commit.h
+++ b/commit.h
@@ -171,7 +171,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 
 int is_descendant_of(struct commit *, struct commit_list *);
-int in_merge_bases(struct commit *, struct commit **, int);
+int in_merge_bases(struct commit *, struct commit *);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
diff --git a/contrib/examples/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
index 0d54aa7..8bc8c75 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -96,7 +96,7 @@ static int update_local_ref(const char *name,
 	strcpy(oldh, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 	strcpy(newh, find_unique_abbrev(sha1_new, DEFAULT_ABBREV));
 
-	if (in_merge_bases(current, &updated, 1)) {
+	if (in_merge_bases(current, updated)) {
 		fprintf(stderr, "* %s: fast-forward to %s\n",
 			name, note);
 		fprintf(stderr, "  old..new: %s..%s\n", oldh, newh);
diff --git a/fast-import.c b/fast-import.c
index eed97c8..c2a814e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1691,7 +1691,7 @@ static int update_branch(struct branch *b)
 			return error("Branch %s is missing commits.", b->name);
 		}
 
-		if (!in_merge_bases(old_cmit, &new_cmit, 1)) {
+		if (!in_merge_bases(old_cmit, new_cmit)) {
 			unlock_ref(lock);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
diff --git a/submodule.c b/submodule.c
index 19dc6a6..d133796 100644
--- a/submodule.c
+++ b/submodule.c
@@ -788,7 +788,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 		die("revision walk setup failed");
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object *o = &(commit->object);
-		if (in_merge_bases(b, &commit, 1))
+		if (in_merge_bases(b, commit))
 			add_object_array(o, NULL, &merges);
 	}
 	reset_revision_walk();
@@ -803,7 +803,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 		contains_another = 0;
 		for (j = 0; j < merges.nr; j++) {
 			struct commit *m2 = (struct commit *) merges.objects[j].item;
-			if (i != j && in_merge_bases(m2, &m1, 1)) {
+			if (i != j && in_merge_bases(m2, m1)) {
 				contains_another = 1;
 				break;
 			}
@@ -865,18 +865,18 @@ int merge_submodule(unsigned char result[20], const char *path,
 	}
 
 	/* check whether both changes are forward */
-	if (!in_merge_bases(commit_base, &commit_a, 1) ||
-	    !in_merge_bases(commit_base, &commit_b, 1)) {
+	if (!in_merge_bases(commit_base, commit_a) ||
+	    !in_merge_bases(commit_base, commit_b)) {
 		MERGE_WARNING(path, "commits don't follow merge-base");
 		return 0;
 	}
 
 	/* Case #1: a is contained in b or vice versa */
-	if (in_merge_bases(commit_a, &commit_b, 1)) {
+	if (in_merge_bases(commit_a, commit_b)) {
 		hashcpy(result, b);
 		return 1;
 	}
-	if (in_merge_bases(commit_b, &commit_a, 1)) {
+	if (in_merge_bases(commit_b, commit_a)) {
 		hashcpy(result, a);
 		return 1;
 	}
-- 
1.7.12.116.g31e0100
