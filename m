From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/9] pv4_tree_desc: avoid lookup_object() when possible
Date: Wed,  9 Oct 2013 21:46:15 +0700
Message-ID: <1381329976-32082-9-git-send-email-pclouds@gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:43:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuzJ-0007dY-EM
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695Ab3JIOnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:43:42 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:45457 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689Ab3JIOnl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:43:41 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so989438pbc.39
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LW7teq6+DP8IMRWtJZYrC2yf/pQob794I/VEydD82Ac=;
        b=CAXIm2YUTlc/0S12z1h10rIb7HFPPRrWRQtFJscBbbzCep1Pzz2e7RIHVyWaLZrl7A
         q7+goTfLaqhaqAZW+PKQpw6PPoiiCTWwBe5nzS7kK+Bp/tBaQqfDPThFhSQMk5k11nKx
         4SopJI2fuNLZP3Bp52RjhNdbyx+Hw/DWmImMLL34zLznR57jb/b+caD5a1YEuB4dhZvu
         cRmNKynIyv50qxdnPUdqlxaYYkfaJyBHrYCMYiqBN9Y/jF10w5bvlTTsjfkC5YtI2k7C
         M1j2Xw36VTE9FwpfGeVvk3unH4h48wP7c9waDG10FDF2mAq4yuXDmkaRM2wg7EUTY7HA
         tNDQ==
X-Received: by 10.66.25.133 with SMTP id c5mr9914994pag.4.1381329821193;
        Wed, 09 Oct 2013 07:43:41 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id os4sm47057405pbb.25.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:43:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:47:24 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235822>

pv4_tree_desc_from_entry() cuts out SHA-1 index lookups when
possible. This patch provides a new set of lookup functions that avoid
looking up object hash table.

We maintain an object pointer array and use SHA-1 table as
key. Because we know index in SHA-1 table in v4 trees, we can skip
binary search and go straight to the object.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        |  1 +
 packv4-parse.c | 33 +++++++++++++++++++++++++++++++++
 packv4-parse.h | 12 ++++++++++++
 sha1_file.c    |  1 +
 4 files changed, 47 insertions(+)

diff --git a/cache.h b/cache.h
index 5028ded..da65063 100644
--- a/cache.h
+++ b/cache.h
@@ -1035,6 +1035,7 @@ extern struct packed_git {
 	struct packv4_dict *ident_dict;
 	off_t ident_dict_end;
 	struct packv4_dict *path_dict;
+	struct object **objs;
 	time_t mtime;
 	int pack_fd;
 	unsigned pack_local:1,
diff --git a/packv4-parse.c b/packv4-parse.c
index 4354ee3..6f6152c 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -11,6 +11,10 @@
 #include "cache.h"
 #include "packv4-parse.h"
 #include "varint.h"
+#include "commit.h"
+#include "tree.h"
+#include "blob.h"
+#include "tag.h"
=20
 int packv4_available;
=20
@@ -815,3 +819,32 @@ int pv4_tree_entry(struct pv4_tree_desc *desc)
 	}
 	return !decode_entries(desc, desc->obj_offset, desc->start++, 1);
 }
+
+static struct object **get_packed_objs(struct pv4_tree_desc *desc)
+{
+	if (!desc->p || !desc->sha1_index)
+		return NULL;
+	if (desc->p->version >=3D 4 && !desc->p->objs)
+		desc->p->objs =3D
+			xmalloc(sizeof(struct object *) * desc->p->num_objects);
+	return desc->p->objs;
+}
+
+#define DEFINE_LOOKUP(TYPE)					\
+struct TYPE *pv4_lookup_##TYPE(struct pv4_tree_desc *desc)	\
+{								\
+	struct object **objs =3D get_packed_objs(desc);		\
+	if (!objs)						\
+		return lookup_##TYPE(desc->v2.entry.sha1);	\
+	objs +=3D desc->sha1_index - 1;				\
+	if (!*objs)						\
+		*objs =3D (struct object *)			\
+			lookup_##TYPE(desc->v2.entry.sha1);	\
+	return (struct TYPE *)objs[0];				\
+}
+
+DEFINE_LOOKUP(object)
+DEFINE_LOOKUP(commit)
+DEFINE_LOOKUP(tree)
+DEFINE_LOOKUP(blob)
+DEFINE_LOOKUP(tag)
diff --git a/packv4-parse.h b/packv4-parse.h
index 874f57c..3bf69bc 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -3,6 +3,12 @@
=20
 #include "tree-walk.h"
=20
+struct object;
+struct commit;
+struct tree;
+struct blob;
+struct tag;
+
 struct packv4_dict {
 	const unsigned char *data;
 	unsigned int nb_entries;
@@ -58,4 +64,10 @@ void pv4_release_tree_desc(struct pv4_tree_desc *des=
c);
=20
 int pv4_tree_entry(struct pv4_tree_desc *desc);
=20
+struct object *pv4_lookup_object(struct pv4_tree_desc *desc);
+struct commit *pv4_lookup_commit(struct pv4_tree_desc *desc);
+struct tree   *pv4_lookup_tree(struct pv4_tree_desc *desc);
+struct blob   *pv4_lookup_blob(struct pv4_tree_desc *desc);
+struct tag    *pv4_lookup_tag(struct pv4_tree_desc *desc);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 4744132..88a6273 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -773,6 +773,7 @@ void free_pack_by_name(const char *pack_name)
 			*pp =3D p->next;
 			if (last_found_pack =3D=3D p)
 				last_found_pack =3D NULL;
+			free(p->objs);
 			free(p);
 			return;
 		}
--=20
1.8.2.83.gc99314b
