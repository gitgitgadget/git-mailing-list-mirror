From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] diffcore-pickaxe: simplify has_changes and contains
Date: Sat,  6 Jul 2013 15:53:27 +0200
Message-ID: <1373118807-1345-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 06 15:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvSvj-0002bG-0A
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 15:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab3GFNxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jul 2013 09:53:35 -0400
Received: from india601.server4you.de ([85.25.151.105]:50202 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab3GFNxe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 09:53:34 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFD94EC.dip0.t-ipconnect.de [79.253.148.236])
	by india601.server4you.de (Postfix) with ESMTPSA id 67D7244E;
	Sat,  6 Jul 2013 15:53:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229700>

Halve the number of callsites of contains() to two using temporary
variables, simplifying the code.  While at it, get rid of the
diff_options parameter, which became unused with 8fa4b09f.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index c97ac9b..401eb72 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -131,8 +131,7 @@ static void diffcore_pickaxe_grep(struct diff_optio=
ns *o)
 	return;
 }
=20
-static unsigned int contains(mmfile_t *mf, struct diff_options *o,
-			     regex_t *regexp, kwset_t kws)
+static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kw=
s)
 {
 	unsigned int cnt;
 	unsigned long sz;
@@ -176,11 +175,9 @@ static int has_changes(mmfile_t *one, mmfile_t *tw=
o,
 		       struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
-	if (!one)
-		return contains(two, o, regexp, kws) !=3D 0;
-	if (!two)
-		return contains(one, o, regexp, kws) !=3D 0;
-	return contains(one, o, regexp, kws) !=3D contains(two, o, regexp, kw=
s);
+	unsigned int one_contains =3D one ? contains(one, regexp, kws) : 0;
+	unsigned int two_contains =3D two ? contains(two, regexp, kws) : 0;
+	return one_contains !=3D two_contains;
 }
=20
 static int pickaxe_match(struct diff_filepair *p, struct diff_options =
*o,
--=20
1.8.3.2
