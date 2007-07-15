From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/6] Introduce commit notes
Date: Mon, 16 Jul 2007 00:23:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160022560.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:23:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADR6-0001KO-04
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbXGOXX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbXGOXX2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:23:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:48098 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754898AbXGOXX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:23:27 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:23:25 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp053) with SMTP; 16 Jul 2007 01:23:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185AiAb8Bw52iw71qjFiI6oWRcNHST//ymDQzXNFY
	6BSMi2i3VACxwS
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707152326080.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52601>


Commit notes are blobs which are shown together with the commit
message.  These blobs are taken from the notes ref, which you can
configure by the config variable core.notesRef, which in turn can
be overridden by the environment variable GIT_NOTES_REF.

The notes ref is a branch which contains trees much like the
loose object trees in .git/objects/.  In other words, to get
at the commit notes for a given SHA-1, take the first two
hex characters as directory name, and the remaining 38 hex
characters as base name, and look that up in the notes ref.

The rationale for putting this information into a ref is this: we
want to be able to fetch and possibly union-merge the notes,
maybe even look at the date when a note was introduced, and we
want to store them efficiently together with the other objects.

There is one severe shortcoming, though.  Since tree objects can
contain file names of a variable length, it is not possible to
do a binary search for the correct base name in the tree object's
contents.  Therefore this approach does not scale well, because
the average lookup time will be proportional to the number of
commit objects, and therefore the slowdown will be quadratic in
that number.

However, a remedy is near: in a later commit, a .git/notes-index
will be introduced, a cached mapping from commits to commit notes,
to be written when the tree name of the notes ref changes.  In
case that notes-index cannot be written, the current (possibly
slow) code will come into effect again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |   15 +++++++++++
 Makefile                 |    3 +-
 cache.h                  |    1 +
 commit.c                 |    5 +++
 config.c                 |    5 +++
 environment.c            |    1 +
 notes.c                  |   64 ++++++++++++++++++++++++++++++++++++++++++++++
 notes.h                  |    9 ++++++
 8 files changed, 102 insertions(+), 1 deletions(-)
 create mode 100644 notes.c
 create mode 100644 notes.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d0e9a17..5fe833d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -285,6 +285,21 @@ core.pager::
 	The command that git will use to paginate output.  Can be overridden
 	with the `GIT_PAGER` environment variable.
 
+core.notesRef::
+	When showing commit messages, also show notes which are stored in
+	the given ref.  This ref is expected to contain paths of the form
+	??/*, where the directory name consists of the first two
+	characters of the commit name, and the base name consists of
+	the remaining 38 characters.
++
+If such a path exists in the given ref, the referenced blob is read, and
+appended to the commit message, separated by a "Notes:" line.  If the
+given ref itself does not exist, it is not an error, but means that no
+notes should be print.
++
+This setting defaults to "refs/notes/commits", and can be overridden by
+the `GIT_NOTES_REF` environment variable.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/Makefile b/Makefile
index d7541b4..119d949 100644
--- a/Makefile
+++ b/Makefile
@@ -322,7 +322,8 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o
+	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
+	notes.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/cache.h b/cache.h
index 328c1ad..c89cac5 100644
--- a/cache.h
+++ b/cache.h
@@ -309,6 +309,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern char *notes_ref_name;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/commit.c b/commit.c
index 0c350bc..3529b6a 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "interpolate.h"
 #include "diff.h"
 #include "revision.h"
+#include "notes.h"
 
 int save_commit_buffer = 1;
 
@@ -1254,6 +1255,10 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	 */
 	if (fmt == CMIT_FMT_EMAIL && offset <= beginning_of_body)
 		buf[offset++] = '\n';
+
+	if (fmt != CMIT_FMT_ONELINE)
+		get_commit_notes(commit, buf_p, &offset, space_p);
+
 	buf[offset] = '\0';
 	free(reencoded);
 	return offset;
diff --git a/config.c b/config.c
index f89a611..05d2ad6 100644
--- a/config.c
+++ b/config.c
@@ -395,6 +395,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.notesref")) {
+		notes_ref_name = xstrdup(value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/environment.c b/environment.c
index f83fb9e..2e677d3 100644
--- a/environment.c
+++ b/environment.c
@@ -34,6 +34,7 @@ char *pager_program;
 int pager_in_use;
 int pager_use_color = 1;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
+char *notes_ref_name;
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
diff --git a/notes.c b/notes.c
new file mode 100644
index 0000000..5d1bb1a
--- /dev/null
+++ b/notes.c
@@ -0,0 +1,64 @@
+#include "cache.h"
+#include "commit.h"
+#include "notes.h"
+#include "refs.h"
+
+static int initialized;
+
+void get_commit_notes(const struct commit *commit,
+		char **buf_p, unsigned long *offset_p, unsigned long *space_p)
+{
+	char name[80];
+	const char *hex;
+	unsigned char sha1[20];
+	char *msg;
+	unsigned long msgoffset, msglen;
+	enum object_type type;
+
+	if (!initialized) {
+		const char *env = getenv(GIT_NOTES_REF);
+		if (env) {
+			if (notes_ref_name)
+				free(notes_ref_name);
+			notes_ref_name = xstrdup(getenv(GIT_NOTES_REF));
+		} else if (!notes_ref_name)
+			notes_ref_name = xstrdup("refs/notes/commits");
+		if (notes_ref_name && read_ref(notes_ref_name, sha1)) {
+			free(notes_ref_name);
+			notes_ref_name = NULL;
+		}
+		initialized = 1;
+	}
+	if (!notes_ref_name)
+		return;
+
+	hex = sha1_to_hex(commit->object.sha1);
+	snprintf(name, sizeof(name), "%s:%.*s/%.*s",
+			notes_ref_name, 2, hex, 38, hex + 2);
+	if (get_sha1(name, sha1))
+		return;
+
+	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen)
+		return;
+	/* we will end the annotation by a newline anyway. */
+	if (msg[msglen - 1] == '\n')
+		msglen--;
+
+	ALLOC_GROW(*buf_p, *offset_p + 14 + msglen, *space_p);
+	*offset_p += sprintf(*buf_p + *offset_p, "\nNotes:\n");
+
+	for (msgoffset = 0; msgoffset < msglen;) {
+		int linelen = get_line_length(msg + msgoffset, msglen);
+
+		ALLOC_GROW(*buf_p, *offset_p + linelen + 6, *space_p);
+		*offset_p += sprintf(*buf_p + *offset_p,
+				"    %.*s", linelen, msg + msgoffset);
+		msgoffset += linelen;
+	}
+	ALLOC_GROW(*buf_p, *offset_p + 1, *space_p);
+	(*buf_p)[*offset_p] = '\n';
+	(*offset_p)++;
+	free(msg);
+}
+
+
diff --git a/notes.h b/notes.h
new file mode 100644
index 0000000..aed80e7
--- /dev/null
+++ b/notes.h
@@ -0,0 +1,9 @@
+#ifndef NOTES_H
+#define NOTES_H
+
+void get_commit_notes(const struct commit *commit,
+	char **buf_p, unsigned long *offset_p, unsigned long *space_p);
+
+#define GIT_NOTES_REF "GIT_NOTES_REF"
+
+#endif
-- 
1.5.3.rc1.2718.gd2dc9-dirty
