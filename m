From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 6/6] Read an object from a pack file
Date: Wed, 14 Oct 2009 12:37:49 +0200
Message-ID: <1255516669-26745-6-git-send-email-herve@itaapy.com>
References: <1255516669-26745-1-git-send-email-herve@itaapy.com>
 <1255516669-26745-2-git-send-email-herve@itaapy.com>
 <1255516669-26745-3-git-send-email-herve@itaapy.com>
 <1255516669-26745-4-git-send-email-herve@itaapy.com>
 <1255516669-26745-5-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 12:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My1Qh-0004AO-OG
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 12:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbZJNKps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 06:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbZJNKpr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 06:45:47 -0400
Received: from mailhost-p4-m2.nerim.net ([78.40.49.191]:50592 "EHLO
	smtp-delay2.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932340AbZJNKpm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 06:45:42 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2009 06:45:42 EDT
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net [62.4.17.103])
	by smtp-delay2.nerim.net (Postfix) with ESMTP id 1C8AEB3D08C
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:36:54 +0200 (CEST)
Received: from localhost.localdomain (itaapy-35-170.cnt.nerim.net [213.215.35.170])
	by mallaury.nerim.net (Postfix) with ESMTP id 7023DA108E
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:35:53 +0200 (CEST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1255516669-26745-5-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130284>

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/odb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index a612299..65a7993 100644
--- a/src/odb.c
+++ b/src/odb.c
@@ -1263,13 +1263,16 @@ static int read_packed(git_obj *out, git_pack *=
p, const git_oid *id)
=20
 	if (pack_openidx(p))
 		return GIT_ERROR;
+	if (pack_openpack(p)) {
+		pack_decidx(p);
+		return GIT_ERROR;
+	}
 	res =3D p->idx_search(&pos, p, id);
 	pack_decidx(p);
+	assert(pos < p->pack_map.len);
=20
-	if (!res) {
-		/* TODO unpack object at pos */
-		res =3D GIT_ERROR;
-	}
+	if (res =3D=3D GIT_SUCCESS)
+		return inflate_pack_obj(out, p, pos);
=20
 	return res;
 }
--=20
1.6.5
