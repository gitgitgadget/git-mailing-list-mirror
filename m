From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] prepare deprecation of git-revert
Date: Fri, 31 Oct 2008 16:55:27 +0100
Message-ID: <1225468527-29694-1-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 16:59:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvwMg-00025V-8X
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 16:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbYJaPzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 11:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbYJaPzb
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 11:55:31 -0400
Received: from pan.madism.org ([88.191.52.104]:52955 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbYJaPza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 11:55:30 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 35EBB3B498;
	Fri, 31 Oct 2008 16:55:29 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 9E2B55EE243; Fri, 31 Oct 2008 16:55:27 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.790.ga4dd7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99595>

* Rename builtin-revert.c into builtin-cherry-pick.c

* Add option -R/--revert to git-cherry-pick.
  Document it by taking the current content of git-revert manpage for the
  option.

* get rid of the no_replay initialization, just ignore it when we're in
  the revert case, it makes really no sense to error out.

* put the warning of deprecation in cmd_revert, #if 0-ed out for now.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

 I've not kept the auto-edit feature of git-revert for the git-cherry-pick -R
 case as I don't believe it makes a lot of sense. But if people are unhappy
 with that, I can easily "fix" it.

 Documentation/git-cherry-pick.txt         |   15 +++++++++++++++
 Makefile                                  |    6 +++---
 builtin-revert.c => builtin-cherry-pick.c |   10 ++++------
 3 files changed, 22 insertions(+), 9 deletions(-)
 rename builtin-revert.c => builtin-cherry-pick.c (98%)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 837fb08..2d92f2d 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -40,6 +40,21 @@ OPTIONS
 	development branch), adding this information can be
 	useful.
 
+-R::
+--revert::
+	Given one existing commit, revert the change the patch introduces, and
+	record a new commit that records it.  This requires your working tree
+	to be clean (no modifications from the HEAD commit).
++
+Note: 'git revert' is used to record a new commit to reverse the
+effect of an earlier commit (often a faulty one).  If you want to
+throw away all uncommitted changes in your working directory, you
+should see linkgit:git-reset[1], particularly the '--hard' option.  If
+you want to extract specific files as they were in another commit, you
+should see linkgit:git-checkout[1], specifically the 'git checkout
+<commit> -- <filename>' syntax.  Take care with these alternatives as
+both will discard uncommitted changes in your working directory.
+
 -r::
 	It used to be that the command defaulted to do `-x`
 	described above, and `-r` was to disable it.  Now the
diff --git a/Makefile b/Makefile
index d6f3695..43eb8e4 100644
--- a/Makefile
+++ b/Makefile
@@ -306,7 +306,7 @@ PROGRAMS += git-var$X
 # builtin-$C.o but is linked in as part of some other command.
 BUILT_INS += $(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
-BUILT_INS += git-cherry-pick$X
+BUILT_INS += git-revert$X
 BUILT_INS += git-cherry$X
 BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
@@ -508,6 +508,7 @@ BUILTIN_OBJS += builtin-check-attr.o
 BUILTIN_OBJS += builtin-check-ref-format.o
 BUILTIN_OBJS += builtin-checkout-index.o
 BUILTIN_OBJS += builtin-checkout.o
+BUILTIN_OBJS += builtin-cherry-pick.o
 BUILTIN_OBJS += builtin-clean.o
 BUILTIN_OBJS += builtin-clone.o
 BUILTIN_OBJS += builtin-commit-tree.o
@@ -556,7 +557,6 @@ BUILTIN_OBJS += builtin-rerere.o
 BUILTIN_OBJS += builtin-reset.o
 BUILTIN_OBJS += builtin-rev-list.o
 BUILTIN_OBJS += builtin-rev-parse.o
-BUILTIN_OBJS += builtin-revert.o
 BUILTIN_OBJS += builtin-rm.o
 BUILTIN_OBJS += builtin-send-pack.o
 BUILTIN_OBJS += builtin-shortlog.o
@@ -1261,7 +1261,7 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
-builtin-revert.o wt-status.o: wt-status.h
+builtin-cherry-pick.o wt-status.o: wt-status.h
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
diff --git a/builtin-revert.c b/builtin-cherry-pick.c
similarity index 98%
rename from builtin-revert.c
rename to builtin-cherry-pick.c
index 4038b41..d1a7188 100644
--- a/builtin-revert.c
+++ b/builtin-cherry-pick.c
@@ -57,6 +57,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
+		OPT_SET_INT('R', "revert", &action, "cherry-pick a reverted patch", REVERT),
 		OPT_END(),
 	};
 
@@ -261,10 +262,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
 
-	/* this is copied from the shell script, but it's never triggered... */
-	if (action == REVERT && !no_replay)
-		die("revert is incompatible with replay");
-
 	if (read_cache() < 0)
 		die("git %s: failed to read the index", me);
 	if (no_commit) {
@@ -439,16 +436,17 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
+#if 0
+	warning("git revert is deprecated, please use git cherry-pick --revert/-R instead");
+#endif
 	if (isatty(0))
 		edit = 1;
-	no_replay = 1;
 	action = REVERT;
 	return revert_or_cherry_pick(argc, argv);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
-	no_replay = 0;
 	action = CHERRY_PICK;
 	return revert_or_cherry_pick(argc, argv);
 }
-- 
1.6.0.3.790.ga4dd7.dirty
