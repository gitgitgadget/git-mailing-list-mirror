From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/21] unpack-objects: recognize end-of-pack in v4 thin pack
Date: Wed, 11 Sep 2013 13:06:13 +0700
Message-ID: <1378879582-15372-13-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:08:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdbG-0006RX-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab3IKGIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:08:23 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:42787 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab3IKGIW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:08:22 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so8559169pbc.23
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hDyEZU1iwmFqSwB+Z4nRKALXiMFzdPm5V9aj0FB7Srs=;
        b=b+5MhM18xJETB7L4ESshb4XeScZmHRZeHbldosJsqZ8m29kkGCW3n7QoZfUmkO9XfB
         SZB3CLXTc2mU2+SB4rj7UiAooeE+IJ792HlsrQZtewknZ6CS7WK3ZjbT4Mv1derrE/2q
         +FnZUfYx5iZBIX3tHRjOEFp2wmFFqHZSJreetY/OJyyte4yL/WlOScd+fg6cGnz8DTjt
         pk6MNMVRnxzVOEkDELy4vk1lf8jdWWktvOKXt3bHbJrdiznj9CpfsLXUmYXr/FsYEHZu
         d/9dxTp/07bJlhIvmLH0uFpHuwfMngejxmQYASimgc38OxIAaUAdp49aDhLcichpbZWS
         y1SA==
X-Received: by 10.68.209.232 with SMTP id mp8mr16212324pbc.129.1378879701276;
        Tue, 10 Sep 2013 23:08:21 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id fk4sm1063002pab.23.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:08:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:08:14 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234536>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/unpack-objects.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6d0a65c..c9eb31d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -20,6 +20,7 @@ static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static git_SHA_CTX ctx;
+static int packv4;
=20
 /*
  * When running under --strict mode, objects whose reachability are
@@ -421,7 +422,7 @@ static void unpack_delta_entry(enum object_type typ=
e, unsigned long delta_size,
 	free(base);
 }
=20
-static void unpack_one(unsigned nr)
+static int unpack_one(unsigned nr)
 {
 	unsigned shift;
 	unsigned char *pack;
@@ -431,6 +432,10 @@ static void unpack_one(unsigned nr)
 	obj_list[nr].offset =3D consumed_bytes;
=20
 	pack =3D fill(1);
+	if (packv4 && *(char*)fill(1) =3D=3D 0) {
+		use(1);
+		return -1;
+	}
 	c =3D *pack;
 	use(1);
 	type =3D (c >> 4) & 7;
@@ -450,18 +455,19 @@ static void unpack_one(unsigned nr)
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		unpack_non_delta_entry(type, size, nr);
-		return;
+		break;
 	case OBJ_REF_DELTA:
 	case OBJ_OFS_DELTA:
 		unpack_delta_entry(type, size, nr);
-		return;
+		break;
 	default:
 		error("bad object type %d", type);
 		has_errors =3D 1;
 		if (recover)
-			return;
+			break;
 		exit(1);
 	}
+	return 0;
 }
=20
 static void unpack_all(void)
@@ -477,13 +483,15 @@ static void unpack_all(void)
 	if (!pack_version_ok(hdr->hdr_version))
 		die("unknown pack file version %"PRIu32,
 			ntohl(hdr->hdr_version));
+	packv4 =3D ntohl(hdr->hdr_version) =3D=3D 4;
 	use(sizeof(struct pack_header));
=20
 	if (!quiet)
 		progress =3D start_progress("Unpacking objects", nr_objects);
 	obj_list =3D xcalloc(nr_objects, sizeof(*obj_list));
 	for (i =3D 0; i < nr_objects; i++) {
-		unpack_one(i);
+		if (unpack_one(i))
+			break;
 		display_progress(progress, i + 1);
 	}
 	stop_progress(&progress);
--=20
1.8.2.82.gc24b958
