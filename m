From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH 1/2] Prevent force-updating of the current branch
Date: Sat, 20 Aug 2011 14:49:48 -0700
Message-ID: <1313876989-16328-2-git-send-email-conrad.irwin@gmail.com>
References: <1313876989-16328-1-git-send-email-conrad.irwin@gmail.com>
Cc: gitster@pobox.com, Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 23:50:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QutR5-0003z5-9Q
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 23:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab1HTVuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 17:50:24 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37483 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab1HTVuN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 17:50:13 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so7812235iye.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M0xtDPyiMO6s6VgMxTg7SXhOryMsNlB05XQ/eF7AB0g=;
        b=Cp1JbVqPXeYOcCMNZbV9KsPd+GdV/VffQnrh9I7y/heAEhxAmZ6bBDW9skvn1ljxKB
         D6genszXyanPs4uA8suJkpTXjQ7Jbh70qYon/E+CX5OAAEoBtYdxVUWJFF0zOxx9XmrF
         lBENo4p8Ww91AKeGieetqRYSG2FeTj6CEYQqI=
Received: by 10.231.60.139 with SMTP id p11mr1932571ibh.73.1313877013595;
        Sat, 20 Aug 2011 14:50:13 -0700 (PDT)
Received: from localhost.localdomain (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id v16sm2391221ibe.51.2011.08.20.14.50.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 14:50:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.562.g0b2d4
In-Reply-To: <1313876989-16328-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179785>

git branch -M <foo> <current-branch> could be used to change the branch
to which HEAD points, without the necessary house-keeping that git reset
normally does to make this operation sensible. It would leave the reflog
in a confusing state (you would be warned when trying to read it) and
had an apparently side-effect of staging the diff between <current branch>
and <foo>.

git checkout -B <current branch> <foo> was also partly vulnerable to
this bug; due to inconsistent pre-flight checks it would perform half of
its task and then abort just before rewriting the branch. Again this
manifested itself as the index file getting out-of-sync with HEAD.

git checkout -f already guarded against this problem, and aborted with
a fatal error.

git branch -M, git checkout -B and git branch -f now use the same checks
before allowing a branch to be created. These prevent you from updating
the current branch.

We considered suggesting the use of "git reset" in the failure message
but concluded that it was not possible to discern what the user was
actually trying to do.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 branch.c                   |   34 ++++++++++++++++++++++++----------
 branch.h                   |    8 ++++++++
 builtin/branch.c           |    6 +-----
 builtin/checkout.c         |   12 +++---------
 t/t2018-checkout-branch.sh |    8 ++++++++
 t/t3200-branch.sh          |   12 ++++++++++++
 6 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/branch.c b/branch.c
index c0c865a..ff84b5b 100644
--- a/branch.c
+++ b/branch.c
@@ -135,6 +135,26 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	return 0;
 }
 
+int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+{
+	const char *head;
+	unsigned char sha1[20];
+
+	if (strbuf_check_branch_ref(ref, name))
+		die("'%s' is not a valid branch name.", name);
+
+	if (!ref_exists(ref->buf))
+		return 0;
+	else if (!force)
+		die("A branch named '%s' already exists.", name);
+
+	head = resolve_ref("HEAD", sha1, 0, NULL);
+	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
+		die("Cannot force update the current branch.");
+
+	return 1;
+}
+
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
 		   int force, int reflog, enum branch_track track)
@@ -151,17 +171,11 @@ void create_branch(const char *head,
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if (strbuf_check_branch_ref(&ref, name))
-		die("'%s' is not a valid branch name.", name);
-
-	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
-		if (!force && track == BRANCH_TRACK_OVERRIDE)
+	if (validate_new_branchname(name, &ref, force || track == BRANCH_TRACK_OVERRIDE)) {
+		if (!force)
 			dont_change_ref = 1;
-		else if (!force)
-			die("A branch named '%s' already exists.", name);
-		else if (!is_bare_repository() && head && !strcmp(head, name))
-			die("Cannot force update the current branch.");
-		forcing = 1;
+		else
+			forcing = 1;
 	}
 
 	real_ref = NULL;
diff --git a/branch.h b/branch.h
index 4026e38..01544e2 100644
--- a/branch.h
+++ b/branch.h
@@ -16,6 +16,14 @@ void create_branch(const char *head, const char *name, const char *start_name,
 		   int force, int reflog, enum branch_track track);
 
 /*
+ * Validates that the requested branch may be created, returning the
+ * interpreted ref in ref, force indicates whether (non-head) branches
+ * may be overwritten. A non-zero return value indicates that the force
+ * parameter was non-zero and the branch already exists.
+ */
+int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+
+/*
  * Remove information about the state of working on the current
  * branch. (E.g., MERGE_HEAD)
  */
diff --git a/builtin/branch.c b/builtin/branch.c
index 3142daa..40f885c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -566,11 +566,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
-	if (strbuf_check_branch_ref(&newref, newname))
-		die(_("Invalid branch name: '%s'"), newname);
-
-	if (resolve_ref(newref.buf, sha1, 1, NULL) && !force)
-		die(_("A branch named '%s' already exists."), newref.buf + 11);
+	validate_new_branchname(newname, &newref, force);
 
 	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 		 oldref.buf, newref.buf);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d647a31..fc4e008 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1072,15 +1072,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	if (opts.new_branch) {
 		struct strbuf buf = STRBUF_INIT;
-		if (strbuf_check_branch_ref(&buf, opts.new_branch))
-			die(_("git checkout: we do not like '%s' as a branch name."),
-			    opts.new_branch);
-		if (ref_exists(buf.buf)) {
-			opts.branch_exists = 1;
-			if (!opts.new_branch_force)
-				die(_("git checkout: branch %s already exists"),
-				    opts.new_branch);
-		}
+
+		opts.branch_exists = validate_new_branchname(opts.new_branch, &buf, !!opts.new_branch_force);
+
 		strbuf_release(&buf);
 	}
 
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index a42e039..b66db2b 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -180,4 +180,12 @@ test_expect_success 'checkout -b <describe>' '
 	test_cmp expect actual
 '
 
+test_expect_success 'checkout -B to the current branch fails before merging' '
+	git checkout branch1 &&
+	setup_dirty_mergeable &&
+	git commit -mfooble &&
+	test_must_fail git checkout -B branch1 initial &&
+	test_must_fail test_dirty_mergeable
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9e69c8c..cb6458d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -98,6 +98,18 @@ test_expect_success 'git branch -m q r/q should fail when r exists' '
 	test_must_fail git branch -m q r/q
 '
 
+test_expect_success 'git branch -M foo bar should fail when bar is checked out' '
+	git branch bar &&
+	git checkout -b foo &&
+	test_must_fail git branch -M bar foo
+'
+
+test_expect_success 'git branch -M baz bam should succeed when baz is checked out' '
+	git checkout -b baz &&
+	git branch bam &&
+	git branch -M baz bam
+'
+
 mv .git/config .git/config-saved
 
 test_expect_success 'git branch -m q q2 without config should succeed' '
-- 
1.7.6.562.g0b2d4
