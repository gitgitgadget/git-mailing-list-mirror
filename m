From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch --set-upstream regression in master
Date: Fri, 16 Sep 2011 16:14:51 -0700
Message-ID: <7v39fwdqqc.fsf@alter.siamese.dyndns.org>
References: <CAG+J_DyxNpPevwfrJVkv3GBmv0tEXgW2LZtdHgarFoXb9Qqghw@mail.gmail.com>
 <7v7h58dri4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, conrad.irwin@gmail.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 17 01:15:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4hca-0006tN-Nz
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 01:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab1IPXO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 19:14:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695Ab1IPXOz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 19:14:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9422C5247;
	Fri, 16 Sep 2011 19:14:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lLCqnX5urUs5Dg+ktJb721q2+FU=; b=aFuPnA
	vWLBRmJdmL5S/PxuVG2kpss0wJGEAa08KsTv8O7tPiDcjJgd3aAvDMTyfWMd04IC
	7UaduieoZVxrk2Nnkvk43/UhB4gLI/DZc5NLmGlgJ9Qwjh9Cr1Qk/WryMrdfZBmJ
	GkIjhhmXgg7qWAY+VbgNMQIURHy7BqrFxs+YE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qfkX8WnciSszrxjqfuaDm7exuVkBa1JA
	YgpvxFI6Y6K0hFe0ztjVH3LfBl1nJTqJM2pCtXsLF2hOm/12EqaO6x0Usf0R8N70
	SfpxEzZtic6fYhswGzUwslZR1jN+cExYhZZ89WjW2gwQutdyOnip3iCkWzHQZkRC
	Kza036cBTE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A55B5246;
	Fri, 16 Sep 2011 19:14:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8530C5245; Fri, 16 Sep 2011
 19:14:52 -0400 (EDT)
In-Reply-To: <7v7h58dri4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Sep 2011 15:58:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEB1AE92-E0B9-11E0-A9CC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181566>

Junio C Hamano <gitster@pobox.com> writes:

> I took a brief look at --set-upstream codepath, and I have to say that the
> implementation is totally broken with respect to an existing branch.
>
> Given
>
> 	$ git branch master --set-upstream origin/master
>
> it passes the exact same codepath as
>
> 	$ git branch master origin/master
>
> uses, only with a different "track" flag, no?  That is, it calls a
> function that is meant to _create_ branch "master" from given branch point
> "origin/master", namely create_branch().  And then create_branch(),
> contrary to its name, is littered with "dont_change_ref" special case to
> work it around, depending on the value of "track".

So here is a quick-and-dirty patch, which may or may not compile or pass
tests.

 branch.c           |   21 ++++++++++++---------
 branch.h           |   12 +++++++++++-
 builtin/branch.c   |    2 +-
 builtin/checkout.c |    3 ++-
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/branch.c b/branch.c
index 478d825..fecedd3 100644
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
index aa705a0..f49596f 100644
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
index 3bb6525..5e356a6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1073,7 +1073,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.new_branch) {
 		struct strbuf buf = STRBUF_INIT;
 
-		opts.branch_exists = validate_new_branchname(opts.new_branch, &buf, !!opts.new_branch_force);
+		opts.branch_exists = validate_new_branchname(opts.new_branch, &buf,
+							     !!opts.new_branch_force, 0);
 
 		strbuf_release(&buf);
 	}
