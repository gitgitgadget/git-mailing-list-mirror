From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/21] unpack-objects: decode v4 trees
Date: Wed, 11 Sep 2013 13:06:19 +0700
Message-ID: <1378879582-15372-19-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdc5-0007ca-EX
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab3IKGJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:09:12 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:59732 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab3IKGJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:09:11 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so8507962pbc.8
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cUqG7tJ/UW/MwreZIBkzrpFvRFAXHeihY7XxUongGXQ=;
        b=igMdYG7vm6ue8NxlcBGfC6c+DMf7PRwQDr2KqpEWtBRVlYR2IsPs4AxI34dahIP9af
         fiRs4hO+IHMIbwhmyQRREfpfn0AK0rnneeEm7uAvQDXxVs/KioVKkJymD/K+1D7SsQ+L
         OiLXW0sp5vGZrGvbrK5umaaJ2f3TjS2TTbjy2g+TmhKY/X7oA77Hc1Il8BmRXXIvO2Po
         /zRK3uGW3UaETX2HvfXDV449lC2Xc9iC/6BPgScK9tfjmgQ3HVgJgG3HmzBR4I6crSD+
         KfsdHwFaFPGcjpOYWpWNdXbxuqaNuQObjSmxkKUdiP48ZFsIYkMD3QOiLawe918P497C
         Yw8w==
X-Received: by 10.66.171.204 with SMTP id aw12mr1733568pac.7.1378879751085;
        Tue, 10 Sep 2013 23:09:11 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id in2sm27432945pbc.37.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:09:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:09:00 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234542>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/unpack-objects.c | 191 +++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 189 insertions(+), 2 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 044a087..9fd5640 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -12,6 +12,7 @@
 #include "decorate.h"
 #include "packv4-parse.h"
 #include "fsck.h"
+#include "varint.h"
=20
 static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] =3D "git unpack-objects [-n] [-q] [-r=
] [--strict] < pack-file";
@@ -148,6 +149,27 @@ static const unsigned char *read_sha1ref(void)
 	return sha1_table + index * 20;
 }
=20
+static void check_against_sha1table(const unsigned char *sha1)
+{
+	const unsigned char *found;
+	if (!packv4)
+		return;
+
+	found =3D bsearch(sha1, sha1_table, nr_objects, 20,
+			(int (*)(const void *, const void *))hashcmp);
+	if (!found)
+		die(_("object %s not found in SHA-1 table"),
+		    sha1_to_hex(sha1));
+}
+
+static const unsigned char *read_sha1table_ref(void)
+{
+	const unsigned char *sha1 =3D read_sha1ref();
+	if (sha1 < sha1_table || sha1 >=3D sha1_table + nr_objects * 20)
+		check_against_sha1table(sha1);
+	return sha1;
+}
+
 static const unsigned char *read_dictref(struct packv4_dict *dict)
 {
 	unsigned int index =3D read_varint();
@@ -327,6 +349,84 @@ static void write_object(unsigned nr, enum object_=
type type,
 	}
 }
=20
+static void resolve_tree_v4(unsigned long nr_obj,
+			    const void *tree,
+			    unsigned long tree_len,
+			    const unsigned char *base_sha1,
+			    const void *base,
+			    unsigned long base_size)
+{
+	int nr;
+	struct strbuf sb =3D STRBUF_INIT;
+	const unsigned char *p =3D tree;
+	const unsigned char *end =3D p + tree_len;
+
+	nr =3D decode_varint(&p);
+	while (nr > 0 && p < end) {
+		unsigned int copy_start_or_path =3D decode_varint(&p);
+		if (copy_start_or_path & 1) { /* copy_start */
+			struct tree_desc desc;
+			struct name_entry entry;
+			unsigned int copy_count =3D decode_varint(&p);
+			unsigned int copy_start =3D copy_start_or_path >> 1;
+			if (!base_sha1)
+				die("we are not supposed to copy from another tree!");
+			if (copy_count & 1) { /* first delta */
+				unsigned int id =3D decode_varint(&p);
+				const unsigned char *last_base;
+				if (!id) {
+					last_base =3D p;
+					p +=3D 20;
+				} else
+					last_base =3D sha1_table + (id - 1) * 20;
+				if (hashcmp(last_base, base_sha1))
+					die("bad base tree in resolve_tree_v4");
+			}
+
+			copy_count >>=3D 1;
+			nr -=3D copy_count;
+
+			init_tree_desc(&desc, base, base_size);
+			while (tree_entry(&desc, &entry)) {
+				if (copy_start)
+					copy_start--;
+				else if (copy_count) {
+					strbuf_addf(&sb, "%o %s%c",
+						    entry.mode, entry.path, '\0');
+					strbuf_add(&sb, entry.sha1, 20);
+					copy_count--;
+				} else
+					break;
+			}
+		} else {	/* path */
+			unsigned int path_idx =3D copy_start_or_path >> 1;
+			const unsigned char *path;
+			unsigned mode;
+			unsigned int id;
+			const unsigned char *entry_sha1;
+
+			id =3D decode_varint(&p);
+			if (!id) {
+				entry_sha1 =3D p;
+				p +=3D 20;
+			} else
+				entry_sha1 =3D sha1_table + (id - 1) * 20;
+			nr--;
+
+			path =3D path_dict->data + path_dict->offsets[path_idx];
+			mode =3D (path[0] << 8) | path[1];
+			strbuf_addf(&sb, "%o %s%c", mode, path+2, '\0');
+			strbuf_add(&sb, entry_sha1, 20);
+		}
+	}
+	if (nr !=3D 0 || p !=3D end)
+		die(_("bad delta tree"));
+	if (!dry_run)
+		write_object(nr_obj, OBJ_TREE, sb.buf, sb.len);
+	else
+		strbuf_release(&sb);
+}
+
 static void resolve_delta(unsigned nr, enum object_type type,
 			  void *base, unsigned long base_size,
 			  void *delta, unsigned long delta_size)
@@ -358,8 +458,13 @@ static void added_object(unsigned nr, enum object_=
type type,
 		    info->base_offset =3D=3D obj_list[nr].offset) {
 			*p =3D info->next;
 			p =3D &delta_list;
-			resolve_delta(info->nr, type, data, size,
-				      info->delta, info->size);
+			if (type =3D=3D OBJ_TREE && packv4)
+				resolve_tree_v4(info->nr, info->delta,
+						info->size, info->base_sha1,
+						data, size);
+			else
+				resolve_delta(info->nr, type, data, size,
+					      info->delta, info->size);
 			free(info);
 			continue;
 		}
@@ -493,6 +598,85 @@ static void unpack_delta_entry(enum object_type ty=
pe, unsigned long delta_size,
 	free(base);
 }
=20
+static int resolve_tree_against_held(unsigned nr, const unsigned char =
*base,
+				     void *delta_data, unsigned long delta_size)
+{
+	struct object *obj;
+	struct obj_buffer *obj_buffer;
+	obj =3D lookup_object(base);
+	if (!obj || obj->type !=3D OBJ_TREE)
+		return 0;
+	obj_buffer =3D lookup_object_buffer(obj);
+	if (!obj_buffer)
+		return 0;
+	resolve_tree_v4(nr, delta_data, delta_size,
+			base, obj_buffer->buffer, obj_buffer->size);
+	return 1;
+}
+
+static void unpack_tree_v4(unsigned long size, unsigned long nr_obj)
+{
+	unsigned int nr;
+	const unsigned char *last_base =3D NULL;
+
+	copy_back_buffer(1);
+	strbuf_reset(&back_buffer);
+	nr =3D read_varint();
+	while (nr) {
+		unsigned int copy_start_or_path =3D read_varint();
+		if (copy_start_or_path & 1) { /* copy_start */
+			unsigned int copy_count =3D read_varint();
+			if (copy_count & 1) { /* first delta */
+				const unsigned char *old_base =3D last_base;
+				last_base =3D read_sha1table_ref();
+				if (old_base && hashcmp(last_base, old_base))
+					die("multi-base trees are not supported");
+			} else if (!last_base)
+				die("missing delta base unpack_tree_v4 at %lu",
+				    (unsigned long)consumed_bytes);
+			copy_count >>=3D 1;
+			if (!copy_count || copy_count > nr)
+				die("bad copy count index in unpack_tree_v4 at %lu",
+				    (unsigned long)consumed_bytes);
+			nr -=3D copy_count;
+		} else {	/* path */
+			unsigned int path_idx =3D copy_start_or_path >> 1;
+			if (path_idx >=3D path_dict->nb_entries)
+				die("bad path index in unpack_tree_v4 at %lu",
+				    (unsigned long)consumed_bytes);
+			read_sha1ref();
+			nr--;
+		}
+	}
+	copy_back_buffer(0);
+
+	if (last_base) {
+		if (has_sha1_file(last_base)) {
+			enum object_type type;
+			unsigned long base_size;
+			void *base =3D read_sha1_file(last_base, &type, &base_size);
+			if (type !=3D OBJ_TREE) {
+				die("base tree %s is not a tree", sha1_to_hex(last_base));
+				last_base =3D NULL;
+			}
+			resolve_tree_v4(nr_obj, back_buffer.buf, back_buffer.len,
+					last_base, base, base_size);
+			free(base);
+		} else if (resolve_tree_against_held(nr_obj, last_base,
+						     back_buffer.buf, back_buffer.len))
+			   ; /* resolved */
+		else {
+			unsigned long delta_size =3D back_buffer.len;
+			char *delta =3D strbuf_detach(&back_buffer, NULL);
+			/* cannot resolve yet --- queue it */
+			hashcpy(obj_list[nr].sha1, null_sha1);
+			add_delta_to_list(nr, last_base, 0, delta, delta_size);
+		}
+	} else
+		resolve_tree_v4(nr_obj, back_buffer.buf, back_buffer.len, NULL, NULL=
, 0);
+	strbuf_release(&back_buffer);
+}
+
 static void unpack_commit_v4(unsigned long size, unsigned long nr)
 {
 	unsigned int nb_parents;
@@ -588,6 +772,9 @@ static int unpack_one(unsigned nr)
 	case OBJ_PV4_COMMIT:
 		unpack_commit_v4(size, nr);
 		break;
+	case OBJ_PV4_TREE:
+		unpack_tree_v4(size, nr);
+		break;
 	default:
 		error("bad object type %d", type);
 		has_errors =3D 1;
--=20
1.8.2.82.gc24b958
