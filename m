From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] exclude: reduce computation cost on checking dirname in patterns
Date: Sat, 26 May 2012 19:31:14 +0700
Message-ID: <1338035474-4346-4-git-send-email-pclouds@gmail.com>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 14:35:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYGDl-0003nB-9t
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 14:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab2EZMfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 08:35:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42457 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab2EZMfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 08:35:44 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2318016dad.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RX4NoO1ZZiRCEVAvBBr1fESKqHZEKUBwc/bN1vKJuUI=;
        b=0mkAy334rb9VEXdvaC6l1pkM6cJHWK6YrA/BNudLCbBaQCs332A5fgijsoPnlq6hHf
         SSE/U4Uo9ulr5GoCs9JpcwMZpOfOtejfoP+bcasZDhrrFWyiENt4cd/E4tW1NmUjyciY
         Fh5Y6XQpbdGxex4P5dnaPLiiIbJjI87+wlxlExYq9Qao31Dn39RWpTLlv2M+7dueQtd1
         zMsJAJgyaW983gOfHNQZNTlZzdTKuz/Uh57HANFyrBm097N39tv+VYgSsknmGt4KSkMt
         FVxha28orliSirotg0loIrnAm1uTqMzzsri5FvuFoc/I+RMwDGwQyt0AuHLckS9ej67w
         7jUg==
Received: by 10.68.232.129 with SMTP id to1mr7480190pbc.27.1338035744191;
        Sat, 26 May 2012 05:35:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.50.33])
        by mx.google.com with ESMTPS id u5sm12408803pbu.76.2012.05.26.05.35.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 05:35:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 26 May 2012 19:31:42 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198556>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 dir.h |  3 +++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 50d744f..ff5e2d9 100644
--- a/dir.c
+++ b/dir.c
@@ -507,7 +507,7 @@ int excluded_from_list(const char *pathname,
 		       int pathlen, const char *basename, int *dtype,
 		       struct exclude_list *el)
 {
-	int i;
+	int i, baselen =3D pathlen - (basename - pathname);
=20
 	if (!el->nr)
 		return -1;	/* undefined */
@@ -562,6 +562,35 @@ int excluded_from_list(const char *pathname,
 		if (prefix > namelen)
 			continue;
=20
+		/*
+		 * it's supposed that the caller throws a series of pathnames of
+		 * the same dirname to this function when el->pruning !=3D 0.
+		 *
+		 * If we could check whether a pattern matches dirname, we could
+		 * save the result and reuse for next pathnames.  The caller
+		 * must reset pruned/dir_matched bits when it moves to a
+		 * different directory.
+		 */
+		if (el->samedir && prefix >=3D namelen - baselen) {
+			int matched;
+			if (x->flags & EXC_FLAG_DIR_MATCH_VALID)
+				matched =3D x->flags & EXC_FLAG_DIR_MATCHED;
+			else {
+				matched =3D !strncmp_icase(exclude, name, namelen - baselen);
+				if (matched)
+					x->flags |=3D EXC_FLAG_DIR_MATCHED;
+				x->flags |=3D EXC_FLAG_DIR_MATCH_VALID;
+			}
+
+			if  (!matched)
+				continue;
+
+			prefix  -=3D namelen - baselen;
+			exclude +=3D namelen - baselen;
+			name     =3D basename;
+			namelen  =3D baselen;
+		}
+
 		if (prefix) {
 			if (strncmp_icase(exclude, name, prefix))
 				continue;
@@ -576,6 +605,28 @@ int excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
=20
+static void prep_exclude_read_directory(struct dir_struct *dir,
+					const struct strbuf *path)
+{
+	int i, st;
+	prep_exclude(dir, path->buf, path->len);
+	for (st =3D EXC_CMDL; st <=3D EXC_FILE; st++) {
+		struct exclude_list *el =3D dir->exclude_list + st;
+		el->samedir =3D 1;
+		for (i =3D 0; i < el->nr; i++)
+			el->excludes[i]->flags &=3D ~EXC_FLAG_DIR_MATCH_VALID;
+	}
+}
+
+static void cleanup_exclude_read_directory(struct dir_struct *dir)
+{
+	int st;
+	for (st =3D EXC_CMDL; st <=3D EXC_FILE; st++) {
+		struct exclude_list *el =3D dir->exclude_list + st;
+		el->samedir =3D 0;
+	}
+}
+
 int excluded(struct dir_struct *dir, const char *pathname, int *dtype_=
p)
 {
 	int pathlen =3D strlen(pathname);
@@ -985,6 +1036,7 @@ static int read_directory_recursive(struct dir_str=
uct *dir,
 		return 0;
=20
 	strbuf_add(&path, base, baselen);
+	prep_exclude_read_directory(dir, &path);
=20
 	while ((de =3D readdir(fdir)) !=3D NULL) {
 		switch (treat_path(dir, de, &path, baselen, simplify)) {
@@ -1005,6 +1057,7 @@ static int read_directory_recursive(struct dir_st=
ruct *dir,
 			dir_add_name(dir, path.buf, path.len);
 	}
 exit_early:
+	cleanup_exclude_read_directory(dir);
 	closedir(fdir);
 	strbuf_release(&path);
=20
diff --git a/dir.h b/dir.h
index 39fc145..003daf4 100644
--- a/dir.h
+++ b/dir.h
@@ -7,12 +7,15 @@ struct dir_entry {
 };
=20
 #define EXC_FLAG_NODIR 1
+#define EXC_FLAG_DIR_MATCH_VALID 2
 #define EXC_FLAG_ENDSWITH 4
 #define EXC_FLAG_MUSTBEDIR 8
+#define EXC_FLAG_DIR_MATCHED 16
=20
 struct exclude_list {
 	int nr;
 	int alloc;
+	int samedir;
 	struct exclude {
 		const char *pattern;
 		int patternlen;
--=20
1.7.10.2.549.g9354186
