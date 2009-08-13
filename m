From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 3/6] builtin-add: refactor the meat of interactive_add()
Date: Thu, 13 Aug 2009 14:29:41 +0200
Message-ID: <fc79a0af2e3687373d4a7fdd9bf35b9a79b37cf9.1250164190.git.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch> <cover.1250164190.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZSC-0002tc-Gm
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbZHMMaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbZHMMaO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:30:14 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54458 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbZHMMaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:30:12 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:09 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:01 +0200
X-Mailer: git-send-email 1.6.4.262.gbda8
In-Reply-To: <cover.1250164190.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125812>

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
index ba9f638..339f1f6 100644
--- a/commit.h
+++ b/commit.h
@@ -137,6 +137,8 @@ struct commit_graft {
 int in_merge_bases(struct commit *, struct commit **, int);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix);
+extern int run_add_interactive(const char *revision, const char *patch_mode,
+			       const char **pathspec);
 
 static inline int single_parent(struct commit *commit)
 {
-- 
1.6.4.262.gbda8
