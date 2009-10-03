From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 6/6] Read an object from a pack file
Date: Sat,  3 Oct 2009 20:10:01 +0200
Message-ID: <1254593401-18801-7-git-send-email-herve@itaapy.com>
References: <1254593401-18801-1-git-send-email-herve@itaapy.com>
 <1254593401-18801-2-git-send-email-herve@itaapy.com>
 <1254593401-18801-3-git-send-email-herve@itaapy.com>
 <1254593401-18801-4-git-send-email-herve@itaapy.com>
 <1254593401-18801-5-git-send-email-herve@itaapy.com>
 <1254593401-18801-6-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 20:13:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu96d-0004eY-V6
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 20:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbZJCSKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2009 14:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbZJCSKD
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 14:10:03 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54313 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbZJCSKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 14:10:02 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 88E254B00D9;
	Sat,  3 Oct 2009 20:08:48 +0200 (CEST)
Received: from localhost.localdomain (mon75-11-82-242-92-33.fbx.proxad.net [82.242.92.33])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 274604B0160;
	Sat,  3 Oct 2009 20:08:46 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <1254593401-18801-6-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129490>

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/odb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index dd3c142..a712d71 100644
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
1.6.4.4
