From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH v3] builtin-fast-export: Add importing and exporting of revision marks
Date: Wed, 11 Jun 2008 13:17:04 +0200
Message-ID: <1213183024-60013-1-git-send-email-pdebie@ai.rug.nl>
References: <7vve0hdbvv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 13:18:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6OLE-0001p1-6J
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 13:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbYFKLRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 07:17:15 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbYFKLRP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 07:17:15 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:54589 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbYFKLRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 07:17:14 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6208.orange.nl (SMTP Server) with ESMTP id 4BFD91C0008F;
	Wed, 11 Jun 2008 13:17:12 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6208.orange.nl (SMTP Server) with ESMTP id ABB5B1C00084;
	Wed, 11 Jun 2008 13:17:05 +0200 (CEST)
X-ME-UUID: 20080611111709703.ABB5B1C00084@mwinf6208.orange.nl
X-Mailer: git-send-email 1.5.6.rc1.153.gc1d96
In-Reply-To: <7vve0hdbvv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84602>

This adds the --import-marks and --export-marks to fast-export. These i=
mport
and export the marks used to for all revisions exported in a similar fa=
shion
to what fast-import does. The format is the same as fast-import, so you=
 can
create a bidirectional importer / exporter by using the same marks file=
 on
both sides.

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

On 10 jun 2008, at 08:47, Junio C Hamano wrote:
>Sign-off and tests are missing.
 =20
  I actually had this new patch ready, but I was hoping Dscho would ans=
wer
  this first:
 =20
On 7 jun 2008, at 18:37, Junio C Hamano wrote:
>Oh, I was not complaining about the one-fourthness.  I was wondering w=
hy
>"(uint32_t *)", which makes it look like the type itself has very deep
>meaning for this computation, was used, instead of "(char *)" or somet=
hing
>that makes it much clearer that what could be pointed at by the pointe=
r
>does not matter and you are only using them as fake integers.  If ther=
e is
>such a deep meaning, it needs documented, and if there isn't then prob=
ably
>the use of (uint32_t *) should also be fixed.
 =20
  since I don't know the answer to that :)
 =20
On 7 jun 2008, at 17:19, Johannes Schindelin wrote:
>Okay, I looked again, and indeed, you _copied_ it.  Instead of using t=
he=20
>functions mark_object() and get_object_mark() which are there only to =
be=20
>used by you.
>
>So please fix.
 =20
  How about this, explicit enough?
 =20
 Documentation/git-fast-export.txt |   20 +++++++
 builtin-fast-export.c             |   99 +++++++++++++++++++++++++++++=
+++++--
 t/t9301-fast-export.sh            |   24 +++++++++
 3 files changed, 137 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast=
-export.txt
index 332346c..277a547 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -36,6 +36,26 @@ when encountering a signed tag.  With 'strip', the t=
ags will be made
 unsigned, with 'verbatim', they will be silently exported
 and with 'warn', they will be exported, but you will see a warning.
=20
+--export-marks=3D<file>::
+	Dumps the internal marks table to <file> when complete.
+	Marks are written one per line as `:markid SHA-1`. Only marks
+	for revisions are dumped; marks for blobs are ignored.
+	Backends can use this file to validate imports after they
+	have been completed, or to save the marks table across
+	incremental runs.  As <file> is only opened and truncated
+	at completion, the same path can also be safely given to
+	\--import-marks.
+
+--import-marks=3D<file>::
+	Before processing any input, load the marks specified in
+	<file>.  The input file must exist, must be readable, and
+	must use the same format as produced by \--export-marks.
++
+Any commits that have already been marked will not be exported again.
+If the backend uses a similar \--import-marks file, this allows for
+incremental bidirectional exporting of the repository by keeping the
+marks the same across runs.
+
=20
 EXAMPLES
 --------
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 1dfc01e..94123c3 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -56,10 +56,24 @@ static int has_unshown_parent(struct commit *commit=
)
 }
=20
 /* Since intptr_t is C99, we do not use it here */
-static void mark_object(struct object *object)
+static inline uint32_t *mark_to_ptr(uint32_t mark)
 {
-	last_idnum++;
-	add_decoration(&idnums, object, ((uint32_t *)NULL) + last_idnum);
+	return ((uint32_t *)NULL) + mark;
+}
+
+static inline uint32_t ptr_to_mark(void * mark)
+{
+	return (uint32_t *)mark - (uint32_t *)NULL;
+}
+
+static inline void mark_object(struct object *object, uint32_t mark)
+{
+	add_decoration(&idnums, object, mark_to_ptr(mark));
+}
+
+static inline void mark_next_object(struct object *object)
+{
+	mark_object(object, ++last_idnum);
 }
=20
 static int get_object_mark(struct object *object)
@@ -67,7 +81,7 @@ static int get_object_mark(struct object *object)
 	void *decoration =3D lookup_decoration(&idnums, object);
 	if (!decoration)
 		return 0;
-	return (uint32_t *)decoration - (uint32_t *)NULL;
+	return ptr_to_mark(decoration);
 }
=20
 static void show_progress(void)
@@ -100,7 +114,7 @@ static void handle_object(const unsigned char *sha1=
)
 	if (!buf)
 		die ("Could not read blob %s", sha1_to_hex(sha1));
=20
-	mark_object(object);
+	mark_next_object(object);
=20
 	printf("blob\nmark :%d\ndata %lu\n", last_idnum, size);
 	if (size && fwrite(buf, size, 1, stdout) !=3D 1)
@@ -185,7 +199,7 @@ static void handle_commit(struct commit *commit, st=
ruct rev_info *rev)
 	for (i =3D 0; i < diff_queued_diff.nr; i++)
 		handle_object(diff_queued_diff.queue[i]->two->sha1);
=20
-	mark_object(&commit->object);
+	mark_next_object(&commit->object);
 	if (!is_encoding_utf8(encoding))
 		reencoded =3D reencode_string(message, "UTF-8", encoding);
 	printf("commit %s\nmark :%d\n%.*s\n%.*s\ndata %u\n%s",
@@ -352,18 +366,85 @@ static void handle_tags_and_duplicates(struct pat=
h_list *extra_refs)
 	}
 }
=20
+static void export_marks(char *file)
+{
+	unsigned int i;
+	uint32_t mark;
+	struct object_decoration *deco =3D idnums.hash;
+	FILE *f;
+
+	f =3D fopen(file, "w");
+	if (!f)
+		error("Unable to open marks file %s for writing", file);
+
+	for (i =3D 0; i < idnums.size; ++i) {
+		deco++;
+		if (deco && deco->base && deco->base->type =3D=3D 1) {
+			mark =3D ptr_to_mark(deco->decoration);
+			fprintf(f, ":%u %s\n", mark, sha1_to_hex(deco->base->sha1));
+		}
+	}
+
+	if (ferror(f) || fclose(f))
+		error("Unable to write marks file %s.", file);
+}
+
+static void import_marks(char * input_file)
+{
+	char line[512];
+	FILE *f =3D fopen(input_file, "r");
+	if (!f)
+		die("cannot read %s: %s", input_file, strerror(errno));
+
+	while (fgets(line, sizeof(line), f)) {
+		uint32_t mark;
+		char *line_end, *mark_end;
+		unsigned char sha1[20];
+		struct object *object;
+
+		line_end =3D strchr(line, '\n');
+		if (line[0] !=3D ':' || !line_end)
+			die("corrupt mark line: %s", line);
+		*line_end =3D 0;
+
+		mark =3D strtoumax(line + 1, &mark_end, 10);
+		if (!mark || mark_end =3D=3D line + 1
+			|| *mark_end !=3D ' ' || get_sha1(mark_end + 1, sha1))
+			die("corrupt mark line: %s", line);
+
+		object =3D parse_object(sha1);
+		if (!object)
+			die ("Could not read blob %s", sha1_to_hex(sha1));
+
+		if (object->flags & SHOWN)
+			error("Object %s already has a mark", sha1);
+
+		mark_object(object, mark);
+		if (last_idnum < mark)
+			last_idnum =3D mark;
+
+		object->flags |=3D SHOWN;
+	}
+	fclose(f);
+}
+
 int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits =3D { 0, 0, NULL };
 	struct path_list extra_refs =3D { NULL, 0, 0, 0 };
 	struct commit *commit;
+	char *export_filename, *import_filename;
 	struct option options[] =3D {
 		OPT_INTEGER(0, "progress", &progress,
 			    "show progress after <n> objects"),
 		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, "mode",
 			     "select handling of signed tags",
 			     parse_opt_signed_tag_mode),
+		OPT_STRING(0, "export-marks", &export_filename, "FILE",
+			     "Dump marks to this file"),
+		OPT_STRING(0, "import-marks", &import_filename, "FILE",
+			     "Import marks from this file"),
 		OPT_END()
 	};
=20
@@ -376,6 +457,9 @@ int cmd_fast_export(int argc, const char **argv, co=
nst char *prefix)
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
=20
+	if (import_filename)
+		import_marks(import_filename);
+
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
=20
 	if (prepare_revision_walk(&revs))
@@ -398,5 +482,8 @@ int cmd_fast_export(int argc, const char **argv, co=
nst char *prefix)
=20
 	handle_tags_and_duplicates(&extra_refs);
=20
+	if (export_filename)
+		export_marks(export_filename);
+
 	return 0;
 }
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index f09bfb1..60b5ee3 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -78,6 +78,30 @@ test_expect_success 'iso-8859-1' '
 		 git cat-file commit i18n | grep "=C3=81=C3=A9=C3=AD =C3=B3=C3=BA")
=20
 '
+test_expect_success 'import/export-marks' '
+
+	git checkout -b marks master &&
+	git fast-export --export-marks=3Dtmp-marks HEAD &&
+	test -s tmp-marks &&
+	cp tmp-marks ~ &&
+	test $(wc -l < tmp-marks) -eq 3 &&
+	test $(
+		git fast-export --import-marks=3Dtmp-marks\
+		--export-marks=3Dtmp-marks HEAD |
+		grep ^commit |
+		wc -l) \
+	-eq 0 &&
+	echo change > file &&
+	git commit -m "last commit" file &&
+	test $(
+		git fast-export --import-marks=3Dtmp-marks \
+		--export-marks=3Dtmp-marks HEAD |
+		grep ^commit\  |
+		wc -l) \
+	-eq 1 &&
+	test $(wc -l < tmp-marks) -eq 4
+
+'
=20
 cat > signed-tag-import << EOF
 tag sign-your-name
--=20
1.5.6.rc1.153.gc1d96
