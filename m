From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Make the git-fsck-objects diagnostics more useful
Date: Tue, 20 Sep 2005 20:56:05 +0200
Message-ID: <20050920185605.GA28621@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 20 20:58:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHnHn-0004Zd-GT
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 20:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVITS4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 14:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVITS4I
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 14:56:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36576 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965072AbVITS4H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 14:56:07 -0400
Received: (qmail 32489 invoked by uid 2001); 20 Sep 2005 20:56:05 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9015>

Actually report what exactly is wrong with the object, instead of an
ambiguous 'bad sha1 file' or such. In places where we already do, unify
the format and clean the messages up.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
commit ff0b3368b45a07ac080574eb721a607892413b99
tree c5e730edddb7679bee63a7d76fb088a7378a9d8b
parent 12913234050c07785b7fc5929e4c8b5f80606609
author Petr Baudis <pasky@suse.cz> Tue, 20 Sep 2005 20:54:33 +0200
committer Petr Baudis <xpasky@machine.(none)> Tue, 20 Sep 2005 20:54:33 +0200

 fsck-objects.c |   82 +++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/fsck-objects.c b/fsck-objects.c
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -20,6 +20,35 @@ static int check_strict = 0;
 static int keep_cache_objects = 0; 
 static unsigned char head_sha1[20];
 
+
+static void objreport(struct object *obj, const char *severity,
+                      const char *err, va_list params)
+{
+	fprintf(stderr, "%s in %s %s: ",
+	        severity, obj->type, sha1_to_hex(obj->sha1));
+	vfprintf(stderr, err, params);
+	fputs("\n", stderr);
+}
+
+int objerror(struct object *obj, const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	objreport(obj, "error", err, params);
+	va_end(params);
+	return -1;
+}
+
+int objwarning(struct object *obj, const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	objreport(obj, "warning", err, params);
+	va_end(params);
+	return -1;
+}
+
+
 static void check_connectivity(void)
 {
 	int i;
@@ -162,31 +191,19 @@ static int fsck_tree(struct tree *item)
 
 	retval = 0;
 	if (has_full_path) {
-		fprintf(stderr, "warning: git-fsck-objects: tree %s "
-			"has full pathnames in it\n", 
-			sha1_to_hex(item->object.sha1));
+		objwarning(&item->object, "contains full pathnames");
 	}
 	if (has_zero_pad) {
-		fprintf(stderr, "warning: git-fsck-objects: tree %s "
-			"has zero-padded file modes in it\n",
-			sha1_to_hex(item->object.sha1));
+		objwarning(&item->object, "contains zero-padded file modes");
 	}
 	if (has_bad_modes) {
-		fprintf(stderr, "warning: git-fsck-objects: tree %s "
-			"has bad file modes in it\n",
-			sha1_to_hex(item->object.sha1));
+		objwarning(&item->object, "contains bad file modes");
 	}
 	if (has_dup_entries) {
-		fprintf(stderr, "error: git-fsck-objects: tree %s "
-			"has duplicate file entries\n",
-			sha1_to_hex(item->object.sha1));
-		retval = -1;
+		retval = objerror(&item->object, "contains duplicate file entries");
 	}
 	if (not_properly_sorted) {
-		fprintf(stderr, "error: git-fsck-objects: tree %s "
-			"is not properly sorted\n",
-			sha1_to_hex(item->object.sha1));
-		retval = -1;
+		retval = objerror(&item->object, "not properly sorted");
 	}
 	return retval;
 }
@@ -194,24 +211,24 @@ static int fsck_tree(struct tree *item)
 static int fsck_commit(struct commit *commit)
 {
 	char *buffer = commit->buffer;
-	unsigned char sha1[20];
+	unsigned char tree_sha1[20], sha1[20];
 
 	if (memcmp(buffer, "tree ", 5))
-		return -1;
-	if (get_sha1_hex(buffer+5, sha1) || buffer[45] != '\n')
-		return -1;
+		return objerror(&commit->object, "invalid format - expected 'tree' line");
+	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
+		return objerror(&commit->object, "invalid 'tree' line format - bad sha1");
 	buffer += 46;
 	while (!memcmp(buffer, "parent ", 7)) {
 		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
-			return -1;
+			return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
 		buffer += 48;
 	}
 	if (memcmp(buffer, "author ", 7))
-		return -1;
+		return objerror(&commit->object, "invalid format - expected 'author' line");
 	free(commit->buffer);
 	commit->buffer = NULL;
 	if (!commit->tree)
-		return -1;
+		return objerror(&commit->object, "could not load commit's tree %s", tree_sha1);
 	if (!commit->parents && show_root)
 		printf("root %s\n", sha1_to_hex(commit->object.sha1));
 	if (!commit->date)
@@ -225,8 +242,7 @@ static int fsck_tag(struct tag *tag)
 	struct object *tagged = tag->tagged;
 
 	if (!tagged) {
-		printf("bad object in tag %s\n", sha1_to_hex(tag->object.sha1));
-		return -1;
+		return objerror(&tag->object, "could not load tagged object");
 	}
 	if (!show_tags)
 		return 0;
@@ -240,7 +256,7 @@ static int fsck_sha1(unsigned char *sha1
 {
 	struct object *obj = parse_object(sha1);
 	if (!obj)
-		return -1;
+		return error("%s: object not found", sha1_to_hex(sha1));
 	if (obj->type == blob_type)
 		return 0;
 	if (obj->type == tree_type)
@@ -249,7 +265,8 @@ static int fsck_sha1(unsigned char *sha1
 		return fsck_commit((struct commit *) obj);
 	if (obj->type == tag_type)
 		return fsck_tag((struct tag *) obj);
-	return -1;
+	/* By now, parse_object() would've returned NULL instead. */
+	return objerror(obj, "unknown type '%s' (internal fsck error)", obj->type);
 }
 
 /*
@@ -285,8 +302,7 @@ static void fsck_sha1_list(void)
 		unsigned char *sha1 = entry->sha1;
 
 		sha1_list.entry[i] = NULL;
-		if (fsck_sha1(sha1) < 0)
-			fprintf(stderr, "bad sha1 entry '%s'\n", sha1_to_hex(sha1));
+		fsck_sha1(sha1);
 		free(entry);
 	}
 	sha1_list.nr = 0;
@@ -479,9 +495,7 @@ int main(int argc, char **argv)
 			for (i = 0; i < num; i++) {
 				unsigned char sha1[20];
 				nth_packed_object_sha1(p, i, sha1);
-				if (fsck_sha1(sha1) < 0)
-					fprintf(stderr, "bad sha1 entry '%s'\n", sha1_to_hex(sha1));
-
+				fsck_sha1(sha1);
 			}
 		}
 	}
@@ -505,7 +519,7 @@ int main(int argc, char **argv)
 			heads++;
 			continue;
 		}
-		error("expected sha1, got %s", arg);
+		error("invalid parameter: expected sha1, got '%s'", arg);
 	}
 
 	/*


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
