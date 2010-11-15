From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/10] unpack-trees: move all skip-worktree check back to unpack_trees()
Date: Mon, 15 Nov 2010 17:36:42 +0700
Message-ID: <1289817410-32470-3-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:38:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwSa-0001b0-RL
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067Ab0KOKip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:38:45 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54021 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab0KOKio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:38:44 -0500
Received: by mail-pz0-f46.google.com with SMTP id 28so921988pzk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=g974AiUshO84EIhIPTnso2NICKUbRynmhR1OjpAC/94=;
        b=hstzQuANewkKBFzQUEO4uAXJRSg568oujFEy8EtLWoQdVG5l7HTRl9YE+eEVyg0hbl
         BnQ0x7nGVyZ9Mmbtp3+qHSHnhUBOhbPIkOMqAqZISYHMlXclR2SbWM2TaMrWH9DBnfvA
         qKvkM8KIzkn215WPUkuDin5EMFirLSb04fZ+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=m556FpoDtVI/mXQloT2RJDSyJLol1VLdSZKnVrY0mn0bVRsYmFaJ+Avsn/qw29kuHC
         CdG0QTlQ0D31cbisY9rv4+2A72/7bLz3LtrkvduDjsHTvCbut3D/UJ9N+yHfWlT7eY3K
         Ar9vKeUIUgzzN/zF4YSbEW2kiCPqOdoDnnS+U=
Received: by 10.142.134.11 with SMTP id h11mr3724542wfd.206.1289817524147;
        Mon, 15 Nov 2010 02:38:44 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id q13sm8567711wfc.17.2010.11.15.02.38.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:38:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:37:27 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161479>

Earlier, the will_have_skip_worktree() checks are done in various place=
s:

1. in verify_* functions to prevent absent/uptodate checks outside
   worktree
2. in merged_entry for new index entries
3. in apply_sparse_checkout() for all entries

In case all entries are added new ($GIT_DIR/index is missing) all the
above checks will be done for all entries, which in the worst case can
become cache_nr*el->nr*3 fnmatch() calls. Quite expensive.

By moving all will_have_skip_worktree() checks to unpack_trees(), we
now have two places to run the checks:

 - one before calling traverse_trees(), where all current index
   entries are checked.
 - one after traverse_trees(), where newly-added entries are checked.

In worst case, each entry will be checked once, or cache_nr*el->nr
fnmatch() calls at most. The two places are a loop over all entries,
which also makes optimization easier.

CE_ADDED is used to mark new entries. The flag is only used by
add_to_index(), which should not be called while unpack_trees() is
running.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        |    1 +
 unpack-trees.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++=
++-----
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..d87708a 100644
--- a/cache.h
+++ b/cache.h
@@ -182,6 +182,7 @@ struct cache_entry {
 #define CE_WT_REMOVE (0x400000) /* remove in work directory */
=20
 #define CE_UNPACKED  (0x1000000)
+#define CE_NEW_SKIP_WORKTREE (0x2000000)
=20
 /*
  * Extended on-disk flags
diff --git a/unpack-trees.c b/unpack-trees.c
index 803445a..9acd9be 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -258,7 +258,7 @@ static int apply_sparse_checkout(struct cache_entry=
 *ce, struct unpack_trees_opt
 {
 	int was_skip_worktree =3D ce_skip_worktree(ce);
=20
-	if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
+	if (ce->ce_flags & CE_NEW_SKIP_WORKTREE)
 		ce->ce_flags |=3D CE_SKIP_WORKTREE;
 	else
 		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
@@ -834,6 +834,49 @@ static int unpack_callback(int n, unsigned long ma=
sk, unsigned long dirmask, str
 	return mask;
 }
=20
+static void set_new_skip_worktree_1(struct unpack_trees_options *o)
+{
+	int i;
+
+	for (i =3D 0;i < o->src_index->cache_nr;i++) {
+		struct cache_entry *ce =3D o->src_index->cache[i];
+		ce->ce_flags &=3D ~CE_ADDED;
+		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
+			ce->ce_flags |=3D CE_NEW_SKIP_WORKTREE;
+		else
+			ce->ce_flags &=3D ~CE_NEW_SKIP_WORKTREE;
+	}
+}
+
+static int verify_absent(struct cache_entry *, enum unpack_trees_error=
_types, struct unpack_trees_options *);
+static int set_new_skip_worktree_2(struct unpack_trees_options *o)
+{
+	int i;
+
+	/*
+	 * CE_ADDED marks new index entries. These have not been processed
+	 * by set_new_skip_worktree_1() so we do it here.
+	 */
+	for (i =3D 0;i < o->result.cache_nr;i++) {
+		struct cache_entry *ce =3D o->result.cache[i];
+
+		if (!(ce->ce_flags & CE_ADDED))
+			continue;
+
+		ce->ce_flags &=3D ~CE_ADDED;
+		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
+			ce->ce_flags |=3D CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE;
+		else
+			ce->ce_flags &=3D ~(CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
+
+		/* Left-over checks from merged_entry when old =3D=3D NULL */
+		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
+			return -1;
+	}
+
+	return 0;
+}
+
 /*
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to ma=
nipulate the
  * resulting index, -2 on failure to reflect the changes to the work t=
ree.
@@ -862,6 +905,9 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 			o->el =3D &el;
 	}
=20
+	if (!o->skip_sparse_checkout)
+		set_new_skip_worktree_1(o);
+
 	memset(&o->result, 0, sizeof(o->result));
 	o->result.initialized =3D 1;
 	o->result.timestamp.sec =3D o->src_index->timestamp.sec;
@@ -922,6 +968,10 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
=20
 	if (!o->skip_sparse_checkout) {
 		int empty_worktree =3D 1;
+
+		if (set_new_skip_worktree_2(o))
+			goto return_failed;
+
 		for (i =3D 0;i < o->result.cache_nr;i++) {
 			struct cache_entry *ce =3D o->result.cache[i];
=20
@@ -1017,7 +1067,7 @@ static int verify_uptodate_1(struct cache_entry *=
ce,
 static int verify_uptodate(struct cache_entry *ce,
 			   struct unpack_trees_options *o)
 {
-	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
+	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE)=
)
 		return 0;
 	return verify_uptodate_1(ce, o, ERROR_NOT_UPTODATE_FILE);
 }
@@ -1204,7 +1254,7 @@ static int verify_absent(struct cache_entry *ce,
 			 enum unpack_trees_error_types error_type,
 			 struct unpack_trees_options *o)
 {
-	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
+	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE)=
)
 		return 0;
 	return verify_absent_1(ce, error_type, o);
 }
@@ -1226,10 +1276,15 @@ static int merged_entry(struct cache_entry *mer=
ge, struct cache_entry *old,
 	int update =3D CE_UPDATE;
=20
 	if (!old) {
+		/*
+		 * Set CE_NEW_SKIP_WORKTREE on "merge" to make
+		 * verify_absent() no-op. The true check will be done
+		 * later on in unpack_trees().
+		 */
+		merge->ce_flags |=3D CE_NEW_SKIP_WORKTREE;
 		if (verify_absent(merge, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
 			return -1;
-		if (!o->skip_sparse_checkout && will_have_skip_worktree(merge, o))
-			update |=3D CE_SKIP_WORKTREE;
+		update |=3D CE_ADDED;
 		invalidate_ce_path(merge, o);
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
 		/*
@@ -1245,8 +1300,8 @@ static int merged_entry(struct cache_entry *merge=
, struct cache_entry *old,
 		} else {
 			if (verify_uptodate(old, o))
 				return -1;
-			if (ce_skip_worktree(old))
-				update |=3D CE_SKIP_WORKTREE;
+			/* Migrate old bits over */
+			update |=3D old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTRE=
E);
 			invalidate_ce_path(old, o);
 		}
 	} else {
--=20
1.7.3.2.210.g045198
