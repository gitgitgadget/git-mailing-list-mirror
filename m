From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/24] untracked cache: don't open non-existent .gitignore
Date: Tue, 20 Jan 2015 20:03:17 +0700
Message-ID: <1421759013-8494-9-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYTu-0003WN-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbbATNE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:04:27 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:52093 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbbATNE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:04:26 -0500
Received: by mail-pa0-f52.google.com with SMTP id kx10so14946648pab.11
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+Yszni37Y4ykaD3jY0dtm+1fkJV/t2BWly9uEnAZCYQ=;
        b=hph9rgwv6Ev88ntM3UiPakA4XGDPzIjsdS22hRGLeAjZ83YO37zgjDAnl7ZAHPGt3J
         w79PdpRjFC6MjhN5V560g1v0sl5xOn1/VwyUL6ntl/D1Mbxi04TYCSi5kON1wIQpSHls
         FoJJu8xUJnrX6EW1tBiQVvE4O1GlprjdHbO6Z8lyW8z5WFHpbA6wRdumztSmH34uEkN8
         Y8nOXDfb+VuoKWkRIK/uO7HduH95KMAIc7s+WhphAi6u1wyWTTf7QfePl4WYc6FlSlso
         ytuPLtXsc5oUHtfKNH6spHda9vOc0oPk/sJP0cSh2Wznxnr+LGYBIPScBE0i5v2TX6Yv
         8dhw==
X-Received: by 10.66.120.47 with SMTP id kz15mr53633620pab.71.1421759066041;
        Tue, 20 Jan 2015 05:04:26 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id qc1sm2885262pbb.84.2015.01.20.05.04.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:04:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:04:35 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262659>

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
2.2.0.84.ge9c7a8a
