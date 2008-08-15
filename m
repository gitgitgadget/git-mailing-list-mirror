From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 6/9] Add support for narrow checkout in unpack_trees()
Date: Fri, 15 Aug 2008 21:26:38 +0700
Message-ID: <20080815142638.GA10736@laptop>
References: <cover.1218807249.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0Ha-0005hJ-B5
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758768AbYHOO05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758667AbYHOO05
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:26:57 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:28585 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758019AbYHOO0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:26:55 -0400
Received: by py-out-1112.google.com with SMTP id p76so869005pyb.10
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+kN52ol+XYQ1FXL6kZo1YtOOvdSYiECJQ9wPtUUlMAk=;
        b=Tkb/pUK7eQ2vBqhMPJ1Qrdv7pwamfRjXxvyw7LjRsBO4wiPey2f59ENDltPubGCPin
         dxgl4fA+KtzBw5v/PZ9dscieBqlbaDdqM4P+IBdYHO4FXXhcH+CMLoqKHR/8wyOIzS/l
         kRmpS8KQBesMfJLaw16ztXgs3ZukM1EUZgpgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sD3itMRYDanVXuZEqI4+0FE8X0WO5bLeBVbjfMYMhdPZ5/jPK9tURT7wlyEbnAJi6R
         IJ8LXxYtep3JLzhqOSUqZ221byBd9sDR4iRxXMs2bA+PZFm8thYoxvO0V9ESgyuZOP6U
         FLX/7mS8nkNO3hukIq1tOHFrRMkQ1PsJNLYFM=
Received: by 10.114.125.2 with SMTP id x2mr2558590wac.59.1218810414220;
        Fri, 15 Aug 2008 07:26:54 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id m29sm335284poh.4.2008.08.15.07.26.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:26:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:26:38 +0700
Content-Disposition: inline
In-Reply-To: <cover.1218807249.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92479>

This patch teaches unpack_trees() to checkout/remove entries
on working directories appropriately when narrow area is
changed. There are three kind of changes:

 - new_narrow_path: reset workdir to a new narrow checkout
 - add_narrow_path: keep current narrow areas and add more entries
 - remove_narrow_path: remove some entries from current narrow areas

CE_WD_REMOVE is introduced to remove entries from working directories,
but still keep them in index

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        |    3 ++
 unpack-trees.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.h |    4 ++
 3 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 86288b6..f502b28 100644
--- a/cache.h
+++ b/cache.h
@@ -139,6 +139,9 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+/* Only remove in work directory, not index */
+#define CE_WD_REMOVE (0x400000)
+
 /* "Assume unchanged" mask */
 #define CE_VALID_MASK (CE_VALID | CE_NO_CHECKOUT)
=20
diff --git a/unpack-trees.c b/unpack-trees.c
index cba0aca..022c643 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -96,6 +96,21 @@ static int check_updates(struct unpack_trees_options=
 *o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
+
+			/*
+			 * Special case: CE_WD_REMOVE may be set along with CE_NO_CHECKOUT
+			 * when some files are going to leave narrow checkout, so it must
+			 * go before ce_no_checkout() check
+			 */
+			if (ce->ce_flags & CE_WD_REMOVE) {
+				total++;
+				continue;
+			}
+
+			/* Now if there is any update outside narrow, ignore it */
+			if (ce_no_checkout(ce))
+				continue;
+
 			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
 				total++;
 		}
@@ -108,6 +123,18 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
+		/* As stated earlier, CE_WD_REMOVE must bypass ce_no_checkout() chec=
k */
+		if (ce->ce_flags & CE_WD_REMOVE) {
+			display_progress(progress, ++cnt);
+			if (o->update)
+				unlink_entry(ce);
+			continue;
+		}
+
+		/* Now if there is any update outside narrow, ignore it */
+		if (ce_no_checkout(ce))
+			continue;
+
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
@@ -121,6 +148,9 @@ static int check_updates(struct unpack_trees_option=
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
@@ -725,6 +755,58 @@ static void show_stage_entry(FILE *o,
 }
 #endif
=20
+int match_narrow_spec(const char *spec_, const char *path)
+{
+	int match =3D 0;
+	char *spec, *cur_spec;
+
+	if (!spec_)
+		return 1; /* always match if spec_ is NULL */
+	spec =3D cur_spec =3D xstrdup(spec_);
+
+	while (!match) {
+		char *next_spec =3D strchr(cur_spec, ':');
+		if (!next_spec) {
+			if (!fnmatch(cur_spec, path, 0))
+				match =3D 1;
+			break;
+		}
+		*next_spec =3D '\0';
+		if (!fnmatch(cur_spec, path, 0))
+			match =3D 1;
+		cur_spec =3D next_spec+1;
+	}
+	free(spec);
+	return match;
+}
+
+static int apply_narrow_checkout(struct cache_entry *ce, struct cache_=
entry *old_ce, struct unpack_trees_options *o)
+{
+	int checkout;
+	int was_no_checkout =3D old_ce && ce_no_checkout(old_ce);
+
+	if (!(o->new_narrow_path | o->add_narrow_path | o->remove_narrow_path=
))
+		return 0;
+
+	checkout =3D match_narrow_spec(o->narrow_spec, ce->name);
+
+	/*
+	 * The logic is a bit twisted here, when we expand checkout (add_narr=
ow_path)
+	 * we narrow no_checkout area. Similarly when we narrow checkout
+	 * (remove_narrow_path), we expand no_checkout area. So there are thr=
ee cases:
+	 *
+	 * [1] New narrow spec: do not care about old_ce
+	 * [2] Expand spec: mark no_checkout if no_checkout previously _and_ =
now too
+	 * [3] Narrow spec: mark no_checkout if previously no_checkout _or_ n=
ow checkout
+	 */
+	if ((o->new_narrow_path && !checkout) /* [1] */
+	    || (o->add_narrow_path && !checkout && was_no_checkout) /* [2] */
+	    || (o->remove_narrow_path && (checkout || was_no_checkout))) /* [=
3] */
+		ce_mark_no_checkout(ce);
+
+	return 1;
+}
+
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o)
 {
 	struct cache_entry *index;
@@ -899,6 +981,7 @@ int twoway_merge(struct cache_entry **src, struct u=
npack_trees_options *o)
 	struct cache_entry *current =3D src[0];
 	struct cache_entry *oldtree =3D src[1];
 	struct cache_entry *newtree =3D src[2];
+	int has_narrow_checkout =3D 0;
=20
 	if (o->merge_size !=3D 2)
 		return error("Cannot do a twoway merge of %d trees",
@@ -909,6 +992,9 @@ int twoway_merge(struct cache_entry **src, struct u=
npack_trees_options *o)
 	if (newtree =3D=3D o->df_conflict_entry)
 		newtree =3D NULL;
=20
+	if (newtree)
+		has_narrow_checkout =3D apply_narrow_checkout(newtree, current, o);
+
 	if (current) {
 		if ((!oldtree && !newtree) || /* 4 and 5 */
 		    (!oldtree && newtree &&
@@ -918,6 +1004,21 @@ int twoway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
 		    (oldtree && newtree &&
 		     !same(oldtree, newtree) && /* 18 and 19 */
 		     same(current, newtree))) {
+			if (has_narrow_checkout) {
+				/* enter narrow checkout, keep entry and add to workdir */
+				if (ce_no_checkout(current) && ce_checkout(newtree)) {
+					add_entry(o, current, CE_UPDATE, CE_NO_CHECKOUT);
+					return 1;
+				}
+
+				/* leave narrow checkout, keep entry and remove from workdir */
+				if (ce_checkout(current) && ce_no_checkout(newtree)) {
+					if (verify_uptodate(current, o))
+						return -1;
+					add_entry(o, current, CE_WD_REMOVE | CE_NO_CHECKOUT, 0);
+					return 1;
+				}
+			}
 			return keep_entry(current, o);
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
@@ -927,6 +1028,9 @@ int twoway_merge(struct cache_entry **src, struct =
unpack_trees_options *o)
 		else if (oldtree && newtree &&
 			 same(current, oldtree) && !same(current, newtree)) {
 			/* 20 or 21 */
+			/* enter narrow checkout, make sure always add  */
+			if (has_narrow_checkout && ce_no_checkout(current) && ce_checkout(n=
ewtree))
+				newtree->ce_flags |=3D CE_UPDATE;
 			return merged_entry(newtree, current, o);
 		}
 		else {
@@ -987,6 +1091,8 @@ int oneway_merge(struct cache_entry **src, struct =
unpack_trees_options *o)
 	if (!a)
 		return deleted_entry(old, old, o);
=20
+	apply_narrow_checkout(a, NULL, o);
+
 	if (old && same(old, a)) {
 		int update =3D 0;
 		if (o->reset) {
diff --git a/unpack-trees.h b/unpack-trees.h
index 94e5672..880cef8 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -26,6 +26,9 @@ struct unpack_trees_options {
 		     verbose_update:1,
 		     aggressive:1,
 		     skip_unmerged:1,
+		     new_narrow_path:1,
+		     add_narrow_path:2,
+		     remove_narrow_path:2,
 		     gently:1;
 	const char *prefix;
 	int pos;
@@ -37,6 +40,7 @@ struct unpack_trees_options {
 	int merge_size;
=20
 	struct cache_entry *df_conflict_entry;
+	const char *narrow_spec;
 	void *unpack_data;
=20
 	struct index_state *dst_index;
--=20
1.6.0.rc3.250.g8dd0
