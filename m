From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/11] Factor out and export large blob writing code to arbitrary file handle
Date: Mon, 27 Feb 2012 14:55:06 +0700
Message-ID: <1330329315-11407-3-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:56:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vRJ-0006vg-5f
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab2B0H4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:56:04 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33496 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab2B0H4C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:56:02 -0500
Received: by mail-pw0-f46.google.com with SMTP id up15so1787730pbc.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:56:02 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.130.134 as permitted sender) client-ip=10.68.130.134;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.130.134 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.130.134])
        by 10.68.130.134 with SMTP id oe6mr37166297pbb.93.1330329362107 (num_hops = 1);
        Sun, 26 Feb 2012 23:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Q+Oat3qcY6qDS83Ebh56D245OwHkcjJBUjhya8QQHIU=;
        b=qdMG8NJVyV/UIIACBFxqzxeaTqFptakblKQdAaV0dIsCBA7J9pEavAL/jY0lhBfFUl
         5PDMEj/XaBvw39AThqOdK3j00+whu/KtiTpcvWsv5643Kq8XDgwzWYtibKIny92kzVgf
         cIxIdx5nclQt937POoN8NmfCIZbzZB0EwE6aE=
Received: by 10.68.130.134 with SMTP id oe6mr31588179pbb.93.1330329362067;
        Sun, 26 Feb 2012 23:56:02 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id 3sm12028621pbx.66.2012.02.26.23.55.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 23:56:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:55:37 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191607>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    3 +++
 entry.c |   39 ++++++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index e12b15f..6ce691b 100644
--- a/cache.h
+++ b/cache.h
@@ -937,6 +937,9 @@ struct checkout {
 		 refresh_cache:1;
 };
=20
+extern int streaming_write_sha1(int fd, int seekable, const unsigned c=
har *sha1,
+				enum object_type exp_type,
+				struct stream_filter *filter);
 extern int checkout_entry(struct cache_entry *ce, const struct checkou=
t *state, char *topath);
=20
 struct cache_def {
diff --git a/entry.c b/entry.c
index 852fea1..dde0d17 100644
--- a/entry.c
+++ b/entry.c
@@ -115,26 +115,20 @@ static int fstat_output(int fd, const struct chec=
kout *state, struct stat *st)
 	return 0;
 }
=20
-static int streaming_write_entry(struct cache_entry *ce, char *path,
-				 struct stream_filter *filter,
-				 const struct checkout *state, int to_tempfile,
-				 int *fstat_done, struct stat *statbuf)
+int streaming_write_sha1(int fd, int seekable, const unsigned char *sh=
a1,
+			 enum object_type exp_type,
+			 struct stream_filter *filter)
 {
 	struct git_istream *st;
 	enum object_type type;
 	unsigned long sz;
 	int result =3D -1;
 	ssize_t kept =3D 0;
-	int fd =3D -1;
=20
-	st =3D open_istream(ce->sha1, &type, &sz, filter);
+	st =3D open_istream(sha1, &type, &sz, filter);
 	if (!st)
 		return -1;
-	if (type !=3D OBJ_BLOB)
-		goto close_and_exit;
-
-	fd =3D open_output_fd(path, ce, to_tempfile);
-	if (fd < 0)
+	if (exp_type !=3D OBJ_ANY && type !=3D exp_type)
 		goto close_and_exit;
=20
 	for (;;) {
@@ -144,7 +138,7 @@ static int streaming_write_entry(struct cache_entry=
 *ce, char *path,
=20
 		if (!readlen)
 			break;
-		if (sizeof(buf) =3D=3D readlen) {
+		if (seekable && sizeof(buf) =3D=3D readlen) {
 			for (holeto =3D 0; holeto < readlen; holeto++)
 				if (buf[holeto])
 					break;
@@ -166,10 +160,29 @@ static int streaming_write_entry(struct cache_ent=
ry *ce, char *path,
 	if (kept && (lseek(fd, kept - 1, SEEK_CUR) =3D=3D (off_t) -1 ||
 		     write(fd, "", 1) !=3D 1))
 		goto close_and_exit;
-	*fstat_done =3D fstat_output(fd, state, statbuf);
+	result =3D 0;
=20
 close_and_exit:
 	close_istream(st);
+	return result;
+}
+
+static int streaming_write_entry(struct cache_entry *ce, char *path,
+				 struct stream_filter *filter,
+				 const struct checkout *state, int to_tempfile,
+				 int *fstat_done, struct stat *statbuf)
+{
+	int result =3D -1;
+	int fd =3D open_output_fd(path, ce, to_tempfile);
+	if (fd < 0)
+		goto close_and_exit;
+
+	if (streaming_write_sha1(fd, 1, ce->sha1, OBJ_BLOB, filter))
+		goto close_and_exit;
+
+	*fstat_done =3D fstat_output(fd, state, statbuf);
+
+close_and_exit:
 	if (0 <=3D fd)
 		result =3D close(fd);
 	if (result && 0 <=3D fd)
--=20
1.7.3.1.256.g2539c.dirty
