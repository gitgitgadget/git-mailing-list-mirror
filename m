From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [RFC PATCH] git push: Push nothing if no refspecs are given or
	configured
Date: Thu, 5 Mar 2009 23:15:29 +0100
Message-ID: <20090305221529.GA25871@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 23:17:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfLsG-0000ZT-Pd
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 23:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbZCEWPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 17:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbZCEWPd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 17:15:33 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:47301 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbZCEWPc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 17:15:32 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LfLqj-0000Xa-Ai; Thu, 05 Mar 2009 23:15:29 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112349>

Previously, git push [remote] with no arguments would behave like
"git push <remote> :" if no push refspecs were configured for the remote.
It may be too easy for novice users to write "git push" or
"git push origin" by accident, so git will now push nothing, and give an
error message in such cases.

Teach git push a new option "--matching" that keeps the old behavior of
pushing all matching branches when none are configured.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/git-push.txt |   10 ++++++++--
 builtin-push.c             |   32 +++++++++++++++++++++++---------
 transport.h                |    1 +
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 4e7e5a7..77a4792 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --matching | --tags] [--dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-v | --verbose]
 	   [<repository> <refspec>...]
 
@@ -63,10 +63,11 @@ the remote repository.
 The special refspec `:` (or `{plus}:` to allow non-fast forward updates)
 directs git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
-already exists on the remote side.  This is the default operation mode
+already exists on the remote side. Nothing will be pushed
 if no explicit refspec is found (that is neither on the command line
 nor in any Push line of the corresponding remotes file---see below).
 
+
 --all::
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` be pushed.
@@ -82,6 +83,11 @@ nor in any Push line of the corresponding remotes file---see below).
 	if the configuration option `remote.<remote>.mirror` is
 	set.
 
+--matching::
+	If no explicit refspecs are given, and no push refspecs are
+	configured for the remote, push all matching branches
+	(branches that exist in both ends) instead of nothing.
+
 --dry-run::
 	Do everything except actually send the updates.
 
diff --git a/builtin-push.c b/builtin-push.c
index 122fdcf..ffc648d 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror | --matching] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -48,6 +48,12 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
+
+static int has_multiple_bits(unsigned int x)
+{
+	return (x & (x - 1)) != 0;
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -71,17 +77,24 @@ static int do_push(const char *repo, int flags)
 		return error("--mirror can't be combined with refspecs");
 	}
 
-	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
-				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
-		return error("--all and --mirror are incompatible");
+	if (has_multiple_bits(flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR | TRANSPORT_PUSH_MATCHING))) {
+		return error("--all, --mirror and --matching are incompatible");
 	}
 
-	if (!refspec
-		&& !(flags & TRANSPORT_PUSH_ALL)
-		&& remote->push_refspec_nr) {
-		refspec = remote->push_refspec;
-		refspec_nr = remote->push_refspec_nr;
+	if ((flags & TRANSPORT_PUSH_MATCHING)  && refspec) {
+		return error("--matching cannot be combined with refspecs");
 	}
+
+
+	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
+		if (remote->push_refspec_nr) {
+			refspec = remote->push_refspec;
+			refspec_nr = remote->push_refspec_nr;
+		} else if (!(flags & TRANSPORT_PUSH_MATCHING)) {
+			return error("No refspecs given and none configured for %s, nothing to push.", remote->name);
+		}
+	}
+
 	errs = 0;
 	for (i = 0; i < remote->url_nr; i++) {
 		struct transport *transport =
@@ -120,6 +133,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
+		OPT_BIT( 0, "matching", &flags, "push all matching refs", TRANSPORT_PUSH_MATCHING),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
 		OPT_BIT( 0 , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
diff --git a/transport.h b/transport.h
index 6bbc1a8..fb98128 100644
--- a/transport.h
+++ b/transport.h
@@ -34,6 +34,7 @@ struct transport {
 #define TRANSPORT_PUSH_DRY_RUN 4
 #define TRANSPORT_PUSH_MIRROR 8
 #define TRANSPORT_PUSH_VERBOSE 16
+#define TRANSPORT_PUSH_MATCHING 32
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.6.2.12.g83676.dirty
