From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] get_merge_bases(): always clean-up object flags
Date: Thu, 30 Oct 2014 12:19:43 -0700
Message-ID: <xmqqvbn1uzzk.fsf@gitster.dls.corp.google.com>
References: <xmqq4mulwfew.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 20:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjvGC-0007yB-8n
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 20:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757506AbaJ3TTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 15:19:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754585AbaJ3TTq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 15:19:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCBDB18C1C;
	Thu, 30 Oct 2014 15:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOvZAQHlYtScXW312l4tD0+JEfY=; b=M7A+A5
	ZH5uIMuls7BqFWdIibqbLhCjhIb7INuLR2A4mMNDVf6vjr1HfKaDuEkIivf5PpyT
	8h/6MbaZEfdvxXUOpv9yADU1oLNSe60OBPOw60l8IfJOogZkaHhH8lRcBytu5fVH
	RceWp0i4ra6hRXoWqJCUT2nEdAN2OfCvbTSrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H+vqLLki63RxUGRLWol6LipZb0FUQXkV
	2tOfct/GsoKbsWQ8IDS/z6TBZu1D789Er/yRjd/hTdhD3QLlRSXmXPuGx1yoZBZD
	+yP6Jsc5N1IcrENC9j/I9nO/m0d0g9IIeCQ8MW7uCl7+RiBPWJ8YZyg0k+z60SY/
	51yV3wxfnvU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B456A18C1B;
	Thu, 30 Oct 2014 15:19:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0606718C1A;
	Thu, 30 Oct 2014 15:19:44 -0400 (EDT)
In-Reply-To: <xmqq4mulwfew.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 30 Oct 2014 12:01:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B4DF7190-6069-11E4-BE22-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callers of get_merge_bases() can choose to leave object flags
used during the merge-base traversal by passing cleanup=0 as a
parameter, but in practice a very few callers can afford to do so
(namely, "git merge-base"), as they need to compute merge base in
preparation for other processing of their own and they need to see
the object without contaminate flags.

Change the function signature of get_merge_bases_many() and
get_merge_bases() to drop the cleanup parameter, so that the
majority of the callers do not have to say ", 1" at the end.

Give a new get_merge_bases_many_dirty() API to support only a few
callers that know they do not need to spend cycles cleaning up the
object flags.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This comes on top of the previous "is it kosher for bisect to use
   the 'cleanup=0' variant in the merge-base computation upfront? I
   do not think so" patch.

 bisect.c             |  2 +-
 builtin/merge-base.c |  4 ++--
 builtin/merge.c      |  4 ++--
 builtin/rev-parse.c  |  2 +-
 commit.c             | 29 +++++++++++++++++++++--------
 commit.h             |  7 +++++--
 merge-recursive.c    |  2 +-
 notes-merge.c        |  2 +-
 revision.c           |  4 ++--
 sha1_name.c          |  2 +-
 submodule.c          |  2 +-
 11 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/bisect.c b/bisect.c
index ccca3b5..8c6d843 100644
--- a/bisect.c
+++ b/bisect.c
@@ -777,7 +777,7 @@ static void check_merge_bases(int no_checkout)
 	int rev_nr;
 	struct commit **rev = get_bad_and_good_commits(&rev_nr);
 
-	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1, 1);
+	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
 
 	for (; result; result = result->next) {
 		const unsigned char *mb = result->item->object.sha1;
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 0ecde8d..fdebef6 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -10,7 +10,7 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
 	struct commit_list *result;
 
-	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1, 0);
+	result = get_merge_bases_many_dirty(rev[0], rev_nr - 1, rev + 1);
 
 	if (!result)
 		return 1;
@@ -176,7 +176,7 @@ static int handle_fork_point(int argc, const char **argv)
 	for (i = 0; i < revs.nr; i++)
 		revs.commit[i]->object.flags &= ~TMP_MARK;
 
-	bases = get_merge_bases_many(derived, revs.nr, revs.commit, 0);
+	bases = get_merge_bases_many_dirty(derived, revs.nr, revs.commit);
 
 	/*
 	 * There should be one and only one merge base, when we found
diff --git a/builtin/merge.c b/builtin/merge.c
index bebbe5b..5249f4e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1320,7 +1320,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!remoteheads)
 		; /* already up-to-date */
 	else if (!remoteheads->next)
-		common = get_merge_bases(head_commit, remoteheads->item, 1);
+		common = get_merge_bases(head_commit, remoteheads->item);
 	else {
 		struct commit_list *list = remoteheads;
 		commit_list_insert(head_commit, &list);
@@ -1417,7 +1417,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * merge_bases again, otherwise "git merge HEAD^
 			 * HEAD^^" would be missed.
 			 */
-			common_one = get_merge_bases(head_commit, j->item, 1);
+			common_one = get_merge_bases(head_commit, j->item);
 			if (hashcmp(common_one->item->object.sha1,
 				j->item->object.sha1)) {
 				up_to_date = 0;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 35d3c43..95328b8 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -279,7 +279,7 @@ static int try_difference(const char *arg)
 			struct commit *a, *b;
 			a = lookup_commit_reference(sha1);
 			b = lookup_commit_reference(end);
-			exclude = get_merge_bases(a, b, 1);
+			exclude = get_merge_bases(a, b);
 			while (exclude) {
 				struct commit_list *n = exclude->next;
 				show_rev(REVERSED,
diff --git a/commit.c b/commit.c
index 19cf8f9..d13250e 100644
--- a/commit.c
+++ b/commit.c
@@ -867,7 +867,7 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 
 		for (j = ret; j; j = j->next) {
 			struct commit_list *bases;
-			bases = get_merge_bases(i->item, j->item, 1);
+			bases = get_merge_bases(i->item, j->item);
 			if (!new)
 				new = bases;
 			else
@@ -936,10 +936,10 @@ static int remove_redundant(struct commit **array, int cnt)
 	return filled;
 }
 
-struct commit_list *get_merge_bases_many(struct commit *one,
-					 int n,
-					 struct commit **twos,
-					 int cleanup)
+static struct commit_list *get_merge_bases_many_0(struct commit *one,
+						  int n,
+						  struct commit **twos,
+						  int cleanup)
 {
 	struct commit_list *list;
 	struct commit **rslt;
@@ -977,10 +977,23 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 	return result;
 }
 
-struct commit_list *get_merge_bases(struct commit *one, struct commit *two,
-				    int cleanup)
+struct commit_list *get_merge_bases_many(struct commit *one,
+					 int n,
+					 struct commit **twos)
+{
+	return get_merge_bases_many_0(one, n, twos, 1);
+}
+
+struct commit_list *get_merge_bases_many_dirty(struct commit *one,
+					       int n,
+					       struct commit **twos)
+{
+	return get_merge_bases_many_0(one, n, twos, 0);
+}
+
+struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
 {
-	return get_merge_bases_many(one, 1, &two, cleanup);
+	return get_merge_bases_many_0(one, 1, &two, 1);
 }
 
 /*
diff --git a/commit.h b/commit.h
index bc68ccb..28bc553 100644
--- a/commit.h
+++ b/commit.h
@@ -236,10 +236,13 @@ struct commit_graft *read_graft_line(char *buf, int len);
 int register_commit_graft(struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
-extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
-extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos, int cleanup);
+extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
+extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
+/* To be used only when object flags after this call no longer matter */
+extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
+
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
 
diff --git a/merge-recursive.c b/merge-recursive.c
index fdb7d0f..f758f7e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1904,7 +1904,7 @@ int merge_recursive(struct merge_options *o,
 	}
 
 	if (!ca) {
-		ca = get_merge_bases(h1, h2, 1);
+		ca = get_merge_bases(h1, h2);
 		ca = reverse_commit_list(ca);
 	}
 
diff --git a/notes-merge.c b/notes-merge.c
index 7eb9d7a..109ff4e 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -594,7 +594,7 @@ int notes_merge(struct notes_merge_options *o,
 	assert(local && remote);
 
 	/* Find merge bases */
-	bases = get_merge_bases(local, remote, 1);
+	bases = get_merge_bases(local, remote);
 	if (!bases) {
 		base_sha1 = null_sha1;
 		base_tree_sha1 = EMPTY_TREE_SHA1_BIN;
diff --git a/revision.c b/revision.c
index 75dda92..14e0e03 100644
--- a/revision.c
+++ b/revision.c
@@ -1441,7 +1441,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	other = lookup_commit_or_die(sha1, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
-	bases = get_merge_bases(head, other, 1);
+	bases = get_merge_bases(head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
 	free_commit_list(bases);
@@ -1546,7 +1546,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 				     : lookup_commit_reference(b_obj->sha1));
 				if (!a || !b)
 					goto missing;
-				exclude = get_merge_bases(a, b, 1);
+				exclude = get_merge_bases(a, b);
 				add_rev_cmdline_list(revs, exclude,
 						     REV_CMD_MERGE_BASE,
 						     flags_exclude);
diff --git a/sha1_name.c b/sha1_name.c
index 5b004f5..9737557 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -993,7 +993,7 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 	two = lookup_commit_reference_gently(sha1_tmp, 0);
 	if (!two)
 		return -1;
-	mbs = get_merge_bases(one, two, 1);
+	mbs = get_merge_bases(one, two);
 	if (!mbs || mbs->next)
 		st = -1;
 	else {
diff --git a/submodule.c b/submodule.c
index 0690dc5..d37d400 100644
--- a/submodule.c
+++ b/submodule.c
@@ -301,7 +301,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	left->object.flags |= SYMMETRIC_LEFT;
 	add_pending_object(rev, &left->object, path);
 	add_pending_object(rev, &right->object, path);
-	merge_bases = get_merge_bases(left, right, 1);
+	merge_bases = get_merge_bases(left, right);
 	if (merge_bases) {
 		if (merge_bases->item == left)
 			*fast_forward = 1;
