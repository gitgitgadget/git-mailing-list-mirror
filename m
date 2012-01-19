From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] Making pathspec limited log play nicer with --first-parent
Date: Thu, 19 Jan 2012 11:58:45 -0800
Message-ID: <7v1uqvjwga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 20:58:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rny8K-0007YC-P8
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 20:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932917Ab2AST6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 14:58:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932487Ab2AST6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 14:58:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 482AA740B;
	Thu, 19 Jan 2012 14:58:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	xtcgyzwp7qE0ZF/eN9Qjd6i7cI=; b=Lb3qiMXY4LH/OeM6ypUmudt6X7KBQN763
	7dJFS2E3JCKWADsY1wfzARhrXlK5g7CR8nxXO2wB8PXkj5OsM5HAO39cjFPDu976
	XffxstikIyvWyKGzZDJBvCCYkChH23K4LXs8MZB78Yy3ECyY7nTRa26LvVbyWP0u
	vMnPoCvg30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=bi53wb1PqxkvjCTvoi1LNNZAGNObyuH4cxtWeVqlxuTYmatJU1Y+Nt3F
	3owgjGG3T3gtXTgZANYSIIhIUKf6T0RpdRPVJ9Fpo3ikUOpOplhaPhdCXe2r5bNy
	XtZAxCBHYVMWXdf52+/MNRAoIexYSFsMu0GUXZnQWxxgWwGOb6M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40357740A;
	Thu, 19 Jan 2012 14:58:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72C5D7409; Thu, 19 Jan 2012
 14:58:46 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF33DACC-42D7-11E1-854E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188828>

I often find myself frustrated when I receive an update to a part of the
project and want to find the latest commit that merges the topic branch
that touched the same area.

For example, I wanted to find the latest merge of any git-p4 related topic
so that I can fork a new topic branch to keep Luke's updates posted today.

Without pathspec, "git log --first-parent" traverses the first-parent
chain just fine, and "-m --stat" shows the list of paths touched by the
merge, so we _could_ ask the question this way:

    $ git log --first-parent --oneline -m --stat master |
      sed -e '/^ contrib\/fast-import\/git-p4 /q' | tail
      
The above finds that 8cbfc11 (Merge branch 'pw/p4-view-updates',
2012-01-06) was such a commit.

But a more natural way to spell it does not work as expected:

    $ git log --first-parent --oneline -m --stat -1 master -- \
      contrib/fast-import/git-p4

This finds ecb7cf9 (git-p4: rewrite view handling, 2012-01-02), which is a
part of the merged topic branch and is _not_ on the first-parent path from
the 'master':

    $ git show-branch 8cbfc11 ecb7cf9
    ! [8cbfc11] Merge branch 'pw/p4-view-updates'
     ! [ecb7cf9] git-p4: rewrite view handling
    --
    -  [8cbfc11] Merge branch 'pw/p4-view-updates'
    +  [8cbfc11^2] git-p4: view spec documentation
    ++ [ecb7cf9] git-p4: rewrite view handling

The problem happens when the merge simplification logic kicks in when the
traversal inspects the merge 8cbfc11. In this case, the history leading to
the tip of 'master' did not touch git-p4 since 'pw/p4-view-updates' topic
forked from it, and the result of the merge is simply a copy from the tip
of the topic branch in the view limited by the given pathspec.  The merge
simplification logic discards the first-parent of the merge and pretends
as if the sole parent of the merge is its second parent, i.e. the tip of
the topic. The history traversal veers off to the side branch, possibly
skipping a large swath of the mainline history if the topic forked from it
long in the past, but that only happens when the mainline did not touch
the paths in the limited view since the side topic forked, so it is not
losing information---but it still is wrong to show the commits on the side
topic when we are explicitly asked to show the first-parent chain.

Here is an attempt to fix this issue, by not allowing us to compare the
merge result with anything but the first parent when --first-parent is in
effect, to avoid the history traversal veering off to the side branch.

As this touches deep innards of a scary hairball that is the revision
traversal machinery, I am obviously not considering it as a 1.7.9
material, but I think we would want to fix it at some point, hopefully
soon.

With this patch, the "more natural way" finds the merge commit I am
looking for.

Comments?

---
 revision.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 064e351..9e4596d 100644
--- a/revision.c
+++ b/revision.c
@@ -416,7 +416,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp, *parent;
-	int tree_changed = 0, tree_same = 0;
+	int tree_changed = 0, tree_same = 0, nth_parent = 0;
 
 	/*
 	 * If we don't do pruning, everything is interesting
@@ -444,6 +444,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	while ((parent = *pp) != NULL) {
 		struct commit *p = parent->item;
 
+		if (revs->first_parent_only && nth_parent++)
+			break;
 		if (parse_commit(p) < 0)
 			die("cannot simplify commit %s (because of %s)",
 			    sha1_to_hex(commit->object.sha1),
