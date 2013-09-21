From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/17] packv4-parse: accept ref-delta as base of pv4-tree
Date: Sat, 21 Sep 2013 20:57:57 +0700
Message-ID: <1379771883-10278-12-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNf4-0001JQ-Hc
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab3IUNzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:46 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61858 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3IUNzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:45 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so1830577pad.28
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AJLRBBH6eH6BNudQzYdoYUJrFRBidmydd1v2B29/0vE=;
        b=XQwlaUC9OZdfsKGZZl1WbQ1J57vlsD31heBkobAdsjT94eUrGz5v4A5TYeT/UbGWsE
         A+sTn89EXU71uwir7U8KsgYVJ5C/Im3H1dcETaVNX+NXTAfTOJeYYH6wAmGh/fWH4gf+
         QLKOmWIkCZ9ihIqlmCciOxHyG6+LbVkYDaiusbE50P5oMiQ3Q6q5sN0pTMHPRwaETl9h
         G6q5ydRglf9cY0iF7ZSUJ2PTZiTZxD//wQchLN8AE0Huw69AIJUJIdMJAz0Efr+P0O75
         OXAk/3KeWB67enXVzP4ANKx/QIxNIktNxIXqvMdvfKA/tDcQvvFLaf+Oq6ZCcXemF8ne
         3S7w==
X-Received: by 10.67.30.164 with SMTP id kf4mr14510339pad.13.1379771745368;
        Sat, 21 Sep 2013 06:55:45 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id ry4sm25719353pab.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:59:08 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235112>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 88b7aa1..31c89c7 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -473,16 +473,19 @@ static int decode_entries(struct packed_git *p, s=
truct pack_window **w_curs,
 			if (++scp - src >=3D avail - 20)
 				return -1;
=20
+		switch (*scp++ & 0xf) {
 		/* is this a canonical tree object? */
-		if ((*scp & 0xf) =3D=3D OBJ_TREE) {
+		case OBJ_TREE:
+		case OBJ_REF_DELTA:
 			return copy_canonical_tree_entries(p, obj_offset,
 							   start, count,
 							   dstp, sizep);
-		}
-
 		/* let's still make sure this is actually a pv4 tree */
-		if ((*scp++ & 0xf) !=3D OBJ_PV4_TREE)
+		case OBJ_PV4_TREE:
+			break;
+		default:
 			return -1;
+		}
=20
 		nb_entries =3D decode_varint(&scp);
 		if (!count)
--=20
1.8.2.83.gc99314b
