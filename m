From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/17] fixup! pack-objects: support writing pack v4
Date: Sat, 21 Sep 2013 20:57:49 +0700
Message-ID: <1379771883-10278-4-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNeM-0008BB-DV
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab3IUNzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:00 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42217 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3IUNzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:00 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so1473350pbc.22
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OpcMSijrbkxGZgiP6MFkyOfHHPWQ10ZhgqOf85VQMMA=;
        b=b380jv5U7b0haeftgi6rSLBxFWpIn87p7ARVpZIIUSwcgx00zNDKYxk8aoyIjJ1nKf
         sphhF1Vdd61pknNXoKiynRU9TdA1pQDtSuieeHNEFNpVVj6FWUUE2hSnO/AiWdWV/s0u
         ab15pIZtolvaBGqWeGuoaG6bXltd6PG9uOgBRLs9Ut9wi3ptTqCgtnGn05UklxUB/3Yu
         zQJaMRdFvBZJwB4YPNhxxNqtDg4mDNaM2p33loi+Z1rKARFglEEBE2im0r/e/Q6d1MLs
         +7x19NF4188FUqtwAdBpheIlbsH76ri7qt7vPbE5fcQi5BpLOSIFE3vJ66Z6+ItOghEK
         /kGQ==
X-Received: by 10.66.216.193 with SMTP id os1mr14620516pac.29.1379771699593;
        Sat, 21 Sep 2013 06:54:59 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id ef10sm25724070pac.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:54:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235104>

In pack v4, commits should be forced to be loaded in canonical format
too (iow. deltified commits are flattened by read_sha1_file, we don't
care about object_entry->delta).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d3c1c8..30559e8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -260,10 +260,11 @@ static unsigned long write_no_reuse_object(struct=
 sha1file *f, struct object_ent
=20
 	if (!usable_delta ||
 	    /*
-	     * Force loading canonical tree. In future we may want to
-	     * read v4 trees directly instead.
+	     * Force loading canonical trees and commits. In future we
+	     * may want to read v4 objects directly instead.
 	     */
-	    (pack_version =3D=3D 4 && entry->type =3D=3D OBJ_TREE)) {
+	    (pack_version =3D=3D 4 && (entry->type =3D=3D OBJ_TREE ||
+				   entry->type =3D=3D OBJ_COMMIT))) {
 		if (entry->type =3D=3D OBJ_BLOB &&
 		    entry->size > big_file_threshold &&
 		    (st =3D open_istream(entry->idx.sha1, &type, &size, NULL)) !=3D =
NULL)
--=20
1.8.2.83.gc99314b
