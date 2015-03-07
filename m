From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 04/10] archive.c: convert to use struct object_id
Date: Sat,  7 Mar 2015 23:23:59 +0000
Message-ID: <1425770645-628957-5-git-send-email-sandals@crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:24:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUO58-0001cR-GQ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbbCGXYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:24:21 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49829 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753119AbbCGXYR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 18:24:17 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 44FF328095;
	Sat,  7 Mar 2015 23:24:16 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265015>

Convert a hard-coded 20 as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/archive.c b/archive.c
index 96057ed..46d9025 100644
--- a/archive.c
+++ b/archive.c
@@ -101,7 +101,7 @@ static void setup_archive_check(struct git_attr_check *check)
 
 struct directory {
 	struct directory *up;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	int baselen, len;
 	unsigned mode;
 	int stage;
@@ -354,7 +354,7 @@ static void parse_treeish_arg(const char **argv,
 	time_t archive_time;
 	struct tree *tree;
 	const struct commit *commit;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	/* Remotes are only allowed to fetch actual refs */
 	if (remote && !remote_allow_unreachable) {
@@ -362,15 +362,15 @@ static void parse_treeish_arg(const char **argv,
 		const char *colon = strchrnul(name, ':');
 		int refnamelen = colon - name;
 
-		if (!dwim_ref(name, refnamelen, sha1, &ref))
+		if (!dwim_ref(name, refnamelen, oid.sha1, &ref))
 			die("no such ref: %.*s", refnamelen, name);
 		free(ref);
 	}
 
-	if (get_sha1(name, sha1))
+	if (get_sha1(name, oid.sha1))
 		die("Not a valid object name");
 
-	commit = lookup_commit_reference_gently(sha1, 1);
+	commit = lookup_commit_reference_gently(oid.sha1, 1);
 	if (commit) {
 		commit_sha1 = commit->object.sha1;
 		archive_time = commit->date;
@@ -379,21 +379,21 @@ static void parse_treeish_arg(const char **argv,
 		archive_time = time(NULL);
 	}
 
-	tree = parse_tree_indirect(sha1);
+	tree = parse_tree_indirect(oid.sha1);
 	if (tree == NULL)
 		die("not a tree object");
 
 	if (prefix) {
-		unsigned char tree_sha1[20];
+		struct object_id tree_oid;
 		unsigned int mode;
 		int err;
 
 		err = get_tree_entry(tree->object.sha1, prefix,
-				     tree_sha1, &mode);
+				     tree_oid.sha1, &mode);
 		if (err || !S_ISDIR(mode))
 			die("current working directory is untracked");
 
-		tree = parse_tree_indirect(tree_sha1);
+		tree = parse_tree_indirect(tree_oid.sha1);
 	}
 	ar_args->tree = tree;
 	ar_args->commit_sha1 = commit_sha1;
-- 
2.2.1.209.g41e5f3a
