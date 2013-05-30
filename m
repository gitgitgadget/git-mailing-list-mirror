From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 7/7] unpack-trees: free cache_entry array members for merges
Date: Thu, 30 May 2013 13:34:24 +0200
Message-ID: <1369913664-49734-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 13:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui181-0006iS-E5
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 13:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802Ab3E3Lek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 07:34:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:57603 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497Ab3E3Led (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 07:34:33 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEB6E.dip0.t-ipconnect.de [87.155.235.110])
	by india601.server4you.de (Postfix) with ESMTPSA id 2697850B;
	Thu, 30 May 2013 13:34:31 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225961>

The merge functions duplicate entries as needed and they don't free
them.  Release them in unpack_nondirectories, the same function
where they were allocated, after we're done.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 unpack-trees.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 2dbc05d..fc0dd5a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -600,9 +600,14 @@ static int unpack_nondirectories(int n, unsigned l=
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
+		for (i =3D 1; i <=3D n; i++)
+			if (src[i] && src[i] !=3D o->df_conflict_entry)
+				free(src[i]);
+		return rc;
+	}
=20
 	for (i =3D 0; i < n; i++)
 		if (src[i] && src[i] !=3D o->df_conflict_entry)
--=20
1.8.3
