From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 3/4] write_entry: use streaming interface for checkout large files
Date: Thu, 28 May 2009 15:29:09 +1000
Message-ID: <1243488550-15357-4-git-send-email-pclouds@gmail.com>
References: <1243488550-15357-1-git-send-email-pclouds@gmail.com>
 <1243488550-15357-2-git-send-email-pclouds@gmail.com>
 <1243488550-15357-3-git-send-email-pclouds@gmail.com>
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
	id 1M9YBH-000273-Od
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 07:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761328AbZE1F3T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 01:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761078AbZE1F3S
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 01:29:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:19285 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761510AbZE1F3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 01:29:17 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1075454wah.21
        for <git@vger.kernel.org>; Wed, 27 May 2009 22:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rocMakf/tFN+cLZVWnEKodhdKAr+f/Bk0BI0urUXAo0=;
        b=vMZ40OI4XOuFlcT5rr+ceel5SaIPB7f9foPj8GnNXw32DCzCHKPid9cGHypQrflsiO
         /ZM6fgYRtfVUOav8LHXXOu03iKWxaEiNkVFhI+j2zmWLMwg7OIVDzVO8JCvOj1cw0Icc
         +jR2lKfoOqRiOHGhTdrmuiiY55pFOrs/nk7hY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bwvexvnt9y5KL2ahOtiPV0i/qENTPn++j5EBuK1r8xYp7FolBe0w05N87gNe48Sphl
         aY20RMf8QVNGvQcl4giwbdC02dHc6Rl2G0KysIiglmen2d6qU2i35HbsrICixiKj1r2q
         OJlwf0Idvyg9DLlDmZkgjEtYA5z5j/kUppH10=
Received: by 10.115.93.18 with SMTP id v18mr550607wal.100.1243488558799;
        Wed, 27 May 2009 22:29:18 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id j26sm15348094waf.28.2009.05.27.22.29.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 22:29:17 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 28 May 2009 15:29:33 +1000
X-Mailer: git-send-email 1.6.3.1.257.gbd13
In-Reply-To: <1243488550-15357-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120148>

With this patch, Git's memory consumption should go pretty flat no
matter how large input files are. So:

 - less memory will be used
 - more less memory for systems that do not have proper mmap() support
 - unmappable files can now be checked in

TODO: buffer size, file size limit that triggers this routine

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 entry.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/entry.c b/entry.c
index cc841ed..2a49d7b 100644
--- a/entry.c
+++ b/entry.c
@@ -91,6 +91,65 @@ static void *read_blob_entry(struct cache_entry *ce,=
 unsigned long *size)
 	return NULL;
 }
=20
+/*
+ * Trying to write entry using blob streaming interface.
+ * Return 1 if normal interface should be used.
+ */
+static int write_large_entry(struct cache_entry *ce, char *path,
+			     const struct checkout *state, int to_tempfile)
+{
+	unsigned int ce_mode_s_ifmt =3D ce->ce_mode & S_IFMT;
+	struct loose_object_handle *oh =3D open_loose_object(ce->sha1);
+	char buf[8192];
+	long len;
+	int fd;
+	size_t wrote;
+
+	if (!oh)
+		return 1;
+
+	if (loose_object_type(oh) !=3D OBJ_BLOB) {
+		close_loose_object(oh);
+		return error("git checkout-index: unable to read sha1 file of %s (%s=
)",
+			     path, sha1_to_hex(ce->sha1));
+	}
+
+	if (convert_to_working_tree_needed(ce->name,  xsize_t(loose_object_si=
ze(oh)))) {
+		close_loose_object(oh);
+		return 1;
+	}
+
+	if (to_tempfile) {
+		if (ce_mode_s_ifmt =3D=3D S_IFREG)
+			strcpy(path, ".merge_file_XXXXXX");
+		else
+			strcpy(path, ".merge_link_XXXXXX");
+		fd =3D mkstemp(path);
+	} else if (ce_mode_s_ifmt =3D=3D S_IFREG) {
+		fd =3D create_file(path, ce->ce_mode);
+	} else {
+		fd =3D create_file(path, 0666);
+	}
+	if (fd < 0) {
+		close_loose_object(oh);
+		return error("git checkout-index: unable to create file %s (%s)",
+			     path, strerror(errno));
+	}
+
+	while ((len =3D read_loose_object(oh, buf, sizeof(buf))) > 0) {
+		wrote =3D write_in_full(fd, buf, len);
+		if (wrote !=3D len) {
+			close(fd);
+			close_loose_object(oh);
+			return error("git checkout-index: unable to write file %s", path);
+		}
+	}
+
+	close(fd);
+	close_loose_object(oh);
+	return 0;
+}
+
 static int write_entry(struct cache_entry *ce, char *path, const struc=
t checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt =3D ce->ce_mode & S_IFMT;
@@ -104,6 +163,15 @@ static int write_entry(struct cache_entry *ce, cha=
r *path, const struct checkout
 	switch (ce_mode_s_ifmt) {
 	case S_IFREG:
 	case S_IFLNK:
+		if (ce_mode_s_ifmt =3D=3D S_IFREG) {
+			ret =3D write_large_entry(ce, path, state, to_tempfile);
+			if (ret < 0) /* failed */
+				return ret;
+			if (ret =3D=3D 0) /* successful */
+				break;
+			/* else, go through */
+		}
+
 		new =3D read_blob_entry(ce, &size);
 		if (!new)
 			return error("git checkout-index: unable to read sha1 file of %s (%=
s)",
--=20
1.6.3.1.257.gbd13
