From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/12] dir.c: provide free_directory() for reclaiming dir_struct memory
Date: Mon, 15 Oct 2012 13:28:05 +0700
Message-ID: <1350282486-4646-11-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:30:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeBb-0001ln-10
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab2JOG3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:29:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55849 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab2JOG3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:29:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4544170pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=E8ONQdXS1r12fIsMOob0udYfCq2wGnMzHDB8D0/APTU=;
        b=vV1zzWPou6vcX7PS9iF8Y8GRDkFI8FI/ULulW4u9jIIarst+AK63TJbChuFyiyBu+r
         k2JKaMId0QJETbbRKuYER2ksR5bi3doqTLGK92bp3Q+3DnvrGAglIk2ALvrYV+xj1lNd
         3tnXWsQaNEmzRo0ZALcl8OTjgCO+x12SKXXb0R599bIzJ5IaBBUI6YwTz6ZX1vL2Y99n
         i9ktdP7Cmwt1RS7dPYCRHpY+Yo/dBQzq+i5k5BpX8gddiggE0QhETa1vxyKPH/5EcUSu
         K7ZK6bsRNFB83nQzjISgVyhG1+56itG067LtvwfuzfPU21f7K+EnEpHtyo8f52udTXsa
         KWZA==
Received: by 10.68.209.200 with SMTP id mo8mr34428098pbc.102.1350282587891;
        Sun, 14 Oct 2012 23:29:47 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pl2sm3088069pbb.66.2012.10.14.23.29.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:29:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:29:37 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207722>

=46rom: Adam Spiers <git@adamspiers.org>

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/api-directory-listing.txt |  2 ++
 dir.c                                             | 28 +++++++++++++++=
++++++--
 dir.h                                             |  1 +
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Docume=
ntation/technical/api-directory-listing.txt
index add6f43..ca571a8 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -76,4 +76,6 @@ marked. If you to exclude files, make sure you have l=
oaded index first.
=20
 * Use `dir.entries[]`.
=20
+* Call `free_directory()` when none of the contained elements are no l=
onger in use.
+
 (JC)
diff --git a/dir.c b/dir.c
index 81a5dd5..d50634d 100644
--- a/dir.c
+++ b/dir.c
@@ -481,6 +481,16 @@ void add_excludes_from_file(struct dir_struct *dir=
, const char *fname)
 		die("cannot use %s as an exclude file", fname);
 }
=20
+static void free_exclude_stack(struct exclude_stack *stk)
+{
+	free(stk->filebuf);
+	free(stk);
+}
+
+/*
+ * Loads the per-directory exclude list for the substring of base
+ * which has a char length of baselen.
+ */
 static void prep_exclude(struct dir_struct *dir, const char *base, int=
 baselen)
 {
 	struct exclude_list *el;
@@ -502,8 +512,7 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 			struct exclude *exclude =3D el->excludes[--el->nr];
 			free(exclude);
 		}
-		free(stk->filebuf);
-		free(stk);
+		free_exclude_stack(stk);
 	}
=20
 	/* Read from the parent directories and push them down. */
@@ -1521,3 +1530,18 @@ void free_pathspec(struct pathspec *pathspec)
 	free(pathspec->items);
 	pathspec->items =3D NULL;
 }
+
+void free_directory(struct dir_struct *dir)
+{
+	struct exclude_stack *stk;
+	int st;
+	for (st =3D EXC_CMDL; st <=3D EXC_FILE; st++)
+		free_excludes(&dir->exclude_list[st]);
+
+	stk =3D dir->exclude_stack;
+	while (stk) {
+		struct exclude_stack *prev =3D stk->prev;
+		free_exclude_stack(stk);
+		stk =3D prev;
+	}
+}
diff --git a/dir.h b/dir.h
index 3921aa9..fb57c66 100644
--- a/dir.h
+++ b/dir.h
@@ -117,6 +117,7 @@ extern void parse_exclude_pattern(const char **stri=
ng, int *patternlen, int *fla
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, const char *src, int srcpos);
 extern void free_excludes(struct exclude_list *el);
+extern void free_directory(struct dir_struct *dir);
 extern int file_exists(const char *);
=20
 extern int is_inside_dir(const char *dir);
--=20
1.8.0.rc0.29.g1fdd78f
