From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/6] index-pack: avoid collision test when verifying in-repo pack
Date: Wed, 23 May 2012 21:09:50 +0700
Message-ID: <1337782191-10091-5-git-send-email-pclouds@gmail.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 16:14:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXCKp-0002ZJ-KP
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 16:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760239Ab2EWOOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 10:14:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38109 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab2EWOOe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 10:14:34 -0400
Received: by pbbrp8 with SMTP id rp8so9945528pbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D7pcHP67nsVvdfAZINX5H8YqTKlH3cbskchCb2oApis=;
        b=gPtylqGJ+yDtijLPMhCR+SMvMd4HpOS1b4p4rjuznZPMd4oVUTEYB559pUN1f22KRs
         XO3jWva9QMZ6Q4GpRDbuu1z8VGezsB0LfFZMzJFuoy7bMdaSZ5duPgNpTQW5XtruxF3S
         9m2cpb5WpM5ABv724IrG/6tLzUbX+nXNksp8Z0Csgz6rU1GPfufU0FHWZ6ypqbvO5kaL
         QoKWsiojrnrdGHTZi4YZRFrxepd+DmAvuwqurJGf2KdBydx9WJ/Fv+rzMv68rByRqo8b
         0TD15DxTlYs4rmWfTbuTLuygCEeHrXdU3jqtIcSDRRAuo7hQxIkbrahDrohbeyoej7ab
         8cpQ==
Received: by 10.68.132.102 with SMTP id ot6mr11043700pbb.6.1337782473664;
        Wed, 23 May 2012 07:14:33 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.52.77])
        by mx.google.com with ESMTPS id wi8sm1988446pbc.11.2012.05.23.07.14.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 07:14:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 May 2012 21:10:32 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1337782191-10091-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198290>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 not part of the original goal, but while i'm touching this code..

 builtin/index-pack.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 05b1d35..641edb5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -78,6 +78,7 @@ static int nr_threads;
 static int from_stdin;
 static int strict;
 static int verbose;
+static int verify;
=20
 static struct progress *progress;
=20
@@ -688,11 +689,13 @@ static void sha1_object(const void *data, struct =
object_entry *obj_entry,
 	int collision_test_needed =3D 1;
 	enum object_type has_type;
 	unsigned long has_size;
+	struct object_info oi;
=20
 	assert(data || obj_entry);
=20
+	oi.sizep =3D &has_size;
 	read_lock();
-	has_type =3D sha1_object_info(sha1, &has_size);
+	has_type =3D sha1_object_info_extended(sha1, &oi);
 	read_unlock();
=20
 	if (has_type < 0)
@@ -703,6 +706,30 @@ static void sha1_object(const void *data, struct o=
bject_entry *obj_entry,
 			collision_test_needed =3D 0;
 		read_unlock();
 	}
+	read_lock();
+	if (collision_test_needed && oi.whence =3D=3D OI_PACKED &&
+	    verify && !from_stdin &&
+	    is_pack_valid(oi.u.packed.pack)) {
+		static int good_stats =3D -1;
+		static struct stat st1, st2;
+
+		good_stats =3D good_stats =3D=3D -1 &&
+			fstat_is_reliable() &&
+			!fstat(pack_fd, &st2) &&
+			!stat(oi.u.packed.pack->pack_name, &st1);
+		read_unlock();
+
+		/*
+		 * Windows builds do not support inode info. Inode
+		 * comparison would be wrong. Luckily in all Windows
+		 * builds set UNRELIABLE_FSTAT and good_stats would
+		 * always be 0, so we never get to inode comparison
+		 * test.
+		 */
+		if (good_stats && st1.st_ino =3D=3D st2.st_ino)
+			collision_test_needed =3D 0;
+	} else
+		read_unlock();
 	if (collision_test_needed) {
 		void *has_data;
 		if (has_type !=3D type || has_size !=3D size)
@@ -1459,7 +1486,7 @@ static void show_pack_info(int stat_only)
=20
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0, stat =3D 0=
;
+	int i, fix_thin_pack =3D 0, stat_only =3D 0, stat =3D 0;
 	const char *curr_pack, *curr_index;
 	const char *index_name =3D NULL, *pack_name =3D NULL;
 	const char *keep_name =3D NULL, *keep_msg =3D NULL;
--=20
1.7.10.2.549.g9354186
