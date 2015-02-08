From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/24] read-cache.c: split racy stat test to a separate function
Date: Sun,  8 Feb 2015 15:55:37 +0700
Message-ID: <1423385748-19825-14-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:57:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNfz-00031Q-0n
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbbBHI5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:57:06 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55830 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbbBHI5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:57:05 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so26952373pad.4
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mq951DenREY98dYQdiczt6ostvoWWyzg5f4SATHBLrI=;
        b=S+rAaRob7SdmHPNqo+qku6smrVPOGKVvDo8rPNQchIjyGvCobwdQYeCn+gMC3eLMuj
         Ae59ILKcFk19VCEAW7Nctyu19mHceGL9aAK7pNOnAsJOFs4Eh+CxAJtvcXxHWGRu33AK
         qVkdM85DdW+ifpmx7Lp+7mMBJ6dIIEaP34HN+ExLYMgU+lrfcFAFb9BjcuskH3c0yVrZ
         pEJtHTd0bAn/qZ/98wtq122dwX7Wm4ya4eGOisBEzFNpQlU7ycjvG5RTQdU16N/ZBR7W
         +aCUwJDbsmSyiiINzrDwZOxEh2XzJowKVIXB51L03E2nHme4iHHOKbkDes2VExNNokP3
         GQKQ==
X-Received: by 10.70.137.66 with SMTP id qg2mr19093727pdb.73.1423385824917;
        Sun, 08 Feb 2015 00:57:04 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id hd4sm12886603pbc.86.2015.02.08.00.57.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:57:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:57:12 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263475>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d643a3f..f12a185 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -270,20 +270,26 @@ static int ce_match_stat_basic(const struct cache=
_entry *ce, struct stat *st)
 	return changed;
 }
=20
-static int is_racy_timestamp(const struct index_state *istate,
-			     const struct cache_entry *ce)
+static int is_racy_stat(const struct index_state *istate,
+			const struct stat_data *sd)
 {
-	return (!S_ISGITLINK(ce->ce_mode) &&
-		istate->timestamp.sec &&
+	return (istate->timestamp.sec &&
 #ifdef USE_NSEC
 		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < ce->ce_stat_data.sd_mtime.sec ||
-		 (istate->timestamp.sec =3D=3D ce->ce_stat_data.sd_mtime.sec &&
-		  istate->timestamp.nsec <=3D ce->ce_stat_data.sd_mtime.nsec))
+		(istate->timestamp.sec < sd->sd_mtime.sec ||
+		 (istate->timestamp.sec =3D=3D sd->sd_mtime.sec &&
+		  istate->timestamp.nsec <=3D sd->sd_mtime.nsec))
 #else
-		istate->timestamp.sec <=3D ce->ce_stat_data.sd_mtime.sec
+		istate->timestamp.sec <=3D sd->sd_mtime.sec
 #endif
-		 );
+		);
+}
+
+static int is_racy_timestamp(const struct index_state *istate,
+			     const struct cache_entry *ce)
+{
+	return (!S_ISGITLINK(ce->ce_mode) &&
+		is_racy_stat(istate, &ce->ce_stat_data));
 }
=20
 int ie_match_stat(const struct index_state *istate,
--=20
2.3.0.rc1.137.g477eb31
