From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/32] pack-write: add functions for creating simple packs
Date: Wed, 25 Aug 2010 08:19:55 +1000
Message-ID: <1282688422-7738-6-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1su-0001Xh-Qu
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262Ab0HXWVc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:21:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47096 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097Ab0HXWVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:21:30 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so2824689pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uQ2K7XlReROgvtOjBBHp6en6CSaNHt23QMW0sCG1o3M=;
        b=iiFRZ22n6bIsywjW6OHn6JoLWW48S/irxoee2XQmunphZf6pN+sXv/Im4jMJswcDwV
         w8pT2RFsRWJBJCPejrniFgXmIce2CTB16c8fkCIAojUeFtKoDEaVNrTXk3kVpCvBjnzh
         9nmsoYibtO1yJJQkcPDCO3UCMscCazbTeNdnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rkcfqbnIJpGnY9H6OKFnNQ7yE7akcUrhF6kbjuaim2j4ZA8bu/u98cAPdxUIKZZsGf
         oQQVim1INuB7cl6uQikCAoqxKBRLI5CK8IsHKz8LrkIeu4HfB26oOgBys9tJXJkBfm2P
         vOy+QBjHLxW6R0tvafwh1qY8uRdqE2NSRgEmk=
Received: by 10.142.201.7 with SMTP id y7mr6186002wff.282.1282688490473;
        Tue, 24 Aug 2010 15:21:30 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id z1sm643008wfd.3.2010.08.24.15.21.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:21:29 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:21:24 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154347>

These are ripoffs from pack-objects and do not do deltas at all.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pack-write.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 pack.h       |   17 +++++++++++
 2 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index cc7761e..2b71bd2 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -305,3 +305,90 @@ unsigned long compress_object(void **pptr, unsigne=
d long size)
=20
 	return stream.total_out;
 }
+
+int create_pack(struct simple_pack *pack)
+{
+	char tmpname[PATH_MAX];
+	struct pack_header hdr;
+
+	if (pack->fd <=3D 0) {
+		pack->fd =3D odb_mkstemp(tmpname, sizeof(tmpname), "pack/tmp_pack_XX=
XXXX");
+		pack->pack_tmp_name =3D xstrdup(tmpname);
+	}
+	pack->f =3D sha1fd(pack->fd, pack->pack_tmp_name ? pack->pack_tmp_nam=
e : "<unknown>");
+
+	if (pack->nr_objects) {
+		int pointer_size =3D sizeof(struct pack_idx_entry*) * pack->nr_objec=
ts;
+		int item_size =3D sizeof(struct pack_idx_entry) * pack->nr_objects;
+		void *buf =3D xmalloc(item_size + pointer_size);
+		pack->written_list =3D buf;
+		pack->written_items =3D (void*)(((char*)buf) + pointer_size);
+	}
+
+	hdr.hdr_signature =3D htonl(PACK_SIGNATURE);
+	hdr.hdr_version =3D htonl(PACK_VERSION);
+	hdr.hdr_entries =3D htonl(pack->nr_objects);
+	sha1write(pack->f, &hdr, sizeof(hdr));
+	if (pack->written_list)
+		pack->offset =3D sizeof(hdr);
+
+	return 0;
+}
+
+int write_object_to_pack(struct simple_pack *pack,
+			 const unsigned char *sha1,
+			 void *buf,
+			 unsigned long size,
+			 enum object_type type)
+{
+	unsigned long datalen;
+	unsigned hdrlen;
+	unsigned char header[10];
+
+	datalen =3D compress_object(&buf, size);
+	hdrlen =3D encode_in_pack_object_header(type, size, header);
+	if (pack->written_list)
+		crc32_begin(pack->f);
+	sha1write(pack->f, header, hdrlen);
+	sha1write(pack->f, buf, datalen);
+	free(buf);
+
+	if (pack->written_list) {
+		struct pack_idx_entry *e;
+
+		e =3D pack->written_list[pack->nr_written] =3D pack->written_items;
+		e->crc32 =3D crc32_end(pack->f);
+		hashcpy(e->sha1, sha1);
+		e->offset =3D pack->offset;
+		pack->offset +=3D datalen+hdrlen;
+	}
+	pack->nr_written++;
+	pack->written_items++;
+
+	return 0;
+}
+
+int close_pack(struct simple_pack *pack)
+{
+	sha1close(pack->f, pack->sha1, CSUM_CLOSE);
+	if (pack->written_list) {
+		char tmpname[PATH_MAX];
+		const char *idx_tmp_name;
+
+		idx_tmp_name =3D write_idx_file(NULL, pack->written_list, pack->nr_w=
ritten, pack->sha1);
+
+		snprintf(tmpname, sizeof(tmpname), "%s/pack/pack-%s.pack", get_objec=
t_directory(), sha1_to_hex(pack->sha1));
+		free_pack_by_name(tmpname);
+		if (adjust_shared_perm(pack->pack_tmp_name))
+			die_errno("unable to make temporary pack file readable");
+		if (rename(pack->pack_tmp_name, tmpname))
+			die_errno("unable to rename temporary pack file");
+		snprintf(tmpname, sizeof(tmpname), "%s/pack/pack-%s.idx", get_object=
_directory(), sha1_to_hex(pack->sha1));
+		if (rename(idx_tmp_name, tmpname))
+			die_errno("unable to rename temporary pack file");
+		free(pack->written_list);
+	}
+	if (pack->pack_tmp_name)
+		free(pack->pack_tmp_name);
+	return 0;
+}
diff --git a/pack.h b/pack.h
index 28a966b..a2e32c7 100644
--- a/pack.h
+++ b/pack.h
@@ -55,6 +55,19 @@ struct pack_idx_entry {
 	off_t offset;
 };
=20
+struct simple_pack {
+	uint32_t nr_objects;
+	unsigned char sha1[20];
+
+	int fd;
+	struct sha1file *f;
+	uint32_t nr_written;
+	off_t offset;
+	char *pack_tmp_name;
+	struct pack_idx_entry **written_list;
+	struct pack_idx_entry *written_items;
+};
+
 extern const char *write_idx_file(const char *index_name, struct pack_=
idx_entry **objects, int nr_objects, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w=
_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
@@ -64,6 +77,10 @@ extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, u=
nsigned char *);
 extern unsigned long compress_object(void **, unsigned long size);
=20
+extern int create_pack(struct simple_pack *);
+extern int write_object_to_pack(struct simple_pack *, const unsigned c=
har *, void *, unsigned long, enum object_type);
+extern int close_pack(struct simple_pack *);
+
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
 #define PH_ERROR_PROTOCOL	(-3)
--=20
1.7.1.rc1.69.g24c2f7
