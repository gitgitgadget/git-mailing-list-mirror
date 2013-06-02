From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 4/7] unpack-trees: create working copy of merge entry in merged_entry
Date: Sun,  2 Jun 2013 17:46:54 +0200
Message-ID: <1370188017-24672-5-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 02 17:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjAV9-0006uU-H0
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 17:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab3FBPrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 11:47:14 -0400
Received: from india601.server4you.de ([85.25.151.105]:58117 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab3FBPrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 11:47:05 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEE4A.dip0.t-ipconnect.de [87.155.238.74])
	by india601.server4you.de (Postfix) with ESMTPSA id 6E00B4CC;
	Sun,  2 Jun 2013 17:47:03 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226161>

Duplicate the merge entry right away and work with that instead of
modifying the entry we got and duplicating it only at the end of
the function.  Then mark that pointer const to document that we
don't modify the referenced cache_entry.

This change is safe because all existing merge functions call
merged_entry just before returning (or not at all), i.e. they don't
care about changes to the referenced cache_entry after the call.
unpack_nondirectories and unpack_index_entry, which call the merge
functions through call_unpack_fn, aren't interested in such changes
neither.

The change complicates merged_entry a bit because we have to free the
copy if we error out, but allows callers to pass a const pointer.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 unpack-trees.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index e8b4cc1..2fecef8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1466,10 +1466,12 @@ static int verify_absent_sparse(struct cache_en=
try *ce,
 	return verify_absent_1(ce, orphaned_error, o);
 }
=20
-static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
-		struct unpack_trees_options *o)
+static int merged_entry(const struct cache_entry *ce,
+			struct cache_entry *old,
+			struct unpack_trees_options *o)
 {
 	int update =3D CE_UPDATE;
+	struct cache_entry *merge =3D dup_entry(ce);
=20
 	if (!old) {
 		/*
@@ -1487,8 +1489,11 @@ static int merged_entry(struct cache_entry *merg=
e, struct cache_entry *old,
 		update |=3D CE_ADDED;
 		merge->ce_flags |=3D CE_NEW_SKIP_WORKTREE;
=20
-		if (verify_absent(merge, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
+		if (verify_absent(merge,
+				  ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o)) {
+			free(merge);
 			return -1;
+		}
 		invalidate_ce_path(merge, o);
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
 		/*
@@ -1502,8 +1507,10 @@ static int merged_entry(struct cache_entry *merg=
e, struct cache_entry *old,
 			copy_cache_entry(merge, old);
 			update =3D 0;
 		} else {
-			if (verify_uptodate(old, o))
+			if (verify_uptodate(old, o)) {
+				free(merge);
 				return -1;
+			}
 			/* Migrate old flags over */
 			update |=3D old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTRE=
E);
 			invalidate_ce_path(old, o);
@@ -1516,7 +1523,7 @@ static int merged_entry(struct cache_entry *merge=
, struct cache_entry *old,
 		invalidate_ce_path(old, o);
 	}
=20
-	add_entry(o, merge, update, CE_STAGEMASK);
+	do_add_entry(o, merge, update, CE_STAGEMASK);
 	return 1;
 }
=20
--=20
1.8.3
