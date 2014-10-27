From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/19] untracked cache: don't open non-existent .gitignore
Date: Mon, 27 Oct 2014 19:10:35 +0700
Message-ID: <1414411846-4450-9-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij95-0002uT-9A
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbaJ0ML2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:28 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:51815 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaJ0ML0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:26 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so3679631pad.11
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8KDiD1SDjEjnkBDWhgTgWf44W1MyiP4Ry00vyptfFy0=;
        b=HmcCq4FEUTCwNuhzERt6xGtnzDaEp/DGqD9awTGPBnKw/l6DmZ2Ar2ejHNhJ+/M3cM
         /hLg/E7FjVGBQnGH57TdPzUWyZegbF7Pp3XEkYFrsI75AKglNryLrnpEXSvJKt5s+6LK
         3EVw5oLqV5+6/TFD7dd5DEvsBmMt8MewowlVL4LgkmQaXSxeTG6VitAdiWGN3vge24Nn
         3j1UCOiWoali2B8cu/k4wpMwWnWcRdbC7IF1kmZYt6Tj0j4vrQTngOp5x9Mo9Mu6IOip
         VjgrKbVFU0+ubBTbvNH91iFcTU8aw5iO/C86k1n9K7jOvtu/23gLHC+uP/szsgAJ8CE5
         pgbA==
X-Received: by 10.70.90.37 with SMTP id bt5mr1956065pdb.142.1414411886434;
        Mon, 27 Oct 2014 05:11:26 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id oo9sm9695043pdb.26.2014.10.27.05.11.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:29 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
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
index d9675c8..d4f9830 100644
--- a/dir.c
+++ b/dir.c
@@ -1014,7 +1014,21 @@ static void prep_exclude(struct dir_struct *dir,=
 const char *base, int baselen)
=20
 		/* Try to read per-directory file */
 		hashclr(ss.sha1);
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
@@ -1778,6 +1792,7 @@ static struct untracked_cache_dir *validate_untra=
cked_cache(struct dir_struct *d
 						      const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *root;
+	int i;
=20
 	if (!dir->untracked)
 		return NULL;
@@ -1829,6 +1844,15 @@ static struct untracked_cache_dir *validate_untr=
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
