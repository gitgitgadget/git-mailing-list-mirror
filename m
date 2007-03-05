From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] fsck: exit with non-zero status upon errors
Date: Mon, 05 Mar 2007 00:22:06 -0800
Message-ID: <7vwt1w14nl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 09:22:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8ST-0007ww-EB
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbXCEIWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 03:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbXCEIWJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:22:09 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47830 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbXCEIWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 03:22:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305082207.MVAU3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 03:22:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WwN61W00B1kojtg0000000; Mon, 05 Mar 2007 03:22:06 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41414>

git-fsck always exited with status 0, which was a bit sloppy.
This makes it exit with a non-zero status when errors are
found.  The error code is an OR'ed result of:

  1 if corrupted objects are found.
  2 if objects that are ought to be reachable are missing or corrupt.

For example, it would exit with 1 in a repository with an
unreachable corrupt object.  If a tree object of the HEAD commit
is corrupt, you would get 3.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-fsck.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index abdd0f2..4d03378 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -18,6 +18,9 @@ static int check_full;
 static int check_strict;
 static int keep_cache_objects;
 static unsigned char head_sha1[20];
+static int errors_found;
+#define ERROR_OBJECT 01
+#define ERROR_REACHABLE 02
 
 #ifdef NO_D_INO_IN_DIRENT
 #define SORT_DIRENT 0
@@ -40,6 +43,7 @@ static int objerror(struct object *obj, const char *err, ...)
 {
 	va_list params;
 	va_start(params, err);
+	errors_found |= ERROR_OBJECT;
 	objreport(obj, "error", err, params);
 	va_end(params);
 	return -1;
@@ -70,6 +74,7 @@ static void check_reachable_object(struct object *obj)
 		if (has_sha1_pack(obj->sha1, NULL))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
+		errors_found |= ERROR_REACHABLE;
 		return;
 	}
 
@@ -88,6 +93,7 @@ static void check_reachable_object(struct object *obj)
 			       typename(obj->type), sha1_to_hex(obj->sha1));
 			printf("              to %7s %s\n",
 			       typename(ref->type), sha1_to_hex(ref->sha1));
+			errors_found |= ERROR_REACHABLE;
 		}
 	}
 }
@@ -346,8 +352,11 @@ static int fsck_tag(struct tag *tag)
 static int fsck_sha1(unsigned char *sha1)
 {
 	struct object *obj = parse_object(sha1);
-	if (!obj)
-		return error("%s: object corrupt or missing", sha1_to_hex(sha1));
+	if (!obj) {
+		errors_found |= ERROR_OBJECT;
+		return error("%s: object corrupt or missing",
+			     sha1_to_hex(sha1));
+	}
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |= SEEN;
@@ -359,8 +368,10 @@ static int fsck_sha1(unsigned char *sha1)
 		return fsck_commit((struct commit *) obj);
 	if (obj->type == OBJ_TAG)
 		return fsck_tag((struct tag *) obj);
+
 	/* By now, parse_object() would've returned NULL instead. */
-	return objerror(obj, "unknown type '%d' (internal fsck error)", obj->type);
+	return objerror(obj, "unknown type '%d' (internal fsck error)",
+			obj->type);
 }
 
 /*
@@ -576,11 +587,16 @@ static int fsck_cache_tree(struct cache_tree *it)
 	return err;
 }
 
+static const char fsck_usage[] =
+"git-fsck [--tags] [--root] [[--unreachable] [--cache] [--full] "
+"[--strict] <head-sha1>*]";
+
 int cmd_fsck(int argc, char **argv, const char *prefix)
 {
 	int i, heads;
 
 	track_object_refs = 1;
+	errors_found = 0;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -610,7 +626,7 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 			continue;
 		}
 		if (*arg == '-')
-			usage("git-fsck [--tags] [--root] [[--unreachable] [--cache] [--full] [--strict] <head-sha1>*]");
+			usage(fsck_usage);
 	}
 
 	fsck_head_link();
@@ -690,5 +706,5 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 	}
 
 	check_connectivity();
-	return 0;
+	return errors_found;
 }
-- 
1.5.0.3.855.ga3b2
