From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m?= <grubba@grubba.org>
Subject: [PATCH 2/4] convert: Keep foreign $Id$ on checkout.
Date: Mon,  1 Mar 2010 17:16:56 +0100
Message-ID: <1267460218-1172-2-git-send-email-grubba@grubba.org>
References: <1267460218-1172-1-git-send-email-grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 17:50:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm8oj-00019C-IQ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 17:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab0CAQt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 11:49:56 -0500
Received: from mail.roxen.com ([212.247.29.220]:51000 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab0CAQty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 11:49:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 949776280EB
	for <git@vger.kernel.org>; Mon,  1 Mar 2010 17:17:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id voHKVXQSVU8U; Mon,  1 Mar 2010 17:17:04 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 76D0C628093;
	Mon,  1 Mar 2010 17:17:04 +0100 (CET)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o21GH4Fa001225;
	Mon, 1 Mar 2010 17:17:04 +0100 (CET)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o21GH4bc001222;
	Mon, 1 Mar 2010 17:17:04 +0100 (CET)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1267460218-1172-1-git-send-email-grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141327>

=46rom: Henrik Grubbstr=C3=B6m (Grubba) <grubba@grubba.org>

If there are foreign $Id$ keywords in the repository, they are most
likely there for a reason. Let's keep them on checkout (which is also
what the documentation indicates). Foreign $Id$ keywords are now
recognized by there being multiple space separated fields in $Id:xxxxx$=
=2E

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 convert.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/convert.c b/convert.c
index 91207ab..28aeea3 100644
--- a/convert.c
+++ b/convert.c
@@ -513,7 +513,10 @@ static int ident_to_worktree(const char *path, con=
st char *src, size_t len,
 		} else if (src[2] =3D=3D ':') {
 			/*
 			 * It's possible that an expanded Id has crept its way into the
-			 * repository, we cope with that by stripping the expansion out
+			 * repository, we cope with that by stripping the expansion out.
+			 * This is probably not a good idea, since it will cause changes
+			 * on checkout, which won't go away by stash, but let's keep it
+			 * for git-style ids.
 			 */
 			dollar =3D memchr(src + 3, '$', len - 3);
 			if (!dollar) {
@@ -527,6 +530,15 @@ static int ident_to_worktree(const char *path, con=
st char *src, size_t len,
 				continue;
 			}
=20
+			if ((src[3] !=3D ' ') ||
+			    (memchr(src + 4, ' ', len - 4) !=3D dollar-1)) {
+				/* There are spaces in unexpected places.
+				 * This is probably an id from some other
+				 * versioning system. Keep it for now.
+				 */
+				continue;
+			}
+
 			len -=3D dollar + 1 - src;
 			src  =3D dollar + 1;
 		} else {
--=20
1.6.4.122.g6ffd7
