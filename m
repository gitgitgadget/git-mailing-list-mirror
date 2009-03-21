From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Respect core.autocrlf when preparing temporary files for
 external diff
Date: Sat, 21 Mar 2009 12:42:52 +0100 (CET)
Message-ID: <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 12:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkzbj-0000I6-6K
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 12:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZCULkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 07:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbZCULkz
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 07:40:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:35403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750871AbZCULky (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 07:40:54 -0400
Received: (qmail invoked by alias); 21 Mar 2009 11:40:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 21 Mar 2009 12:40:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19N4AE7PgVNhAyNADQBLS6E0xj1rB+8QEfnKDMIea
	tXXdxs6XnPhd8H
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1237635609u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114036>

When preparing temporary files for an external diff, the files should be
handled as if they were worktree files.

This makes things consistent for the case when one side of the diff was
found in the current working directory (and therefore creating a temporary
file could be avoided altogether).

This fixes msysGit issue 177.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c                   |   13 ++++++++++---
 t/t4020-diff-external.sh |   16 ++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 75d9fab..699ae6a 100644
--- a/diff.c
+++ b/diff.c
@@ -1946,17 +1946,23 @@ void diff_free_filespec_data(struct diff_filespec *s)
 	s->cnt_data = NULL;
 }
 
-static void prep_temp_blob(struct diff_tempfile *temp,
+static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 			   void *blob,
 			   unsigned long size,
 			   const unsigned char *sha1,
 			   int mode)
 {
 	int fd;
+	struct strbuf buf = STRBUF_INIT;
 
 	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
 	if (fd < 0)
 		die("unable to create temp-file: %s", strerror(errno));
+	if (convert_to_working_tree(path,
+			(const char *)blob, (size_t)size, &buf)) {
+		blob = buf.buf;
+		size = buf.len;
+	}
 	if (write_in_full(fd, blob, size) != size)
 		die("unable to write temp-file");
 	close(fd);
@@ -1964,6 +1970,7 @@ static void prep_temp_blob(struct diff_tempfile *temp,
 	strcpy(temp->hex, sha1_to_hex(sha1));
 	temp->hex[40] = 0;
 	sprintf(temp->mode, "%06o", mode);
+	strbuf_release(&buf);
 }
 
 static struct diff_tempfile *prepare_temp_file(const char *name,
@@ -2004,7 +2011,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 				die("readlink(%s)", name);
 			if (ret == sizeof(buf))
 				die("symlink too long: %s", name);
-			prep_temp_blob(temp, buf, ret,
+			prep_temp_blob(name, temp, buf, ret,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
 				       (one->sha1_valid ?
@@ -2030,7 +2037,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 	else {
 		if (diff_populate_filespec(one, 0))
 			die("cannot read data blob for %s", one->path);
-		prep_temp_blob(temp, one->data, one->size,
+		prep_temp_blob(name, temp, one->data, one->size,
 			       one->sha1, one->mode);
 	}
 	return temp;
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 281680d..f8c99f1 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -136,4 +136,20 @@ test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
 	GIT_EXTERNAL_DIFF=echo git diff
 '
 
+echo "#!$SHELL_PATH" >fake-diff.sh
+cat >> fake-diff.sh <<\EOF
+cat $2 >> crlfed.txt
+EOF
+chmod a+x fake-diff.sh
+
+keep_only_cr () {
+	tr -dc '\015'
+}
+
+test_expect_success 'external diff with autocrlf = true' '
+	git config core.autocrlf true &&
+	GIT_EXTERNAL_DIFF=./fake-diff.sh git diff &&
+	test $(wc -l < crlfed.txt) = $(cat crlfed.txt | keep_only_cr | wc -c)
+'
+
 test_done
-- 
1.6.2.1.493.g67cf3
