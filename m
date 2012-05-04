From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] checkout (detached): truncate list of orphaned commits
 at the new HEAD
Date: Fri, 04 May 2012 20:14:48 +0200
Message-ID: <4FA41C98.2010105@kdbg.org>
References: <4FA41C3A.9080002@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 20:14:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQN1r-0003fC-6V
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 20:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759304Ab2EDSOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 14:14:50 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:12552 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab2EDSOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 14:14:50 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B75A513004B;
	Fri,  4 May 2012 20:14:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6DB6F19F6CE;
	Fri,  4 May 2012 20:14:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <4FA41C3A.9080002@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197045>

When git checkout switches from a detached HEAD to any other commit, then
all orphaned commits were listed in a warning:

  Warning: you are leaving 2 commits behind...:

    a5e5396 another fixup
    6aa1af6 fixup foo

But if the new commit is actually one from this list (6aa1af6 in this
example), then the list in the warning can be truncated at the new HEAD,
because history beginning at HEAD is not "left behind". This makes it so.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin/checkout.c         | 13 +++++++------
 t/t2020-checkout-detach.sh |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 23fc56d..c93efe4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -672,10 +672,10 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
  * HEAD.  If it is not reachable from any ref, this is the last chance
  * for the user to do so without resorting to reflog.
  */
-static void orphaned_commit_warning(struct commit *commit)
+static void orphaned_commit_warning(struct commit *old, struct commit *new)
 {
 	struct rev_info revs;
-	struct object *object = &commit->object;
+	struct object *object = &old->object;
 	struct object_array refs;
 
 	init_revisions(&revs, NULL);
@@ -685,16 +685,17 @@ static void orphaned_commit_warning(struct commit *commit)
 	add_pending_object(&revs, object, sha1_to_hex(object->sha1));
 
 	for_each_ref(add_pending_uninteresting_ref, &revs);
+	add_pending_sha1(&revs, "HEAD", new->object.sha1, UNINTERESTING);
 
 	refs = revs.pending;
 	revs.leak_pending = 1;
 
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
-	if (!(commit->object.flags & UNINTERESTING))
-		suggest_reattach(commit, &revs);
+	if (!(old->object.flags & UNINTERESTING))
+		suggest_reattach(old, &revs);
 	else
-		describe_detached_head(_("Previous HEAD position was"), commit);
+		describe_detached_head(_("Previous HEAD position was"), old);
 
 	clear_commit_marks_for_object_array(&refs, ALL_REV_FLAGS);
 	free(refs.objects);
@@ -731,7 +732,7 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	}
 
 	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
-		orphaned_commit_warning(old.commit);
+		orphaned_commit_warning(old.commit, new->commit);
 
 	update_refs_for_switch(opts, &old, new);
 
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 1839b32..8100537 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -126,7 +126,7 @@ test_expect_success 'checkout warns orphaning 1 of 2 commits' '
 '
 
 test_expect_success 'checkout warns orphaning 1 of 2 commits: output' '
-	check_orphan_warning stderr "2 commits"
+	check_orphan_warning stderr "1 commit"
 '
 
 test_expect_success 'checkout does not warn leaving ref tip' '
-- 
1.7.10.1.462.g199f411
