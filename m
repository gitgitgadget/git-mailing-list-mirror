From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 4/4] index_fd: support indexing large files
Date: Thu, 28 May 2009 15:29:10 +1000
Message-ID: <1243488550-15357-5-git-send-email-pclouds@gmail.com>
References: <1243488550-15357-1-git-send-email-pclouds@gmail.com>
 <1243488550-15357-2-git-send-email-pclouds@gmail.com>
 <1243488550-15357-3-git-send-email-pclouds@gmail.com>
 <1243488550-15357-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 07:30:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9YCP-0002oI-SU
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 07:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760122AbZE1F3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 01:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759826AbZE1F3a
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 01:29:30 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:52587 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756302AbZE1F3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 01:29:24 -0400
Received: by pzk7 with SMTP id 7so4029474pzk.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4QLspA+0TYNDVn+Pd3LfTsUOdkRmrE35JnhdwBIEjQc=;
        b=AXhPdT7LtpoGdRvcTOD0y3ZrRxVWJnb6E2nRzfy3gBK5AvNFzoflCSPXb8uPHhI8RN
         n2UB97WPWC4Vc56CK5heBk8/uWFs22OdID1LNZ2TX6h+m5KlUwyRqz4WNG33NPyLWklO
         eXI8ZOe6BhYQtsM34vc86Ms3+VGGheK5mWtx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iCbOP852ajClcBUNXGLFAMTwfuHkCMoc28oOYx9II9qlmem2cgBN8cpihoIL4og49L
         P6tUBM9Fpi8p+5oxQcNdFxZYk/1bEmkg+06RdMXWjyJFPqY9IqeLzVQtNPKmSi1Jhdgj
         vr8RBUyiyIOffrZQM7twkhfR2ATVuMqL/C8BI=
Received: by 10.114.202.15 with SMTP id z15mr550898waf.67.1243488565581;
        Wed, 27 May 2009 22:29:25 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id m31sm14983526wag.31.2009.05.27.22.29.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 22:29:24 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 28 May 2009 15:29:40 +1000
X-Mailer: git-send-email 1.6.3.1.257.gbd13
In-Reply-To: <1243488550-15357-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120150>

This patch is less impressed than the previous one as memory usage is
usually lower. But then systems without proper mmap() would still love =
it.

TODO: again, file limit

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c |  120 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2ed06a2..f4f90ab 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2609,12 +2609,132 @@ static int index_mem(unsigned char *sha1, void=
 *buf, size_t size,
 	return ret;
 }
=20
+static int index_and_write_fd(unsigned char *sha1, int fd, struct stat=
 *st,
+			      enum object_type type, const char *path)
+{
+	int fdo, ret;
+	z_stream stream;
+	char *filename;
+	static char tmpfile[PATH_MAX];
+	int hdrlen;
+	int bufin_length =3D 8192, bufout_length =3D 8192;
+	char bufin[8192], bufout[8192];
+	int written_out =3D 0;
+	git_SHA_CTX c;
+
+	fdo =3D create_tmpfile(tmpfile, sizeof(tmpfile), "foo");
+	if (fdo < 0) {
+		if (errno =3D=3D EACCES)
+			return error("insufficient permission for adding an object to repos=
itory database %s\n", get_object_directory());
+		else
+			return error("unable to create temporary sha1 filename %s: %s\n", t=
mpfile, strerror(errno));
+	}
+
+	hdrlen =3D sprintf(bufin, "%s %lu", typename(type), (unsigned long)st=
->st_size)+1;
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, bufin, hdrlen);
+
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, zlib_compression_level);
+	stream.next_out =3D (unsigned char *)bufout;
+	stream.avail_out =3D bufout_length;
+
+	/* First header.. */
+	stream.next_in =3D (unsigned char *)bufin;
+	stream.avail_in =3D hdrlen;
+	while (deflate(&stream, 0) =3D=3D Z_OK)
+		/* nothing */;
+
+	written_out =3D stream.total_out;
+	write_or_die(fdo, bufout, written_out);
+	stream.next_out =3D (unsigned char *)bufout;
+	stream.avail_out =3D bufout_length;
+
+	/* Then the data itself.. */
+	stream.next_in =3D (unsigned char *)bufin;
+	stream.avail_in =3D xread(fd, bufin, bufin_length);
+	git_SHA1_Update(&c, stream.next_in, stream.avail_in);
+
+	while ((ret =3D deflate(&stream, Z_NO_FLUSH)) =3D=3D Z_OK || ret =3D=3D=
 Z_BUF_ERROR) {
+		if (stream.total_out > written_out) {
+			write_or_die(fdo, bufout, stream.total_out - written_out);
+			written_out =3D stream.total_out;
+			stream.next_out =3D (unsigned char *)bufout;
+			stream.avail_out =3D bufout_length;
+		}
+		if (stream.avail_in =3D=3D 0) {
+			stream.next_in =3D (unsigned char *)bufin;
+			stream.avail_in =3D xread(fd, bufin, bufin_length);
+			if (!stream.avail_in)
+				break;
+			git_SHA1_Update(&c, stream.next_in, stream.avail_in);
+		}
+	}
+
+	/* Done computing SHA-1 */
+	git_SHA1_Final(sha1, &c);
+
+	/* Make sure everything is flushed out */
+	while ((ret =3D deflate(&stream, Z_FINISH)) =3D=3D Z_OK) {
+		write_or_die(fdo, bufout, stream.total_out - written_out);
+		written_out =3D stream.total_out;
+		stream.next_out =3D (unsigned char *)bufout;
+		stream.avail_out =3D bufout_length;
+	}
+
+	if (ret !=3D Z_STREAM_END)
+		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
+
+	/* Last piece */
+	if (written_out < stream.total_out)
+		write_or_die(fdo, bufout, stream.total_out - written_out);
+	close_sha1_file(fdo);
+
+	ret =3D deflateEnd(&stream);
+	if (ret !=3D Z_OK)
+		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
+
+	/* Now generate proper path from SHA-1 */
+	filename =3D sha1_file_name(sha1);
+	safe_create_leading_directories_const(filename);
+	return move_temp_to_file(tmpfile, filename);
+}
+
+static int hash_fd(unsigned char *sha1, int fd, struct stat *st,
+		   enum object_type type, const char *path)
+{
+	git_SHA_CTX c;
+	char buf[8192];
+	int buflen;
+
+	/* Generate the header */
+	buflen =3D sprintf(buf, "%s %lu", typename(type), (unsigned long)st->=
st_size)+1;
+
+	/* Sha1.. */
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, buf, buflen);
+	while ((buflen =3D xread(fd, buf, 8192)) > 0)
+		git_SHA1_Update(&c, buf, buflen);
+	git_SHA1_Final(sha1, &c);
+	return 0;
+}
+
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_o=
bject,
 	     enum object_type type, const char *path)
 {
 	int ret;
 	size_t size =3D xsize_t(st->st_size);
=20
+	if (S_ISREG(st->st_mode) && path && !convert_to_git_needed(path, size=
)) {
+		if (write_object)
+			ret =3D index_and_write_fd(sha1, fd, st, type, path);
+		else
+			ret =3D hash_fd(sha1, fd, st, type, path);
+		close(fd);
+		return ret;
+	}
+
 	if (!S_ISREG(st->st_mode)) {
 		struct strbuf sbuf =3D STRBUF_INIT;
 		if (strbuf_read(&sbuf, fd, 4096) >=3D 0)
--=20
1.6.3.1.257.gbd13
