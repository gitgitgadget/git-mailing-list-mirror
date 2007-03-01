From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-show: use pathattr to run "display"
Date: Wed, 28 Feb 2007 23:18:05 -0800
Message-ID: <7vodndxwia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 08:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMfZM-0006Kl-NK
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 08:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913AbXCAHS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 02:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933052AbXCAHS1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 02:18:27 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53088 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933043AbXCAHSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 02:18:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301071805.NYUN748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 02:18:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VKJ51W0081kojtg0000000; Thu, 01 Mar 2007 02:18:05 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41040>

This is a bit of detour, to demonstrate a possible use of
pathattr infrastructure.  With this,

	$ git show v1.4.4:t/test4012.png

would hopefully do what you would expect.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I was planning to write the config reader as a follow-up, but
   got sidetracked.  After all, doing something whose effect is
   visible is more fun.

 builtin-log.c |   31 ++++++++++++++++++++++++-------
 pathattr.c    |    8 ++++++++
 pathattr.h    |    3 +++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1c9f7d0..519fab2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "tag.h"
 #include "reflog-walk.h"
+#include "pathattr.h"
 
 static int default_show_root = 1;
 
@@ -86,26 +87,42 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	return cmd_log_walk(&rev);
 }
 
-static int show_object(const unsigned char *sha1, int suppress_header)
+static void to_stdout(const unsigned char *blobdata, unsigned long size)
+{
+	fwrite(blobdata, size, 1, stdout);
+}
+
+static int show_object(const unsigned char *sha1, const char *path, int nohead)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = read_sha1_file(sha1, &type, &size);
+	unsigned char *buf = read_sha1_file(sha1, &type, &size);
 	int offset = 0;
+	pretty_fn pretty = to_stdout;
 
 	if (!buf)
 		return error("Could not read object %s", sha1_to_hex(sha1));
 
-	if (suppress_header)
+	if (nohead) {
 		while (offset < size && buf[offset++] != '\n') {
 			int new_offset = offset;
 			while (new_offset < size && buf[new_offset++] != '\n')
 				; /* do nothing */
 			offset = new_offset;
 		}
+	}
+
+	if (size <= offset)
+		goto finish;
+
+	if (path) {
+		const struct pathattr *a = pathattr_lookup(path);
+		if (a && a->pretty)
+			pretty = a->pretty;
+	}
 
-	if (offset < size)
-		fwrite(buf + offset, size - offset, 1, stdout);
+	pretty(buf + offset, size - offset);
+ finish:
 	free(buf);
 	return 0;
 }
@@ -142,7 +159,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret = show_object(o->sha1, 0);
+			ret = show_object(o->sha1, name, 0);
 			break;
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
@@ -153,7 +170,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					t->tag,
 					diff_get_color(rev.diffopt.color_diff,
 						DIFF_RESET));
-			ret = show_object(o->sha1, 1);
+			ret = show_object(o->sha1, name, 1);
 			objects[i].item = (struct object *)t->tagged;
 			i--;
 			break;
diff --git a/pathattr.c b/pathattr.c
index 06bbb4e..c84be39 100644
--- a/pathattr.c
+++ b/pathattr.c
@@ -1,6 +1,13 @@
 #include "cache.h"
 #include "pathattr.h"
 
+static void show_display(const unsigned char *blobdata, unsigned long size)
+{
+	FILE *display = popen("display -", "w");
+	fwrite(blobdata, size, 1, display);
+	fclose(display);
+}
+
 /*
  * Path match specification
  */
@@ -93,6 +100,7 @@ static void init_stack(void)
 	a = locate(stk, "image/*");
 	a->conv_i = NULL;
 	a->conv_o = NULL;
+	a->pretty = show_display;
 	add_match(stk, a, "*.png");
 	add_match(stk, a, "*.jpg");
 	add_match(stk, a, "*.gif");
diff --git a/pathattr.h b/pathattr.h
index 4ca4e60..bfd9ff1 100644
--- a/pathattr.h
+++ b/pathattr.h
@@ -3,6 +3,8 @@
 
 #include "convert.h"
 
+typedef void (*pretty_fn)(const unsigned char *blobdata, unsigned long size);
+
 /*
  * Data in one section of [pathattr "name"], except
  * the path match specification.
@@ -11,6 +13,7 @@ struct pathattr {
 	char *name;
 	convi_fn conv_i;
 	convo_fn conv_o;
+	pretty_fn pretty;
 };
 
 const struct pathattr *pathattr_lookup(const char *);
-- 
1.5.0.2.809.g0f936
