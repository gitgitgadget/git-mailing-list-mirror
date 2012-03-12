From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/2] notes-merge: use opendir/readdir instead of using read_directory()
Date: Mon, 12 Mar 2012 15:47:27 +0100
Message-ID: <1331563647-1909-2-git-send-email-johan@herland.net>
References: <1319438176-7304-3-git-send-email-pclouds@gmail.com>
 <1331563647-1909-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	david@tethera.net, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 15:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76Xl-0005hJ-Bc
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 15:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093Ab2CLOsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 10:48:04 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43961 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab2CLOsC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 10:48:02 -0400
Received: by wejx9 with SMTP id x9so3298011wej.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 07:48:01 -0700 (PDT)
Received: by 10.180.87.100 with SMTP id w4mr27682189wiz.22.1331563681068;
        Mon, 12 Mar 2012 07:48:01 -0700 (PDT)
Received: from gamma.cisco.com (64-103-25-233.cisco.com. [64.103.25.233])
        by mx.google.com with ESMTPS id o2sm36130055wiv.11.2012.03.12.07.47.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 07:47:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.2
In-Reply-To: <1331563647-1909-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192869>

notes_merge_commit() only needs to list all entries (non-recursively)
under a directory, which can be easily accomplished with
opendir/readdir and would be more lightweight than read_directory().

read_directory() is designed to list paths inside a working
directory. Using it outside of its scope may lead to undesired effects.

Apparently, one of the undesired effects of read_directory() is that it
doesn't deal with being given absolute paths. This creates problems for
notes_merge_commit() when git_path() returns an absolute path, which
happens when the current working directory is in a subdirectory of the
=2Egit directory.

Originally-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Updated-by:  Johan Herland <johan@herland.net>
Signed-off-by: Johan Herland <johan@herland.net>
---

This is a resurrection of pclouds' patch 2/11 in a patch series sent
last October for rewriting read_directory(). This patch doesn't
actually touch read_directory(), but instead rewrites
notes_merge_commit() to use opendir()/readdir() instead of
read_directory(). Since the usage of read_directory() is what caused
the bug that David found (in the previous patch), this rewrite happens
to fix that bug as well.


Have fun! :)

=2E..Johan

 notes-merge.c                         |   50 ++++++++++++++++++++-----=
--------
 t/t3310-notes-merge-manual-resolve.sh |    2 +-
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index fb0832f..3a16af2 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -687,51 +687,60 @@ int notes_merge_commit(struct notes_merge_options=
 *o,
 {
 	/*
 	 * Iterate through files in .git/NOTES_MERGE_WORKTREE and add all
-	 * found notes to 'partial_tree'. Write the updates notes tree to
+	 * found notes to 'partial_tree'. Write the updated notes tree to
 	 * the DB, and commit the resulting tree object while reusing the
 	 * commit message and parents from 'partial_commit'.
 	 * Finally store the new commit object SHA1 into 'result_sha1'.
 	 */
-	struct dir_struct dir;
-	char *path =3D xstrdup(git_path(NOTES_MERGE_WORKTREE "/"));
-	int path_len =3D strlen(path), i;
+	DIR *dir;
+	struct dirent *e;
+	struct strbuf path =3D STRBUF_INIT;
 	char *msg =3D strstr(partial_commit->buffer, "\n\n");
 	struct strbuf sb_msg =3D STRBUF_INIT;
+	int baselen;

+	strbuf_addstr(&path, git_path(NOTES_MERGE_WORKTREE));
 	if (o->verbosity >=3D 3)
-		printf("Committing notes in notes merge worktree at %.*s\n",
-			path_len - 1, path);
+		printf("Committing notes in notes merge worktree at %s\n",
+			path.buf);

 	if (!msg || msg[2] =3D=3D '\0')
 		die("partial notes commit has empty message");
 	msg +=3D 2;

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

-		if (ent->len - path_len !=3D 40 || get_sha1_hex(relpath, obj_sha1)) =
{
+		if (is_dot_or_dotdot(e->d_name))
+			continue;
+
+		if (strlen(e->d_name) !=3D 40 || get_sha1_hex(e->d_name, obj_sha1)) =
{
 			if (o->verbosity >=3D 3)
-				printf("Skipping non-SHA1 entry '%s'\n",
-								ent->name);
+				printf("Skipping non-SHA1 entry '%s%s'\n",
+					path.buf, e->d_name);
 			continue;
 		}

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
 		if (o->verbosity >=3D 4)
 			printf("Added resolved note for object %s: %s\n",
 				sha1_to_hex(obj_sha1), sha1_to_hex(blob_sha1));
+		strbuf_setlen(&path, baselen);
 	}

 	strbuf_attach(&sb_msg, msg, strlen(msg), strlen(msg) + 1);
@@ -740,7 +749,8 @@ int notes_merge_commit(struct notes_merge_options *=
o,
 	if (o->verbosity >=3D 4)
 		printf("Finalized notes merge commit: %s\n",
 			sha1_to_hex(result_sha1));
-	free(path);
+	strbuf_release(&path);
+	closedir(dir);
 	return 0;
 }

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merg=
e-manual-resolve.sh
index 0c531c3..d6d6ac6 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -558,7 +558,7 @@ foo
 bar
 EOF

-test_expect_failure 'switch cwd before committing notes merge' '
+test_expect_success 'switch cwd before committing notes merge' '
 	git notes add -m foo HEAD &&
 	git notes --ref=3Dother add -m bar HEAD &&
 	test_must_fail git notes merge refs/notes/other &&
--
1.7.9.2
