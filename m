From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v1 3/3] prep_exclude: remove the artificial PATH_MAX limit
Date: Mon, 14 Jul 2014 11:50:22 +0200
Message-ID: <53C3A7DE.3020704@gmail.com>
References: <53C3A71F.1020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 11:50:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6cu2-0001me-SN
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 11:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbaGNJub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 05:50:31 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:53223 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaGNJu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 05:50:29 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so3828276wgh.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 02:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=fOXR52gNKv/BuIWrkslXlcTFWAstBHLYN/G1uFtPC2c=;
        b=E03/2bCSS4K2JL8Rf6E9wbJDFTTmuiJfBwL23C/G36xSfDKzN1Qf5EyVuhP22zM07N
         73Ps2qnrPklV3dxSDFaCtG6BiLL6yKxgqYwA0EdLtAZiukZ9qCPLN0Dntnt6RTdl5qR0
         920QUxZy5N65MinJweZGhnIe7UnUpz8BnHCc2wJaw9UC8+c83X8WZ6/o4tBwyGF2vK9+
         eZ+BBFe8YytI9KlSu0RUGdWxO4+RjKr/hPk6Oh/FdkH0eMUvOIGp+nBEXI7kOwXMps1c
         0DuVQujrPxQG+iEOBykbgeanNpHDx2aC+tth9lpKX+uCWzkwTo2S78xxXQlx9zQcWqDA
         5m/A==
X-Received: by 10.194.174.35 with SMTP id bp3mr17182648wjc.33.1405331428048;
        Mon, 14 Jul 2014 02:50:28 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id dn3sm29205163wib.12.2014.07.14.02.50.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jul 2014 02:50:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C3A71F.1020101@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253482>

=46rom: =3D?UTF-8?q?Nguy=3DE1=3DBB=3D85n=3D20Th=3DC3=3DA1i=3D20Ng=3DE1=3D=
BB=3D8Dc=3D20Duy?=3D
 <pclouds@gmail.com>

This fixes a segfault in git-status with long paths on Windows,
where PATH_MAX is only 260.

This also fixes the problem of silently ignoring .gitignore if the
full path exceeds PATH_MAX. Now add_excludes_from_file() will report
if it gets ENAMETOOLONG.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c | 47 ++++++++++++++++++++++++++++-------------------
 dir.h |  2 +-
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/dir.c b/dir.c
index 3068ca8..fcb6872 100644
--- a/dir.c
+++ b/dir.c
@@ -799,12 +799,12 @@ static void prep_exclude(struct dir_struct *dir, =
const char *base, int baselen)
 	 */
 	while ((stk =3D dir->exclude_stack) !=3D NULL) {
 		if (stk->baselen <=3D baselen &&
-		    !strncmp(dir->basebuf, base, stk->baselen))
+		    !strncmp(dir->basebuf.buf, base, stk->baselen))
 			break;
 		el =3D &group->el[dir->exclude_stack->exclude_ix];
 		dir->exclude_stack =3D stk->prev;
 		dir->exclude =3D NULL;
-		free((char *)el->src); /* see strdup() below */
+		free((char *)el->src); /* see strbuf_detach() below */
 		clear_exclude_list(el);
 		free(stk);
 		group->nr--;
@@ -814,8 +814,17 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 	if (dir->exclude)
 		return;
=20
+	/*
+	 * Lazy initialization. All call sites currently just
+	 * memset(dir, 0, sizeof(*dir)) before use. Changing all of
+	 * them seems lots of work for little benefit.
+	 */
+	if (!dir->basebuf.buf)
+		strbuf_init(&dir->basebuf, PATH_MAX);
+
 	/* Read from the parent directories and push them down. */
 	current =3D stk ? stk->baselen : -1;
+	strbuf_setlen(&dir->basebuf, current < 0 ? 0 : current);
 	while (current < baselen) {
 		struct exclude_stack *stk =3D xcalloc(1, sizeof(*stk));
 		const char *cp;
@@ -833,48 +842,47 @@ static void prep_exclude(struct dir_struct *dir, =
const char *base, int baselen)
 		stk->baselen =3D cp - base;
 		stk->exclude_ix =3D group->nr;
 		el =3D add_exclude_list(dir, EXC_DIRS, NULL);
-		memcpy(dir->basebuf + current, base + current,
-		       stk->baselen - current);
+		strbuf_add(&dir->basebuf, base + current, stk->baselen - current);
+		assert(stk->baselen =3D=3D dir->basebuf.len);
=20
 		/* Abort if the directory is excluded */
 		if (stk->baselen) {
 			int dt =3D DT_DIR;
-			dir->basebuf[stk->baselen - 1] =3D 0;
+			dir->basebuf.buf[stk->baselen - 1] =3D 0;
 			dir->exclude =3D last_exclude_matching_from_lists(dir,
-				dir->basebuf, stk->baselen - 1,
-				dir->basebuf + current, &dt);
-			dir->basebuf[stk->baselen - 1] =3D '/';
+				dir->basebuf.buf, stk->baselen - 1,
+				dir->basebuf.buf + current, &dt);
+			dir->basebuf.buf[stk->baselen - 1] =3D '/';
 			if (dir->exclude &&
 			    dir->exclude->flags & EXC_FLAG_NEGATIVE)
 				dir->exclude =3D NULL;
 			if (dir->exclude) {
-				dir->basebuf[stk->baselen] =3D 0;
 				dir->exclude_stack =3D stk;
 				return;
 			}
 		}
=20
-		/* Try to read per-directory file unless path is too long */
-		if (dir->exclude_per_dir &&
-		    stk->baselen + strlen(dir->exclude_per_dir) < PATH_MAX) {
-			strcpy(dir->basebuf + stk->baselen,
-					dir->exclude_per_dir);
+		/* Try to read per-directory file */
+		if (dir->exclude_per_dir) {
 			/*
 			 * dir->basebuf gets reused by the traversal, but we
 			 * need fname to remain unchanged to ensure the src
 			 * member of each struct exclude correctly
 			 * back-references its source file.  Other invocations
 			 * of add_exclude_list provide stable strings, so we
-			 * strdup() and free() here in the caller.
+			 * strbuf_detach() and free() here in the caller.
 			 */
-			el->src =3D strdup(dir->basebuf);
-			add_excludes_from_file_to_list(dir->basebuf,
-					dir->basebuf, stk->baselen, el, 1);
+			struct strbuf sb =3D STRBUF_INIT;
+			strbuf_addbuf(&sb, &dir->basebuf);
+			strbuf_addstr(&sb, dir->exclude_per_dir);
+			el->src =3D strbuf_detach(&sb, NULL);
+			add_excludes_from_file_to_list(el->src, el->src,
+						       stk->baselen, el, 1);
 		}
 		dir->exclude_stack =3D stk;
 		current =3D stk->baselen;
 	}
-	dir->basebuf[baselen] =3D '\0';
+	strbuf_setlen(&dir->basebuf, baselen);
 }
=20
 /*
@@ -1671,4 +1679,5 @@ void clear_directory(struct dir_struct *dir)
 		free(stk);
 		stk =3D prev;
 	}
+	strbuf_release(&dir->basebuf);
 }
diff --git a/dir.h b/dir.h
index 02e3710..6c45e9d 100644
--- a/dir.h
+++ b/dir.h
@@ -119,7 +119,7 @@ struct dir_struct {
 	 */
 	struct exclude_stack *exclude_stack;
 	struct exclude *exclude;
-	char basebuf[PATH_MAX];
+	struct strbuf basebuf;
 };
=20
 /*
--=20
2.0.0.9646.g840d1f9.dirty
