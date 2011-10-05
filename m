From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed,  5 Oct 2011 12:01:09 -0400
Message-ID: <1317830469-72878-1-git-send-email-jaysoffian@gmail.com>
References: <1317828285-66581-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 18:01:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBTuN-0000X3-2H
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 18:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934891Ab1JEQBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 12:01:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53136 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934513Ab1JEQBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 12:01:17 -0400
Received: by ggnv2 with SMTP id v2so832906ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8g+3RzLbzN/3lrM+2dOI0/1Vag8rYwPLLRBfzSSeUms=;
        b=rI6ShN1FqWEm1AkKRxR+fWQdsTyyBA0Bzydsr3O8+KiVN+kRyttbau4m1Udw4BpUJU
         lEoaZsmnpVyCbO55WWNz+Y8vtUvvIhnrij/HBt65l+FCaNZnvvjTSN2TUaBkiMO88Jr3
         BMHF86O9ffrbRb5ROCW3pw4ZF++jAMXqF8cDw=
Received: by 10.150.206.14 with SMTP id d14mr2368229ybg.223.1317830476844;
        Wed, 05 Oct 2011 09:01:16 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id k31sm5962190ann.15.2011.10.05.09.01.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 09:01:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.5.gd207e.dirty
In-Reply-To: <1317828285-66581-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182856>

> I was more looking for feedback on the idea than the implementation, but
> here's a better implementation. Still an RFC so no tests yet.

Oops. Let's try that again. Sent the wrong thing.

-- >8 --
Subject: [RFC/PATCH] Teach branch/checkout about workdirs

When using 'git new-workdir', there is no safety mechanism to prevent the
same branch from being checked out twice, nor to prevent a checked out
branch from being deleted.

Teach 'checkout' to record the workdir path using 'branch.<name>.checkout'
when switching branches. We can then easily check if a branch is already
checked out in another workdir before switching to that branch. Add a
similar check before deleting a branch.

Allow 'checkout -f' to force the checkout and issue a warning instead of
an error.

Guard this behavior behind 'core.recordCheckouts', which we will teach
'git new-workdir' to set in a followup commit.

Note: when switching away from a branch, we set 'branch.<name>.checkout'
to the empty string, instead of deleting it entirely, since git_config()
otherwise leaves behind an empty section which it does not re-use.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin/branch.c   |   10 ++++++++++
 builtin/checkout.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 remote.c           |    4 ++++
 remote.h           |    1 +
 4 files changed, 58 insertions(+), 0 deletions(-)

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
index 5e356a6c61..75510befde 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,6 +33,7 @@ struct checkout_opts {
 	int force_detach;
 	int writeout_stage;
 	int writeout_error;
+	int record_checkouts;
 
 	/* not set by parse_options */
 	int branch_exists;
@@ -508,6 +509,21 @@ static void detach_advice(const char *old_path, const char *new_name)
 	fprintf(stderr, fmt, new_name);
 }
 
+static void record_checkout(const char *name, const char *new_work_tree)
+{
+	struct strbuf key = STRBUF_INIT;
+	strbuf_addf(&key, "branch.%s.checkout", name);
+	if (new_work_tree) { /* reserve name */
+		git_config_set(key.buf, new_work_tree);
+	} else { /* release name if we reserved it */
+		struct branch *branch = branch_get(name);
+		if (branch->work_tree &&
+		    !strcmp(branch->work_tree, get_git_work_tree()))
+			git_config_set(key.buf, "");
+	}
+	strbuf_release(&key);
+}
+
 static void update_refs_for_switch(struct checkout_opts *opts,
 				   struct branch_info *old,
 				   struct branch_info *new)
@@ -556,6 +572,8 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 				detach_advice(old->path, new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
+		if (opts->record_checkouts && old->name)
+			record_checkout(old->name, NULL);
 	} else if (new->path) {	/* Switch branches. */
 		create_symref("HEAD", new->path, msg.buf);
 		if (!opts->quiet) {
@@ -580,6 +598,11 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			if (!file_exists(ref_file) && file_exists(log_file))
 				remove_path(log_file);
 		}
+		if (opts->record_checkouts) {
+			if (old->name)
+				record_checkout(old->name, NULL);
+			record_checkout(new->name, get_git_work_tree());
+		}
 	}
 	remove_branch_state();
 	strbuf_release(&msg);
@@ -709,6 +732,20 @@ static void orphaned_commit_warning(struct commit *commit)
 	for_each_ref(clear_commit_marks_from_one_ref, NULL);
 }
 
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
@@ -732,6 +769,8 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 		if (!new->commit)
 			die(_("You are on a branch yet to be born"));
 		parse_commit(new->commit);
+	} else if (opts->record_checkouts) {
+		check_if_checked_out(opts, new->name);
 	}
 
 	ret = merge_working_tree(opts, &old, new);
@@ -756,6 +795,10 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
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
1.7.7.5.gd207e.dirty
