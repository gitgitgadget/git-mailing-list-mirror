From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-fsck: learn about --verbose
Date: Tue, 5 Jun 2007 03:44:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706050341500.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 05 04:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvP3s-0004yy-5Z
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 04:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130AbXFECqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 22:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756873AbXFECqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 22:46:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:50217 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756130AbXFECqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 22:46:06 -0400
Received: (qmail invoked by alias); 05 Jun 2007 02:46:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 05 Jun 2007 04:46:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+d5o41O2qdPj6I/z+wEN9tlhRAj8PnIcnnBLAzuX
	Mk2cKGCgD4k0PO
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49149>


With --verbose, it gets really chatty now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Steven Grimm on IRC said that this might come in handy someday, 
	although it did not help _his_ case.

 Documentation/git-fsck.txt |    5 ++++-
 builtin-fsck.c             |   42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 8c68cf0..ed6413a 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
-		 [--full] [--strict] [<object>*]
+		 [--full] [--strict] [--verbose] [<object>*]
 
 DESCRIPTION
 -----------
@@ -61,6 +61,9 @@ index file and all SHA1 references in .git/refs/* as heads.
 	objects that triggers this check, but it is recommended
 	to check new projects with this flag.
 
+--verbose::
+	Be chatty.
+
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 9959818..bacae5d 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -20,6 +20,7 @@ static int check_strict;
 static int keep_cache_objects;
 static unsigned char head_sha1[20];
 static int errors_found;
+static int verbose;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 
@@ -149,6 +150,9 @@ static void check_unreachable_object(struct object *obj)
 
 static void check_object(struct object *obj)
 {
+	if (verbose)
+		fprintf(stderr, "Checking %s\n", sha1_to_hex(obj->sha1));
+
 	if (obj->flags & REACHABLE)
 		check_reachable_object(obj);
 	else
@@ -161,6 +165,9 @@ static void check_connectivity(void)
 
 	/* Look up all the requirements, warn about missing objects.. */
 	max = get_max_object_index();
+	if (verbose)
+		fprintf(stderr, "Checking connectivity (%d objects)\n", max);
+
 	for (i = 0; i < max; i++) {
 		struct object *obj = get_indexed_object(i);
 
@@ -229,6 +236,10 @@ static int fsck_tree(struct tree *item)
 	const char *o_name;
 	const unsigned char *o_sha1;
 
+	if (verbose)
+		fprintf(stderr, "Checking tree %s\n",
+				sha1_to_hex(item->object.sha1));
+
 	init_tree_desc(&desc, item->buffer, item->size);
 
 	o_mode = 0;
@@ -317,6 +328,10 @@ static int fsck_commit(struct commit *commit)
 	char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 
+	if (verbose)
+		fprintf(stderr, "Checking commit %s\n",
+			sha1_to_hex(commit->object.sha1));
+
 	if (memcmp(buffer, "tree ", 5))
 		return objerror(&commit->object, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
@@ -345,6 +360,10 @@ static int fsck_tag(struct tag *tag)
 {
 	struct object *tagged = tag->tagged;
 
+	if (verbose)
+		fprintf(stderr, "Checking tag %s\n",
+			sha1_to_hex(tag->object.sha1));
+
 	if (!tagged) {
 		return objerror(&tag->object, "could not load tagged object");
 	}
@@ -446,6 +465,9 @@ static void fsck_dir(int i, char *path)
 	if (!dir)
 		return;
 
+	if (verbose)
+		fprintf(stderr, "Checking directory %s\n", path);
+
 	while ((de = readdir(dir)) != NULL) {
 		char name[100];
 		unsigned char sha1[20];
@@ -480,6 +502,10 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 {
 	struct object *obj;
 
+	if (verbose)
+		fprintf(stderr, "Checking reflog %s->%s\n",
+			sha1_to_hex(osha1), sha1_to_hex(nsha1));
+
 	if (!is_null_sha1(osha1)) {
 		obj = lookup_object(osha1);
 		if (obj) {
@@ -549,6 +575,10 @@ static void get_default_heads(void)
 static void fsck_object_dir(const char *path)
 {
 	int i;
+
+	if (verbose)
+		fprintf(stderr, "Checking object directory\n");
+
 	for (i = 0; i < 256; i++) {
 		static char dir[4096];
 		sprintf(dir, "%s/%02x", path, i);
@@ -564,6 +594,9 @@ static int fsck_head_link(void)
 	int null_is_error = 0;
 	const char *head_points_at = resolve_ref("HEAD", sha1, 0, &flag);
 
+	if (verbose)
+		fprintf(stderr, "Checking HEAD link\n");
+
 	if (!head_points_at)
 		return error("Invalid HEAD");
 	if (!strcmp(head_points_at, "HEAD"))
@@ -586,6 +619,9 @@ static int fsck_cache_tree(struct cache_tree *it)
 	int i;
 	int err = 0;
 
+	if (verbose)
+		fprintf(stderr, "Checking cache tree\n");
+
 	if (0 <= it->entry_count) {
 		struct object *obj = parse_object(it->sha1);
 		if (!obj) {
@@ -605,7 +641,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 
 static const char fsck_usage[] =
 "git-fsck [--tags] [--root] [[--unreachable] [--cache] [--full] "
-"[--strict] <head-sha1>*]";
+"[--strict] [--verbose] <head-sha1>*]";
 
 int cmd_fsck(int argc, char **argv, const char *prefix)
 {
@@ -645,6 +681,10 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 			check_strict = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--verbose")) {
+			verbose = 1;
+			continue;
+		}
 		if (*arg == '-')
 			usage(fsck_usage);
 	}
-- 
1.5.2.1.2626.ge1044-dirty
