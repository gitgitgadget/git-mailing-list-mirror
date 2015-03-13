From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 04/10] archive.c: convert to use struct object_id
Date: Fri, 13 Mar 2015 23:39:30 +0000
Message-ID: <1426289976-568060-5-git-send-email-sandals@crustytoothpaste.net>
References: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 00:40:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWZC7-0000Kn-4o
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 00:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbbCMXki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 19:40:38 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50126 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753843AbbCMXkL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 19:40:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 00AD028095;
	Fri, 13 Mar 2015 23:40:10 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265432>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/archive.c b/archive.c
index 96057ed..d37c41d 100644
--- a/archive.c
+++ b/archive.c
@@ -101,7 +101,7 @@ static void setup_archive_check(struct git_attr_check *check)
 
 struct directory {
 	struct directory *up;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int baselen, len;
 	unsigned mode;
 	int stage;
@@ -177,7 +177,7 @@ static void queue_directory(const unsigned char *sha1,
 	d->stage   = stage;
 	c->bottom  = d;
 	d->len = sprintf(d->path, "%.*s%s/", (int)base->len, base->buf, filename);
-	hashcpy(d->sha1, sha1);
+	hashcpy(d->oid.hash, sha1);
 }
 
 static int write_directory(struct archiver_context *c)
@@ -191,7 +191,7 @@ static int write_directory(struct archiver_context *c)
 	d->path[d->len - 1] = '\0'; /* no trailing slash */
 	ret =
 		write_directory(c) ||
-		write_archive_entry(d->sha1, d->path, d->baselen,
+		write_archive_entry(d->oid.hash, d->path, d->baselen,
 				    d->path + d->baselen, d->mode,
 				    d->stage, c) != READ_TREE_RECURSIVE;
 	free(d);
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
+		if (!dwim_ref(name, refnamelen, oid.hash, &ref))
 			die("no such ref: %.*s", refnamelen, name);
 		free(ref);
 	}
 
-	if (get_sha1(name, sha1))
+	if (get_sha1(name, oid.hash))
 		die("Not a valid object name");
 
-	commit = lookup_commit_reference_gently(sha1, 1);
+	commit = lookup_commit_reference_gently(oid.hash, 1);
 	if (commit) {
 		commit_sha1 = commit->object.sha1;
 		archive_time = commit->date;
@@ -379,21 +379,21 @@ static void parse_treeish_arg(const char **argv,
 		archive_time = time(NULL);
 	}
 
-	tree = parse_tree_indirect(sha1);
+	tree = parse_tree_indirect(oid.hash);
 	if (tree == NULL)
 		die("not a tree object");
 
 	if (prefix) {
-		unsigned char tree_sha1[20];
+		struct object_id tree_oid;
 		unsigned int mode;
 		int err;
 
 		err = get_tree_entry(tree->object.sha1, prefix,
-				     tree_sha1, &mode);
+				     tree_oid.hash, &mode);
 		if (err || !S_ISDIR(mode))
 			die("current working directory is untracked");
 
-		tree = parse_tree_indirect(tree_sha1);
+		tree = parse_tree_indirect(tree_oid.hash);
 	}
 	ar_args->tree = tree;
 	ar_args->commit_sha1 = commit_sha1;
-- 
2.2.1.209.g41e5f3a
