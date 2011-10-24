From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 02/11] notes-merge: use opendir/readdir instead of using read_directory()
Date: Mon, 24 Oct 2011 17:36:07 +1100
Message-ID: <1319438176-7304-3-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:38:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEB5-0000cc-6P
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab1JXGi1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:38:27 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59080 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1JXGi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:38:26 -0400
Received: by mail-yw0-f46.google.com with SMTP id 3so1171021ywm.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7vkrgDyXLxEzW2HK5n2tjNhlrYM+1sLqpBaUZTLSz9A=;
        b=SC2AOK377uI8qVn2GjkCTOmLseL5TU/pbQqdA8TzclocLpHlTsZ1St44cDd/+ElxdL
         nUHQUjUHGX9nIdkBlYqLwu/EMiqjB222+BE9keduVYuVn4mlIZPuYmAhIyrPmXdfs+gf
         wDXcWGxd56ok8NzDEpW/5gRbsH1IWTJkeLpMg=
Received: by 10.236.78.129 with SMTP id g1mr32410635yhe.52.1319438306104;
        Sun, 23 Oct 2011 23:38:26 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id v4sm31219250yhk.3.2011.10.23.23.38.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:38:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:36:43 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184155>

notes_merge_commit() only needs to list all entries (non-recursively)
under a directory, which can be easily accomplished with
opendir/readdir and would be more lightweight than read_directory().

read_directory() is designed to list paths inside a working
directory. Using it outside of its scope may lead to undesired effects.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 notes-merge.c |   45 +++++++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index e9e4199..80d64a2 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -680,48 +680,57 @@ int notes_merge_commit(struct notes_merge_options=
 *o,
 	 * commit message and parents from 'partial_commit'.
 	 * Finally store the new commit object SHA1 into 'result_sha1'.
 	 */
-	struct dir_struct dir;
-	char *path =3D xstrdup(git_path(NOTES_MERGE_WORKTREE "/"));
-	int path_len =3D strlen(path), i;
+	DIR *dir;
+	struct dirent *e;
+	struct strbuf path =3D STRBUF_INIT;
 	const char *msg =3D strstr(partial_commit->buffer, "\n\n");
+	int baselen;
=20
-	OUTPUT(o, 3, "Committing notes in notes merge worktree at %.*s",
-	       path_len - 1, path);
+	strbuf_addstr(&path, git_path(NOTES_MERGE_WORKTREE));
+	OUTPUT(o, 3, "Committing notes in notes merge worktree at %s", path.b=
uf);
=20
 	if (!msg || msg[2] =3D=3D '\0')
 		die("partial notes commit has empty message");
 	msg +=3D 2;
=20
-	memset(&dir, 0, sizeof(dir));
-	read_directory(&dir, path, path_len, NULL);
-	for (i =3D 0; i < dir.nr; i++) {
-		struct dir_entry *ent =3D dir.entries[i];
+	dir =3D opendir(path.buf);
+	if (!dir)
+		die_errno("could not open %s", path.buf);
+
+	strbuf_addch(&path, '/');
+	baselen =3D path.len;
+	while ((e =3D readdir(dir)) !=3D NULL) {
 		struct stat st;
-		const char *relpath =3D ent->name + path_len;
 		unsigned char obj_sha1[20], blob_sha1[20];
=20
-		if (ent->len - path_len !=3D 40 || get_sha1_hex(relpath, obj_sha1)) =
{
-			OUTPUT(o, 3, "Skipping non-SHA1 entry '%s'", ent->name);
+		if (is_dot_or_dotdot(e->d_name))
+			continue;
+
+		if (strlen(e->d_name) !=3D 40 || get_sha1_hex(e->d_name, obj_sha1)) =
{
+			OUTPUT(o, 3, "Skipping non-SHA1 entry '%s%s'", path.buf, e->d_name)=
;
 			continue;
 		}
=20
+		strbuf_addstr(&path, e->d_name);
 		/* write file as blob, and add to partial_tree */
-		if (stat(ent->name, &st))
-			die_errno("Failed to stat '%s'", ent->name);
-		if (index_path(blob_sha1, ent->name, &st, HASH_WRITE_OBJECT))
-			die("Failed to write blob object from '%s'", ent->name);
+		if (stat(path.buf, &st))
+			die_errno("Failed to stat '%s'", path.buf);
+		if (index_path(blob_sha1, path.buf, &st, HASH_WRITE_OBJECT))
+			die("Failed to write blob object from '%s'", path.buf);
 		if (add_note(partial_tree, obj_sha1, blob_sha1, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
-			    ent->name);
+			    path.buf);
 		OUTPUT(o, 4, "Added resolved note for object %s: %s",
 		       sha1_to_hex(obj_sha1), sha1_to_hex(blob_sha1));
+		strbuf_setlen(&path, baselen);
 	}
=20
 	create_notes_commit(partial_tree, partial_commit->parents, msg,
 			    result_sha1);
 	OUTPUT(o, 4, "Finalized notes merge commit: %s",
 	       sha1_to_hex(result_sha1));
-	free(path);
+	strbuf_release(&path);
+	closedir(dir);
 	return 0;
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
