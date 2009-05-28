From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 2/4] sha1_file.c: add streaming interface for reading blobs
Date: Thu, 28 May 2009 15:29:08 +1000
Message-ID: <1243488550-15357-3-git-send-email-pclouds@gmail.com>
References: <1243488550-15357-1-git-send-email-pclouds@gmail.com>
 <1243488550-15357-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 07:29:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9YBG-000273-Fz
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 07:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760680AbZE1F3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 01:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760466AbZE1F3M
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 01:29:12 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:32974 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759015AbZE1F3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 01:29:09 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so792455pxi.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Y8GbxTwslmsVKwwvAAAVmR6LZYeWEyLxIy++FAWQ4/g=;
        b=MtU1YDzG8nsU+n//LhywTXqjp/LyLZepnmg60217nUvUGL79tkxpgZ+NjyC+1++B4Y
         v0duiAnIiH5spsFPbC9jCxQXbJCBzgcEGaan6gIsfyEku3g3ANetowerdEHn2IrsW/dL
         oBhcgWMm1T4GXJTHAEA7edYSSnQ7bvQF4q6mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=M8Ppl9sW+ETbucBo4qwb8MkvNm58xoIOsDTaI2345Py7NG1+rxaYE3UpAq8GapjT8t
         uWXUF8ImMzdEwltpoB/C+13A0tLuoKlG45sle9+AluzEkDra7hbDha8S5dZzvoH20ZiA
         pBrq60kljuSdmwxHGaiVnSesVTwExOVhY6GUs=
Received: by 10.115.107.1 with SMTP id j1mr575879wam.62.1243488551895;
        Wed, 27 May 2009 22:29:11 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id n6sm1094518wag.4.2009.05.27.22.29.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 22:29:11 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 28 May 2009 15:29:26 +1000
X-Mailer: git-send-email 1.6.3.1.257.gbd13
In-Reply-To: <1243488550-15357-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120147>

The reason is quite obvious: large files should not be read entirely
into memory (and in some cases, cannot).

This patch deals with separate blobs only for two reasons:

 1. large blobs are less likely to be put in packs (*)
 2. streaming interface for blobs in pack is more complicated, thus
    more troublesome

(*) With regard to the first point, there is an assumption that large
blobs must stay out of pack otherwise you cannot make use of this
interface. This is not true now, but it was discussed and worked on in
the past. Hopefully a patch series that makes this assumption true
will come soon.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |    8 ++++
 sha1_file.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index f3fc822..f6f70ce 100644
--- a/cache.h
+++ b/cache.h
@@ -655,6 +655,14 @@ extern int write_sha1_file(void *buf, unsigned lon=
g len, const char *type, unsig
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, =
unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime)=
;
=20
+struct loose_object_handle;
+struct loose_object_handle *open_loose_object(const unsigned char *sha=
1);
+int read_loose_object(struct loose_object_handle *oh, void *buf, unsig=
ned long len);
+int close_loose_object(struct loose_object_handle *oh);
+const unsigned char *loose_object_sha1(struct loose_object_handle *oh)=
;
+unsigned long loose_object_size(struct loose_object_handle *oh);
+enum object_type loose_object_type(struct loose_object_handle *oh);
+
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
=20
diff --git a/sha1_file.c b/sha1_file.c
index e73cd4f..2ed06a2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1340,6 +1340,119 @@ static void *unpack_sha1_file(void *map, unsign=
ed long mapsize, enum object_type
 	return unpack_sha1_rest(&stream, hdr, *size, sha1);
 }
=20
+
+struct loose_object_handle {
+	unsigned char sha1[20];
+	enum object_type type;
+	unsigned long size;
+
+	int fd;
+	z_stream stream;
+	char *bufin, *bufout;
+	int bufin_length, bufout_length;
+	unsigned long start, end;
+};
+
+enum object_type loose_object_type(struct loose_object_handle *oh)
+{
+	return oh->type;
+}
+
+unsigned long loose_object_size(struct loose_object_handle *oh)
+{
+	return oh->size;
+}
+
+const unsigned char *loose_object_sha1(struct loose_object_handle *oh)
+{
+	return oh->sha1;
+}
+
+struct loose_object_handle *open_loose_object(const unsigned char *sha=
1)
+{
+	int ret, len;
+	struct loose_object_handle oh, *ohp;
+
+	oh.fd =3D open_sha1_file(sha1);
+	if (oh.fd =3D=3D -1)
+		return NULL;
+
+	oh.bufin_length =3D 8192;
+	oh.bufin =3D xmalloc(oh.bufin_length);
+	len =3D xread(oh.fd, oh.bufin, oh.bufin_length);
+	if (len =3D=3D -1) {
+		free(oh.bufin);
+		return NULL;
+	}
+
+	oh.bufout_length =3D 8192;
+	oh.bufout =3D xmalloc(oh.bufout_length);
+
+	ret =3D unpack_sha1_header(&oh.stream, (unsigned char *)oh.bufin, len=
, oh.bufout, oh.bufout_length);
+	if (ret < Z_OK || (oh.type =3D parse_sha1_header(oh.bufout, &oh.size)=
) < 0) {
+		free(oh.bufin);
+		free(oh.bufout);
+		return NULL;
+	}
+
+	ohp =3D xmalloc(sizeof(*ohp));
+	*ohp =3D oh;
+	memcpy(ohp->sha1, sha1, 20);
+
+	ohp->start =3D strlen(ohp->bufout)+1;
+	ohp->end =3D ohp->stream.total_out;
+	return ohp;
+}
+
+int read_loose_object(struct loose_object_handle *oh, void *buf, unsig=
ned long buflen)
+{
+	if (oh->end =3D=3D oh->start) {
+		int status;
+
+		oh->start =3D 0;
+		oh->stream.next_out =3D (unsigned char*)oh->bufout;
+		oh->stream.avail_out =3D oh->bufout_length;
+		status =3D inflate(&oh->stream, Z_NO_FLUSH);
+		oh->end =3D oh->stream.next_out - (unsigned char*)oh->bufout;
+
+		if (oh->stream.avail_in =3D=3D 0) {
+			oh->stream.avail_in =3D xread(oh->fd, oh->bufin, oh->bufin_length);
+			oh->stream.next_in =3D (unsigned char *)oh->bufin;
+		}
+
+		/* trying to get Z_STREAM_END */
+		if (oh->stream.total_out =3D=3D oh->size && status =3D=3D Z_OK) {
+			status =3D inflate(&oh->stream, Z_NO_FLUSH);
+
+			if (status < 0)
+				error("corrupt loose object '%s'", sha1_to_hex(oh->sha1));
+			else if (oh->stream.avail_in)
+				error("garbage at end of loose object '%s'",
+				      sha1_to_hex(oh->sha1));
+		}
+	}
+
+	if (oh->end > oh->start) {
+		int len =3D oh->end - oh->start;
+		memcpy(buf, (char *) oh->bufout + oh->start, len);
+		oh->start =3D oh->end;
+		return len;
+	}
+
+	/* How can it get here? */
+	return -1;
+}
+
+int close_loose_object(struct loose_object_handle *oh)
+{
+	close(oh->fd);
+	free(oh->bufin);
+	free(oh->bufout);
+	inflateEnd(&oh->stream);
+	free(oh);
+	return 0;
+}
+
 unsigned long get_size_from_delta(struct packed_git *p,
 				  struct pack_window **w_curs,
 			          off_t curpos)
--=20
1.6.3.1.257.gbd13
