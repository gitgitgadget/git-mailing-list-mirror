From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/17] fixup! pack v4: code to obtain a SHA1 from a sha1ref
Date: Sat, 21 Sep 2013 20:57:54 +0700
Message-ID: <1379771883-10278-9-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNet-0000uc-6L
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab3IUNzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:31 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:58647 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab3IUNz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:28 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so1476078pdj.30
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Drr4iCyGYYICXJLPA5dgXV0LisZq1a3RwZO7Z4N0EdU=;
        b=DRMBsVaPSW1g0Krk4s6h96NFjQ7u7HB4Q8KB8bJpGYjn95BicvTvphGqW53CPTnA85
         EHNbuMLKNd8s2T716O/Y+LgrIrsWlRx2UctDZO+TWbl2GsTJqc/KjUKbSChlMM7t1OLN
         yW2zRARIT0iIrAtLa+qTF92GdEIaWhKWPLg3McBpuzwr+fn5VP1CMUp3Vy5a0vtfCNVv
         96xLo9MvcZPmniDHXH8w6o0KxogpE1Ke7oGu+L4odzWeIuM6Ff8+UPn94WDik6k/CScy
         zMHGmfZQQV4VM+5jVbzS5gq9troAAupjUvHa84g5lF3v/eW16Hv/d80te4M/f51WadIb
         rLpw==
X-Received: by 10.68.225.164 with SMTP id rl4mr3558833pbc.100.1379771728280;
        Sat, 21 Sep 2013 06:55:28 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id tx5sm21082674pbc.29.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:51 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235109>

Don't die or it'll upset t5303's recovery action by repacking from
loose objects

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index e833cd2..88b7aa1 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -18,13 +18,18 @@ const unsigned char *get_sha1ref(struct packed_git =
*p,
 {
 	const unsigned char *sha1;
=20
+	if (!p->sha1_table)
+		return NULL;
+
 	if (!**bufp) {
 		sha1 =3D *bufp + 1;
 		*bufp +=3D 21;
 	} else {
 		unsigned int index =3D decode_varint(bufp);
-		if (index < 1 || index - 1 > p->num_objects)
-			die("bad index in %s", __func__);
+		if (index < 1 || index - 1 > p->num_objects) {
+			error("bad index in get_sha1ref");
+			return NULL;
+		}
 		sha1 =3D p->sha1_table + (index - 1) * 20;
 	}
=20
--=20
1.8.2.83.gc99314b
