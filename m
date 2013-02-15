From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] read_directory: avoid invoking exclude machinery on tracked files
Date: Fri, 15 Feb 2013 21:17:28 +0700
Message-ID: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 15:17:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6M6E-0008Ez-H9
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 15:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773Ab3BOOQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2013 09:16:50 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38678 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab3BOOQt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 09:16:49 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so1765284pad.40
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 06:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Z6HqoND2Us0YEm7ziE0nMqTlC1sddjTUB8b+bpbnOXU=;
        b=XY68XB0s3Mq+BbiZ870tnnCrW7V8S9roFmdsfhQ0tIfHvm4qJGp2apL1v2i1UHiCfZ
         V2IbuZIvBksQ85E1BsyHjifgqr72sc6srB+T+hr6jg9JsUpoj1pYPqjwCYtKXpaT74IE
         PrNpWttOIMxOkeNnbX7piVqQDS6YJXXNYfvEXSv8R7+GQjaoflCXc+nccdFlkrOw3Ifz
         +k9rnJEqXD3SD0JrM8yxs9dhKWiM5XNc77RwkR2AxXpW3t1o7bsBGUo9LnQNRQjWFlSI
         CVAE1bXJ8GFUT1RkAEu6OW3s0ZpzRpxoHM41pKN4WURr8nFK+1NI5yT4fzJFclWrh0EJ
         UaYg==
X-Received: by 10.68.213.200 with SMTP id nu8mr6357235pbc.46.1360937808785;
        Fri, 15 Feb 2013 06:16:48 -0800 (PST)
Received: from lanh ([115.74.55.130])
        by mx.google.com with ESMTPS id b9sm4857330pba.6.2013.02.15.06.16.44
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Feb 2013 06:16:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 15 Feb 2013 21:17:35 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216347>

read_directory() (and its friendly wrapper fill_directory) collects
untracked/ignored files by traversing through the whole worktree (*),
feeding every entry to treat_one_path(), where each entry is checked
against .gitignore patterns.

One may see that tracked files can't be excluded and we do not need to
run them through exclude machinery. On repos where there are many
=2Egitignore patterns and/or a lot of tracked files, this unnecessary
processing can become expensive.

This patch avoids it mostly for normal cases. Directories are still
processed as before. DIR_SHOW_IGNORED and DIR_COLLECT_IGNORED are not
normally used unless some options are given (e.g. "checkout
--overwrite-ignore", "add -f"...) so people still need to pay penalty
in some cases, just not as often as before.

git status   | webkit linux-2.6 libreoffice-core gentoo-x86
-------------+----------------------------------------------
before       | 1.159s    0.226s           0.415s     0.597s
after        | 0.778s    0.176s           0.266s     0.556s
nr. patterns |    89       376               19          0
nr. tracked  |   182k       40k              63k       101k

(*) Not completely true. read_directory may skip recursing into a
    directory if it's entirely excluded and DIR_SHOW_OTHER_DIRECTORIES
    is not set.

Tracked-down-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 For reference:
 http://thread.gmane.org/gmane.comp.version-control.git/215820/focus=3D=
216195

 dir.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 57394e4..bdff256 100644
--- a/dir.c
+++ b/dir.c
@@ -1244,7 +1244,19 @@ static enum path_treatment treat_one_path(struct=
 dir_struct *dir,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude =3D is_excluded(dir, path->buf, &dtype);
+	int exclude;
+
+	if (dtype =3D=3D DT_UNKNOWN)
+		dtype =3D get_dtype(de, path->buf, path->len);
+
+	if (!(dir->flags & DIR_SHOW_IGNORED) &&
+	    !(dir->flags & DIR_COLLECT_IGNORED) &&
+	    dtype !=3D DT_DIR &&
+	    cache_name_exists(path->buf, path->len, ignore_case))
+		return path_ignored;
+
+	exclude =3D is_excluded(dir, path->buf, &dtype);
+
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
@@ -1256,9 +1268,6 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
 		return path_ignored;
=20
-	if (dtype =3D=3D DT_UNKNOWN)
-		dtype =3D get_dtype(de, path->buf, path->len);
-
 	switch (dtype) {
 	default:
 		return path_ignored;
--=20
1.8.1.2.536.gf441e6d
