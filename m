From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/10] streaming: make streaming-write-entry to be more reusable
Date: Sun,  4 Mar 2012 19:59:48 +0700
Message-ID: <1330865996-2069-3-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 14:02:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4B5L-0003U1-9E
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 14:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab2CDNCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 08:02:40 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:42943 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab2CDNCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 08:02:22 -0500
Received: by dadp12 with SMTP id p12so3847615dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 05:02:22 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.234.131 as permitted sender) client-ip=10.68.234.131;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.234.131 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.234.131])
        by 10.68.234.131 with SMTP id ue3mr10264430pbc.5.1330866142257 (num_hops = 1);
        Sun, 04 Mar 2012 05:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TeScr1lDFxblAAJdyDAaDWL5Zl/FUo431PcNNQdWa/U=;
        b=Ewis2bgrFk6p6FrvSxzBLc9X3fM8NeV53RH7CTomZkZGWf5xn65coI7/hNBFVTLZOm
         H82Ao3zXxUuBbk203X8RGTByxGyuA/+bOWRp/rw8D+onRBiZm0Gsj4ZTo122erc8wuZN
         sXfh4kWhPgzj9N3Jd66WGXM5HLk2EaLSb0wy/XG2pKtEdyANN3RsTlYVr2kJtSPutab3
         5YgkddKll26rdVkkUJXOAUIuI/vPLBt9z2MPdwNOe7pnzbOh/UkMsG2Xf4ceyIovRcXq
         vFhwx8xZAkvlaNNz6nAHmqFX//U6rv3megJJ1YlxwD+dG2FPH1kWVMBKanEVt+Gm9Q4r
         bndw==
Received: by 10.68.234.131 with SMTP id ue3mr9048641pbc.5.1330866142047;
        Sun, 04 Mar 2012 05:02:22 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.34.94])
        by mx.google.com with ESMTPS id f5sm3301385pbq.43.2012.03.04.05.02.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 05:02:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 04 Mar 2012 20:00:15 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192154>

=46rom: Junio C Hamano <gitster@pobox.com>

The static function in entry.c takes a cache entry and streams its blob
contents to a file in the working tree.  Refactor the logic to a new AP=
I
function stream_blob_to_fd() that takes an object name and an open file
descriptor, so that it can be reused by other callers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 entry.c     |   53 +++++----------------------------------------------=
--
 streaming.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 streaming.h |    2 ++
 3 files changed, 62 insertions(+), 48 deletions(-)

diff --git a/entry.c b/entry.c
index 852fea1..17a6bcc 100644
--- a/entry.c
+++ b/entry.c
@@ -120,58 +120,15 @@ static int streaming_write_entry(struct cache_ent=
ry *ce, char *path,
 				 const struct checkout *state, int to_tempfile,
 				 int *fstat_done, struct stat *statbuf)
 {
-	struct git_istream *st;
-	enum object_type type;
-	unsigned long sz;
 	int result =3D -1;
-	ssize_t kept =3D 0;
-	int fd =3D -1;
-
-	st =3D open_istream(ce->sha1, &type, &sz, filter);
-	if (!st)
-		return -1;
-	if (type !=3D OBJ_BLOB)
-		goto close_and_exit;
+	int fd;
=20
 	fd =3D open_output_fd(path, ce, to_tempfile);
-	if (fd < 0)
-		goto close_and_exit;
-
-	for (;;) {
-		char buf[1024 * 16];
-		ssize_t wrote, holeto;
-		ssize_t readlen =3D read_istream(st, buf, sizeof(buf));
-
-		if (!readlen)
-			break;
-		if (sizeof(buf) =3D=3D readlen) {
-			for (holeto =3D 0; holeto < readlen; holeto++)
-				if (buf[holeto])
-					break;
-			if (readlen =3D=3D holeto) {
-				kept +=3D holeto;
-				continue;
-			}
-		}
-
-		if (kept && lseek(fd, kept, SEEK_CUR) =3D=3D (off_t) -1)
-			goto close_and_exit;
-		else
-			kept =3D 0;
-		wrote =3D write_in_full(fd, buf, readlen);
-
-		if (wrote !=3D readlen)
-			goto close_and_exit;
-	}
-	if (kept && (lseek(fd, kept - 1, SEEK_CUR) =3D=3D (off_t) -1 ||
-		     write(fd, "", 1) !=3D 1))
-		goto close_and_exit;
-	*fstat_done =3D fstat_output(fd, state, statbuf);
-
-close_and_exit:
-	close_istream(st);
-	if (0 <=3D fd)
+	if (0 <=3D fd) {
+		result =3D stream_blob_to_fd(fd, ce->sha1, filter, 1);
+		*fstat_done =3D fstat_output(fd, state, statbuf);
 		result =3D close(fd);
+	}
 	if (result && 0 <=3D fd)
 		unlink(path);
 	return result;
diff --git a/streaming.c b/streaming.c
index 71072e1..7e7ee2b 100644
--- a/streaming.c
+++ b/streaming.c
@@ -489,3 +489,58 @@ static open_method_decl(incore)
=20
 	return st->u.incore.buf ? 0 : -1;
 }
+
+
+/****************************************************************
+ * Users of streaming interface
+ ****************************************************************/
+
+int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream=
_filter *filter,
+		      int can_seek)
+{
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+	ssize_t kept =3D 0;
+	int result =3D -1;
+
+	st =3D open_istream(sha1, &type, &sz, filter);
+	if (!st)
+		return result;
+	if (type !=3D OBJ_BLOB)
+		goto close_and_exit;
+	for (;;) {
+		char buf[1024 * 16];
+		ssize_t wrote, holeto;
+		ssize_t readlen =3D read_istream(st, buf, sizeof(buf));
+
+		if (!readlen)
+			break;
+		if (can_seek && sizeof(buf) =3D=3D readlen) {
+			for (holeto =3D 0; holeto < readlen; holeto++)
+				if (buf[holeto])
+					break;
+			if (readlen =3D=3D holeto) {
+				kept +=3D holeto;
+				continue;
+			}
+		}
+
+		if (kept && lseek(fd, kept, SEEK_CUR) =3D=3D (off_t) -1)
+			goto close_and_exit;
+		else
+			kept =3D 0;
+		wrote =3D write_in_full(fd, buf, readlen);
+
+		if (wrote !=3D readlen)
+			goto close_and_exit;
+	}
+	if (kept && (lseek(fd, kept - 1, SEEK_CUR) =3D=3D (off_t) -1 ||
+		     write(fd, "", 1) !=3D 1))
+		goto close_and_exit;
+	result =3D 0;
+
+ close_and_exit:
+	close_istream(st);
+	return result;
+}
diff --git a/streaming.h b/streaming.h
index 589e857..3e82770 100644
--- a/streaming.h
+++ b/streaming.h
@@ -12,4 +12,6 @@ extern struct git_istream *open_istream(const unsigne=
d char *, enum object_type
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, char *, size_t);
=20
+extern int stream_blob_to_fd(int fd, const unsigned char *, struct str=
eam_filter *, int can_seek);
+
 #endif /* STREAMING_H */
--=20
1.7.8.36.g69ee2
