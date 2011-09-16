From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch --set-upstream regression in master
Date: Fri, 16 Sep 2011 16:52:19 -0700
Message-ID: <7vy5xocafg.fsf@alter.siamese.dyndns.org>
References: <CAG+J_DyxNpPevwfrJVkv3GBmv0tEXgW2LZtdHgarFoXb9Qqghw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, conrad.irwin@gmail.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 17 01:52:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4iCq-0001jO-DH
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 01:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab1IPXwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 19:52:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925Ab1IPXwW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 19:52:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69D5C596A;
	Fri, 16 Sep 2011 19:52:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=enoBcBqnXAD+xCaRWljkm8zfml4=; b=vY5sCJ
	nHsiBVq4jtb7wBknFRaecj7V4hGXsM7kJdgbEGeQewOCoEqBh5PI+/uzzQleA/YF
	Wf5+HIIUOQEgellgi7aBJbA2XIAQzsekdHfJzI8keki7dOJCeqbn5/qFy0YBEnyA
	vHqgJetOdZHKSKDQK9tDfWKGMNRGl7RenMyN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mrrwB+MDbmFhDLoML0od0GJIlGPYxDDJ
	bFJIJjgENzrgeJXm2B68sQTn9IMVCFfk9RQGZo6bREfH1/cuZrLi9vDFnXzzVPv3
	gXBXktPMVH7YXwXoMXBWDwKHnRg7Fh0R4reO5VYrDioZuWPH+bFayDB5tZuQ20Qx
	jPEdBYjXsaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C9E45969;
	Fri, 16 Sep 2011 19:52:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 648E55968; Fri, 16 Sep 2011
 19:52:20 -0400 (EDT)
In-Reply-To: <CAG+J_DyxNpPevwfrJVkv3GBmv0tEXgW2LZtdHgarFoXb9Qqghw@mail.gmail.com> (Jay
 Soffian's message of "Fri, 16 Sep 2011 17:43:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA86D69A-E0BE-11E0-90E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181567>

Jay Soffian <jaysoffian@gmail.com> writes:

> This used to be possible on the checked out branch:
>
>   $ git branch --set-upstream origin/master master
>
> Now it gives "fatal: Cannot force update the current branch."
> broken.

Let's do this. I would be happy if I can include it in -rc2 with Tested-by:
or something ;-)

-- >8 --
Subject: [PATCH] branch --set-upstream: regression fix

The "git branch" command, while not in listing mode, calls create_branch()
even when the target branch already exists, and it does so even when it is
not interested in updating the value of the branch (i.e. the name of the
commit object that sits at the tip of the existing branch). This happens
when the command is run with "--set-upstream" option.

The earlier safety-measure to prevent "git branch -f $branch $commit" from
updating the currently checked out branch did not take it into account,
and we no longer can update the tracking information of the current branch.

Minimally fix this regression by telling the validation code if it is
called to really update the value of a potentially existing branch, or if
the caller merely is interested in updating auxiliary aspects of a branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c           |   21 ++++++++++++---------
 branch.h           |   12 +++++++++++-
 builtin/branch.c   |    2 +-
 builtin/checkout.c |    3 ++-
 t/t3200-branch.sh  |   13 +++++++++++++
 5 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/branch.c b/branch.c
index 1fe3078..4338a90 100644
--- a/branch.c
+++ b/branch.c
@@ -135,23 +135,25 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	return 0;
 }
 
-int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+int validate_new_branchname(const char *name, struct strbuf *ref,
+			    int force, int attr_only)
 {
-	const char *head;
-	unsigned char sha1[20];
-
 	if (strbuf_check_branch_ref(ref, name))
 		die("'%s' is not a valid branch name.", name);
 
 	if (!ref_exists(ref->buf))
 		return 0;
-	else if (!force)
+	else if (!force && !attr_only)
 		die("A branch named '%s' already exists.", ref->buf + strlen("refs/heads/"));
 
-	head = resolve_ref("HEAD", sha1, 0, NULL);
-	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-		die("Cannot force update the current branch.");
+	if (!attr_only) {
+		const char *head;
+		unsigned char sha1[20];
 
+		head = resolve_ref("HEAD", sha1, 0, NULL);
+		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
+			die("Cannot force update the current branch.");
+	}
 	return 1;
 }
 
@@ -171,7 +173,8 @@ void create_branch(const char *head,
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if (validate_new_branchname(name, &ref, force || track == BRANCH_TRACK_OVERRIDE)) {
+	if (validate_new_branchname(name, &ref, force,
+				    track == BRANCH_TRACK_OVERRIDE)) {
 		if (!force)
 			dont_change_ref = 1;
 		else
diff --git a/branch.h b/branch.h
index 01544e2..1285158 100644
--- a/branch.h
+++ b/branch.h
@@ -20,8 +20,18 @@ void create_branch(const char *head, const char *name, const char *start_name,
  * interpreted ref in ref, force indicates whether (non-head) branches
  * may be overwritten. A non-zero return value indicates that the force
  * parameter was non-zero and the branch already exists.
+ *
+ * Contrary to all of the above, when attr_only is 1, the caller is
+ * not interested in verifying if it is Ok to update the named
+ * branch to point at a potentially different commit. It is merely
+ * asking if it is OK to change some attribute for the named branch
+ * (e.g. tracking upstream).
+ *
+ * NEEDSWORK: This needs to be split into two separate functions in the
+ * longer run for sanity.
+ *
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+int validate_new_branchname(const char *name, struct strbuf *ref, int force, int attr_only);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index 40f885c..5fb3d85 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -566,7 +566,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
-	validate_new_branchname(newname, &newref, force);
+	validate_new_branchname(newname, &newref, force, 0);
 
 	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 		 oldref.buf, newref.buf);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ddefec0..909a334 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1072,7 +1072,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.new_branch) {
 		struct strbuf buf = STRBUF_INIT;
 
-		opts.branch_exists = validate_new_branchname(opts.new_branch, &buf, !!opts.new_branch_force);
+		opts.branch_exists = validate_new_branchname(opts.new_branch, &buf,
+							     !!opts.new_branch_force, 0);
 
 		strbuf_release(&buf);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cb6458d..7633930 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -554,4 +554,17 @@ test_expect_success 'attempt to delete a branch merged to its base' '
 	test_must_fail git branch -d my10
 '
 
+test_expect_success 'use set-upstream on the current branch' '
+	git checkout master &&
+	git --bare init myupstream.git &&
+	git push myupstream.git master:refs/heads/frotz &&
+	git remote add origin myupstream.git &&
+	git fetch &&
+	git branch --set-upstream master origin/frotz &&
+
+	test "z$(git config branch.master.remote)" = "zorigin" &&
+	test "z$(git config branch.master.merge)" = "zrefs/heads/frotz"
+
+'
+
 test_done
-- 
1.7.7.rc1.4.g26e426
