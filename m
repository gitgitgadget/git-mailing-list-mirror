From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/32] split-index: the writing part
Date: Mon, 28 Apr 2014 17:55:42 +0700
Message-ID: <1398682553-11634-22-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:56:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejEh-00030A-DL
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbaD1K42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:28 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:45945 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420AbaD1K4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:25 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so5677232pab.13
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sdy18INTaMxETgh7G1gKSHNE07GJEFWm62voy/7/EiU=;
        b=uc4HfvF0+x/pqzh77iqV+SDXc2CZnecqBj2/zM4Rh8Kjdix6Ixv+Sg/d7uf3S76YQL
         qzdOi2bxRXv7pcm0xyEhlnHGHqtsAolYGixLGP6IQP2bzxJhr3V4aw3MQhL6SwPAaPVm
         AsQ+Xb1j4ZEUG5dRdhXf6+nxwBhWuSlRaMP6WMUO7Oq1YXnC9KlLKe4KrhZ0QUydH0GT
         eKXNg/FgnZuO39ovfmoLlMIF5oUkJnakGgSfauuZGiRDvHrNVM4mVWoNdJDAeDRvar4i
         8KAOm5kP0rOVN4S3fkL+60mexnazJihxZDcrftK6OimrMbHoyxyjDeW9adlCzC+au8F8
         SY4w==
X-Received: by 10.66.254.234 with SMTP id al10mr3017132pad.137.1398682584956;
        Mon, 28 Apr 2014 03:56:24 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id av2sm34236248pbc.16.2014.04.28.03.56.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:52 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247285>

prepare_to_write_split_index() does the major work, classifying
deleted, updated and added entries. write_link_extension() then just
writes it down.

An observation is, deleting an entry, then adding it back is recorded
as "entry X is deleted, entry X is added", not "entry X is replaced".
This is simpler, with small overhead: a replaced entry is stored
without its path, a new entry is store with its path.

A note about unpack_trees() and the deduplication code inside
prepare_to_write_split_index(). Usually tracking updated/removed
entries via read-cache API is enough. unpack_trees() manipulates the
index in a different way: it throws the entire source index out,
builds up a new one, copying/duplicating entries (using dup_entry)
from the source index over if necessary, then returns the new index.

A naive solution would be marking the entire source index "deleted"
and add their duplicates as new. That could bring $GIT_DIR/index back
to the original size. So we try harder and memcmp() between the
original and the duplicate to see if it needs updating.

We could avoid memcmp() too, by avoiding duplicating the original
entry in dup_entry(). The performance gain this way is within noise
level and it complicates unpack-trees.c. So memcmp() is the preferred
way to deal with deduplication.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 split-index.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 split-index.h |   4 +++
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/split-index.c b/split-index.c
index b36c73b..5708807 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "split-index.h"
+#include "ewah/ewok.h"
=20
 struct split_index *init_split_index(struct index_state *istate)
 {
@@ -26,11 +27,22 @@ int read_link_extension(struct index_state *istate,
 	return 0;
 }
=20
+static int write_strbuf(void *user_data, const void *data, size_t len)
+{
+	struct strbuf *sb =3D user_data;
+	strbuf_add(sb, data, len);
+	return len;
+}
+
 int write_link_extension(struct strbuf *sb,
 			 struct index_state *istate)
 {
 	struct split_index *si =3D istate->split_index;
 	strbuf_add(sb, si->base_sha1, 20);
+	if (!si->delete_bitmap && !si->replace_bitmap)
+		return 0;
+	ewah_serialize_to(si->delete_bitmap, write_strbuf, sb);
+	ewah_serialize_to(si->replace_bitmap, write_strbuf, sb);
 	return 0;
 }
=20
@@ -62,14 +74,99 @@ void merge_base_index(struct index_state *istate)
 void prepare_to_write_split_index(struct index_state *istate)
 {
 	struct split_index *si =3D init_split_index(istate);
-	/* take cache[] out temporarily */
+	struct cache_entry **entries =3D NULL, *ce;
+	int i, nr_entries =3D 0, nr_alloc =3D 0;
+
+	si->delete_bitmap =3D ewah_new();
+	si->replace_bitmap =3D ewah_new();
+
+	if (si->base) {
+		/* Go through istate->cache[] and mark CE_MATCHED to
+		 * entry with positive index. We'll go through
+		 * base->cache[] later to delete all entries in base
+		 * that are not marked eith either CE_MATCHED or
+		 * CE_UPDATE_IN_BASE. If istate->cache[i] is a
+		 * duplicate, deduplicate it.
+		 */
+		for (i =3D 0; i < istate->cache_nr; i++) {
+			struct cache_entry *base;
+			/* namelen is checked separately */
+			const unsigned int ondisk_flags =3D
+				CE_STAGEMASK | CE_VALID | CE_EXTENDED_FLAGS;
+			unsigned int ce_flags, base_flags, ret;
+			ce =3D istate->cache[i];
+			if (!ce->index)
+				continue;
+			if (ce->index > si->base->cache_nr) {
+				ce->index =3D 0;
+				continue;
+			}
+			ce->ce_flags |=3D CE_MATCHED; /* or "shared" */
+			base =3D si->base->cache[ce->index - 1];
+			if (ce =3D=3D base)
+				continue;
+			if (ce->ce_namelen !=3D base->ce_namelen ||
+			    strcmp(ce->name, base->name)) {
+				ce->index =3D 0;
+				continue;
+			}
+			ce_flags =3D ce->ce_flags;
+			base_flags =3D base->ce_flags;
+			/* only on-disk flags matter */
+			ce->ce_flags   &=3D ondisk_flags;
+			base->ce_flags &=3D ondisk_flags;
+			ret =3D memcmp(&ce->ce_stat_data, &base->ce_stat_data,
+				     offsetof(struct cache_entry, name) -
+				     offsetof(struct cache_entry, ce_stat_data));
+			ce->ce_flags =3D ce_flags;
+			base->ce_flags =3D base_flags;
+			if (ret)
+				ce->ce_flags |=3D CE_UPDATE_IN_BASE;
+			free(base);
+			si->base->cache[ce->index - 1] =3D ce;
+		}
+		for (i =3D 0; i < si->base->cache_nr; i++) {
+			ce =3D si->base->cache[i];
+			if ((ce->ce_flags & CE_REMOVE) ||
+			    !(ce->ce_flags & CE_MATCHED))
+				ewah_set(si->delete_bitmap, i);
+			else if (ce->ce_flags & CE_UPDATE_IN_BASE) {
+				ewah_set(si->replace_bitmap, i);
+				ALLOC_GROW(entries, nr_entries+1, nr_alloc);
+				entries[nr_entries++] =3D ce;
+			}
+		}
+	}
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		ce =3D istate->cache[i];
+		if ((!si->base || !ce->index) && !(ce->ce_flags & CE_REMOVE)) {
+			ALLOC_GROW(entries, nr_entries+1, nr_alloc);
+			entries[nr_entries++] =3D ce;
+		}
+		ce->ce_flags &=3D ~CE_MATCHED;
+	}
+
+	/*
+	 * take cache[] out temporarily, put entries[] in its place
+	 * for writing
+	 */
+	si->saved_cache =3D istate->cache;
 	si->saved_cache_nr =3D istate->cache_nr;
-	istate->cache_nr =3D 0;
+	istate->cache =3D entries;
+	istate->cache_nr =3D nr_entries;
 }
=20
 void finish_writing_split_index(struct index_state *istate)
 {
 	struct split_index *si =3D init_split_index(istate);
+
+	ewah_free(si->delete_bitmap);
+	ewah_free(si->replace_bitmap);
+	si->delete_bitmap =3D NULL;
+	si->replace_bitmap =3D NULL;
+	free(istate->cache);
+	istate->cache =3D si->saved_cache;
 	istate->cache_nr =3D si->saved_cache_nr;
 }
=20
diff --git a/split-index.h b/split-index.h
index 812e510..53b778f 100644
--- a/split-index.h
+++ b/split-index.h
@@ -3,10 +3,14 @@
=20
 struct index_state;
 struct strbuf;
+struct ewah_bitmap;
=20
 struct split_index {
 	unsigned char base_sha1[20];
 	struct index_state *base;
+	struct ewah_bitmap *delete_bitmap;
+	struct ewah_bitmap *replace_bitmap;
+	struct cache_entry **saved_cache;
 	unsigned int saved_cache_nr;
 	int refcount;
 };
--=20
1.9.1.346.ga2b5940
