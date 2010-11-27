From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] unpack-trees: move all skip-worktree checks back to unpack_trees()
Date: Sat, 27 Nov 2010 13:24:04 +0700
Message-ID: <1290839044-25775-1-git-send-email-pclouds@gmail.com>
References: <1290795467-7570-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>, tfransosi@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 27 07:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMEDt-00028o-O4
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 07:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab0K0GZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 01:25:21 -0500
Received: from mail-pw0-f66.google.com ([209.85.160.66]:58903 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0K0GZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 01:25:19 -0500
Received: by pwj5 with SMTP id 5so572066pwj.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 22:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xT80xgkRPoMWSRCt0cQgeTH1pvocco9NXJ8xljFN6PU=;
        b=QrR+HKcqIMkEsIXVVYeD6Ic0pCGfVf8rtks/GTDoN+MIU7YNycLcm71bMjzM9pn+Ew
         iAVGae4aFwxAQ+39ms42UHOlKArpD6h14y+bDmiRBuauISgZZQxRqs2LaUQTG/eK4u8O
         bZiMabzduexBCwoCKoosQNOj9c6J06Pnd2vB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vp8L7BserTEhwRDpQlZGs1OjDho2gBejp5H+1e/8DwfCz8E+8vxjW9GcHnSKzAygAo
         cp6JgTacnqRAiSZ7Kv5z6a1ZbQWEb9P8sMhC6jPMGcmIEafZzZRa4OktcOVodDnDkxIm
         msyMQ+Fdz07IlkW+3UaAEkYypzybjXhZdFKa4=
Received: by 10.142.215.11 with SMTP id n11mr3208053wfg.224.1290839118826;
        Fri, 26 Nov 2010 22:25:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id x18sm3674510wfa.23.2010.11.26.22.25.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 22:25:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Nov 2010 13:24:05 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290795467-7570-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162300>

Earlier, the will_have_skip_worktree() checks are done in various
places, which makes it hard to traverse the index tree-alike, required
by excluded_from_list(). This patch moves all the checks into two
loops in unpack_trees().

Entries in index in this operation can be classified into two
groups: ones already in index before unpack_trees() is called and ones
added to index after traverse_trees() is called.

In both groups, before checking file status on worktree, the future
skip-worktree bit must be checked, so that if an entry will be outside
worktree, worktree should not be checked.

=46or the first group, the future skip-worktree bit is precomputed and
stored as CE_NEW_SKIP_WORKTREE in the first loop before
traverse_trees() is called so that *way_merge() function does not need
to compute it again.

=46or the second group, because we don't know what entries will be in
this group until traverse_trees() finishes, operations that need
future skip-worktree check is delayed until CE_NEW_SKIP_WORKTREE is
computed in the second loop. CE_ADDED is used to mark entries in the
second group.

CE_ADDED and CE_NEW_SKIP_WORKTREE are temporary flags used in
unpack_trees().  CE_ADDED is only used by add_to_index(), which should
not be called while unpack_trees() is running.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 CE_NEW_SKIP_WORKTREE is changed to (1 << 25) instead of 0x2000000

 cache.h        |    1 +
 unpack-trees.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++=
+------
 2 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index f9545a1..cb69318 100644
--- a/cache.h
+++ b/cache.h
@@ -181,6 +181,7 @@ struct cache_entry {
 #define CE_CONFLICTED        (1 << 23)
=20
 #define CE_UNPACKED          (1 << 24)
+#define CE_NEW_SKIP_WORKTREE (1 << 25)
=20
 /*
  * Extended on-disk flags
diff --git a/unpack-trees.c b/unpack-trees.c
index 4d92412..a6518db 100644
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
@@ -333,7 +333,7 @@ static void mark_all_ce_unused(struct index_state *=
index)
 {
 	int i;
 	for (i =3D 0; i < index->cache_nr; i++)
-		index->cache[i]->ce_flags &=3D ~CE_UNPACKED;
+		index->cache[i]->ce_flags &=3D ~(CE_UNPACKED | CE_ADDED | CE_NEW_SKI=
P_WORKTREE);
 }
=20
 static int locate_in_src_index(struct cache_entry *ce,
@@ -835,8 +835,33 @@ static int unpack_callback(int n, unsigned long ma=
sk, unsigned long dirmask, str
 }
=20
 /*
+ * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-ch=
eckout
+ */
+static void mark_new_skip_worktree(struct exclude_list *el,
+				   struct index_state *the_index,
+				   int select_flag, int skip_wt_flag)
+{
+	int i;
+
+	for (i =3D 0; i < the_index->cache_nr; i++) {
+		struct cache_entry *ce =3D the_index->cache[i];
+
+		if (select_flag && !(ce->ce_flags & select_flag))
+			continue;
+
+		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
+			ce->ce_flags |=3D skip_wt_flag;
+		else
+			ce->ce_flags &=3D ~skip_wt_flag;
+	}
+}
+
+static int verify_absent(struct cache_entry *, enum unpack_trees_error=
_types, struct unpack_trees_options *);
+/*
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to ma=
nipulate the
  * resulting index, -2 on failure to reflect the changes to the work t=
ree.
+ *
+ * CE_ADDED, CE_UNPACKED and CE_NEW_SKIP_WORKTREE are used internally
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_tree=
s_options *o)
 {
@@ -869,6 +894,12 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 	o->merge_size =3D len;
 	mark_all_ce_unused(o->src_index);
=20
+	/*
+	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
+	 */
+	if (!o->skip_sparse_checkout)
+		mark_new_skip_worktree(o->el, o->src_index, 0, CE_NEW_SKIP_WORKTREE)=
;
+
 	if (!dfc)
 		dfc =3D xcalloc(1, cache_entry_size(0));
 	o->df_conflict_entry =3D dfc;
@@ -922,9 +953,29 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
=20
 	if (!o->skip_sparse_checkout) {
 		int empty_worktree =3D 1;
-		for (i =3D 0;i < o->result.cache_nr;i++) {
+
+		/*
+		 * Sparse checkout loop #2: set NEW_SKIP_WORKTREE on entries not in =
loop #1
+		 * If the will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
+		 * so apply_sparse_checkout() won't attempt to remove it from worktr=
ee
+		 */
+		mark_new_skip_worktree(o->el, &o->result, CE_ADDED, CE_SKIP_WORKTREE=
 | CE_NEW_SKIP_WORKTREE);
+
+		for (i =3D 0; i < o->result.cache_nr; i++) {
 			struct cache_entry *ce =3D o->result.cache[i];
=20
+			/*
+			 * Entries marked with CE_ADDED in merged_entry() do not have
+			 * verify_absent() check (the check is effectively disabled
+			 * because CE_NEW_SKIP_WORKTREE is set unconditionally).
+			 *
+			 * Do the real check now because we have had
+			 * correct CE_NEW_SKIP_WORKTREE
+			 */
+			if (ce->ce_flags & CE_ADDED &&
+			    verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
+					return -1;
+
 			if (apply_sparse_checkout(ce, o)) {
 				ret =3D -1;
 				goto done;
@@ -1013,7 +1064,7 @@ static int verify_uptodate_1(struct cache_entry *=
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
@@ -1200,7 +1251,7 @@ static int verify_absent(struct cache_entry *ce,
 			 enum unpack_trees_error_types error_type,
 			 struct unpack_trees_options *o)
 {
-	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
+	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE)=
)
 		return 0;
 	return verify_absent_1(ce, error_type, o);
 }
@@ -1222,10 +1273,23 @@ static int merged_entry(struct cache_entry *mer=
ge, struct cache_entry *old,
 	int update =3D CE_UPDATE;
=20
 	if (!old) {
+		/*
+		 * New index entries. In sparse checkout, the following
+		 * verify_absent() will be delayed until after
+		 * traverse_trees() finishes in unpack_trees(), then:
+		 *
+		 *  - CE_NEW_SKIP_WORKTREE will be computed correctly
+		 *  - verify_absent() be called again, this time with
+		 *    correct CE_NEW_SKIP_WORKTREE
+		 *
+		 * verify_absent() call here does nothing in sparse
+		 * checkout (i.e. o->skip_sparse_checkout =3D=3D 0)
+		 */
+		update |=3D CE_ADDED;
+		merge->ce_flags |=3D CE_NEW_SKIP_WORKTREE;
+
 		if (verify_absent(merge, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
 			return -1;
-		if (!o->skip_sparse_checkout && will_have_skip_worktree(merge, o))
-			update |=3D CE_SKIP_WORKTREE;
 		invalidate_ce_path(merge, o);
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
 		/*
@@ -1241,8 +1305,8 @@ static int merged_entry(struct cache_entry *merge=
, struct cache_entry *old,
 		} else {
 			if (verify_uptodate(old, o))
 				return -1;
-			if (ce_skip_worktree(old))
-				update |=3D CE_SKIP_WORKTREE;
+			/* Migrate old flags over */
+			update |=3D old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTRE=
E);
 			invalidate_ce_path(old, o);
 		}
 	} else {
--=20
1.7.3.2.316.gda8b3
