From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Tue,  4 Oct 2011 23:43:24 -0400
Message-ID: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 05:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBIOV-0002xU-JN
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 05:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608Ab1JEDnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 23:43:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53592 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149Ab1JEDna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 23:43:30 -0400
Received: by ywb5 with SMTP id 5so1183690ywb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 20:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NtFIDEIEVToDztjbYPrB68LpBwAkvyqULFY38n8TW8s=;
        b=vJlnfH4jvTiiqgKRt5zBylIGciT0CsstVXtlOlEMtpZBc+GTCdr7GvJPo/7GQPh3Rv
         qpA52eGv2zscHBZpyZ4Nepv0Umzgf/jexBOOrWEaRb34smRJn4D+8FQsMQ0vPOQa+pB2
         vrQ5XwI9bV2WJNmlo/W7PxlNOYDheZxQ4IrWI=
Received: by 10.101.142.12 with SMTP id u12mr1681163ann.43.1317786209066;
        Tue, 04 Oct 2011 20:43:29 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id e19sm949023anm.6.2011.10.04.20.43.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Oct 2011 20:43:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.4.g39e02c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182821>

When using 'git new-workdir', there is no safety mechanism to prevent the
same branch from being checked out twice, nor to prevent a checked out
branch from being deleted.

By teaching 'checkout' to record the workdir path using
'branch.<name>.checkout' when switching branches, we can easily check if a
branch is already checked out in another workdir before switching to that
branch. Similarly, we can now add a check before deleting a branch.

Allow 'checkout -f' to force the checkout and issue a warning
instead of an error.

Guard this behavior behind 'core.recordCheckouts', which we will
teach 'git new-workdir' to set in a followup commit.

Note: when switching away from a branch, we set 'branch.<name>.checkout'
to the empty string, instead of deleting it entirely, since git_config()
otherwise leaves behind an empty section which it does not re-use.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin/branch.c   |   10 ++++++++++
 builtin/checkout.c |   39 +++++++++++++++++++++++++++++++++++++++
 remote.c           |    4 ++++
 remote.h           |    1 +
 4 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f49596f826..6ce1a5b133 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -182,6 +182,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			ret = 1;
 			continue;
 		}
+		if (kinds == REF_LOCAL_BRANCH) {
+			struct branch *branch = branch_get(bname.buf);
+			if (branch->work_tree && strlen(branch->work_tree)) {
+				error(_("Cannot delete the branch '%s' "
+					"which is currently checked out in '%s'"),
+				      bname.buf, branch->work_tree);
+				ret = 1;
+				continue;
+			}
+		}
 
 		free(name);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5e356a6c61..26259a41a7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,6 +33,7 @@ struct checkout_opts {
 	int force_detach;
 	int writeout_stage;
 	int writeout_error;
+	int record_checkouts;
 
 	/* not set by parse_options */
 	int branch_exists;
@@ -709,12 +710,35 @@ static void orphaned_commit_warning(struct commit *commit)
 	for_each_ref(clear_commit_marks_from_one_ref, NULL);
 }
 
+static void record_checkout(const char *name, const char *work_tree)
+{
+	struct strbuf key = STRBUF_INIT;
+	strbuf_addf(&key, "branch.%s.checkout", name);
+	git_config_set(key.buf, work_tree);
+	strbuf_release(&key);
+}
+
+static void check_if_checked_out(struct checkout_opts *opts, const char *name)
+{
+	struct branch *branch = branch_get(name);
+	if (branch->work_tree && strlen(branch->work_tree) &&
+	    strcmp(branch->work_tree, get_git_work_tree())) {
+		if (opts->force)
+			warning(_("branch '%s' is currently checked out"
+				  " in '%s'"), name, branch->work_tree);
+		else
+			die(_("branch '%s' is currently checked out"
+			      " in '%s'"), name, branch->work_tree);
+	}
+}
+
 static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 {
 	int ret = 0;
 	struct branch_info old;
 	unsigned char rev[20];
 	int flag;
+
 	memset(&old, 0, sizeof(old));
 	old.path = xstrdup(resolve_ref("HEAD", rev, 0, &flag));
 	old.commit = lookup_commit_reference_gently(rev, 1);
@@ -734,6 +758,9 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 		parse_commit(new->commit);
 	}
 
+	if (opts->record_checkouts)
+		check_if_checked_out(opts, new->name);
+
 	ret = merge_working_tree(opts, &old, new);
 	if (ret)
 		return ret;
@@ -743,6 +770,14 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 
 	update_refs_for_switch(opts, &old, new);
 
+	if (opts->record_checkouts) {
+		const char *work_tree = get_git_work_tree();
+		struct branch *branch = branch_get(old.name);
+		if (branch->work_tree && !strcmp(branch->work_tree, work_tree))
+			record_checkout(old.name, "");
+		record_checkout(new->name, work_tree);
+	}
+
 	ret = post_checkout_hook(old.commit, new->commit, 1);
 	free((char *)old.path);
 	return ret || opts->writeout_error;
@@ -756,6 +791,10 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.recordcheckouts")) {
+		struct checkout_opts *opts = cb;
+		opts->record_checkouts = git_config_bool(var, value);
+	}
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
diff --git a/remote.c b/remote.c
index b8ecfa5d95..2bc063dae8 100644
--- a/remote.c
+++ b/remote.c
@@ -364,6 +364,10 @@ static int handle_config(const char *key, const char *value, void *cb)
 			if (!value)
 				return config_error_nonbool(key);
 			add_merge(branch, xstrdup(value));
+		} else if (!strcmp(subkey, ".checkout")) {
+			if (!value)
+				return config_error_nonbool(key);
+			branch->work_tree = xstrdup(value);
 		}
 		return 0;
 	}
diff --git a/remote.h b/remote.h
index 9a30a9dba6..4103ec7e31 100644
--- a/remote.h
+++ b/remote.h
@@ -126,6 +126,7 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec);
 struct branch {
 	const char *name;
 	const char *refname;
+	const char *work_tree;
 
 	const char *remote_name;
 	struct remote *remote;
-- 
1.7.7.4.g39e02c
