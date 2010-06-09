From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [RFC/ PATCH 1/5] tree-walk: do not stop when an error is detected
Date: Wed,  9 Jun 2010 14:44:02 +0200
Message-ID: <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 15:27:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMLJH-0005bm-H1
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 15:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757727Ab0FIN0m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 09:26:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34209 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757699Ab0FIN0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 09:26:40 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o59Cb621011076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Jun 2010 14:37:06 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59Cin6d010548;
	Wed, 9 Jun 2010 14:44:49 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o59Cinko025377;
	Wed, 9 Jun 2010 14:44:49 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o59CinW8025376;
	Wed, 9 Jun 2010 14:44:49 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Jun 2010 14:37:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59Cb621011076
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148776>

=46rom: Diane <diane.gasselin@ensimag.imag.fr>

When an error is detected, traverse_trees() is not stopped anymore.
The whole tree is traversed so that all the merging errors can be detec=
ted.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
---
 tree-walk.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 67a9a0c..04072aa 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -310,6 +310,7 @@ static void free_extended_entry(struct tree_desc_x =
*t)
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *i=
nfo)
 {
 	int ret =3D 0;
+	int error =3D 0;
 	struct name_entry *entry =3D xmalloc(n*sizeof(*entry));
 	int i;
 	struct tree_desc_x *tx =3D xcalloc(n, sizeof(*tx));
@@ -378,7 +379,7 @@ int traverse_trees(int n, struct tree_desc *t, stru=
ct traverse_info *info)
 			break;
 		ret =3D info->fn(n, mask, dirmask, entry, info);
 		if (ret < 0)
-			break;
+			error =3D ret;
 		mask &=3D ret;
 		ret =3D 0;
 		for (i =3D 0; i < n; i++)
@@ -389,7 +390,7 @@ int traverse_trees(int n, struct tree_desc *t, stru=
ct traverse_info *info)
 	for (i =3D 0; i < n; i++)
 		free_extended_entry(tx + i);
 	free(tx);
-	return ret;
+	return error;
 }
=20
 static int find_tree_entry(struct tree_desc *t, const char *name, unsi=
gned char *result, unsigned *mode)
--=20
1.6.6.7.ga5fe3
