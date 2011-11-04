From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] Stop verify_packfile() as soon as an error occurs
Date: Fri,  4 Nov 2011 22:47:48 +0700
Message-ID: <1320421670-518-3-git-send-email-pclouds@gmail.com>
References: <1320421670-518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 16:49:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMM1R-0003E6-M6
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 16:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab1KDPtd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 11:49:33 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37365 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932551Ab1KDPtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 11:49:32 -0400
Received: by qyk2 with SMTP id 2so2109098qyk.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EGn7UIwKnEsFkhWW+JU7kjVEOCmlpKVa71Yvj3NClvI=;
        b=tLoQlUb5+hg0ebYGwF4YEmpCR8peYdFWM/5medzhxKhpgpvPss4cK/rILwKmzqm4Uw
         GKRY1Nn5woYL215ETvNXss77ywdgKj9X6qkBQoi1ysYdufUwdyWs4YgmAS5TAxdnIcQt
         4rkSuleaUP5NfcxHOpiHHyPbepJAUdAmculy0=
Received: by 10.50.213.40 with SMTP id np8mr12667446igc.10.1320421771914;
        Fri, 04 Nov 2011 08:49:31 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.210.255])
        by mx.google.com with ESMTPS id a6sm9700626igc.3.2011.11.04.08.49.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 08:49:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 04 Nov 2011 22:48:12 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320421670-518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184779>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pack-check.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 0c19b6e..e33ea79 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -79,6 +79,8 @@ static int verify_packfile(struct packed_git *p,
 		err =3D error("%s SHA1 does not match its index",
 			    p->pack_name);
 	unuse_pack(w_curs);
+	if (err)
+		return err;
=20
 	/* Make sure everything reachable from idx is valid.  Since we
 	 * have verified that nr_objects matches between idx and pack,
@@ -106,11 +108,13 @@ static int verify_packfile(struct packed_git *p,
 			off_t offset =3D entries[i].offset;
 			off_t len =3D entries[i+1].offset - offset;
 			unsigned int nr =3D entries[i].nr;
-			if (check_pack_crc(p, w_curs, offset, len, nr))
+			if (check_pack_crc(p, w_curs, offset, len, nr)) {
 				err =3D error("index CRC mismatch for object %s "
 					    "from %s at offset %"PRIuMAX"",
 					    sha1_to_hex(entries[i].sha1),
 					    p->pack_name, (uintmax_t)offset);
+				break;
+			}
 		}
 		data =3D unpack_entry(p, entries[i].offset, &type, &size);
 		if (!data) {
--=20
1.7.4.74.g639db
