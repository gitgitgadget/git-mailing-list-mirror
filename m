From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/22] read-cache.c: split racy stat test to a separate function
Date: Sat,  8 Nov 2014 16:39:45 +0700
Message-ID: <1415439595-469-13-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:41:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2Vw-0001Eb-5y
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbaKHJky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:40:54 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40520 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbaKHJkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:40:51 -0500
Received: by mail-pd0-f177.google.com with SMTP id v10so4717937pde.8
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xYNQFFiMJUmnnzwJNFl/CM5f5zsbVFyDWlYPuP9DW6w=;
        b=nWQdb3DpxDl4G2jP07D9/rK4IZlcCH9jsRfEZPJPAueDGnNGzyi1W1L0xcx3nDJ0FS
         2cYWGMJWOpStkETBdlAlXZPAh8wt5ylayYlm6WtsjwjDb478bAOS6pEDZ2uq5IoZ3gYd
         nWOEr732HNhMmUk1lYrY7mHnUu4nwCdJ7hguo8xZaHnb9cbFQUO266ZPG5esDzUmFSXz
         BhFvNrlBFBZ+LUG0dG7ULu9fGMS+2jzKwn0zlDavctVM73UUdgeFvNkMG7x1EqyQZ+Nr
         WQQtIC/Ev/nzVwXgukD3Kh65VL8e/zPqD3r29roytZwdM/L1TVVDenYmmXoSabMvHwy8
         sicg==
X-Received: by 10.70.88.44 with SMTP id bd12mr18026196pdb.133.1415439650975;
        Sat, 08 Nov 2014 01:40:50 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id nb5sm11025487pbc.25.2014.11.08.01.40.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:40:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:41:04 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7870d4a..794176f 100644
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
2.1.0.rc0.78.gc0d8480
