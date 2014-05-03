From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/9] archive.c: convert to use struct object_id
Date: Sat,  3 May 2014 20:12:16 +0000
Message-ID: <1399147942-165308-4-git-send-email-sandals@crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:12:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIq-0005FK-M3
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbaECUMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:48 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47529 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753298AbaECUM2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DE1242808A
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:27 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248055>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/archive.c b/archive.c
index 3fc0fb2..dba148a 100644
--- a/archive.c
+++ b/archive.c
@@ -255,7 +255,7 @@ static void parse_treeish_arg(const char **argv,
 	time_t archive_time;
 	struct tree *tree;
 	const struct commit *commit;
-	unsigned char sha1[20];
+	struct object_id sha1;
 
 	/* Remotes are only allowed to fetch actual refs */
 	if (remote && !remote_allow_unreachable) {
@@ -263,15 +263,15 @@ static void parse_treeish_arg(const char **argv,
 		const char *colon = strchrnul(name, ':');
 		int refnamelen = colon - name;
 
-		if (!dwim_ref(name, refnamelen, sha1, &ref))
+		if (!dwim_ref(name, refnamelen, sha1.oid, &ref))
 			die("no such ref: %.*s", refnamelen, name);
 		free(ref);
 	}
 
-	if (get_sha1(name, sha1))
+	if (get_sha1(name, sha1.oid))
 		die("Not a valid object name");
 
-	commit = lookup_commit_reference_gently(sha1, 1);
+	commit = lookup_commit_reference_gently(sha1.oid, 1);
 	if (commit) {
 		commit_sha1 = commit->object.sha1;
 		archive_time = commit->date;
@@ -280,21 +280,21 @@ static void parse_treeish_arg(const char **argv,
 		archive_time = time(NULL);
 	}
 
-	tree = parse_tree_indirect(sha1);
+	tree = parse_tree_indirect(sha1.oid);
 	if (tree == NULL)
 		die("not a tree object");
 
 	if (prefix) {
-		unsigned char tree_sha1[20];
+		struct object_id tree_sha1;
 		unsigned int mode;
 		int err;
 
 		err = get_tree_entry(tree->object.sha1, prefix,
-				     tree_sha1, &mode);
+				     tree_sha1.oid, &mode);
 		if (err || !S_ISDIR(mode))
 			die("current working directory is untracked");
 
-		tree = parse_tree_indirect(tree_sha1);
+		tree = parse_tree_indirect(tree_sha1.oid);
 	}
 	ar_args->tree = tree;
 	ar_args->commit_sha1 = commit_sha1;
-- 
2.0.0.rc0
