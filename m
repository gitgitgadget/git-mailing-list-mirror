From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] Make lookup_*() functions thread-safe
Date: Tue, 10 Apr 2012 21:39:29 +0700
Message-ID: <1334068771-32725-4-git-send-email-pclouds@gmail.com>
References: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 16:43:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcHl-0007Ih-Ly
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 16:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758911Ab2DJOnC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 10:43:02 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52722 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758913Ab2DJOnA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 10:43:00 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so45834pbc.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=O2GmL6AwJy45+wIFy3rG2uXWHKzyBM1HqMitGg5YA5o=;
        b=mClY6fy06+cGJcvyGgqkKBuxDDB3ZpObafdzMVJRNVm0GdbeZKB76vAdUw7IOL2FLx
         MBKu5n+OPdmfIPcy6RcDt3Za1ilkbzKW6J/Vl1MdEoiBfdAJtYaCtc5Aeh3/WpQAjg8N
         5Uhry3+EkinCUB3SkXdOQJE405PdK7w9evapseyT09YrMhI7a3ZUgI4qgLnD7zKcYUyp
         t/VghoTMUSJkqJ7Xd0IbdKNKBZ45LfYcfitcikVyrIn9qq6ezMn3zQY6KdG2xHvEDULN
         HJIO2rk8LN4aVdvuKUmdV6flZkqlroNRKO9ml+41+CkuAFqqjD5zqzGWiBV0NhS7V8OV
         KwhQ==
Received: by 10.68.222.165 with SMTP id qn5mr29083117pbc.88.1334068980544;
        Tue, 10 Apr 2012 07:43:00 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.33.136])
        by mx.google.com with ESMTPS id st4sm47933pbc.51.2012.04.10.07.42.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 07:42:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Apr 2012 21:40:00 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195089>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 blob.c         |   11 +++++++++--
 commit.c       |   12 +++++++++---
 list-objects.c |    2 ++
 object.c       |    9 ++++++++-
 object.h       |    6 ++++++
 tag.c          |    9 +++++++--
 tree.c         |   18 ++++++++++++++----
 7 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/blob.c b/blob.c
index ae320bd..606e2be 100644
--- a/blob.c
+++ b/blob.c
@@ -6,8 +6,13 @@ const char *blob_type =3D "blob";
 struct blob *lookup_blob(const unsigned char *sha1)
 {
 	struct object *obj =3D lookup_object(sha1);
-	if (!obj)
-		return create_object(sha1, OBJ_BLOB, alloc_blob_node());
+	LOCK();
+	if (!obj) {
+		obj =3D create_object(sha1, OBJ_BLOB, alloc_blob_node());
+		UNLOCK();
+		return obj;
+	}
+	UNLOCK();
 	if (!obj->type)
 		obj->type =3D OBJ_BLOB;
 	if (obj->type !=3D OBJ_BLOB) {
@@ -20,6 +25,8 @@ struct blob *lookup_blob(const unsigned char *sha1)
=20
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long s=
ize)
 {
+	LOCK();
 	item->object.parsed =3D 1;
+	UNLOCK();
 	return 0;
 }
diff --git a/commit.c b/commit.c
index 4b39c19..f84152c 100644
--- a/commit.c
+++ b/commit.c
@@ -54,9 +54,15 @@ struct commit *lookup_commit_or_die(const unsigned c=
har *sha1, const char *ref_n
=20
 struct commit *lookup_commit(const unsigned char *sha1)
 {
-	struct object *obj =3D lookup_object(sha1);
-	if (!obj)
-		return create_object(sha1, OBJ_COMMIT, alloc_commit_node());
+	struct object *obj;
+	LOCK();
+	obj =3D lookup_object(sha1);
+	if (!obj) {
+		obj =3D create_object(sha1, OBJ_COMMIT, alloc_commit_node());
+		UNLOCK();
+		return (struct commit*)obj;
+	}
+	UNLOCK();
 	if (!obj->type)
 		obj->type =3D OBJ_COMMIT;
 	return check_commit(obj, sha1, 0);
diff --git a/list-objects.c b/list-objects.c
index 3dd4a96..2605b63 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -123,8 +123,10 @@ static void process_tree(struct rev_info *revs,
 				     cb_data);
 	}
 	strbuf_setlen(base, baselen);
+	LOCK();
 	free(tree->buffer);
 	tree->buffer =3D NULL;
+	UNLOCK();
 }
=20
 static void mark_edge_parents_uninteresting(struct commit *commit,
diff --git a/object.c b/object.c
index 6b06297..05fb91f 100644
--- a/object.c
+++ b/object.c
@@ -8,6 +8,9 @@
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
=20
+int multithread_object_access;
+pthread_mutex_t mtx;
+
 unsigned int get_max_object_index(void)
 {
 	return obj_hash_size;
@@ -126,9 +129,13 @@ void *create_object(const unsigned char *sha1, int=
 type, void *o)
=20
 struct object *lookup_unknown_object(const unsigned char *sha1)
 {
-	struct object *obj =3D lookup_object(sha1);
+	struct object *obj;
+
+	LOCK();
+	obj =3D lookup_object(sha1);
 	if (!obj)
 		obj =3D create_object(sha1, OBJ_NONE, alloc_object_node());
+	UNLOCK();
 	return obj;
 }
=20
diff --git a/object.h b/object.h
index b6618d9..17c7c65 100644
--- a/object.h
+++ b/object.h
@@ -32,6 +32,12 @@ struct object {
 	unsigned char sha1[20];
 };
=20
+extern int multithread_object_access;
+extern pthread_mutex_t mtx;
+
+#define LOCK() { if (multithread_object_access) pthread_mutex_lock(&mt=
x); }
+#define UNLOCK() { if (multithread_object_access) pthread_mutex_unlock=
(&mtx); }
+
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
=20
diff --git a/tag.c b/tag.c
index 78d272b..4f16c5b 100644
--- a/tag.c
+++ b/tag.c
@@ -39,8 +39,13 @@ struct object *deref_tag_noverify(struct object *o)
 struct tag *lookup_tag(const unsigned char *sha1)
 {
 	struct object *obj =3D lookup_object(sha1);
-	if (!obj)
-		return create_object(sha1, OBJ_TAG, alloc_tag_node());
+	LOCK();
+	if (!obj) {
+		obj =3D create_object(sha1, OBJ_TAG, alloc_tag_node());
+		UNLOCK();
+		return obj;
+	}
+	UNLOCK();
 	if (!obj->type)
 		obj->type =3D OBJ_TAG;
 	if (obj->type !=3D OBJ_TAG) {
diff --git a/tree.c b/tree.c
index 676e9f7..6d3c6a2 100644
--- a/tree.c
+++ b/tree.c
@@ -180,9 +180,15 @@ int read_tree(struct tree *tree, int stage, struct=
 pathspec *match)
=20
 struct tree *lookup_tree(const unsigned char *sha1)
 {
-	struct object *obj =3D lookup_object(sha1);
-	if (!obj)
-		return create_object(sha1, OBJ_TREE, alloc_tree_node());
+	struct object *obj;
+	LOCK();
+	obj =3D lookup_object(sha1);
+	if (!obj) {
+		obj =3D create_object(sha1, OBJ_TREE, alloc_tree_node());
+		UNLOCK();
+		return obj;
+	}
+	UNLOCK();
 	if (!obj->type)
 		obj->type =3D OBJ_TREE;
 	if (obj->type !=3D OBJ_TREE) {
@@ -195,11 +201,15 @@ struct tree *lookup_tree(const unsigned char *sha=
1)
=20
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long s=
ize)
 {
-	if (item->object.parsed)
+	LOCK();
+	if (item->object.parsed) {
+		UNLOCK();
 		return 0;
+	}
 	item->object.parsed =3D 1;
 	item->buffer =3D buffer;
 	item->size =3D size;
+	UNLOCK();
=20
 	return 0;
 }
--=20
1.7.8.36.g69ee2
