From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 2/6] Accept object data in the fsck_object() function
Date: Fri, 12 Sep 2014 10:07:55 +0200 (CEST)
Message-ID: <7bccb22f4c3e5aa45d3552e7acce1c360393a610.1410509168.git.johannes.schindelin@gmx.de>
References: <cover.1410445430.git.johannes.schindelin@gmx.de> <cover.1410509168.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 12 10:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSLtp-0005AA-44
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 10:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbaILIIC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 04:08:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:56070 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbaILIH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 04:07:58 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MF4iR-1XYeUZ0CCZ-00GIh9;
 Fri, 12 Sep 2014 10:07:56 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410509168.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:oQxDbnbBzwsVvYUUFcM3vJckfEK96d9pBmR08F6rF3XrzXXfpoH
 QC8XIiHlR2gt+tKlk2om5zWeMXSmI+XsXTNANUfiFb/MAFlGGp+LUfzZrI75CxjTClpVZNa
 sbBHnvzj+u/zicosgIXBPnJiNCb6w+XWRXuybF6cL7hs99FiGKr3zaO2YgL5OBB8nbuhj/d
 7q/XGw1bYkIh8QsqA0LuQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256908>

When fsck'ing an incoming pack, we need to fsck objects that cannot be
read via read_sha1_file() because they are not local yet (and might even
be rejected if transfer.fsckobjects is set to 'true').

For commits, there is a hack in place: we basically cache commit
objects' buffers anyway, but the same is not true, say, for tag objects.

By refactoring fsck_object() to take the object buffer and size as
optional arguments -- optional, because we still fall back to the
previous method to look at the cached commit objects if the caller
passes NULL -- we prepare the machinery for the upcoming handling of tag
objects.

The assumption that such buffers are inherently NUL terminated is now
wrong, of course, hence we pass the size of the buffer so that we can
add a sanity check later, to prevent running past the end of the buffer.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fsck.c           |  2 +-
 builtin/index-pack.c     |  3 ++-
 builtin/unpack-objects.c | 14 ++++++++++----
 fsck.c                   | 24 +++++++++++++++---------
 fsck.h                   |  4 +++-
 5 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d42a27d..d9f4e6e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -298,7 +298,7 @@ static int fsck_obj(struct object *obj)
 
 	if (fsck_walk(obj, mark_used, NULL))
 		objerror(obj, "broken links");
-	if (fsck_object(obj, check_strict, fsck_error_func))
+	if (fsck_object(obj, NULL, 0, check_strict, fsck_error_func))
 		return -1;
 
 	if (obj->type == OBJ_TREE) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5568a5b..f2465ff 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -773,7 +773,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (!obj)
 				die(_("invalid %s"), typename(type));
 			if (do_fsck_object &&
-			    fsck_object(obj, 1, fsck_error_function))
+			    fsck_object(obj, buf, size, 1,
+				    fsck_error_function))
 				die(_("Error in object"));
 			if (fsck_walk(obj, mark_link, NULL))
 				die(_("Not all child objects of %s are reachable"), sha1_to_hex(obj->sha1));
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 99cde45..855d94b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -164,10 +164,10 @@ static unsigned nr_objects;
  * Called only from check_object() after it verified this object
  * is Ok.
  */
-static void write_cached_object(struct object *obj)
+static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
 {
 	unsigned char sha1[20];
-	struct obj_buffer *obj_buf = lookup_object_buffer(obj);
+
 	if (write_sha1_file(obj_buf->buffer, obj_buf->size, typename(obj->type), sha1) < 0)
 		die("failed to write object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= FLAG_WRITTEN;
@@ -180,6 +180,8 @@ static void write_cached_object(struct object *obj)
  */
 static int check_object(struct object *obj, int type, void *data)
 {
+	struct obj_buffer *obj_buf;
+
 	if (!obj)
 		return 1;
 
@@ -198,11 +200,15 @@ static int check_object(struct object *obj, int type, void *data)
 		return 0;
 	}
 
-	if (fsck_object(obj, 1, fsck_error_function))
+	obj_buf = lookup_object_buffer(obj);
+	if (!obj_buf)
+		die("Whoops! Cannot find object '%s'", sha1_to_hex(obj->sha1));
+	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, 1,
+			fsck_error_function))
 		die("Error in object");
 	if (fsck_walk(obj, check_object, NULL))
 		die("Error on reachable objects of %s", sha1_to_hex(obj->sha1));
-	write_cached_object(obj);
+	write_cached_object(obj, obj_buf);
 	return 0;
 }
 
diff --git a/fsck.c b/fsck.c
index 56156ff..dd77628 100644
--- a/fsck.c
+++ b/fsck.c
@@ -277,7 +277,7 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 }
 
 static int fsck_commit_buffer(struct commit *commit, const char *buffer,
-			      fsck_error error_func)
+	unsigned long size, fsck_error error_func)
 {
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
@@ -322,15 +322,18 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	return 0;
 }
 
-static int fsck_commit(struct commit *commit, fsck_error error_func)
+static int fsck_commit(struct commit *commit, const char *data,
+	unsigned long size, fsck_error error_func)
 {
-	const char *buffer = get_commit_buffer(commit, NULL);
-	int ret = fsck_commit_buffer(commit, buffer, error_func);
-	unuse_commit_buffer(commit, buffer);
+	const char *buffer = data ?  data : get_commit_buffer(commit, &size);
+	int ret = fsck_commit_buffer(commit, buffer, size, error_func);
+	if (!data)
+		unuse_commit_buffer(commit, buffer);
 	return ret;
 }
 
-static int fsck_tag(struct tag *tag, fsck_error error_func)
+static int fsck_tag(struct tag *tag, const char *data,
+	unsigned long size, fsck_error error_func)
 {
 	struct object *tagged = tag->tagged;
 
@@ -339,7 +342,8 @@ static int fsck_tag(struct tag *tag, fsck_error error_func)
 	return 0;
 }
 
-int fsck_object(struct object *obj, int strict, fsck_error error_func)
+int fsck_object(struct object *obj, void *data, unsigned long size,
+	int strict, fsck_error error_func)
 {
 	if (!obj)
 		return error_func(obj, FSCK_ERROR, "no valid object to fsck");
@@ -349,9 +353,11 @@ int fsck_object(struct object *obj, int strict, fsck_error error_func)
 	if (obj->type == OBJ_TREE)
 		return fsck_tree((struct tree *) obj, strict, error_func);
 	if (obj->type == OBJ_COMMIT)
-		return fsck_commit((struct commit *) obj, error_func);
+		return fsck_commit((struct commit *) obj, (const char *) data,
+			size, error_func);
 	if (obj->type == OBJ_TAG)
-		return fsck_tag((struct tag *) obj, error_func);
+		return fsck_tag((struct tag *) obj, (const char *) data,
+			size, error_func);
 
 	return error_func(obj, FSCK_ERROR, "unknown type '%d' (internal fsck error)",
 			  obj->type);
diff --git a/fsck.h b/fsck.h
index 1e4f527..d1e6387 100644
--- a/fsck.h
+++ b/fsck.h
@@ -28,6 +28,8 @@ int fsck_error_function(struct object *obj, int type, const char *fmt, ...);
  *    0		everything OK
  */
 int fsck_walk(struct object *obj, fsck_walk_func walk, void *data);
-int fsck_object(struct object *obj, int strict, fsck_error error_func);
+/* If NULL is passed for data, we assume the object is local and read it. */
+int fsck_object(struct object *obj, void *data, unsigned long size,
+	int strict, fsck_error error_func);
 
 #endif
-- 
2.0.0.rc3.9669.g840d1f9
