From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/6] revisions: split handle_revision_args from parse_revisions.
Date: Tue,  8 Jul 2008 11:56:02 +0200
Message-ID: <1215510964-16664-5-git-send-email-madcoder@debian.org>
References: <1215510964-16664-1-git-send-email-madcoder@debian.org>
 <1215510964-16664-2-git-send-email-madcoder@debian.org>
 <1215510964-16664-3-git-send-email-madcoder@debian.org>
 <1215510964-16664-4-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 12:00:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG9wh-0003P0-Hd
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 11:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYGHJ4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 05:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbYGHJ4M
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 05:56:12 -0400
Received: from pan.madism.org ([88.191.52.104]:33902 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbYGHJ4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 05:56:09 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id DEEF234389;
	Tue,  8 Jul 2008 11:56:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D12672BD381; Tue,  8 Jul 2008 11:56:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.352.g416a6
In-Reply-To: <1215510964-16664-4-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87736>

This new function is meant to only parse non option revision arguments in
a row. IOW it's meant to parse what remains from a parse-opt filtering of
the argument list, with the knowledge of the "--" position (0 means none).

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 revision.c |   97 +++++++++++++++++++++++++++++++----------------------------
 revision.h |    1 +
 2 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/revision.c b/revision.c
index 87f89a2..c7de30f 100644
--- a/revision.c
+++ b/revision.c
@@ -1241,49 +1241,11 @@ int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 	return 1;
 }
 
-/*
- * Parse revision information, filling in the "rev_info" structure,
- * and removing the used arguments from the argument list.
- *
- * Returns the number of arguments left that weren't recognized
- * (which are also moved to the head of the argument list)
- */
-int parse_revisions(int argc, const char **argv, struct rev_info *revs)
+int handle_revision_args(struct rev_info *revs,
+                         int argc, const char **argv, int dashdash_pos)
 {
-	int i, left, flags;
-	int seen_dashdash = 0;
-
-	/* First, filter out revision options and look for "--" */
-	for (left = i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		int opts;
-
-		if (arg[0] != '-') {
-			argv[left++] = arg;
-			continue;
-		}
-
-		if (!strcmp(arg, "--")) {
-			seen_dashdash = left;
-			memcpy(argv + left, argv + i, sizeof(*argv) * (argc - i));
-			left += argc - i;
-			break;
-		}
+	int i, left, flags = 0;
 
-		opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
-		if (opts > 0) {
-			i += opts - 1;
-			continue;
-		}
-		if (opts < 0)
-			exit(128);
-		argv[left++] = arg;
-	}
-	argv[left] = NULL;
-	argc = left;
-
-	/* Second, parse revisions arguments */
-	flags = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -1320,7 +1282,7 @@ int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 				revs->no_walk = 0;
 				continue;
 			}
-			if (i == seen_dashdash) {
+			if (i == dashdash_pos) {
 				argv[i] = NULL;
 				argc = i;
 				if (argv[i + 1])
@@ -1332,10 +1294,10 @@ int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 			continue;
 		}
 
-		if (handle_revision_arg(arg, revs, flags, seen_dashdash)) {
+		if (handle_revision_arg(arg, revs, flags, dashdash_pos)) {
 			int j;
-			if (seen_dashdash || *arg == '^')
-				die("bad revision '%s'", arg);
+			if (dashdash_pos || *arg == '^')
+				return error("bad revision '%s'", arg);
 
 			/* If we didn't have a "--":
 			 * (1) all filenames must exist;
@@ -1351,7 +1313,50 @@ int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 			break;
 		}
 	}
-	return left;
+
+        return left;
+}
+
+/*
+ * Parse revision information, filling in the "rev_info" structure,
+ * and removing the used arguments from the argument list.
+ *
+ * Returns the number of arguments left that weren't recognized
+ * (which are also moved to the head of the argument list)
+ */
+int parse_revisions(int argc, const char **argv, struct rev_info *revs)
+{
+	int i, left, dashdash_pos = 0;
+
+	/* First, filter out revision options and look for "--" */
+	for (left = i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		int opts;
+
+		if (arg[0] != '-') {
+			argv[left++] = arg;
+			continue;
+		}
+
+		if (!strcmp(arg, "--")) {
+			dashdash_pos = left;
+			memcpy(argv + left, argv + i, sizeof(*argv) * (argc - i));
+			left += argc - i;
+			break;
+		}
+
+		opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
+		if (opts > 0) {
+			i += opts - 1;
+			continue;
+		}
+		if (opts < 0)
+			exit(128);
+		argv[left++] = arg;
+	}
+	argv[left] = NULL;
+
+        return handle_revision_args(revs, left, argv, dashdash_pos);
 }
 
 void setup_revisions(struct rev_info *revs, const char *def)
diff --git a/revision.h b/revision.h
index 46ab713..c0f5df0 100644
--- a/revision.h
+++ b/revision.h
@@ -125,6 +125,7 @@ extern int parse_revisions(int argc, const char **argv, struct rev_info *revs);
 extern void setup_revisions(struct rev_info *revs, const char *def);
 extern int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv);
+extern int handle_revision_args(struct rev_info *revs, int argc, const char **argv, int dashdash_pos);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
 
 extern int prepare_revision_walk(struct rev_info *revs);
-- 
1.5.6.2.352.g416a6
