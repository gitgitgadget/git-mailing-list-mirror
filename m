From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/23] untracked cache: don't open non-existent .gitignore
Date: Mon,  8 Dec 2014 21:04:52 +0700
Message-ID: <1418047507-22892-10-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:55:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxymq-0004Y5-4a
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493AbaLHNzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:55:32 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:51105 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaLHNz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:55:28 -0500
Received: by mail-pd0-f178.google.com with SMTP id g10so5205676pdj.37
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AmoXq5dVWboVxhfTMcPSq3OiMBl0BdUQa9SRuTE2Sro=;
        b=e3KIGXyQIW4c+TaVxks+l4K4rywhV06kBoNa0T0pDDUDMDGS3WSaUXd8aXYjawTNny
         9Gk+jrVwxTL6a4HCd3GSuV4x6mKRiuAYAPrOvf6ta/uhlyyQiMNwJdBB/g5nvZXqXWGE
         t6G925k8wctUWx7J6j1AYGtgkviQ4wjlUHLFZzfdD3vNEwE9czwNuHfqh1F8AfDso3xC
         W5DyX+YzYBqo2HdKQT5vYR8IhobnAaQMlYH1cqFyx6Hfb2lAzL4+MvqdfHepz2x3Nax9
         bUkSyY87dxiIZQq9RXnAFnKA6quD0vMt8E5tl3Lhe8eNOo/jTmDswI2dpqASvEf7dU5E
         UkZQ==
X-Received: by 10.66.65.168 with SMTP id y8mr54813014pas.48.1418046928144;
        Mon, 08 Dec 2014 05:55:28 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id py1sm16616118pdb.74.2014.12.08.05.55.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:55:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:06:03 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261027>

This cuts down a signficant number of open(.gitignore) because most
directories usually don't have .gitignore files.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
2.2.0.60.gb7b3c64
