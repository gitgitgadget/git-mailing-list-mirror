From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Teach git-describe to verify annotated tag names before output
Date: Thu, 28 Feb 2008 01:22:36 -0500
Message-ID: <20080228062236.GA15845@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 07:23:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUcBK-0007ug-09
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 07:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbYB1GWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 01:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbYB1GWk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 01:22:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34069 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbYB1GWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 01:22:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JUcA9-00008U-4k; Thu, 28 Feb 2008 01:22:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5646620FBAE; Thu, 28 Feb 2008 01:22:36 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75359>

If an annotated tag describes a commit we want to favor the name
listed in the body of the tag, rather than whatever name it has
been stored under locally.  By doing so it is easier to converse
about tags with others, even if the tags happen to be fetched to
a different name than it was given by its creator.

To avoid confusion when a tag is stored under a different name
(and thus is not readable via git-rev-parse --verify, etc.) we show
a warning message if the name of the tag does not match the ref
we found it under and if that tag was also selected for output.
For example:

  $ git tag -a -m "i am a test" testtag
  $ mv .git/refs/tags/testtag .git/refs/tags/bobbytag

  $ ./git-describe HEAD
  warning: tag 'testtag' is really 'bobbytag' here
  testtag

  $ git tag -d testtag
  error: tag 'testtag' not found.
  $ git tag -d bobbytag
  Deleted tag 'bobbytag'

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 05e309f..08d1850 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -22,7 +22,9 @@ static int max_candidates = 10;
 const char *pattern = NULL;
 
 struct commit_name {
+	struct tag *tag;
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
+	unsigned char sha1[20];
 	char path[FLEX_ARRAY]; /* more */
 };
 static const char *prio_names[] = {
@@ -31,14 +33,17 @@ static const char *prio_names[] = {
 
 static void add_to_known_names(const char *path,
 			       struct commit *commit,
-			       int prio)
+			       int prio,
+			       const unsigned char *sha1)
 {
 	struct commit_name *e = commit->util;
 	if (!e || e->prio < prio) {
 		size_t len = strlen(path)+1;
 		free(e);
 		e = xmalloc(sizeof(struct commit_name) + len);
+		e->tag = NULL;
 		e->prio = prio;
+		hashcpy(e->sha1, sha1);
 		memcpy(e->path, path, len);
 		commit->util = e;
 	}
@@ -89,7 +94,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 		if (!tags && prio < 2)
 			return 0;
 	}
-	add_to_known_names(all ? path + 5 : path + 10, commit, prio);
+	add_to_known_names(all ? path + 5 : path + 10, commit, prio, sha1);
 	return 0;
 }
 
@@ -146,6 +151,22 @@ static unsigned long finish_depth_computation(
 	return seen_commits;
 }
 
+static void display_name(struct commit_name *n)
+{
+	if (n->prio == 2 && !n->tag) {
+		n->tag = lookup_tag(n->sha1);
+		if (!n->tag || !n->tag->tag)
+			die("annotated tag %s not available", n->path);
+		if (strcmp(n->tag->tag, n->path))
+			warning("tag '%s' is really '%s' here", n->tag->tag, n->path);
+	}
+
+	if (n->tag)
+		printf("%s", n->tag->tag);
+	else
+		printf("%s", n->path);
+}
+
 static void describe(const char *arg, int last_one)
 {
 	unsigned char sha1[20];
@@ -170,7 +191,8 @@ static void describe(const char *arg, int last_one)
 
 	n = cmit->util;
 	if (n) {
-		printf("%s\n", n->path);
+		display_name(n);
+		printf("\n");
 		return;
 	}
 
@@ -252,12 +274,12 @@ static void describe(const char *arg, int last_one)
 				sha1_to_hex(gave_up_on->object.sha1));
 		}
 	}
-	if (abbrev == 0)
-		printf("%s\n", all_matches[0].name->path );
-	else
-		printf("%s-%d-g%s\n", all_matches[0].name->path,
-		       all_matches[0].depth,
+
+	display_name(all_matches[0].name);
+	if (abbrev)
+		printf("-%d-g%s", all_matches[0].depth,
 		       find_unique_abbrev(cmit->object.sha1, abbrev));
+	printf("\n");
 
 	if (!last_one)
 		clear_commit_marks(cmit, -1);
-- 
1.5.4.3.393.g5540
