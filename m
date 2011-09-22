From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] sparse checkout: show error messages when worktree shaping fails
Date: Thu, 22 Sep 2011 21:24:22 +1000
Message-ID: <1316690663-29382-1-git-send-email-pclouds@gmail.com>
References: <7vk4911ux8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 13:24:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6hOT-0001yF-C9
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 13:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab1IVLYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 07:24:36 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42979 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1IVLYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 07:24:35 -0400
Received: by gxk6 with SMTP id 6so1849200gxk.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TzeE3koE+AzDOPYenZcBlhmbt5JR2FEj/6K2GtPrTMg=;
        b=c+C9ZIZeSOa2fFxXcI1rCotKZydYZTAS+0esfrFOwL3Kwtpn8LSB9Eti2Ep4bIcfp2
         YvEgihun1Mb3PClY8Fo0qXKuCPKI+oUDDaVMVuP7fsqRhjnyzIwBaHfb+vnYQDow2wkW
         GNnyA/c2kj7T8LqzyGrQ0vUyLCYWG/xHuzhS0=
Received: by 10.150.186.1 with SMTP id j1mr2003496ybf.345.1316690674290;
        Thu, 22 Sep 2011 04:24:34 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id t10sm29971711anl.26.2011.09.22.04.24.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 04:24:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 22 Sep 2011 21:24:24 +1000
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <7vk4911ux8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181892>

verify_* functions can queue errors up and to be printed later at
label return_failed. In case of errors, do not go to label "done"
directly because all queued messages would be dropped on the floor.

=46ound-by: Joshua Jensen <jjensen@workspacewhiz.com>
Tracked-down-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Now print all errors.

 t/t1011-read-tree-sparse-checkout.sh |   15 +++++++++++++++
 unpack-trees.c                       |   13 ++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 018c354..efcd8ab 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -234,4 +234,19 @@ test_expect_success 'read-tree --reset removes out=
side worktree' '
 	test_cmp empty result
 '
=20
+test_expect_success 'print errors when failed to update worktree' '
+	echo sub >.git/info/sparse-checkout &&
+	git checkout -f init &&
+	mkdir sub &&
+	touch sub/added sub/addedtoo &&
+	test_must_fail git checkout top 2>actual &&
+	cat >expected <<\EOF &&
+error: The following untracked working tree files would be overwritten=
 by checkout:
+	sub/added
+	sub/addedtoo
+Please move or remove them before you can switch branches.
+EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index cc616c3..fcf40a0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1089,6 +1089,7 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 		 */
 		mark_new_skip_worktree(o->el, &o->result, CE_ADDED, CE_SKIP_WORKTREE=
 | CE_NEW_SKIP_WORKTREE);
=20
+		ret =3D 0;
 		for (i =3D 0; i < o->result.cache_nr; i++) {
 			struct cache_entry *ce =3D o->result.cache[i];
=20
@@ -1101,17 +1102,23 @@ int unpack_trees(unsigned len, struct tree_desc=
 *t, struct unpack_trees_options
 			 * correct CE_NEW_SKIP_WORKTREE
 			 */
 			if (ce->ce_flags & CE_ADDED &&
-			    verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
-					return -1;
+			    verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o)) {
+				if (!o->show_all_errors)
+					goto return_failed;
+				ret =3D -1;
+			}
=20
 			if (apply_sparse_checkout(ce, o)) {
+				if (!o->show_all_errors)
+					goto return_failed;
 				ret =3D -1;
-				goto done;
 			}
 			if (!ce_skip_worktree(ce))
 				empty_worktree =3D 0;
=20
 		}
+		if (ret < 0)
+			goto return_failed;
 		if (o->result.cache_nr && empty_worktree) {
 			/* dubious---why should this fail??? */
 			ret =3D unpack_failed(o, "Sparse checkout leaves no entry on workin=
g directory");
--=20
1.7.3.1.256.g2539c.dirty
