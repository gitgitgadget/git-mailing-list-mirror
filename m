From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 03:30:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707190258550.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 04:31:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBLnL-0005Fj-48
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 04:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758057AbXGSCau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 22:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760029AbXGSCau
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 22:30:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:33177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757755AbXGSCat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 22:30:49 -0400
Received: (qmail invoked by alias); 19 Jul 2007 02:30:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 19 Jul 2007 04:30:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zFAEV4t+zuDK7gab/h+dA/tTZSlBHm1xNVfWGhu
	/Aj9sul9/yuFgR
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52925>


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

	On Sun, 15 Jul 2007, Junio C Hamano wrote:

	> This design forces "one blob and only one blob decorates a
	> commit".  It certainly makes the implementation and semantics
	> simpler -- if I have this note and you have that note on the
	> same commit, comparing notes eventually should result in a merge
	> of our notes.  But is it sufficient in real life usage scenarios
	> (what's the use case)?  One example that was raised on the list
	> is to collect "Acked-by", "Tested-by", etc., and in that case
	> perhaps one set "refs/notes/acks" may hold the former while
	> "refs/notes/tests" the latter.  If we wanted to show both at the
	> same time, is it the only option to put them in the same "note"
	> blob and not use "refs/notes/{acks,tests}"?

	Would that not make things even slower?  I am hesitant.

	All other concerns should be addressed, here and in the two 
	upcoming revised patches.

 Documentation/config.txt |   15 +++++++++
 Makefile                 |    3 +-
 cache.h                  |    3 ++
 commit.c                 |    5 +++
 config.c                 |    5 +++
 environment.c            |    1 +
 notes.c                  |   77 ++++++++++++++++++++++++++++++++++++++++++++++
 notes.h                  |    8 +++++
 8 files changed, 116 insertions(+), 1 deletions(-)
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
index 328c1ad..df45336 100644
--- a/cache.h
+++ b/cache.h
@@ -204,6 +204,8 @@ enum object_type {
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
+#define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
+#define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
@@ -309,6 +311,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern char *notes_ref_name;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/commit.c b/commit.c
index 0c350bc..8911a18 100644
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
+		get_commit_notes(commit, buf_p, &offset, space_p, encoding);
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
index 0000000..6207f95
--- /dev/null
+++ b/notes.c
@@ -0,0 +1,77 @@
+#include "cache.h"
+#include "commit.h"
+#include "notes.h"
+#include "refs.h"
+#include "utf8.h"
+
+static int initialized;
+
+void get_commit_notes(const struct commit *commit,
+		char **buf_p, unsigned long *offset_p, unsigned long *space_p,
+		const char *output_encoding)
+{
+        static const char *utf8 = "utf-8";
+	char name[80];
+	const char *hex;
+	unsigned char sha1[20];
+	char *msg;
+	unsigned long msgoffset, msglen;
+	enum object_type type;
+
+	if (!initialized) {
+		const char *env = getenv(GIT_NOTES_REF_ENVIRONMENT);
+		if (env)
+			notes_ref_name = getenv(GIT_NOTES_REF_ENVIRONMENT);
+		else if (!notes_ref_name)
+			notes_ref_name = GIT_NOTES_DEFAULT_REF;
+		if (notes_ref_name && read_ref(notes_ref_name, sha1))
+			notes_ref_name = NULL;
+		initialized = 1;
+	}
+	if (!notes_ref_name)
+		return;
+
+	hex = sha1_to_hex(commit->object.sha1);
+	if (snprintf(name, sizeof(name), "%s:%.*s/%.*s",
+			notes_ref_name, 2, hex, 38, hex + 2)
+			>= sizeof(name) - 1) {
+		error("Notes ref name too long: %.*s", 60, notes_ref_name);
+		return;
+	}
+	if (get_sha1(name, sha1))
+		return;
+
+	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen ||
+			type != OBJ_BLOB)
+		return;
+        if (output_encoding && *output_encoding &&
+			strcmp(utf8, output_encoding)) {
+                char *reencoded = reencode_string(msg, output_encoding, utf8);
+		if (reencoded) {
+			free(msg);
+			msg = reencoded;
+			msglen = strlen(msg);
+		}
+	}
+	/* we will end the annotation by a newline anyway. */
+	if (msg[msglen - 1] == '\n')
+		msglen--;
+
+	ALLOC_GROW(*buf_p, *offset_p + 8 + msglen, *space_p);
+	*offset_p += sprintf(*buf_p + *offset_p, "\nNotes:\n");
+
+	for (msgoffset = 0; msgoffset < msglen;) {
+		int linelen = get_line_length(msg + msgoffset, msglen);
+
+		ALLOC_GROW(*buf_p, *offset_p + linelen + 5, *space_p);
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
index 0000000..fe8f209
--- /dev/null
+++ b/notes.h
@@ -0,0 +1,8 @@
+#ifndef NOTES_H
+#define NOTES_H
+
+void get_commit_notes(const struct commit *commit,
+	char **buf_p, unsigned long *offset_p, unsigned long *space_p,
+	const char *output_encoding);
+
+#endif
-- 
1.5.3.rc1.16.g9d6f-dirty
