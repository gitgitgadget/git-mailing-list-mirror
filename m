From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/4] Introduce commit notes
Date: Sat, 20 Dec 2008 13:05:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812201304580.30769@pacific.mpi-cbg.de>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de> <alpine.DEB.1.00.0812200034450.30769@pacific.mpi-cbg.de>
 <20081220065337.GA2581@coredump.intra.peff.net> <alpine.DEB.1.00.0812201304210.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 12:58:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE0Tt-0005jR-Mi
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 12:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYLTL5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 06:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbYLTL5f
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 06:57:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:45276 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751516AbYLTL5e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 06:57:34 -0500
Received: (qmail invoked by alias); 20 Dec 2008 11:57:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 20 Dec 2008 12:57:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jUsIEezIjKijk54Sw/QURKy647OQCE7+vB3zZFt
	h2dbDNIUjr5Y4Z
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0812201304210.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103643>


Commit notes are blobs which are shown together with the commit
message.  These blobs are taken from the notes ref, which you can
configure by the config variable core.notesRef, which in turn can
be overridden by the environment variable GIT_NOTES_REF.

The notes ref is a branch which contains "files" whose names are
the names of the corresponding commits (i.e. the SHA-1).

The rationale for putting this information into a ref is this: we
want to be able to fetch and possibly union-merge the notes,
maybe even look at the date when a note was introduced, and we
want to store them efficiently together with the other objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |   15 ++++++++++
 Makefile                 |    2 +
 cache.h                  |    3 ++
 commit.c                 |    1 +
 config.c                 |    5 +++
 environment.c            |    1 +
 notes.c                  |   68 ++++++++++++++++++++++++++++++++++++++++++++++
 notes.h                  |    7 +++++
 pretty.c                 |    5 +++
 9 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 notes.c
 create mode 100644 notes.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 21ea165..b35a32a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -422,6 +422,21 @@ relatively high IO latencies.  With this set to 'true', git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.
 
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
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/Makefile b/Makefile
index 5fcff9a..dc0a324 100644
--- a/Makefile
+++ b/Makefile
@@ -370,6 +370,7 @@ LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
 LIB_H += merge-recursive.h
+LIB_H += notes.h
 LIB_H += object.h
 LIB_H += pack.h
 LIB_H += pack-refs.h
@@ -451,6 +452,7 @@ LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += name-hash.o
+LIB_OBJS += notes.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-refs.o
diff --git a/cache.h b/cache.h
index 9dabcc7..9192853 100644
--- a/cache.h
+++ b/cache.h
@@ -375,6 +375,8 @@ static inline enum object_type object_type(unsigned int mode)
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
+#define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
+#define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
@@ -546,6 +548,7 @@ enum rebase_setup_type {
 
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
+extern char *notes_ref_name;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/commit.c b/commit.c
index c99db16..10e532a 100644
--- a/commit.c
+++ b/commit.c
@@ -5,6 +5,7 @@
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
+#include "notes.h"
 
 int save_commit_buffer = 1;
 
diff --git a/config.c b/config.c
index 790405a..e5d5b4b 100644
--- a/config.c
+++ b/config.c
@@ -469,6 +469,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.notesref")) {
+		notes_ref_name = xstrdup(value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.pager"))
 		return git_config_string(&pager_program, var, value);
 
diff --git a/environment.c b/environment.c
index e278bce..0edae21 100644
--- a/environment.c
+++ b/environment.c
@@ -45,6 +45,7 @@ enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
+char *notes_ref_name;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/notes.c b/notes.c
new file mode 100644
index 0000000..91ec77f
--- /dev/null
+++ b/notes.c
@@ -0,0 +1,68 @@
+#include "cache.h"
+#include "commit.h"
+#include "notes.h"
+#include "refs.h"
+#include "utf8.h"
+#include "strbuf.h"
+
+static int initialized;
+
+void get_commit_notes(const struct commit *commit, struct strbuf *sb,
+		const char *output_encoding)
+{
+	static const char *utf8 = "utf-8";
+	struct strbuf name = STRBUF_INIT;
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
+
+	if (!notes_ref_name)
+		return;
+
+	strbuf_addf(&name, "%s:%s", notes_ref_name,
+			sha1_to_hex(commit->object.sha1));
+	if (get_sha1(name.buf, sha1))
+		return;
+
+	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen ||
+			type != OBJ_BLOB)
+		return;
+
+	if (output_encoding && *output_encoding &&
+			strcmp(utf8, output_encoding)) {
+		char *reencoded = reencode_string(msg, output_encoding, utf8);
+		if (reencoded) {
+			free(msg);
+			msg = reencoded;
+			msglen = strlen(msg);
+		}
+	}
+
+	/* we will end the annotation by a newline anyway */
+	if (msglen && msg[msglen - 1] == '\n')
+		msglen--;
+
+	strbuf_addstr(sb, "\nNotes:\n");
+
+	for (msgoffset = 0; msgoffset < msglen;) {
+		int linelen = strchrnul(msg, '\n') - msg;
+
+		strbuf_addstr(sb, "    ");
+		strbuf_add(sb, msg + msgoffset, linelen);
+		msgoffset += linelen;
+	}
+	free(msg);
+}
diff --git a/notes.h b/notes.h
new file mode 100644
index 0000000..79d21b6
--- /dev/null
+++ b/notes.h
@@ -0,0 +1,7 @@
+#ifndef NOTES_H
+#define NOTES_H
+
+void get_commit_notes(const struct commit *commit, struct strbuf *sb,
+		const char *output_encoding);
+
+#endif
diff --git a/pretty.c b/pretty.c
index f6ff312..2d2872f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -6,6 +6,7 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "log-tree.h"
+#include "notes.h"
 
 static char *user_format;
 
@@ -881,5 +882,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	 */
 	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
+
+	if (fmt != CMIT_FMT_ONELINE)
+		get_commit_notes(commit, sb, encoding);
+
 	free(reencoded);
 }
-- 
1.6.1.rc3.412.ga72b
