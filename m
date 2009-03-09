From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 3/7] git push: New options --matching and --current
Date: Mon,  9 Mar 2009 23:35:47 +0100
Message-ID: <1236638151-6465-4-git-send-email-finnag@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:18:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgojY-0001tF-K9
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbZCIXQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbZCIXQn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:16:43 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:57868 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbZCIXQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:16:41 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lgo57-0002Lo-D3
	for git@vger.kernel.org; Mon, 09 Mar 2009 23:36:25 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112755>

--matching: Push all branches that already exist with the same name in
the remote
--current: Push the current branch to whatever it is tracking

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/git-push.txt |   10 +++++-
 builtin-push.c             |   87 +++++++++++++++++++++++++++++++++++---------
 transport.h                |    9 +++++
 3 files changed, 87 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 4e7e5a7..cb7b3d2 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,8 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags | --matching | --current]
+	   [--dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-v | --verbose]
 	   [<repository> <refspec>...]
 
@@ -82,6 +83,13 @@ nor in any Push line of the corresponding remotes file---see below).
 	if the configuration option `remote.<remote>.mirror` is
 	set.
 
+--matching::
+	For every branch on the local side, the remote side is updated if
+	a branch of the same name already exists there.
+
+--current::
+	Push the current branch to the branch it is tracking on the remote.
+
 --dry-run::
 	Do everything except actually send the updates.
 
diff --git a/builtin-push.c b/builtin-push.c
index 122fdcf..5706c99 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror | --current | --matching] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -48,6 +48,53 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
+static const char *make_push_ref(const char *a, const char *b)
+{
+	char *buf = xmalloc(strlen(a) + strlen(b) + 2);
+	strcpy(buf, a);
+	strcat(buf, ":");
+	strcat(buf, b);
+	return buf;
+}
+
+static void setup_push_current(struct remote *remote)
+{
+	int n;
+	struct branch *branch = branch_get(NULL);
+	if (!branch)
+		die("You are not currently on a branch.");
+	if (!branch->merge_nr)
+		die("The current branch %s is not tracking anything.",
+		    branch->name);
+	if (branch->remote != remote)
+		die("The current branch is tracking \"%s\", not \"%s\"!",
+		    branch->remote->name, remote->name);
+	for (n = 0; n < branch->merge_nr; n++)
+		add_refspec(make_push_ref(branch->name,
+						branch->merge[n]->src));
+}
+
+static void handle_default_push(struct remote *remote, int *flags)
+{
+	git_config(git_default_config, NULL);
+	switch (push_default) {
+	case PUSH_DEFAULT_UNSPECIFIED:
+		/* fallthrough */
+
+	case PUSH_DEFAULT_MATCHING:
+		add_refspec(":");
+		break;
+
+	case PUSH_DEFAULT_CURRENT:
+		setup_push_current(remote);
+		break;
+
+	case PUSH_DEFAULT_NOTHING:
+		die("No refspec given, and none configured.");
+		break;
+	}
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -59,29 +106,29 @@ static int do_push(const char *repo, int flags)
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
-	if ((flags & TRANSPORT_PUSH_ALL) && refspec) {
+	if ((flags & TRANSPORT_PUSH_MODE_MASK) && refspec) {
 		if (!strcmp(*refspec, "refs/tags/*"))
-			return error("--all and --tags are incompatible");
-		return error("--all can't be combined with refspecs");
+			return error("--tags cannot be combined with a push mode");
+		return error("push modes cannot be combined with explicit refspecs");
 	}
 
-	if ((flags & TRANSPORT_PUSH_MIRROR) && refspec) {
-		if (!strcmp(*refspec, "refs/tags/*"))
-			return error("--mirror and --tags are incompatible");
-		return error("--mirror can't be combined with refspecs");
-	}
+	if (HAS_MULTI_BITS(flags & TRANSPORT_PUSH_MODE_MASK))
+		return error("Multiple push modes specified");
 
-	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
-				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
-		return error("--all and --mirror are incompatible");
-	}
+	if (flags & TRANSPORT_PUSH_CURRENT)
+		setup_push_current(remote);
+	else if (flags & TRANSPORT_PUSH_MATCHING)
+		add_refspec(":");
 
-	if (!refspec
-		&& !(flags & TRANSPORT_PUSH_ALL)
-		&& remote->push_refspec_nr) {
-		refspec = remote->push_refspec;
-		refspec_nr = remote->push_refspec_nr;
+	if (!refspec && !(flags & TRANSPORT_PUSH_MODE_MASK)) {
+		if (remote->push_refspec_nr) {
+			refspec = remote->push_refspec;
+			refspec_nr = remote->push_refspec_nr;
+		} else {
+			handle_default_push(remote, &flags);
+		}
 	}
+
 	errs = 0;
 	for (i = 0; i < remote->url_nr; i++) {
 		struct transport *transport =
@@ -120,6 +167,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
+		OPT_BIT( 0 , "matching", &flags, "push all matching refs",
+			 TRANSPORT_PUSH_MATCHING),
+		OPT_BIT( 0 , "current", &flags, "push current branch",
+			 TRANSPORT_PUSH_CURRENT),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
 		OPT_BIT( 0 , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
diff --git a/transport.h b/transport.h
index 6bbc1a8..b897d0c 100644
--- a/transport.h
+++ b/transport.h
@@ -34,6 +34,15 @@ struct transport {
 #define TRANSPORT_PUSH_DRY_RUN 4
 #define TRANSPORT_PUSH_MIRROR 8
 #define TRANSPORT_PUSH_VERBOSE 16
+#define TRANSPORT_PUSH_MATCHING 32
+#define TRANSPORT_PUSH_CURRENT 64
+/**
+ * All push flags that imply a certain set of refspecs to be pushed must
+ * be combined into TRANSPORT_PUSH_MODE_MASK
+ **/
+#define TRANSPORT_PUSH_MODE_MASK \
+    (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR | TRANSPORT_PUSH_MATCHING | \
+    TRANSPORT_PUSH_CURRENT)
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.6.2.105.g6ff1f.dirty
