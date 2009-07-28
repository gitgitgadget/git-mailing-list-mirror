From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 2/5] builtin-add: refactor the meat of interactive_add()
Date: Tue, 28 Jul 2009 23:20:08 +0200
Message-ID: <dc47610d9634317e77b8db58eb2cf91813360d30.1248815580.git.trast@student.ethz.ch>
References: <200907271210.40001.trast@student.ethz.ch> <cover.1248815580.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 23:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVu6G-0001P2-Sg
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 23:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbZG1VU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 17:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbZG1VU1
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 17:20:27 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28959 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832AbZG1VUY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 17:20:24 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 23:20:22 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 23:20:21 +0200
X-Mailer: git-send-email 1.6.4.rc3.215.gd714f
In-Reply-To: <cover.1248815580.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 28 Jul 2009 21:20:21.0797 (UTC) FILETIME=[36EF3550:01CA0FC9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124280>

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
1.6.4.rc3.215.g18405
