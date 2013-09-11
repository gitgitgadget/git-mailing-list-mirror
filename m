From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/21] unpack-objects: decode v4 commits
Date: Wed, 11 Sep 2013 13:06:17 +0700
Message-ID: <1378879582-15372-17-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 11 08:08:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdbl-00078b-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab3IKGIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:08:53 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:59893 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab3IKGIw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:08:52 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so8644796pdj.8
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0P9J7xJZAobn3/MRWRhnAcoPf2Sxiyn/ISpo+jhccHE=;
        b=QuLIxfDiIeabxjo5qkXF/UpuMUyt2dNBMQC2M44VX69DdR2tLdeMu4mj7fd77qjKNs
         OGMMwxIN8nH8M4LXmYk9AX/nc+y4+Vr7zW7QFAm7pgO59EQ71542J2emNryniKsrT0X9
         KP8Fs4bRQTxO4bHf+346solnGimfl5+biatHEGPwqHCStf4HN1yR0PhQiCayFEqa+stg
         ouhlP2ZudbEiX9WoJC+wSYivHynKsWvYIhMut5/Q6vDkb3izjhNo6uYXRXl00LpMfdNz
         hl3HL3M/DEiHhZgGIQrmwCLt9Ja3VCCc4HbP+9M3d9YNJt5g0Mbh7GWD+f0xsSgji3Iv
         zUmA==
X-Received: by 10.66.25.232 with SMTP id f8mr1762679pag.25.1378879732355;
        Tue, 10 Sep 2013 23:08:52 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id os4sm27448596pbb.25.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:08:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:08:45 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234540>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/unpack-objects.c | 60 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 60 insertions(+)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f8442f4..6fc72c1 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -131,6 +131,15 @@ static const unsigned char *read_sha1ref(void)
 	return sha1_table + index * 20;
 }
=20
+static const unsigned char *read_dictref(struct packv4_dict *dict)
+{
+	unsigned int index =3D read_varint();
+	if (index >=3D dict->nb_entries)
+		die("bad index in read_dictref at %lu",
+		    (unsigned long)consumed_bytes);
+	return  dict->data + dict->offsets[index];
+}
+
 static void *get_data(unsigned long size)
 {
 	git_zstream stream;
@@ -467,6 +476,54 @@ static void unpack_delta_entry(enum object_type ty=
pe, unsigned long delta_size,
 	free(base);
 }
=20
+static void unpack_commit_v4(unsigned long size, unsigned long nr)
+{
+	unsigned int nb_parents;
+	const unsigned char *committer, *author, *ident;
+	unsigned long author_time, committer_time;
+	int16_t committer_tz, author_tz;
+	struct strbuf dst;
+	char *remaining;
+
+	strbuf_init(&dst, size);
+
+	strbuf_addf(&dst, "tree %s\n", sha1_to_hex(read_sha1ref()));
+	nb_parents =3D read_varint();
+	while (nb_parents--)
+		strbuf_addf(&dst, "parent %s\n", sha1_to_hex(read_sha1ref()));
+
+	committer_time =3D read_varint();
+	ident =3D read_dictref(name_dict);
+	committer_tz =3D (ident[0] << 8) | ident[1];
+	committer =3D ident + 2;
+
+	author_time =3D read_varint();
+	ident =3D read_dictref(name_dict);
+	author_tz =3D (ident[0] << 8) | ident[1];
+	author =3D ident + 2;
+
+	if (author_time & 1)
+		author_time =3D committer_time + (author_time >> 1);
+	else
+		author_time =3D committer_time - (author_time >> 1);
+
+	strbuf_addf(&dst,
+		    "author %s %lu %+05d\n"
+		    "committer %s %lu %+05d\n",
+		    author, author_time, author_tz,
+		    committer, committer_time, committer_tz);
+
+	if (dst.len > size)
+		die("bad commit");
+
+	remaining =3D get_data(size - dst.len);
+	strbuf_add(&dst, remaining, size - dst.len);
+	if (!dry_run)
+		write_object(nr, OBJ_COMMIT, dst.buf, dst.len);
+	else
+		strbuf_release(&dst);
+}
+
 static void read_typesize_v2(enum object_type *type, unsigned long *si=
ze)
 {
 	unsigned char c =3D *(char*)fill_and_use(1);
@@ -511,6 +568,9 @@ static int unpack_one(unsigned nr)
 	case OBJ_OFS_DELTA:
 		unpack_delta_entry(type, size, nr);
 		break;
+	case OBJ_PV4_COMMIT:
+		unpack_commit_v4(size, nr);
+		break;
 	default:
 		error("bad object type %d", type);
 		has_errors =3D 1;
--=20
1.8.2.82.gc24b958
