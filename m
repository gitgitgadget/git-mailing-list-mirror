From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/24] untracked cache: don't open non-existent .gitignore
Date: Sun,  8 Feb 2015 15:55:32 +0700
Message-ID: <1423385748-19825-9-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:56:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNfW-0002jl-N9
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbbBHI4i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:56:38 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64459 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbbBHI4i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:56:38 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so26951115pad.4
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=J6Ri/qWh7LNZ0poMVq2JC1YeDjyAC28aMZlhtyZX+Wk=;
        b=OzmnLTDZmMNjFqIEj4jj2Pbr5Vp42ytmMQeeMNQhHRffGByhxJABE17HACgszoOuAK
         WBJzPQE/k+q4l1ExLtpLxQQlIeQ+6JJ8gqkHkuVxz2X+OscJ1/ar8sdoMayJhsEHU4JF
         Bsd1madAhxZXTTYyd0TY9g8CdJr6D40NTyBGkD99NRLelThmmAkppfGi6px1O8odRGBX
         Sy/jhvgxVAmSULpZRkzmi5fdU2AF6ZH7u7VJcFndSZUTft2EyMRPi6Xy/JaOrDt+Z3eR
         reKWdR+9LkOB/yUWQopObXwAPn9LJoxPb34y8Li8PtHPG2o2Oscb1YtgyNSJqguPP98P
         GZ2g==
X-Received: by 10.68.211.228 with SMTP id nf4mr19417621pbc.66.1423385797340;
        Sun, 08 Feb 2015 00:56:37 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id rr9sm12916289pbc.39.2015.02.08.00.56.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:56:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:56:44 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263470>

This cuts down a signficant number of open(.gitignore) because most
directories usually don't have .gitignore files.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 02cdc26..95a0f0a 100644
--- a/dir.c
+++ b/dir.c
@@ -1019,7 +1019,21 @@ static void prep_exclude(struct dir_struct *dir,=
 const char *base, int baselen)
 		/* Try to read per-directory file */
 		hashclr(sha1_stat.sha1);
 		sha1_stat.valid =3D 0;
-		if (dir->exclude_per_dir) {
+		if (dir->exclude_per_dir &&
+		    /*
+		     * If we know that no files have been added in
+		     * this directory (i.e. valid_cached_dir() has
+		     * been executed and set untracked->valid) ..
+		     */
+		    (!untracked || !untracked->valid ||
+		     /*
+		      * .. and .gitignore does not exist before
+		      * (i.e. null exclude_sha1 and skip_worktree is
+		      * not set). Then we can skip loading .gitignore,
+		      * which would result in ENOENT anyway.
+		      * skip_worktree is taken care in read_directory()
+		      */
+		     !is_null_sha1(untracked->exclude_sha1))) {
 			/*
 			 * dir->basebuf gets reused by the traversal, but we
 			 * need fname to remain unchanged to ensure the src
@@ -1782,6 +1796,7 @@ static struct untracked_cache_dir *validate_untra=
cked_cache(struct dir_struct *d
 						      const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *root;
+	int i;
=20
 	if (!dir->untracked)
 		return NULL;
@@ -1833,6 +1848,15 @@ static struct untracked_cache_dir *validate_untr=
acked_cache(struct dir_struct *d
 	if (dir->exclude_list_group[EXC_CMDL].nr)
 		return NULL;
=20
+	/*
+	 * An optimization in prep_exclude() does not play well with
+	 * CE_SKIP_WORKTREE. It's a rare case anyway, if a single
+	 * entry has that bit set, disable the whole untracked cache.
+	 */
+	for (i =3D 0; i < active_nr; i++)
+		if (ce_skip_worktree(active_cache[i]))
+			return NULL;
+
 	if (!dir->untracked->root) {
 		const int len =3D sizeof(*dir->untracked->root);
 		dir->untracked->root =3D xmalloc(len);
--=20
2.3.0.rc1.137.g477eb31
