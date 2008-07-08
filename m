From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/6] revisions: parse_revisions refactor.
Date: Tue,  8 Jul 2008 11:56:01 +0200
Message-ID: <1215510964-16664-4-git-send-email-madcoder@debian.org>
References: <1215510964-16664-1-git-send-email-madcoder@debian.org>
 <1215510964-16664-2-git-send-email-madcoder@debian.org>
 <1215510964-16664-3-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 12:01:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG9wg-0003P0-TL
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 11:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbYGHJ4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 05:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbYGHJ4L
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 05:56:11 -0400
Received: from pan.madism.org ([88.191.52.104]:33900 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbYGHJ4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 05:56:09 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id EB6273438B;
	Tue,  8 Jul 2008 11:56:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C8D0B2AFB16; Tue,  8 Jul 2008 11:56:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.352.g416a6
In-Reply-To: <1215510964-16664-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87738>

Reorder parse_revisions so that it works more like a parse-opt based
parser would: use two pass, the first filtering out options that the
revision parser understands, and remember if we saw a "--", and then
parse revision arguments.

Once everyone is using a parse-opt parser, it will be possible to simplify
parse_revisions further. The first pass is a NOOP for incremental
parse-opt based parsers.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 revision.c |   63 ++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/revision.c b/revision.c
index a3792c9..87f89a2 100644
--- a/revision.c
+++ b/revision.c
@@ -1250,30 +1250,44 @@ int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
  */
 int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 {
-	int i, flags, seen_dashdash;
-	const char **unrecognized = argv + 1;
-	int left = 1;
+	int i, left, flags;
+	int seen_dashdash = 0;
 
-	/* First, search for "--" */
-	seen_dashdash = 0;
-	for (i = 1; i < argc; i++) {
+	/* First, filter out revision options and look for "--" */
+	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (strcmp(arg, "--"))
+		int opts;
+
+		if (arg[0] != '-') {
+			argv[left++] = arg;
 			continue;
-		argv[i] = NULL;
-		argc = i;
-		if (argv[i + 1])
-			revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
-		seen_dashdash = 1;
-		break;
+		}
+
+		if (!strcmp(arg, "--")) {
+			seen_dashdash = left;
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
 	}
+	argv[left] = NULL;
+	argc = left;
 
+	/* Second, parse revisions arguments */
 	flags = 0;
-	for (i = 1; i < argc; i++) {
+	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (*arg == '-') {
-			int opts;
 
+		if (*arg == '-') {
 			if (!strcmp(arg, "--all")) {
 				handle_refs(revs, flags, for_each_ref);
 				continue;
@@ -1306,16 +1320,15 @@ int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 				revs->no_walk = 0;
 				continue;
 			}
-
-			opts = handle_revision_opt(revs, argc - i, argv + i, NULL, NULL);
-			if (opts > 0) {
-				i += opts - 1;
-				continue;
+			if (i == seen_dashdash) {
+				argv[i] = NULL;
+				argc = i;
+				if (argv[i + 1])
+					revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
+				break;
 			}
-			if (opts < 0)
-				exit(128);
-			*unrecognized++ = arg;
-			left++;
+
+			argv[left++] = arg;
 			continue;
 		}
 
-- 
1.5.6.2.352.g416a6
