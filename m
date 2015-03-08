From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/24] untracked cache: don't open non-existent .gitignore
Date: Sun,  8 Mar 2015 17:12:31 +0700
Message-ID: <1425809567-25518-9-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:13:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYDe-00035w-4s
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbbCHKNy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:13:54 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34814 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbbCHKNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:13:53 -0400
Received: by paceu11 with SMTP id eu11so50731102pac.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jb9jKvyAdQkJdbK7Ong5q+5F52OdN/3+jSUHZbSfQXY=;
        b=FBrrlMwYXZCaVzC3zl2ldaaBOZgEHPsWHHuXCACLGgl4mebYcY5tPyqHYwmotoIwfg
         OEe2XtLUMqJd6eU8phkgBY66767D2M6V/lh3YfXxxRUHnXmHHFhtzIfCE1Fso/lgglUt
         UNbzBUjOpuPVnx3LKbArwUzcU7a6VDQLAW1UD8JuNjhIeSBvxaWEw0xEo33cy8Hi8Af1
         6F8lCdsLeJZ6hv7kUeoPCNmG9iZ+B5Syv/2giBu1cRH4+HxYchLvqBJffau5IbihMj1x
         r0c1mnQS4+VIu0V4wkQ2mWBvEHKh2dJwFZpXSBKgaMOTeaoU0E++pWNhvNnJzY7iKY8n
         4z+A==
X-Received: by 10.68.217.228 with SMTP id pb4mr40788957pbc.129.1425809632920;
        Sun, 08 Mar 2015 03:13:52 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id bs2sm14323877pbd.74.2015.03.08.03.13.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:13:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:13:48 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265062>

This cuts down a signficant number of open(.gitignore) because most
directories usually don't have .gitignore files.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 9642332..b2128a0 100644
--- a/dir.c
+++ b/dir.c
@@ -1020,7 +1020,21 @@ static void prep_exclude(struct dir_struct *dir,=
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
@@ -1783,6 +1797,7 @@ static struct untracked_cache_dir *validate_untra=
cked_cache(struct dir_struct *d
 						      const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *root;
+	int i;
=20
 	if (!dir->untracked)
 		return NULL;
@@ -1834,6 +1849,15 @@ static struct untracked_cache_dir *validate_untr=
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
