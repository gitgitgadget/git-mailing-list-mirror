From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] mailmap: support reading mailmap from blobs
Date: Wed, 12 Dec 2012 06:04:04 -0500
Message-ID: <20121212110404.GB19653@sigill.intra.peff.net>
References: <20121212105822.GA15842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 12:04:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tik70-0002Fk-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 12:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab2LLLEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 06:04:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42763 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650Ab2LLLEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 06:04:08 -0500
Received: (qmail 22692 invoked by uid 107); 12 Dec 2012 11:05:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 06:05:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 06:04:04 -0500
Content-Disposition: inline
In-Reply-To: <20121212105822.GA15842@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211338>

In a bare repository, there isn't a simple way to respect an
in-tree mailmap without extracting it to a temporary file.
This patch provides a config variable, similar to
mailmap.file, which reads the mailmap from a blob in the
repository.

Signed-off-by: Jeff King <peff@peff.net>
---
The error-return convention from read_mailmap is really wonky, but I
didn't change it here. It will return "1" for error, and will do so only
if no mailmap sources could be read (including if they simply don't
exist). But it's perfectly OK not to have a mailmap at all.  However,
nobody actually seems to check the return code, so nobody has cared.

A more sane convention would probably be:

  1. If ENOENT (or no such blob), silently return success.

  2. Otherwise, return -1 and print a message to stderr indicating that
     there is a mailmap file, but it is broken or otherwise could not be
     opened.

 Documentation/config.txt |  6 ++++
 cache.h                  |  1 +
 config.c                 |  2 ++
 mailmap.c                | 49 ++++++++++++++++++++++++++++++--
 t/t4203-mailmap.sh       | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf8f911..3760077 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1517,6 +1517,12 @@ mailmap.file::
 	subdirectory, or somewhere outside of the repository itself.
 	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
 
+mailmap.blob::
+	Like `mailmap.file`, but consider the value as a reference to a
+	blob in the repository (e.g., `HEAD:.mailmap`). If both
+	`mailmap.file` and `mailmap.blob` are given, both are parsed,
+	with entries from `mailmap.file` taking precedence.
+
 man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
diff --git a/cache.h b/cache.h
index 18fdd18..a65f6d1 100644
--- a/cache.h
+++ b/cache.h
@@ -1155,6 +1155,7 @@ extern const char *git_mailmap_file;
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
 extern const char *git_mailmap_file;
+extern const char *git_mailmap_blob;
 
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
diff --git a/config.c b/config.c
index fb3f868..97364c0 100644
--- a/config.c
+++ b/config.c
@@ -839,6 +839,8 @@ static int git_default_mailmap_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "mailmap.file"))
 		return git_config_string(&git_mailmap_file, var, value);
+	if (!strcmp(var, "mailmap.blob"))
+		return git_config_string(&git_mailmap_blob, var, value);
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/mailmap.c b/mailmap.c
index 89bc318..2f9c691 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -10,6 +10,7 @@ const char *git_mailmap_file;
 #endif
 
 const char *git_mailmap_file;
+const char *git_mailmap_blob;
 
 struct mailmap_info {
 	char *name;
@@ -177,12 +178,56 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 	return 0;
 }
 
+static void read_mailmap_buf(struct string_list *map,
+			     const char *buf, unsigned long len,
+			     char **repo_abbrev)
+{
+	while (len) {
+		const char *end = strchrnul(buf, '\n');
+		unsigned long linelen = end - buf + 1;
+		char *line = xmemdupz(buf, linelen);
+
+		read_mailmap_line(map, line, repo_abbrev);
+
+		free(line);
+		buf += linelen;
+		len -= linelen;
+	}
+}
+
+static int read_mailmap_blob(struct string_list *map,
+			     const char *name,
+			     char **repo_abbrev)
+{
+	unsigned char sha1[20];
+	char *buf;
+	unsigned long size;
+	enum object_type type;
+
+	if (!name)
+		return 1;
+	if (get_sha1(name, sha1) < 0)
+		return 1;
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return 1;
+	if (type != OBJ_BLOB)
+		return 1;
+
+	read_mailmap_buf(map, buf, size, repo_abbrev);
+
+	free(buf);
+	return 0;
+}
+
 int read_mailmap(struct string_list *map, char **repo_abbrev)
 {
 	map->strdup_strings = 1;
-	/* each failure returns 1, so >1 means both calls failed */
+	/* each failure returns 1, so >2 means all calls failed */
 	return read_mailmap_file(map, ".mailmap", repo_abbrev) +
-	       read_mailmap_file(map, git_mailmap_file, repo_abbrev) > 1;
+	       read_mailmap_blob(map, git_mailmap_blob, repo_abbrev) +
+	       read_mailmap_file(map, git_mailmap_file, repo_abbrev) > 2;
 }
 
 void clear_mailmap(struct string_list *map)
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 1f182f6..e7ea40c 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -149,6 +149,79 @@ test_expect_success 'No mailmap files, but configured' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup mailmap blob tests' '
+	git checkout -b map &&
+	test_when_finished "git checkout master" &&
+	cat >just-bugs <<-\EOF &&
+	Blob Guy <bugs@company.xx>
+	EOF
+	cat >both <<-\EOF &&
+	Blob Guy <author@example.com>
+	Blob Guy <bugs@company.xx>
+	EOF
+	git add just-bugs both &&
+	git commit -m "my mailmaps" &&
+	echo "Repo Guy <author@example.com>" >.mailmap &&
+	echo "Internal Guy <author@example.com>" >internal.map
+'
+
+test_expect_success 'mailmap.blob set' '
+	cat >expect <<-\EOF &&
+	Blob Guy (1):
+	      second
+
+	Repo Guy (1):
+	      initial
+
+	EOF
+	git -c mailmap.blob=map:just-bugs shortlog HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mailmap.blob overrides .mailmap' '
+	cat >expect <<-\EOF &&
+	Blob Guy (2):
+	      initial
+	      second
+
+	EOF
+	git -c mailmap.blob=map:both shortlog HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mailmap.file overrides mailmap.blob' '
+	cat >expect <<-\EOF &&
+	Blob Guy (1):
+	      second
+
+	Internal Guy (1):
+	      initial
+
+	EOF
+	git \
+	  -c mailmap.blob=map:both \
+	  -c mailmap.file=internal.map \
+	  shortlog HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mailmap.blob can be missing' '
+	cat >expect <<-\EOF &&
+	Repo Guy (1):
+	      initial
+
+	nick1 (1):
+	      second
+
+	EOF
+	git -c mailmap.blob=map:nonexistent shortlog HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cleanup after mailmap.blob tests' '
+	rm -f .mailmap
+'
+
 # Extended mailmap configurations should give us the following output for shortlog
 cat >expect <<\EOF
 A U Thor <author@example.com> (1):
-- 
1.8.0.2.4.g59402aa
