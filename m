From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/22] untracked cache: don't open non-existent .gitignore
Date: Sat,  8 Nov 2014 16:39:41 +0700
Message-ID: <1415439595-469-9-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:40:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2Vb-0000sZ-Nj
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbaKHJke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:40:34 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58514 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbaKHJkb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:40:31 -0500
Received: by mail-pa0-f48.google.com with SMTP id ey11so5066373pad.35
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=itQN1Hbp65IjzzALrhc+/W5lvgG2+H1rnzmucQsGcno=;
        b=JRpU+029fEPKUBgChFXDNsuclxX9fMAOAiNgPFF0eLx1XT/Lpnpg+obQgTbbAmUIm9
         SQZOsP++08qS136rQkSVsqZRF+jA9vmcBuw3Ot0F1NYl2yzK7Gsgpdyoydd3HlFK5hnz
         TyEGzhBGFjWlCxrO/+oS6tGVPI2kDEniFz/LO//+ivSB6nsDcUr992j7fUn2198eDU38
         e4+9d3Of6EjlGoUfZ7LGYzZW5ZQnaIM0itW8O+Cpf9LWDS/lCnxNjGQqsY8AJui1XFPT
         yGSUodLTcJUYeWqBtfxylCTQpn4i7usEQovSz7n6GfIvxojwoBQQ7qKqojuf27DOkNaV
         cTTA==
X-Received: by 10.68.68.240 with SMTP id z16mr18200598pbt.70.1415439630602;
        Sat, 08 Nov 2014 01:40:30 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id pc8sm11004367pdb.54.2014.11.08.01.40.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:40:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:40:44 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cuts down a signficant number of open(.gitignore) because most
directories usually don't have .gitignore files.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 32406bf..5936c84 100644
--- a/dir.c
+++ b/dir.c
@@ -1018,7 +1018,21 @@ static void prep_exclude(struct dir_struct *dir,=
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
@@ -1781,6 +1795,7 @@ static struct untracked_cache_dir *validate_untra=
cked_cache(struct dir_struct *d
 						      const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *root;
+	int i;
=20
 	if (!dir->untracked)
 		return NULL;
@@ -1832,6 +1847,15 @@ static struct untracked_cache_dir *validate_untr=
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
2.1.0.rc0.78.gc0d8480
