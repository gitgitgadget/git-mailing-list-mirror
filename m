From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Wed, 29 Dec 2010 12:53:55 -0800
Message-ID: <7voc84s3ks.fsf_-_@alter.siamese.dyndns.org>
References: <20101201171814.GC6439@ikki.ethgen.de>
 <20101201185046.GB27024@burratino> <7vipydwp50.fsf@alter.siamese.dyndns.org>
 <4D1A7B42.1050907@web.de> <7vlj39to1t.fsf@alter.siamese.dyndns.org>
 <4D1AF989.3000105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 29 21:54:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY32K-0007QU-Gl
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 21:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab0L2UyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 15:54:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab0L2UyN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 15:54:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C21753FD1;
	Wed, 29 Dec 2010 15:54:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5/+ZphO7HzKmaK5S+a8EH0UDbRY=; b=eSfmP+
	4qHgNDnaCq0hlNzuZKfqu7Z/m4ssGyJZCUFZg36pDIa3kXpVkiwh+d3VDU+bWEhV
	Qf/t9JpYrkFXufKWvTt8l2Y3BVkHNGpCTF1rXE7cok6vnfgDIelohU/zi6CftZEa
	OAT7It++d8fcc3ZYK9Wstepts/rirTQ9XlTcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QaFmw8OqdXwCFOFyXHWbnKKKoH/wsJPg
	ShXOblbrZUmbcc7yHf2dZi3cLWW1FD3lxJR5iOF9xn1bfdR09TrrnuGaxu5RBO+Y
	eyVQF9Cny/1/6v3mau00cSEe2rvnDncE5AAwLNcN6NhTRLV8creiUmyuIT4Ke0FU
	Yy9EY6sHfg8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 713633FD0;
	Wed, 29 Dec 2010 15:54:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 474EA3FCF; Wed, 29 Dec 2010
 15:54:30 -0500 (EST)
In-Reply-To: <4D1AF989.3000105@web.de> (Jens Lehmann's message of "Wed\, 29
 Dec 2010 10\:04\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D91194EE-138D-11E0-A7BA-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164329>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> $ git checkout -f -q -b master origin/master
> fatal: git checkout: branch master already exists
> $ git checkout -f -q -B master origin/master
> fatal: Cannot force update the current branch.
>
> So maybe the real problem here is that "git checkout -B" barfs when it
> doesn't have anything to do instead of silently doing nothing?
>
> So we maybe want to fix this issue in "git checkout"? Then the patch
> will start working (and the test for it can be added in a later patch).

Let me think aloud, as it may be a good time to summarize the current
semantics of what "checking out a branch" means.

 0. "git checkout $branch" to check out a branch is to start preparing to
    commit on that branch while keeping the tentative changes you have in
    your working tree and your index.

 1. You might not have the $branch yet to check out in such a way.  You
    could do

    $ git branch $branch $start && git checkout $branch

    and

    $ git checkout -b $branch $start

    is conceptually a short-hand of the above two command sequence.

 3. When $branch exists, 2. should fail, as it involves resetting the tip
    of $branch to $start, potentially losing commits near its old tip.
    If you really mean it, you can force it by

    $ git checkout -B $branch $start

    which is conceptually a short-hand for:

    $ git branch -f $branch $start && git checkout $branch

 4. "git checkout $branch" refuses to discard your work when the
    tentative changes you made conflict with the difference between your
    current HEAD and $branch.  You can give "-m" to force it to attempt a
    three-way merge with possible conflicts, or you can give "-f" to force
    it to discard all tentative changes.

 5. The logical consequence of all of the above is that "git checkout [-f]
    -B $branch $start" should conceptually be a short-hand for:

    $ git branch -f $branch $start && git checkout [-f] $branch

And "branch -f $branch" refuses to reset the tip of the current branch.

An end-user who runs "git checkout -f -B $branch $start" is telling us
the following things:

 - The $branch may or may not exist;

 - The tip it currently may point at is immaterial and the user is willing
   to lose it (this is what capital-ness of -B means);

 - The tentative changes in the working tree and the index is immaterial
   (this is what -f given to checkout means).

It seems to me that "checkout -f -B $branch $start" when $branch is the
current one ought to do an equivalent of "reset --hard $start" and nothing
else.

What happens if -f is not given?  The user wants to keep the tentative
changes, and that is done by comparing a commit in HEAD (i.e. the current
branch) and the target $branch.  The two step approach that can be
illustrated by the short-hand definition of "checkout -B" however breaks
down in this case, even if you change the variant of "git branch -f" it
internally runs:

    $ git branch --allow-updating-current -f $branch $start &&
      git checkout $branch

The first step already resets $branch to its new value, and the second
step does not have a way to know that your tentative changes are based on
the previous value.

BUT ;-)

I think it is Ok after all. The actual implementation of "checkout -[b|B]"
is more like:

    $ git read-tree -m -u HEAD $start
    $ git update-ref -f refs/heads/$branch $start
    $ git symbolic-ref HEAD refs/heads/$branch

That is, when we update the working tree and the index, we still haven't
updated the HEAD yet (switch_branches() calls merge_working_tree() to run
this two-way merge, and then calls update_refs_for_switch() which does the
update-ref part including the branch creation).

The next question is if we want to enable "git branch -f $branch $start"
for the current branch from the end user, which presumably would look as
if the user ran "git reset $start".  I am actually indifferent about this,
but as the first step we probably should be conservative to forbid it as
we do now.

So in conclusion, here is a patch that is not even compile tested ;-)

This was made on top of 'maint' only because that was the branch I
happened to have checked out in my development working tree.

Note that the test script does not even test the case I was initially
worried about (i.e. keeping local changes).  I'll leave it to interested
others ;-)

 branch.c                   |   12 ++++++++----
 branch.h                   |   23 +++++++++++++++--------
 builtin/branch.c           |    3 ++-
 builtin/checkout.c         |    4 +++-
 t/t2018-checkout-branch.sh |   13 +++++++++++++
 5 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index 93dc866..74eb866 100644
--- a/branch.c
+++ b/branch.c
@@ -137,7 +137,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
-		   int force, int reflog, enum branch_track track)
+		   int flags, int reflog, enum branch_track track)
 {
 	struct ref_lock *lock = NULL;
 	struct commit *commit;
@@ -147,6 +147,9 @@ void create_branch(const char *head,
 	int forcing = 0;
 	int dont_change_ref = 0;
 	int explicit_tracking = 0;
+	int ok_to_update = flags & (CREATE_BRANCH_UPDATE_OK |
+				    CREATE_BRANCH_UPDATE_CURRENT_OK);
+	int ok_to_update_current = flags & CREATE_BRANCH_UPDATE_CURRENT_OK;
 
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
@@ -155,11 +158,12 @@ void create_branch(const char *head,
 		die("'%s' is not a valid branch name.", name);
 
 	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
-		if (!force && track == BRANCH_TRACK_OVERRIDE)
+		if (!ok_to_update && track == BRANCH_TRACK_OVERRIDE)
 			dont_change_ref = 1;
-		else if (!force)
+		else if (!ok_to_update)
 			die("A branch named '%s' already exists.", name);
-		else if (!is_bare_repository() && head && !strcmp(head, name))
+		else if (!ok_to_update_current &&
+			 !is_bare_repository() && head && !strcmp(head, name))
 			die("Cannot force update the current branch.");
 		forcing = 1;
 	}
diff --git a/branch.h b/branch.h
index eed817a..0afbeae 100644
--- a/branch.h
+++ b/branch.h
@@ -4,16 +4,23 @@
 /* Functions for acting on the information about branches. */
 
 /*
- * Creates a new branch, where head is the branch currently checked
- * out, name is the new branch name, start_name is the name of the
- * existing branch that the new branch should start from, force
- * enables overwriting an existing (non-head) branch, reflog creates a
- * reflog for the branch, and track causes the new branch to be
- * configured to merge the remote branch that start_name is a tracking
- * branch for (if any).
+ * Creates a new branch, where:
+ *
+ * - head is the branch currently checked out;
+ * - name is the new branch name;
+ * - start_name is the name of a commit that the new branch should start at
+ *   (could be another branch or a remote-tracking branch, in which case
+ *   track---see below---may also trigger);
+ * - flags indicates overwriting an existing branch and/or overwriting the
+ *   current branch is allowed;
+ * - reflog creates a reflog for the branch; and
+ * - track causes the new branch to be configured to merge the remote branch
+ *   that start_name is a tracking branch for (if any).
  */
+#define CREATE_BRANCH_UPDATE_OK 01
+#define CREATE_BRANCH_UPDATE_CURRENT_OK 02
 void create_branch(const char *head, const char *name, const char *start_name,
-		   int force, int reflog, enum branch_track track);
+		   int flags, int reflog, enum branch_track track);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index 87976f0..ea5b411 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -651,7 +651,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
-		OPT_BOOLEAN('f', "force", &force_create, "force creation (when already exists)"),
+		OPT_SET_INT('f', "force", &force_create, "force creation (when already exists)",
+			    CREATE_BRANCH_UPDATE_OK),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
 			"commit", "print only not merged branches",
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a54583b..bf5b43a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -529,7 +529,9 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		}
 		else
 			create_branch(old->name, opts->new_branch, new->name,
-				      opts->new_branch_force ? 1 : 0,
+				      opts->new_branch_force
+				      ? CREATE_BRANCH_UPDATE_CURRENT_OK
+				      : 0,
 				      opts->new_branch_log, opts->track);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index fa69016..37e4fdb 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -169,4 +169,17 @@ test_expect_success 'checkout -f -B to an existing branch with mergeable changes
 	test_must_fail test_dirty_mergeable
 '
 
+test_expect_success 'checkout -b/B the current branch' '
+	git reset --hard &&
+	git checkout branch1 &&
+	it=$(git rev-parse --verify HEAD) &&
+	test_must_fail git checkout -b branch1 HEAD &&
+	git checkout -B branch1 $it &&
+	test "$it" = "$(git rev-parse --verify HEAD)" &&
+	test "refs/heads/branch1" = "$(git symbolic-ref HEAD)" &&
+	git checkout -B branch1 HEAD &&
+	test "$it" = "$(git rev-parse --verify HEAD)" &&
+	test "refs/heads/branch1" = "$(git symbolic-ref HEAD)"
+'
+
 test_done
