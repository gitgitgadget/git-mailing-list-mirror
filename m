From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 01/22] Introduce commit notes
Date: Fri, 09 Oct 2009 12:21:57 +0200
Message-ID: <1255083738-23263-3-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClO-0004PL-72
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760666AbZJIKXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 06:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760664AbZJIKXU
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:23:20 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54694 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760661AbZJIKXS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:23:18 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BNDSTG9320@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:28 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:28 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129768>

=46rom: Johannes Schindelin <Johannes.Schindelin@gmx.de>

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

This patch has been improved by the following contributions:
- Thomas Rast: fix core.notesRef documentation
- Tor Arne Vestb=C3=B8: fix printing of multi-line notes
- Alex Riesen: Using char array instead of char pointer costs less BSS
- Johan Herland: Plug leak when msg is good, but msglen or type causes =
return

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Tor Arne Vestb=C3=B8 <tavestbo@trolltech.com>
Signed-off-by: Johan Herland <johan@herland.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

get_commit_notes(): Plug memory leak when 'if' triggers, but not becaus=
e of read_sha1_file() failure
---
 Documentation/config.txt |   13 ++++++++
 Makefile                 |    2 +
 cache.h                  |    4 ++
 commit.c                 |    1 +
 config.c                 |    5 +++
 environment.c            |    1 +
 notes.c                  |   70 ++++++++++++++++++++++++++++++++++++++=
++++++++
 notes.h                  |    7 ++++
 pretty.c                 |    5 +++
 9 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 notes.c
 create mode 100644 notes.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cc156b8..32b0cdf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -458,6 +458,19 @@ On some file system/operating system combinations,=
 this is unreliable.
 Set this config setting to 'rename' there; However, This will remove t=
he
 check that makes sure that existing object files will not get overwrit=
ten.
=20
+core.notesRef::
+	When showing commit messages, also show notes which are stored in
+	the given ref.  This ref is expected to contain files named
+	after the full SHA-1 of the commit they annotate.
++
+If such a file exists in the given ref, the referenced blob is read, a=
nd
+appended to the commit message, separated by a "Notes:" line.  If the
+given ref itself does not exist, it is not an error, but means that no
+notes should be printed.
++
+This setting defaults to "refs/notes/commits", and can be overridden b=
y
+the `GIT_NOTES_REF` environment variable.
+
 add.ignore-errors::
 	Tells 'git-add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/Makefile b/Makefile
index 8925b1d..9e414db 100644
--- a/Makefile
+++ b/Makefile
@@ -429,6 +429,7 @@ LIB_H +=3D ll-merge.h
 LIB_H +=3D log-tree.h
 LIB_H +=3D mailmap.h
 LIB_H +=3D merge-recursive.h
+LIB_H +=3D notes.h
 LIB_H +=3D object.h
 LIB_H +=3D pack.h
 LIB_H +=3D pack-refs.h
@@ -513,6 +514,7 @@ LIB_OBJS +=3D match-trees.o
 LIB_OBJS +=3D merge-file.o
 LIB_OBJS +=3D merge-recursive.o
 LIB_OBJS +=3D name-hash.o
+LIB_OBJS +=3D notes.o
 LIB_OBJS +=3D object.o
 LIB_OBJS +=3D pack-check.o
 LIB_OBJS +=3D pack-refs.o
diff --git a/cache.h b/cache.h
index 96840c7..0343e8e 100644
--- a/cache.h
+++ b/cache.h
@@ -372,6 +372,8 @@ static inline enum object_type object_type(unsigned=
 int mode)
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
+#define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
+#define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
=20
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
@@ -567,6 +569,8 @@ enum object_creation_mode {
=20
 extern enum object_creation_mode object_creation_mode;
=20
+extern char *notes_ref_name;
+
 extern int grafts_replace_parents;
=20
 #define GIT_REPO_VERSION 0
diff --git a/commit.c b/commit.c
index fedbd5e..5ade8ed 100644
--- a/commit.c
+++ b/commit.c
@@ -5,6 +5,7 @@
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
+#include "notes.h"
=20
 int save_commit_buffer =3D 1;
=20
diff --git a/config.c b/config.c
index c644061..51f2208 100644
--- a/config.c
+++ b/config.c
@@ -467,6 +467,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.notesref")) {
+		notes_ref_name =3D xstrdup(value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.pager"))
 		return git_config_string(&pager_program, var, value);
=20
diff --git a/environment.c b/environment.c
index 5de6837..571ab56 100644
--- a/environment.c
+++ b/environment.c
@@ -49,6 +49,7 @@ enum push_default_type push_default =3D PUSH_DEFAULT_=
MATCHING;
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
 enum object_creation_mode object_creation_mode =3D OBJECT_CREATION_MOD=
E;
+char *notes_ref_name;
 int grafts_replace_parents =3D 1;
=20
 /* Parallel index stat data preload? */
diff --git a/notes.c b/notes.c
new file mode 100644
index 0000000..66379ff
--- /dev/null
+++ b/notes.c
@@ -0,0 +1,70 @@
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
+	static const char utf8[] =3D "utf-8";
+	struct strbuf name =3D STRBUF_INIT;
+	unsigned char sha1[20];
+	char *msg, *msg_p;
+	unsigned long linelen, msglen;
+	enum object_type type;
+
+	if (!initialized) {
+		const char *env =3D getenv(GIT_NOTES_REF_ENVIRONMENT);
+		if (env)
+			notes_ref_name =3D getenv(GIT_NOTES_REF_ENVIRONMENT);
+		else if (!notes_ref_name)
+			notes_ref_name =3D GIT_NOTES_DEFAULT_REF;
+		if (notes_ref_name && read_ref(notes_ref_name, sha1))
+			notes_ref_name =3D NULL;
+		initialized =3D 1;
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
+	if (!(msg =3D read_sha1_file(sha1, &type, &msglen)) || !msglen ||
+			type !=3D OBJ_BLOB) {
+		free(msg);
+		return;
+	}
+
+	if (output_encoding && *output_encoding &&
+			strcmp(utf8, output_encoding)) {
+		char *reencoded =3D reencode_string(msg, output_encoding, utf8);
+		if (reencoded) {
+			free(msg);
+			msg =3D reencoded;
+			msglen =3D strlen(msg);
+		}
+	}
+
+	/* we will end the annotation by a newline anyway */
+	if (msglen && msg[msglen - 1] =3D=3D '\n')
+		msglen--;
+
+	strbuf_addstr(sb, "\nNotes:\n");
+
+	for (msg_p =3D msg; msg_p < msg + msglen; msg_p +=3D linelen + 1) {
+		linelen =3D strchrnul(msg_p, '\n') - msg_p;
+
+		strbuf_addstr(sb, "    ");
+		strbuf_add(sb, msg_p, linelen);
+		strbuf_addch(sb, '\n');
+	}
+
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
index f5983f8..e25db81 100644
--- a/pretty.c
+++ b/pretty.c
@@ -6,6 +6,7 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "log-tree.h"
+#include "notes.h"
 #include "color.h"
=20
 static char *user_format;
@@ -975,5 +976,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const s=
truct commit *commit,
 	 */
 	if (fmt =3D=3D CMIT_FMT_EMAIL && sb->len <=3D beginning_of_body)
 		strbuf_addch(sb, '\n');
+
+	if (fmt !=3D CMIT_FMT_ONELINE)
+		get_commit_notes(commit, sb, encoding);
+
 	free(reencoded);
 }
--=20
1.6.4.304.g1365c.dirty
