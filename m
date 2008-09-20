From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/14] unpack_trees(): add support for sparse checkout
Date: Sat, 20 Sep 2008 17:01:50 +0700
Message-ID: <1221904913-25887-12-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
 <1221904913-25887-4-git-send-email-pclouds@gmail.com>
 <1221904913-25887-5-git-send-email-pclouds@gmail.com>
 <1221904913-25887-6-git-send-email-pclouds@gmail.com>
 <1221904913-25887-7-git-send-email-pclouds@gmail.com>
 <1221904913-25887-8-git-send-email-pclouds@gmail.com>
 <1221904913-25887-9-git-send-email-pclouds@gmail.com>
 <1221904913-25887-10-git-send-email-pclouds@gmail.com>
 <1221904913-25887-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:04:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzKa-0001On-7h
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbYITKDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbYITKDf
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:03:35 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:21281 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYITKDd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:03:33 -0400
Received: by wf-out-1314.google.com with SMTP id 27so880198wfd.4
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=R+3OTu3mGzIRjdMJbeTUEahuSQ2hS0y+F+GYbIaN0Fo=;
        b=Wc1M08MBSFHuAHTIN1OV5zDahCEQqCoFoKHtnOq4SRaoQzlE8Gvq2WwM6KnI/5f+1o
         tFS6SOj6ekZEDuCWjAHjaEvWFaS1sMDVHtKvA3wT9aysxBp/XidOx/hj4RQUkMRVhpin
         tSNsflMeWTkwckR0zYztJ2xUcCnyRwKADQJwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=I9zQZkA1/TmONQcZJkXksZY1QX/WRGDRNmrJs4Ld0Qkl7MglLNFwCx0LPO0/c32IeS
         65oiIiv9OhxA1fcQ+seT6GmWcTl5m2+V0OhVn80dGvoCo/4dxutsiT0YZEBcPmINXxWC
         1C/5lW4WCSrEAgqCq/yohBJ65ppPbLzYCOsZg=
Received: by 10.142.162.9 with SMTP id k9mr452137wfe.158.1221905013570;
        Sat, 20 Sep 2008 03:03:33 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 22sm3683883wfg.13.2008.09.20.03.03.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:03:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:03:22 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-11-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96350>

This patch teaches unpack_trees() to checkout/remove entries
on working directories appropriately when sparse checkout area is
changed. There are three kind of changes:

 - new_narrow_path: reset workdir to a completely new checkout area
 - add_narrow_path: keep current areas and add more entries
 - remove_narrow_path: remove some entries from current areas

CE_WD_REMOVE is introduced to remove entries from working directories,
but still keep them in index

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        |    3 ++
 unpack-trees.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 unpack-trees.h |    4 +++
 3 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 6e875d5..f4025b5 100644
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
index ce4c826..10f377c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -96,7 +96,7 @@ static int check_updates(struct unpack_trees_options =
*o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
+			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WD_REMOVE))
 				total++;
 		}
=20
@@ -108,6 +108,13 @@ static int check_updates(struct unpack_trees_optio=
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
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
@@ -133,6 +140,66 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	return errs !=3D 0;
 }
=20
+static int verify_uptodate(struct cache_entry *ce, struct unpack_trees=
_options *o);
+static int apply_narrow_spec(struct unpack_trees_options *o)
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
+		int match =3D match_narrow_spec(o->narrow_spec, ce->name);
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
+		/* Update worktree, add/remove entries if needed */
+
+		/*
+		 * We only care about files getting into the checkout area
+		 * If merge strategies want to remove some, go ahead
+		 */
+		if (ce->ce_flags & CE_REMOVE)
+			continue;
+
+		if (was_checkout && ce_no_checkout(ce)) {
+			/*
+			 * If CE_UPDATE is set, verify_uptodate() must be called already
+			 * also stat info may have lost after merged_entry() so calling
+			 * verify_uptodate() again may fail
+			 */
+			if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate(ce, o))
+				return -1;
+			ce->ce_flags |=3D CE_WD_REMOVE;
+		}
+		if (!was_checkout && ce_checkout(ce))
+			ce->ce_flags |=3D CE_UPDATE;
+
+		/* merge strategies may set CE_UPDATE outside checkout area */
+		if (ce_no_checkout(ce))
+			ce->ce_flags &=3D ~CE_UPDATE;
+
+	}
+	return 0;
+}
+
 static inline int call_unpack_fn(struct cache_entry **src, struct unpa=
ck_trees_options *o)
 {
 	int ret =3D o->fn(src, o);
@@ -409,6 +476,9 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
=20
+	if (apply_narrow_spec(o))
+		return unpack_failed(o, NULL);
+
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -677,6 +747,8 @@ static int merged_entry(struct cache_entry *merge, =
struct cache_entry *old,
 				return -1;
 			invalidate_ce_path(old, o);
 		}
+		if (ce_no_checkout(old))
+			update |=3D CE_NO_CHECKOUT;
 	}
 	else {
 		if (verify_absent(merge, "overwritten", o))
diff --git a/unpack-trees.h b/unpack-trees.h
index 6b1971f..0d899b6 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -43,6 +43,9 @@ struct unpack_trees_options {
 		     aggressive:1,
 		     skip_unmerged:1,
 		     initial_checkout:1,
+		     new_narrow_path:1,
+		     add_narrow_path:2,
+		     remove_narrow_path:2,
 		     gently:1;
 	const char *prefix;
 	int pos;
@@ -54,6 +57,7 @@ struct unpack_trees_options {
 	int merge_size;
=20
 	struct cache_entry *df_conflict_entry;
+	struct narrow_spec *narrow_spec;
 	void *unpack_data;
=20
 	struct index_state *dst_index;
--=20
1.6.0.96.g2fad1.dirty
