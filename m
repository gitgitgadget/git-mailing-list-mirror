From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/16] unpack_trees(): add support for narrow checkout
Date: Sun, 14 Sep 2008 20:08:00 +0700
Message-ID: <1221397685-27715-12-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:10:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerNI-00060e-56
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbYINNJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbYINNJj
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:09:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:58446 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbYINNJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:09:38 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1704584rvb.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JFEFOOlT1o+ZYPDpKsX1MkYAZg+pqrcZsH/woKxjedE=;
        b=Odmql7D5CG3Jj5j0pLEUkcGkd45RrepTSzRauMNEUb+tWgJxgdI/1YJK5b82ZddDxk
         Z2frd4hl2nCG2Vx4xaeqJbtUe52Bkl3Kb9tiTK+kBMpw6ha5HbtIlDgkaM/vjqhcKaEk
         4loGcF28rJsRffBO07Z0iyd4GnIDqGIitL1lE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OTgIEhFeh+RMLYA9DCeF3M3w8ife1lsa3GkNjAwkzTOUKe0UeET6hQIir9XwapP5Fj
         KPjgpgcXbG2lnROagqdynMaM5H7vpDOaoy4WU79yqeuxzaMunh0iZ+0VTNluwNXkf3cG
         VPiSwVCVB585Y4KLNMwSNN/hIwUhh7SmrhoAg=
Received: by 10.143.1.12 with SMTP id d12mr2249056wfi.297.1221397777480;
        Sun, 14 Sep 2008 06:09:37 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 24sm20034823wff.17.2008.09.14.06.09.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:09:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:09:28 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-11-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95838>

This patch teaches unpack_trees() to checkout/remove entries
on working directories appropriately when narrow area is
changed. There are three kind of changes:

 - new_narrow_path: reset workdir to a new narrow checkout
 - add_narrow_path: keep current narrow areas and add more entries
 - remove_narrow_path: remove some entries from current narrow areas

A simple "narrow spec" is introduced to specify what entries is in
narrow area. For now it is just a list of prefix separated by colon.

CE_WD_REMOVE is introduced to remove entries from working directories,
but still keep them in index

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        |    3 ++
 unpack-trees.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.h |    6 +++
 3 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 2b2c90f..1fc0f83 100644
--- a/cache.h
+++ b/cache.h
@@ -167,6 +167,9 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+/* Only remove in work directory, not index */
+#define CE_WD_REMOVE (0x400000)
+
 /*
  * Extended on-disk flags
  */
diff --git a/unpack-trees.c b/unpack-trees.c
index e59d144..968cc98 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -96,6 +96,15 @@ static int check_updates(struct unpack_trees_options=
 *o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
+
+			if (ce->ce_flags & CE_WD_REMOVE) {
+				total++;
+				continue;
+			}
+
+			if (ce_no_checkout(ce))
+				continue;
+
 			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
 				total++;
 		}
@@ -108,6 +117,16 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
+		if (ce->ce_flags & CE_WD_REMOVE) {
+			display_progress(progress, ++cnt);
+			if (o->update)
+				unlink_entry(ce);
+			continue;
+		}
+
+		if (ce_no_checkout(ce))
+			continue;
+
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
@@ -121,6 +140,9 @@ static int check_updates(struct unpack_trees_option=
s *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
+		if (ce_no_checkout(ce))
+			continue;
+
 		if (ce->ce_flags & CE_UPDATE) {
 			display_progress(progress, ++cnt);
 			ce->ce_flags &=3D ~CE_UPDATE;
@@ -133,6 +155,47 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	return errs !=3D 0;
 }
=20
+static int verify_uptodate(struct cache_entry *ce, struct unpack_trees=
_options *o);
+static int apply_narrow_checkout(struct unpack_trees_options *o)
+{
+	struct index_state *index =3D &o->result;
+	int i;
+
+	if (!(o->new_narrow_path | o->add_narrow_path | o->remove_narrow_path=
))
+		return 0;
+
+	for (i =3D 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce =3D index->cache[i];
+		int was_checkout =3D ce_checkout(ce);
+		int match =3D match_narrow_spec(o->narrow_spec, ce->name, o->narrow_=
prefix);
+
+		if (ce_stage(ce))
+			continue;
+
+		if (o->new_narrow_path) {
+			if (match)
+				ce_mark_checkout(ce);
+			else
+				ce_mark_no_checkout(ce);
+		}
+
+		if (o->add_narrow_path && match)
+			ce_mark_checkout(ce);
+
+		if (o->remove_narrow_path && match)
+			ce_mark_no_checkout(ce);
+
+		if (was_checkout && ce_no_checkout(ce)) {
+			if (verify_uptodate(ce, o))
+				return -1;
+			ce->ce_flags |=3D CE_WD_REMOVE;
+		}
+		if (!was_checkout && ce_checkout(ce))
+			ce->ce_flags |=3D CE_UPDATE;
+	}
+	return 0;
+}
+
 static inline int call_unpack_fn(struct cache_entry **src, struct unpa=
ck_trees_options *o)
 {
 	int ret =3D o->fn(src, o);
@@ -409,6 +472,9 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
=20
+	if (apply_narrow_checkout(o))
+		return unpack_failed(o, NULL);
+
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -677,6 +743,8 @@ static int merged_entry(struct cache_entry *merge, =
struct cache_entry *old,
 				return -1;
 			invalidate_ce_path(old, o);
 		}
+		if (ce_no_checkout(old))
+			update |=3D CE_NO_CHECKOUT;
 	}
 	else {
 		if (verify_absent(merge, "overwritten", o))
@@ -726,6 +794,38 @@ static void show_stage_entry(FILE *o,
 }
 #endif
=20
+int match_narrow_spec(const char *spec_, const char *path, const char =
*prefix)
+{
+	int match =3D 0;
+	char *spec, *cur_spec;
+	int prefix_len =3D 0;
+
+	if (!spec_)
+		return 1; /* always match if spec_ is NULL */
+	if (prefix) {
+		if (prefixcmp(path, prefix))
+			return 0;
+		prefix_len =3D strlen(prefix);
+	}
+
+	spec =3D cur_spec =3D xstrdup(spec_);
+
+	while (!match) {
+		char *next_spec =3D strchr(cur_spec, ':');
+		if (next_spec)
+			*next_spec =3D '\0';
+
+		if (!fnmatch(cur_spec, path+prefix_len, 0))
+			match =3D 1;
+
+		if (!next_spec)
+			break;
+		cur_spec =3D next_spec+1;
+	}
+	free(spec);
+	return match;
+}
+
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o)
 {
 	struct cache_entry *index;
diff --git a/unpack-trees.h b/unpack-trees.h
index 0d26f3d..942a007 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -27,6 +27,9 @@ struct unpack_trees_options {
 		     aggressive:1,
 		     skip_unmerged:1,
 		     initial_checkout:1,
+		     new_narrow_path:1,
+		     add_narrow_path:2,
+		     remove_narrow_path:2,
 		     gently:1;
 	const char *prefix;
 	int pos;
@@ -38,6 +41,8 @@ struct unpack_trees_options {
 	int merge_size;
=20
 	struct cache_entry *df_conflict_entry;
+	const char *narrow_spec;
+	const char *narrow_prefix;
 	void *unpack_data;
=20
 	struct index_state *dst_index;
@@ -48,6 +53,7 @@ struct unpack_trees_options {
 extern int unpack_trees(unsigned n, struct tree_desc *t,
 		struct unpack_trees_options *options);
=20
+int match_narrow_spec(const char *spec_, const char *path, const char =
*prefix);
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o);
 int twoway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o);
 int bind_merge(struct cache_entry **src, struct unpack_trees_options *=
o);
--=20
1.6.0.96.g2fad1.dirty
