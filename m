From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 7/7] unpack-trees: free cache_entry array members for merges
Date: Sun,  2 Jun 2013 17:46:57 +0200
Message-ID: <1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 02 17:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjAVK-00070x-E9
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 17:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab3FBPr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 11:47:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:58128 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab3FBPrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 11:47:06 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEE4A.dip0.t-ipconnect.de [87.155.238.74])
	by india601.server4you.de (Postfix) with ESMTPSA id 5D9D26F2;
	Sun,  2 Jun 2013 17:47:04 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226166>

The merge functions duplicate entries as needed and they don't free
them.  Release them in unpack_nondirectories, the same function
where they were allocated, after we're done.

As suggested by Felipe, use the same loop style (zero-based for loop)
for freeing as for allocating.

Improved-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 unpack-trees.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 2dbc05d..57b4074 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -600,9 +600,16 @@ static int unpack_nondirectories(int n, unsigned l=
ong mask,
 		src[i + o->merge] =3D create_ce_entry(info, names + i, stage);
 	}
=20
-	if (o->merge)
-		return call_unpack_fn((const struct cache_entry * const *)src,
-				      o);
+	if (o->merge) {
+		int rc =3D call_unpack_fn((const struct cache_entry * const *)src,
+					o);
+		for (i =3D 0; i < n; i++) {
+			struct cache_entry *ce =3D src[i + o->merge];
+			if (ce !=3D o->df_conflict_entry)
+				free(ce);
+		}
+		return rc;
+	}
=20
 	for (i =3D 0; i < n; i++)
 		if (src[i] && src[i] !=3D o->df_conflict_entry)
--=20
1.8.3
