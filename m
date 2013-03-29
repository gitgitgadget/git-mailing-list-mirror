From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] rev-list: preallocate object hash table in --all --objects
Date: Fri, 29 Mar 2013 20:20:10 +0700
Message-ID: <1364563210-28813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 14:20:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULZEY-0007zG-1v
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 14:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437Ab3C2NUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 09:20:08 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:60458 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab3C2NUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 09:20:07 -0400
Received: by mail-da0-f41.google.com with SMTP id w4so224063dam.14
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0DatPJUN8DvQucp4cV8ill68C0KLgVWjaYRYC9UptAU=;
        b=fRKtBTcAafys7hkdUkPXXSrEc4SFsS+50sZHodStwwWK67m+9ltKJG5B71nGRLNh6P
         TsA7iSMk4kMVTRaSUDr3A49kzLU4Egq1PA6+4KRVCkrmaXs10vOkT8cR5IUiYiqI8o74
         UEvV0n6YYokK3iI5Zyvk+22jEMP/+BbnW+XPU1iz2ZACxiQzH8AWiZl1ku1Xx1s8wJED
         yk101W4PBJHKuILELIQRq9WrmRcmR+vq8PbdUeGl2Lh8C6dNXhE3+9RNDu25b5O4qWCs
         H2Kzlc9QNZKdp4D0oz9xLAl5REAjhK5m/yMTy3z7XRI7jzlZ9Q6kJ4uaIwRoIjg/tHth
         1kYA==
X-Received: by 10.68.7.163 with SMTP id k3mr3579094pba.141.1364563206968;
        Fri, 29 Mar 2013 06:20:06 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id qe3sm2868097pbb.0.2013.03.29.06.20.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Mar 2013 06:20:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 29 Mar 2013 20:20:11 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219499>

Every time the object hash table grows, all entries must be
rearranged. The few last times could be really expensive when the
table contains a lot of entries.

When we do "--all --objects" we know in advance we may need to hash
all objects. Just prepare the hash table big enough, so there won't be
any resizing later on. The hash table is resized a couple times before
prehash_objects() is called. But that's ok because there aren't many
objects by that time (unless you have tons of refs, likely tags..)

On linux-2.6.git:

        before       after
real    0m34.402s    0m33.288s
user    0m34.111s    0m32.863s
sys     0m0.205s     0m0.352s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 object.c   | 21 +++++++++++++++++++--
 object.h   |  2 ++
 revision.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+----
 3 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/object.c b/object.c
index 20703f5..bcfd2c6 100644
--- a/object.c
+++ b/object.c
@@ -88,10 +88,10 @@ struct object *lookup_object(const unsigned char *s=
ha1)
 	return obj;
 }
=20
-static void grow_object_hash(void)
+void grow_object_hash_to(unsigned long nr)
 {
 	int i;
-	int new_hash_size =3D obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	int new_hash_size =3D nr < 32 ? 32 : nr * 2;
 	struct object **new_hash;
=20
 	new_hash =3D xcalloc(new_hash_size, sizeof(struct object *));
@@ -106,6 +106,11 @@ static void grow_object_hash(void)
 	obj_hash_size =3D new_hash_size;
 }
=20
+static void grow_object_hash(void)
+{
+	grow_object_hash_to(obj_hash_size);
+}
+
 void *create_object(const unsigned char *sha1, int type, void *o)
 {
 	struct object *obj =3D o;
@@ -307,3 +312,15 @@ void clear_object_flags(unsigned flags)
 			obj->flags &=3D ~flags;
 	}
 }
+
+int has_object_flags(unsigned flags)
+{
+	int i;
+
+	for (i =3D 0; i < obj_hash_size; i++) {
+		struct object *obj =3D obj_hash[i];
+		if (obj && (obj->flags & flags))
+			return 1;
+	}
+	return 0;
+}
diff --git a/object.h b/object.h
index 97d384b..1e8fee8 100644
--- a/object.h
+++ b/object.h
@@ -52,6 +52,7 @@ extern struct object *get_indexed_object(unsigned int=
);
  */
 struct object *lookup_object(const unsigned char *sha1);
=20
+extern void grow_object_hash_to(unsigned long nr);
 extern void *create_object(const unsigned char *sha1, int type, void *=
obj);
=20
 /*
@@ -87,6 +88,7 @@ void add_object_array(struct object *obj, const char =
*name, struct object_array
 void add_object_array_with_mode(struct object *obj, const char *name, =
struct object_array *array, unsigned mode);
 void object_array_remove_duplicates(struct object_array *);
=20
+int has_object_flags(unsigned flags);
 void clear_object_flags(unsigned flags);
=20
 #endif /* OBJECT_H */
diff --git a/revision.c b/revision.c
index 71e62d8..f9ea2d1 100644
--- a/revision.c
+++ b/revision.c
@@ -1665,8 +1665,9 @@ static int for_each_good_bisect_ref(const char *s=
ubmodule, each_ref_fn fn, void
 }
=20
 static int handle_revision_pseudo_opt(const char *submodule,
-				struct rev_info *revs,
-				int argc, const char **argv, int *flags)
+				      struct rev_info *revs,
+				      int argc, const char **argv,
+				      int *flags, int *all)
 {
 	const char *arg =3D argv[0];
 	const char *optarg;
@@ -1685,6 +1686,7 @@ static int handle_revision_pseudo_opt(const char =
*submodule,
 	if (!strcmp(arg, "--all")) {
 		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
 		handle_refs(submodule, revs, *flags, head_ref_submodule);
+		*all =3D 1;
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
 	} else if (!strcmp(arg, "--bisect")) {
@@ -1738,6 +1740,49 @@ static int handle_revision_pseudo_opt(const char=
 *submodule,
 	return 1;
 }
=20
+static void preallocate_hash_table(void)
+{
+	unsigned long cnt =3D 0;
+	struct packed_git *p;
+	int i;
+
+	if (has_object_flags(UNINTERESTING))
+		/*
+		 * nope this is not simply "--all --objects"
+		 * not worth preallocation.
+		 */
+		return;
+
+	for (i =3D 0; i < 256; i++) {
+		struct dirent *ent;
+		DIR *d =3D opendir(git_path("objects/%02x", i));
+		if (!d)
+			continue;
+		while ((ent =3D readdir(d)) !=3D NULL)
+			/*
+			 * We only worry about insufficient size which
+			 * leads to expensive growths later on. A few
+			 * extra slots in the hash table would not hurt.
+			 */
+			cnt++;
+		closedir(d);
+	}
+
+	if (!packed_git)
+		prepare_packed_git();
+
+	for (p =3D packed_git; p; p =3D p->next) {
+		if (!p->pack_local)
+			/* this may lead to extra growths later */
+			continue;
+		if (open_pack_index(p))
+			continue;
+		cnt +=3D p->num_objects;
+	}
+
+	grow_object_hash_to(cnt);
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -1750,6 +1795,7 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg =3D 0=
, revarg_opt;
 	struct cmdline_pathspec prune_data;
 	const char *submodule =3D NULL;
+	int all =3D 0;
=20
 	memset(&prune_data, 0, sizeof(prune_data));
 	if (opt)
@@ -1785,8 +1831,9 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 			int opts;
=20
 			opts =3D handle_revision_pseudo_opt(submodule,
-						revs, argc - i, argv + i,
-						&flags);
+							  revs, argc - i,
+							  argv + i,
+							  &flags, &all);
 			if (opts > 0) {
 				i +=3D opts - 1;
 				continue;
@@ -1856,6 +1903,10 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, struct s
 			      get_pathspec(revs->prefix, prune_data.path));
 	}
=20
+	if (all && revs->tag_objects &&
+	    revs->tree_objects && revs->blob_objects)
+		preallocate_hash_table();
+
 	if (revs->def =3D=3D NULL)
 		revs->def =3D opt ? opt->def : NULL;
 	if (opt && opt->tweak)
--=20
1.8.2.83.gc99314b
