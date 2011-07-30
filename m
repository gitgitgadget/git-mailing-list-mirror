From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Break down no-lstat() condition checks in verify_uptodate()
Date: Sat, 30 Jul 2011 10:55:05 +0700
Message-ID: <1311998105-6267-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 06:00:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn0iV-0007C3-1E
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 05:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab1G3D7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 23:59:54 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34855 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab1G3D7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 23:59:54 -0400
Received: by pzk37 with SMTP id 37so7417508pzk.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 20:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=QvZoZJbWjYgJEBFcCQsKVTGSilcfR2+RXKTMRejunzo=;
        b=sKHj0PyMsTmWF0GeBYGxXuLQ4zEuva+20/3OK3iKDvoJo/BLMabVqJte0pTGkBoj4b
         uqKa2nE2a131flco2ZquHPA+mnX6TydRSdpL3WQ+rq9BBmDNn56hXLSqPKm1/fGsJldC
         6/0s6mCUWNu388kmsbu3tYgVziHOdlgbq0VL8=
Received: by 10.68.16.165 with SMTP id h5mr3151411pbd.382.1311998393703;
        Fri, 29 Jul 2011 20:59:53 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.215.47])
        by mx.google.com with ESMTPS id d1sm2771106pbj.72.2011.07.29.20.59.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 20:59:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 30 Jul 2011 10:55:08 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178175>

Make it easier to grok under what conditions we can skip lstat().

While at there, shorten ie_match_stat() line for the sake of my eyes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a61d82..d8c7eb9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1168,11 +1168,22 @@ static int verify_uptodate_1(struct cache_entry=
 *ce,
 {
 	struct stat st;
=20
-	if (o->index_only || (!((ce->ce_flags & CE_VALID) || ce_skip_worktree=
(ce)) && (o->reset || ce_uptodate(ce))))
+	if (o->index_only)
+		return 0;
+
+	/*
+	 * CE_VALID and CE_SKIP_WORKTREE cheat, we better check again
+	 * if this entry is truely uptodate because this file may be
+	 * overwritten.
+	 */
+	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
+		; /* keep checking */
+	else if (o->reset || ce_uptodate(ce))
 		return 0;
=20
 	if (!lstat(ce->name, &st)) {
-		unsigned changed =3D ie_match_stat(o->src_index, ce, &st, CE_MATCH_I=
GNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		int flags =3D CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
+		unsigned changed =3D ie_match_stat(o->src_index, ce, &st, flags);
 		if (!changed)
 			return 0;
 		/*
--=20
1.7.4.74.g639db
