From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH np/pack-v4] index-pack: tighten object type check based on pack version
Date: Wed, 18 Sep 2013 19:25:29 +0700
Message-ID: <1379507129-27151-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Sep 18 14:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMGlu-0001XQ-3q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 14:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab3IRMWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Sep 2013 08:22:12 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40557 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab3IRMWL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 08:22:11 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so6940223pdj.21
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=7P8n1Gz4PMs8c1+qSgt4KH/YyrdzaKaYNn5fQYLRGOc=;
        b=h4wDW4OwXr8xarerLSuXi/PlUjWJo3wtT2MtwZqtMoE5X1urvFU1k5zPnGsliHht0i
         FZHr7udppGlu5W5mi7n/Zp4uMeGujJKCRwP9vyLHZccOYqyVMZghMmBvttD153htfmZP
         WthXk+kl9O6VZbn6z5xbQf7B48qqZC84aKzlwHDA8RFaNw83Q5Cgkm9TyWniBuBj16OH
         WM4MyJFROD2NJeE74FozKYA1CsOkM7qmyKtPCJPHxckGaGFJTP4uNlXk9JfuudNsu5wq
         ta4haKz3H1cFvETrSCZPac8YKDGoyuSqWrkexYOEHs0HOu9LGsV5Vbe1yVS5EdryOdMO
         GOOg==
X-Received: by 10.67.14.231 with SMTP id fj7mr19461074pad.115.1379506930568;
        Wed, 18 Sep 2013 05:22:10 -0700 (PDT)
Received: from lanh ([115.73.221.161])
        by mx.google.com with ESMTPSA id w6sm2102072pbt.32.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 05:22:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Sep 2013 19:25:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234963>

In pack version 4, ref-delta technically could be used to compress any
objects including commits and trees (both canonical and v4). But it
does not make sense to do so. It can only lead to performance
degradation. Catch those packers.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I could now verify that pack-objects does not compress commits nor
 trees using ref-delta in v4. But perhaps these are a bit too strict?
 Maybe downgrade from die() to warning() and still accept the pack?

 builtin/index-pack.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fbf97f0..e4ecf69 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -788,6 +788,12 @@ static void *unpack_raw_entry(struct object_entry =
*obj,
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		break;
+
+	/*
+	 * OBJ_PV4_* are all greater than 7, which is the limit of
+	 * field "type" in pack v2. So we do not really need 'if
+	 * (!packv4) die("wrong type");' here.
+	 */
 	case OBJ_PV4_COMMIT:
 		obj->real_type =3D OBJ_COMMIT;
 		break;
@@ -1288,6 +1294,16 @@ static void resolve_delta(struct object_entry *d=
elta_obj,
 	hash_sha1_file(result->data, result->size,
 		       typename(delta_obj->real_type), delta_obj->idx.sha1);
 	check_against_sha1table(delta_obj->idx.sha1);
+	if (packv4 &&
+	    delta_obj->type =3D=3D OBJ_REF_DELTA &&
+	    delta_obj->real_type =3D=3D OBJ_TREE)
+		bad_object(delta_obj->idx.offset,
+			   _("ref-delta on a tree is not supported in pack version 4"));
+	if (packv4 &&
+	    delta_obj->type =3D=3D OBJ_REF_DELTA &&
+	    delta_obj->real_type =3D=3D OBJ_COMMIT)
+		bad_object(delta_obj->idx.offset,
+			   _("ref-delta on a commit is not supported in pack version 4"));
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
 	counter_lock();
--=20
1.8.2.83.gc99314b
