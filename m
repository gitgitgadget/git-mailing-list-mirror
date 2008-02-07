From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2 07/11] Move create_branch into a library file
Date: Thu, 7 Feb 2008 11:40:08 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802071131100.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 17:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9oi-0007U1-HJ
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 17:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbYBGQkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 11:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755735AbYBGQkQ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 11:40:16 -0500
Received: from iabervon.org ([66.92.72.58]:39488 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574AbYBGQkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 11:40:13 -0500
Received: (qmail 29795 invoked by uid 1000); 7 Feb 2008 16:40:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Feb 2008 16:40:08 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72973>

You can also create branches, in exactly the same way, with checkout -b.

This introduces branch.{c,h} library files for doing porcelain-level 
operations on branches (such as creating them with their appropriate 
default configuration).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile         |    2 +-
 branch.c         |  140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 branch.h         |    8 +++
 builtin-branch.c |  138 +----------------------------------------------------
 4 files changed, 151 insertions(+), 137 deletions(-)
 create mode 100644 branch.c
 create mode 100644 branch.h

diff --git a/Makefile b/Makefile
index 27a8b1b..cc0643e 100644
--- a/Makefile
+++ b/Makefile
@@ -323,7 +323,7 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o walker.o parse-options.o ws.o archive.o
+	transport.o bundle.o walker.o parse-options.o ws.o archive.o branch.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/branch.c b/branch.c
new file mode 100644
index 0000000..45ab820
--- /dev/null
+++ b/branch.c
@@ -0,0 +1,140 @@
+#include "cache.h"
+#include "branch.h"
+#include "refs.h"
+#include "remote.h"
+#include "commit.h"
+
+struct tracking {
+	struct refspec spec;
+	char *src;
+	const char *remote;
+	int matches;
+};
+
+static int find_tracked_branch(struct remote *remote, void *priv)
+{
+	struct tracking *tracking = priv;
+
+	if (!remote_find_tracking(remote, &tracking->spec)) {
+		if (++tracking->matches == 1) {
+			tracking->src = tracking->spec.src;
+			tracking->remote = remote->name;
+		} else {
+			free(tracking->spec.src);
+			if (tracking->src) {
+				free(tracking->src);
+				tracking->src = NULL;
+			}
+		}
+		tracking->spec.src = NULL;
+	}
+
+	return 0;
+}
+
+/*
+ * This is called when new_ref is branched off of orig_ref, and tries
+ * to infer the settings for branch.<new_ref>.{remote,merge} from the
+ * config.
+ */
+static int setup_tracking(const char *new_ref, const char *orig_ref)
+{
+	char key[1024];
+	struct tracking tracking;
+
+	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
+		return error("Tracking not set up: name too long: %s",
+				new_ref);
+
+	memset(&tracking, 0, sizeof(tracking));
+	tracking.spec.dst = (char *)orig_ref;
+	if (for_each_remote(find_tracked_branch, &tracking) ||
+			!tracking.matches)
+		return 1;
+
+	if (tracking.matches > 1)
+		return error("Not tracking: ambiguous information for ref %s",
+				orig_ref);
+
+	if (tracking.matches == 1) {
+		sprintf(key, "branch.%s.remote", new_ref);
+		git_config_set(key, tracking.remote ?  tracking.remote : ".");
+		sprintf(key, "branch.%s.merge", new_ref);
+		git_config_set(key, tracking.src);
+		free(tracking.src);
+		printf("Branch %s set up to track remote branch %s.\n",
+			       new_ref, orig_ref);
+	}
+
+	return 0;
+}
+
+void create_branch(const char *head,
+		   const char *name, const char *start_name,
+		   int force, int reflog, int track)
+{
+	struct ref_lock *lock;
+	struct commit *commit;
+	unsigned char sha1[20];
+	char *real_ref, ref[PATH_MAX], msg[PATH_MAX + 20];
+	int forcing = 0;
+
+	snprintf(ref, sizeof ref, "refs/heads/%s", name);
+	if (check_ref_format(ref))
+		die("'%s' is not a valid branch name.", name);
+
+	if (resolve_ref(ref, sha1, 1, NULL)) {
+		if (!force)
+			die("A branch named '%s' already exists.", name);
+		else if (!is_bare_repository() && !strcmp(head, name))
+			die("Cannot force update the current branch.");
+		forcing = 1;
+	}
+
+	real_ref = NULL;
+	if (get_sha1(start_name, sha1))
+		die("Not a valid object name: '%s'.", start_name);
+
+	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
+	case 0:
+		/* Not branching from any existing branch */
+		real_ref = NULL;
+		break;
+	case 1:
+		/* Unique completion -- good */
+		break;
+	default:
+		die("Ambiguous object name: '%s'.", start_name);
+		break;
+	}
+
+	if ((commit = lookup_commit_reference(sha1)) == NULL)
+		die("Not a valid branch point: '%s'.", start_name);
+	hashcpy(sha1, commit->object.sha1);
+
+	lock = lock_any_ref_for_update(ref, NULL, 0);
+	if (!lock)
+		die("Failed to lock ref for update: %s.", strerror(errno));
+
+	if (reflog)
+		log_all_ref_updates = 1;
+
+	if (forcing)
+		snprintf(msg, sizeof msg, "branch: Reset from %s",
+			 start_name);
+	else
+		snprintf(msg, sizeof msg, "branch: Created from %s",
+			 start_name);
+
+	/* When branching off a remote branch, set up so that git-pull
+	   automatically merges from there.  So far, this is only done for
+	   remotes registered via .git/config.  */
+	if (real_ref && track)
+		setup_tracking(name, real_ref);
+
+	if (write_ref_sha1(lock, sha1, msg) < 0)
+		die("Failed to write ref: %s.", strerror(errno));
+
+	if (real_ref)
+		free(real_ref);
+}
diff --git a/branch.h b/branch.h
new file mode 100644
index 0000000..8bcd9dc
--- /dev/null
+++ b/branch.h
@@ -0,0 +1,8 @@
+#ifndef BRANCH_H
+#define BRANCH_H
+
+void create_branch(const char *head,
+		   const char *name, const char *start_name,
+		   int force, int reflog, int track);
+
+#endif
diff --git a/builtin-branch.c b/builtin-branch.c
index 089cae5..1e0c9de 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "remote.h"
 #include "parse-options.h"
+#include "branch.h"
 
 static const char * const builtin_branch_usage[] = {
 	"git-branch [options] [-r | -a]",
@@ -356,141 +357,6 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	free_ref_list(&ref_list);
 }
 
-struct tracking {
-	struct refspec spec;
-	char *src;
-	const char *remote;
-	int matches;
-};
-
-static int find_tracked_branch(struct remote *remote, void *priv)
-{
-	struct tracking *tracking = priv;
-
-	if (!remote_find_tracking(remote, &tracking->spec)) {
-		if (++tracking->matches == 1) {
-			tracking->src = tracking->spec.src;
-			tracking->remote = remote->name;
-		} else {
-			free(tracking->spec.src);
-			if (tracking->src) {
-				free(tracking->src);
-				tracking->src = NULL;
-			}
-		}
-		tracking->spec.src = NULL;
-	}
-
-	return 0;
-}
-
-
-/*
- * This is called when new_ref is branched off of orig_ref, and tries
- * to infer the settings for branch.<new_ref>.{remote,merge} from the
- * config.
- */
-static int setup_tracking(const char *new_ref, const char *orig_ref)
-{
-	char key[1024];
-	struct tracking tracking;
-
-	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
-		return error("Tracking not set up: name too long: %s",
-				new_ref);
-
-	memset(&tracking, 0, sizeof(tracking));
-	tracking.spec.dst = (char *)orig_ref;
-	if (for_each_remote(find_tracked_branch, &tracking) ||
-			!tracking.matches)
-		return 1;
-
-	if (tracking.matches > 1)
-		return error("Not tracking: ambiguous information for ref %s",
-				orig_ref);
-
-	if (tracking.matches == 1) {
-		sprintf(key, "branch.%s.remote", new_ref);
-		git_config_set(key, tracking.remote ?  tracking.remote : ".");
-		sprintf(key, "branch.%s.merge", new_ref);
-		git_config_set(key, tracking.src);
-		free(tracking.src);
-		printf("Branch %s set up to track remote branch %s.\n",
-			       new_ref, orig_ref);
-	}
-
-	return 0;
-}
-
-static void create_branch(const char *name, const char *start_name,
-			  int force, int reflog, int track)
-{
-	struct ref_lock *lock;
-	struct commit *commit;
-	unsigned char sha1[20];
-	char *real_ref, ref[PATH_MAX], msg[PATH_MAX + 20];
-	int forcing = 0;
-
-	snprintf(ref, sizeof ref, "refs/heads/%s", name);
-	if (check_ref_format(ref))
-		die("'%s' is not a valid branch name.", name);
-
-	if (resolve_ref(ref, sha1, 1, NULL)) {
-		if (!force)
-			die("A branch named '%s' already exists.", name);
-		else if (!is_bare_repository() && !strcmp(head, name))
-			die("Cannot force update the current branch.");
-		forcing = 1;
-	}
-
-	real_ref = NULL;
-	if (get_sha1(start_name, sha1))
-		die("Not a valid object name: '%s'.", start_name);
-
-	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
-	case 0:
-		/* Not branching from any existing branch */
-		real_ref = NULL;
-		break;
-	case 1:
-		/* Unique completion -- good */
-		break;
-	default:
-		die("Ambiguous object name: '%s'.", start_name);
-		break;
-	}
-
-	if ((commit = lookup_commit_reference(sha1)) == NULL)
-		die("Not a valid branch point: '%s'.", start_name);
-	hashcpy(sha1, commit->object.sha1);
-
-	lock = lock_any_ref_for_update(ref, NULL, 0);
-	if (!lock)
-		die("Failed to lock ref for update: %s.", strerror(errno));
-
-	if (reflog)
-		log_all_ref_updates = 1;
-
-	if (forcing)
-		snprintf(msg, sizeof msg, "branch: Reset from %s",
-			 start_name);
-	else
-		snprintf(msg, sizeof msg, "branch: Created from %s",
-			 start_name);
-
-	/* When branching off a remote branch, set up so that git-pull
-	   automatically merges from there.  So far, this is only done for
-	   remotes registered via .git/config.  */
-	if (real_ref && track)
-		setup_tracking(name, real_ref);
-
-	if (write_ref_sha1(lock, sha1, msg) < 0)
-		die("Failed to write ref: %s.", strerror(errno));
-
-	if (real_ref)
-		free(real_ref);
-}
-
 static void rename_branch(const char *oldname, const char *newname, int force)
 {
 	char oldref[PATH_MAX], newref[PATH_MAX], logmsg[PATH_MAX*2 + 100];
@@ -611,7 +477,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	else if (rename && (argc == 2))
 		rename_branch(argv[0], argv[1], rename > 1);
 	else if (argc <= 2)
-		create_branch(argv[0], (argc == 2) ? argv[1] : head,
+		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
 			      force_create, reflog, track);
 	else
 		usage_with_options(builtin_branch_usage, options);
-- 
1.5.4
