From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] unpack-trees: only clear CE_UPDATE|CE_REMOVE when skip-worktree is always set
Date: Sat, 31 Jul 2010 13:14:26 +0700
Message-ID: <1280556869-707-3-git-send-email-pclouds@gmail.com>
References: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 08:15:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5Lh-000281-IH
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab0GaGPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 02:15:00 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34402 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0GaGO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:14:59 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so799856pvc.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=iwiEIm3L6oX5wxzxMBiIPD2Ciidt9u9d5UEMOWp6c0M=;
        b=R8RCzoyIBHGIb4PjHQM0HszhUC5HzXtct2AnySgMs3JzZcKLjroaFEzm0im2kxoheV
         0E/AUQm/ExYY3BYjCjPCUtOI4Tuf7EA+vJ0FMEXaHza5gVjTM2QvPOJqMA10exnB0Z+C
         W5EDcx7bh3nygIq/8hXJZ/zusf+I4fFxupXRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WWSJY+/Svs6icXZCDCGMeRb+RD3EHxiU94HJLt314A1SndhhNrN0KkbaUAQkNdCK6c
         g//guwcoAMm50jkXIg29nWhBkUwU8kT0QylS4XXNtaf2VIuvtwqaugP4Poqn0gk2Yl8F
         1jyU6PxQp8iu7Ykp14bWDErkaecnGWdmkXAUg=
Received: by 10.142.52.13 with SMTP id z13mr2671800wfz.268.1280556899366;
        Fri, 30 Jul 2010 23:14:59 -0700 (PDT)
Received: from dektop ([123.200.231.45])
        by mx.google.com with ESMTPS id v38sm3683963wfh.0.2010.07.30.23.14.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 23:14:58 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 13:14:50 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152311>

The purpose of this clearing is, as explained in comment, because
verify_*() may set those bits before apply_sparse_checkout() is
called. By that time, it's not clear whether an entry will stay in
checkout area or out. After $GIT_DIR/info/sparse-checkout is applied,
we know what entries will be in finally. It's time to clean unwanted
bits.

That works perfectly when checkout area remains unchanged. When
checkout area changes, apply_sparse_checkout() may set CE_UPDATE
or CE_WT_REMOVE to widen/narrow checkout area. Doing the clearing
after apply_sparse_checkout() may clear those widening/narrowing
bits unexpectedly.

So, only do that on entries that are not affected by checkout area
changes (i.e. skip-worktree bit does not change after
apply_sparse_checkout).

This code does not actually fix anything though, just
future-proof. The removed code and the narrow/widen code inside
apply_sparse_checkout are currently independent (narrow code never
sets CE_REMOVE, widen code sets CE_UPDATE, but ce_skip_worktree()
would be false).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1011-read-tree-sparse-checkout.sh |   12 ++++++++++++
 unpack-trees.c                       |   26 ++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 9189de8..2876daf 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -155,4 +155,16 @@ test_expect_success 'read-tree adds to worktree, d=
irty case' '
 	grep -q dirty sub/added
 '
=20
+test_expect_success 'index removal and worktree narrowing at the same =
time' '
+	>empty &&
+	echo init.t >.git/info/sparse-checkout &&
+	echo sub/added >>.git/info/sparse-checkout &&
+	git checkout -f top &&
+	echo init.t >.git/info/sparse-checkout &&
+	git checkout removed &&
+	git ls-files sub/added >result
+	test ! -f sub/added &&
+	test_cmp empty result
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index e8f03f5..6d0df99 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -156,13 +156,18 @@ static int apply_sparse_checkout(struct cache_ent=
ry *ce, struct unpack_trees_opt
 		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
=20
 	/*
-	 * We only care about files getting into the checkout area
-	 * If merge strategies want to remove some, go ahead, this
-	 * flag will be removed eventually in unpack_trees() if it's
-	 * outside checkout area.
+	 * if (!was_skip_worktree && !ce_skip_worktree()) {
+	 *	This is perfectly normal. Move on;
+	 * }
 	 */
-	if (ce->ce_flags & CE_REMOVE)
-		return 0;
+
+	/*
+	 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
+	 * area as a result of ce_skip_worktree() shortcuts in
+	 * verify_absent() and verify_uptodate(). Clear them.
+	 */
+	if (was_skip_worktree && ce_skip_worktree(ce))
+		ce->ce_flags &=3D ~(CE_UPDATE | CE_REMOVE);
=20
 	if (!was_skip_worktree && ce_skip_worktree(ce)) {
 		/*
@@ -796,14 +801,7 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 				ret =3D -1;
 				goto done;
 			}
-			/*
-			 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
-			 * area as a result of ce_skip_worktree() shortcuts in
-			 * verify_absent() and verify_uptodate(). Clear them.
-			 */
-			if (ce_skip_worktree(ce))
-				ce->ce_flags &=3D ~(CE_UPDATE | CE_REMOVE);
-			else
+			if (!ce_skip_worktree(ce))
 				empty_worktree =3D 0;
=20
 		}
--=20
1.7.1.rc1.69.g24c2f7
