From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about 'branch -d' safety
Date: Tue, 29 Dec 2009 22:43:04 -0800
Message-ID: <7vhbr955dz.fsf@alter.siamese.dyndns.org>
References: <20091230065442.6117@nanako3.lavabit.com>
 <20091229223123.GA12965@vidovic> <20091230121238.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 07:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPsH9-0001Qg-Tb
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 07:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbZL3GnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 01:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbZL3GnP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 01:43:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbZL3GnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 01:43:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 801E7AB902;
	Wed, 30 Dec 2009 01:43:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K4vvUQ0j+jaWuFF6YlpEZQLDEMY=; b=dp3jIx
	t68T8+ju6HWYLmKALrXjX5lfIhzrzLgGV+hi2yQKEvv+lJIPQxbrYjhDgnN7t4OA
	TOkevMjfxGu/BlmhEVi764K67qTxM/vevhpzBuQ8EJNPU39k2XPlZ4PBned9uGec
	9slp/OUhNL80h9mO0toF57C2aNhv02oYp+nVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uicsBVr6VZmEfpBg+MVVFVPqSAaaFttJ
	FQnMku2g4BNigMElzWgttSv49IHGH/lq93D4oGx28ivUPXcwL5h1VfsSDVARX1WK
	7EsM0WgB79D5HElc6ee+TxhzqEzbsF9vsO1z2GCnn9IjAhiaFKQaFQsdmejQJhXF
	4cxtiY2x+6E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 501E8AB901;
	Wed, 30 Dec 2009 01:43:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B3575AB900; Wed, 30 Dec 2009
 01:43:05 -0500 (EST)
In-Reply-To: <20091230121238.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 30 Dec 2009 12\:12\:38 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 986660DA-F50E-11DE-81E7-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135863>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
>
>> The 30/12/09, Nanako Shiraishi wrote:
>>
>>> I think the safety feature should check if the branch to be deleted is merged to the remote tracking branch it was forked from, instead of checking the current branch.
>>> 
>>> What do you think?
>>
>> I think we shouldn't. At first, every repository don't have a remote.
>> This may easily be passed by a "double check" with a logical OR between
>> the two statements.
>
> Sorry, I was unclear. What I meant was that checking with the branch the
> branch to be deleted was forked from, if and only if such a branch
> exists. Otherwise, we can keep using the old default behavior to check
> with the current branch.

Back when the original "safety valve" was added, there was no mechanical
"this branch _always_ merges from/rebases on that other one" settings.
The users were supposed to keep track of the correspondence, and the
canonical workflow was "checkout this && merge that && branch -d that".

But I actually think it is quite a natural thing to do in year 2010 to
change the safety valve as suggested.

A patch to do so would look like this.

-- >8 --
branch -d: base the "already-merged" safety on the branch it merges with

When a branch is marked to merge with another ref (e.g. local 'next' that
merges from and pushes back to origin's 'next', with 'branch.next.merge'
set to 'refs/heads/next'), it makes little sense to base the "branch -d"
safety, whose purpose is not to lose commits that are not merged to other
branches, on the current branch.  It is much more sensible to check if it
is merged with the other branch it merges with.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-branch.c  |   64 ++++++++++++++++++++++++++++++++++++++++++++--------
 t/t3200-branch.sh |   26 +++++++++++++++++++++
 2 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index c87e63b..d2a35fe 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -93,9 +93,60 @@ static const char *branch_get_color(enum color_branch ix)
 	return "";
 }
 
+static int branch_merged(int kind, const char *name,
+			 struct commit *rev, struct commit *head_rev)
+{
+	/*
+	 * This checks whether the merge bases of branch and HEAD (or
+	 * the other branch this branch builds upon) contains the
+	 * branch, which means that the branch has already been merged
+	 * safely to HEAD (or the other branch).
+	 */
+	struct commit *reference_rev = NULL;
+	const char *reference_name = NULL;
+	int merged;
+
+	if (kind == REF_LOCAL_BRANCH) {
+		struct branch *branch = branch_get(name);
+		unsigned char sha1[20];
+
+		if (branch &&
+		    branch->merge &&
+		    branch->merge[0] &&
+		    branch->merge[0]->dst &&
+		    (reference_name =
+		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL)) != NULL)
+			reference_rev = lookup_commit_reference(sha1);
+	}
+	if (!reference_rev)
+		reference_rev = head_rev;
+
+	merged = in_merge_bases(rev, &reference_rev, 1);
+
+	/*
+	 * After the safety valve is fully redefined to "check with
+	 * upstream, if any, otherwise with HEAD", we should just
+	 * return the result of the in_merge_bases() above without
+	 * any of the following code, but during the transition period,
+	 * a gentle reminder is in order.
+	 */
+	if ((head_rev != reference_rev) &&
+	    in_merge_bases(rev, &head_rev, 1) != merged) {
+		if (merged)
+			warning("deleting branch '%s' that has been merged to\n"
+				"         '%s', but it is not yet merged to HEAD.",
+				name, reference_name);
+		else
+			warning("not deleting branch '%s' that is not yet merged to\n"
+				"         '%s', even though it is merged to HEAD.",
+				name, reference_name);
+	}
+	return merged;
+}
+
 static int delete_branches(int argc, const char **argv, int force, int kinds)
 {
-	struct commit *rev, *head_rev = head_rev;
+	struct commit *rev, *head_rev = NULL;
 	unsigned char sha1[20];
 	char *name = NULL;
 	const char *fmt, *remote;
@@ -148,15 +199,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			continue;
 		}
 
-		/* This checks whether the merge bases of branch and
-		 * HEAD contains branch -- which means that the HEAD
-		 * contains everything in both.
-		 */
-
-		if (!force &&
-		    !in_merge_bases(rev, &head_rev, 1)) {
-			error("The branch '%s' is not an ancestor of "
-			      "your current HEAD.\n"
+		if (!force && !branch_merged(kinds, bname.buf, rev, head_rev)) {
+			error("The branch '%s' is not fully merged.\n"
 			      "If you are sure you want to delete it, "
 			      "run 'git branch -D %s'.", bname.buf, bname.buf);
 			ret = 1;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d59a9b4..e0b7605 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -468,4 +468,30 @@ test_expect_success 'detect misconfigured autosetuprebase (no value)' '
 	git config --unset branch.autosetuprebase
 '
 
+test_expect_success 'attempt to delete a branch without base and unmerged to HEAD' '
+	git checkout my9 &&
+	git config --unset branch.my8.merge &&
+	test_must_fail git branch -d my8
+'
+
+test_expect_success 'attempt to delete a branch merged to its base' '
+	# we are on my9 which is the initial commit; traditionally
+	# we would not have allowed deleting my8 that is not merged
+	# to my9, but it is set to track master that already has my8
+	git config branch.my8.merge refs/heads/master &&
+	git branch -d my8
+'
+
+test_expect_success 'attempt to delete a branch merged to its base' '
+	git checkout master &&
+	echo Third >>A &&
+	git commit -m "Third commit" A &&
+	git branch -t my10 my9 &&
+	git branch -f my10 HEAD^ &&
+	# we are on master which is at the third commit, and my10
+	# is behind us, so traditionally we would have allowed deleting
+	# it; but my10 is set to track my9 that is further behind.
+	test_must_fail git branch -d my10
+'
+
 test_done
