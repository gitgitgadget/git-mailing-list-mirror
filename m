From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/6] branch: allow configuring the publish branch
Date: Sun,  1 Sep 2013 03:26:39 -0500
Message-ID: <1378024002-26190-4-git-send-email-felipe.contreras@gmail.com>
References: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 10:31:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG34d-00018i-Q6
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 10:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab3IAIbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 04:31:48 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:32877 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab3IAIbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 04:31:33 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so3430274obc.21
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wYsBXNVjGfDItY4e69olPkZigVvOPVrAGLdiSv3PPPE=;
        b=fU9tiGND12lOen/Wpz+uH1+zy/iTbN45mfnCYIYKBfKEkK3rS/P7re763GjvVEevYn
         ca9xUndhccbPHtqZbWUliDDkpog/StS+9YOGIrABgDIWuJjcBd1zzajRARG+zJRghobm
         0Mvdbty4zbI+UadgeF24b8o79QxgGOeUIzQwxTG0tPeJ3aBLt3jIB12DY03fOjDwJ9la
         +afMlpjd1xqdUiyB48CtfvG5PyghJW9bvpoXVHYFwxTmqKlkjRC3GcHHdIQgtGZnXuBy
         znACBV44Ha51FIIx+nOhPBkFm7jAxZdhOgWpoo99Thq8fbZl3tJDpaGeMljrfG+tf7jc
         +GWA==
X-Received: by 10.182.106.114 with SMTP id gt18mr12937700obb.77.1378024292290;
        Sun, 01 Sep 2013 01:31:32 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm7766666oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 01:31:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233573>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-branch.txt | 11 +++++++++
 branch.c                     | 43 ++++++++++++++++++++++++++++++++++
 branch.h                     |  2 ++
 builtin/branch.c             | 56 ++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b7cb625..1bf9b2a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,7 +14,9 @@ SYNOPSIS
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
+'git branch' (--set-publish-to=<publish> | -p <publish>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
+'git branch' --unset-publish [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
@@ -189,6 +191,15 @@ start-point is either a local or remote-tracking branch.
 	Remove the upstream information for <branchname>. If no branch
 	is specified it defaults to the current branch.
 
+-p <publish>::
+--set-publish-to=<publish>::
+	Set up <branchname>'s publish tracking information. If no
+	<branchname> is specified, then it defaults to the current branch.
+
+--unset-publish::
+	Remove the publish information for <branchname>. If no branch
+	is specified it defaults to the current branch.
+
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
diff --git a/branch.c b/branch.c
index c5c6984..02495e3 100644
--- a/branch.c
+++ b/branch.c
@@ -144,6 +144,49 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	return 0;
 }
 
+void install_branch_publish(const char *name, const char *remote, const char *remote_ref)
+{
+	struct strbuf key = STRBUF_INIT;
+
+	if (!remote && !strcmp(name, remote_ref + 11) && !prefixcmp(remote_ref, "refs/heads")) {
+		warning(_("Not setting branch %s as its own publish branch."), name);
+		return;
+	}
+
+	strbuf_addf(&key, "branch.%s.pushremote", name);
+	git_config_set(key.buf, remote ? remote : ".");
+
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.push", name);
+	git_config_set(key.buf, remote_ref);
+
+	strbuf_release(&key);
+}
+
+int setup_publish(const char *name, const char *ref)
+{
+	struct tracking tracking;
+	const char *remote, *remote_ref;
+
+	memset(&tracking, 0, sizeof(tracking));
+	tracking.spec.dst = (char*)ref;
+	if (for_each_remote(find_tracked_branch, &tracking))
+		return 1;
+
+	if (tracking.matches > 1)
+		return error(_("Not tracking: ambiguous information for ref %s"),
+				ref);
+
+	remote = tracking.remote;
+	remote_ref = tracking.src ? tracking.src : ref;
+
+	install_branch_publish(name, remote, remote_ref);
+
+	free(tracking.src);
+
+	return 0;
+}
+
 struct branch_desc_cb {
 	const char *config_name;
 	const char *value;
diff --git a/branch.h b/branch.h
index 64173ab..c9b6aa9 100644
--- a/branch.h
+++ b/branch.h
@@ -51,5 +51,7 @@ extern void install_branch_config(int flag, const char *local, const char *origi
  * Read branch description
  */
 extern int read_branch_desc(struct strbuf *, const char *branch_name);
+extern int setup_publish(const char *name, const char *ref);
+extern void install_branch_publish(const char *name, const char *remote, const char *remote_ref);
 
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..48af999 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -781,8 +781,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0, edit_description = 0;
-	int quiet = 0, unset_upstream = 0;
-	const char *new_upstream = NULL;
+	int quiet = 0, unset_upstream = 0, unset_publish = 0;
+	const char *new_upstream = NULL, *publish = NULL;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
@@ -797,7 +797,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
 			BRANCH_TRACK_OVERRIDE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
+		OPT_STRING('p', "set-publish-to", &publish, "publish", "change the publish info"),
 		OPT_BOOLEAN(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
+		OPT_BOOLEAN(0, "unset-publish", &unset_publish, "Unset the publish info"),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &kinds, N_("act on remote-tracking branches"),
 			REF_REMOTE_BRANCH),
@@ -866,13 +868,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
+	if (!delete && !rename && !edit_description && !new_upstream && !publish &&
+			!unset_upstream && !unset_publish && argc == 0)
 		list = 1;
 
 	if (with_commit || merge_filter != NO_FILTER)
 		list = 1;
 
-	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!unset_upstream > 1)
+	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!publish +
+			!!unset_upstream + !! unset_publish > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
@@ -978,6 +982,50 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
+	} else if (publish) {
+		struct branch *branch = branch_get(argv[0]);
+		char *real_ref = NULL;
+		unsigned char sha1[20];
+
+		if (argc > 1)
+			die(_("too many branches to set new publish branch"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("could not set publish branch of HEAD when "
+				      "it does not point to any branch."));
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
+		if (!ref_exists(branch->refname))
+			die(_("branch '%s' does not exist"), branch->name);
+
+		if (dwim_ref(publish, strlen(publish), sha1, &real_ref) != 1 ||
+				setup_publish(branch->name, real_ref))
+			die(_("Cannot setup publish branch to '%s'."), publish);
+	} else if (unset_publish) {
+		struct branch *branch = branch_get(argv[0]);
+		struct strbuf buf = STRBUF_INIT;
+
+		if (argc > 1)
+			die(_("too many branches to unset publish branch"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("could not unset publish branch of HEAD when "
+				      "it does not point to any branch."));
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
+		if (!branch->push_name)
+			die(_("Branch '%s' has no publish information"), branch->name);
+
+		strbuf_addf(&buf, "branch.%s.pushremote", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "branch.%s.push", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
 		int branch_existed = 0, remote_tracking = 0;
-- 
1.8.4-337-g7358a66-dirty
