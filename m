Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341E720445
	for <e@80x24.org>; Fri, 13 Oct 2017 05:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753498AbdJMFLj (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 01:11:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51251 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753294AbdJMFLh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 01:11:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 558A1B3089;
        Fri, 13 Oct 2017 01:11:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=9jmF
        jJgOiZpYRwa4CRgFsO03RZk=; b=QGZZxddGl6avFTY5S0gM586K/YK3U092rRJ1
        4ZHr7UW/YI7h2dx/H4ZnDk6lymKz3UUeG9uCJUIdwI+BV+4lOrDP2xzaqx4wswP0
        0hXCWXPjVWhZ5EMFOOw44tJQbYg0Tsb4SkegmBHo6HqWu7SrFy4YhIm73jG5cMZV
        TWnA4SQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=OWnVjR
        gPr0TTGlSmvdGNvsUI6uAClWOTjlJ4aiXThWFZbKTrmXs0v1a8VAcQyQcX8U1GUC
        TgiqMq2t6psS58wPE0G/vMfmdUyJpVwahxQz1mw8KVeDclxanlM7KbdQipG8oHnH
        fFP4VozPNl20AvHueorxZDEV2W7y5FnFGb9+g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D87EB3088;
        Fri, 13 Oct 2017 01:11:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDB90B3087;
        Fri, 13 Oct 2017 01:11:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] branch: split validate_new_branchname() into two
Date:   Fri, 13 Oct 2017 14:11:31 +0900
Message-Id: <20171013051132.3973-3-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc1-158-gbd035ae683
In-Reply-To: <20171013051132.3973-1-gitster@pobox.com>
References: <20171013051132.3973-1-gitster@pobox.com>
X-Pobox-Relay-ID: FCD5FB5A-AFD4-11E7-8587-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking if a proposed name is appropriate for a branch is strictly
a subset of checking if we want to allow creating or updating a
branch with such a name.  The mysterious sounding 'attr_only'
parameter to validate_new_branchname() is used to switch the
function between these two roles.

Instead, split the function into two, and adjust the callers.  A new
helper validate_branchname() only checks the name and reports if the
branch already exists.

This loses one NEEDSWORK from the branch API.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c           | 34 +++++++++++++++++++++++-----------
 branch.h           | 27 ++++++++++++---------------
 builtin/branch.c   |  8 ++++----
 builtin/checkout.c | 10 +++++-----
 4 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/branch.c b/branch.c
index 7404597678..2c3a364a0b 100644
--- a/branch.c
+++ b/branch.c
@@ -178,19 +178,31 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
-int validate_new_branchname(const char *name, struct strbuf *ref,
-			    int force, int attr_only)
+/*
+ * Check if 'name' can be a valid name for a branch; die otherwise.
+ * Return 1 if the named branch already exists; return 0 otherwise.
+ * Fill ref with the full refname for the branch.
+ */
+int validate_branchname(const char *name, struct strbuf *ref)
 {
-	const char *head;
-
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name."), name);
 
-	if (!ref_exists(ref->buf))
-		return 0;
+	return ref_exists(ref->buf);
+}
 
-	if (attr_only)
-		return 1;
+/*
+ * Check if a branch 'name' can be created as a new branch; die otherwise.
+ * 'force' can be used when it is OK for the named branch already exists.
+ * Return 1 if the named branch already exists; return 0 otherwise.
+ * Fill ref with the full refname for the branch.
+ */
+int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+{
+	const char *head;
+
+	if (!validate_branchname(name, ref))
+		return 0;
 
 	if (!force)
 		die(_("A branch named '%s' already exists."),
@@ -246,9 +258,9 @@ void create_branch(const char *name, const char *start_name,
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if (validate_new_branchname(name, &ref, force,
-				    track == BRANCH_TRACK_OVERRIDE ||
-				    clobber_head)) {
+	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head)
+	    ? validate_branchname(name, &ref)
+	    : validate_new_branchname(name, &ref, force)) {
 		if (!force)
 			dont_change_ref = 1;
 		else
diff --git a/branch.h b/branch.h
index b07788558c..be5e5d1308 100644
--- a/branch.h
+++ b/branch.h
@@ -23,22 +23,19 @@ void create_branch(const char *name, const char *start_name,
 		   int clobber_head, int quiet, enum branch_track track);
 
 /*
- * Validates that the requested branch may be created, returning the
- * interpreted ref in ref, force indicates whether (non-head) branches
- * may be overwritten. A non-zero return value indicates that the force
- * parameter was non-zero and the branch already exists.
- *
- * Contrary to all of the above, when attr_only is 1, the caller is
- * not interested in verifying if it is Ok to update the named
- * branch to point at a potentially different commit. It is merely
- * asking if it is OK to change some attribute for the named branch
- * (e.g. tracking upstream).
- *
- * NEEDSWORK: This needs to be split into two separate functions in the
- * longer run for sanity.
- *
+ * Check if 'name' can be a valid name for a branch; die otherwise.
+ * Return 1 if the named branch already exists; return 0 otherwise.
+ * Fill ref with the full refname for the branch.
+ */
+extern int validate_branchname(const char *name, struct strbuf *ref);
+
+/*
+ * Check if a branch 'name' can be created as a new branch; die otherwise.
+ * 'force' can be used when it is OK for the named branch already exists.
+ * Return 1 if the named branch already exists; return 0 otherwise.
+ * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force, int attr_only);
+extern int validate_new_branchname(const char *name, struct strbuf *ref, int force);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index b67593288c..e5bbfb4a17 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -463,7 +463,6 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	int recovery = 0;
-	int clobber_head_ok;
 
 	if (!oldname) {
 		if (copy)
@@ -487,9 +486,10 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	 * A command like "git branch -M currentbranch currentbranch" cannot
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
 	 */
-	clobber_head_ok = !strcmp(oldname, newname);
-
-	validate_new_branchname(newname, &newref, force, clobber_head_ok);
+	if (!strcmp(oldname, newname))
+		validate_branchname(newname, &newref);
+	else
+		validate_new_branchname(newname, &newref, force);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index fc4f8fd2ea..697ac7dcaf 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1289,11 +1289,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.new_branch) {
 		struct strbuf buf = STRBUF_INIT;
 
-		opts.branch_exists =
-			validate_new_branchname(opts.new_branch, &buf,
-						!!opts.new_branch_force,
-						!!opts.new_branch_force);
-
+		if (opts.new_branch_force)
+			opts.branch_exists = validate_branchname(opts.new_branch, &buf);
+		else
+			opts.branch_exists =
+				validate_new_branchname(opts.new_branch, &buf, 0);
 		strbuf_release(&buf);
 	}
 
-- 
2.15.0-rc1-158-gbd035ae683

