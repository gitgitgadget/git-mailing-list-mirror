From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 2/5] builtin-add: refactor the meat of interactive_add()
Date: Sat, 25 Jul 2009 23:29:31 +0200
Message-ID: <35bee46b2361c0af841bbc844ce2f76c3ebbeb3e.1248557241.git.trast@student.ethz.ch>
References: <7vzlat64u1.fsf@alter.siamese.dyndns.org> <cover.1248557241.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 23:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoog-00037K-Rg
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbZGYV3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 17:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbZGYV3q
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:29:46 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9118 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbZGYV3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 17:29:45 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:44 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:44 +0200
X-Mailer: git-send-email 1.6.4.rc2.227.gf5e17
In-Reply-To: <cover.1248557241.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 25 Jul 2009 21:29:44.0201 (UTC) FILETIME=[06E9FF90:01CA0D6F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124076>

This moves the call setup for 'git add--interactive' to a separate
function, as other users will call it without running
validate_pathspec() first.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin-add.c |   43 +++++++++++++++++++++++++++++--------------
 commit.h      |    2 ++
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 581a2a1..c422a62 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -131,27 +131,27 @@ static void refresh(int verbose, const char **pathspec)
 	return pathspec;
 }
 
-int interactive_add(int argc, const char **argv, const char *prefix)
+int run_add_interactive(const char *revision, const char *patch_mode,
+			const char **pathspec)
 {
-	int status, ac;
+	int status, ac, pc = 0;
 	const char **args;
-	const char **pathspec = NULL;
 
-	if (argc) {
-		pathspec = validate_pathspec(argc, argv, prefix);
-		if (!pathspec)
-			return -1;
-	}
+	if (pathspec)
+		while (pathspec[pc])
+			pc++;
 
-	args = xcalloc(sizeof(const char *), (argc + 4));
+	args = xcalloc(sizeof(const char *), (pc + 5));
 	ac = 0;
 	args[ac++] = "add--interactive";
-	if (patch_interactive)
-		args[ac++] = "--patch";
+	if (patch_mode)
+		args[ac++] = patch_mode;
+	if (revision)
+		args[ac++] = revision;
 	args[ac++] = "--";
-	if (argc) {
-		memcpy(&(args[ac]), pathspec, sizeof(const char *) * argc);
-		ac += argc;
+	if (pc) {
+		memcpy(&(args[ac]), pathspec, sizeof(const char *) * pc);
+		ac += pc;
 	}
 	args[ac] = NULL;
 
@@ -160,6 +160,21 @@ int interactive_add(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+int interactive_add(int argc, const char **argv, const char *prefix)
+{
+	const char **pathspec = NULL;
+
+	if (argc) {
+		pathspec = validate_pathspec(argc, argv, prefix);
+		if (!pathspec)
+			return -1;
+	}
+
+	return run_add_interactive(NULL,
+				   patch_interactive ? "--patch" : NULL,
+				   pathspec);
+}
+
 static int edit_patch(int argc, const char **argv, const char *prefix)
 {
 	char *file = xstrdup(git_path("ADD_EDIT.patch"));
diff --git a/commit.h b/commit.h
index 8bfdf0e..0555e80 100644
--- a/commit.h
+++ b/commit.h
@@ -139,6 +139,8 @@ struct commit_graft {
 int in_merge_bases(struct commit *, struct commit **, int);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix);
+extern int run_add_interactive(const char *revision, const char *patch_mode,
+			       const char **pathspec);
 
 static inline int single_parent(struct commit *commit)
 {
-- 
1.6.4.rc2.227.gf5e17
