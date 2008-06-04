From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] builtin-fast-export: Add importing and exporting of revision marks
Date: Wed,  4 Jun 2008 22:55:47 +0200
Message-ID: <1212612947-34720-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:56:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K402F-0004jx-EK
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYFDUzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbYFDUzu
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:55:50 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:20011 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbYFDUzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:55:49 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id 41E837000083;
	Wed,  4 Jun 2008 22:55:48 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id 926B07000082;
	Wed,  4 Jun 2008 22:55:47 +0200 (CEST)
X-ME-UUID: 20080604205547599.926B07000082@mwinf6109.orange.nl
X-Mailer: git-send-email 1.5.6.rc0.165.ge08d6b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83827>

This adds the --import-marks and --export-marks to fast-export. These import
and export the marks used to for all revisions exported in a similar fashion
to what fast-import does. The format is the same as fast-import, so you can
create a bidirectional importer / exporter by using the same marks file on
both sides.
---

I used this to create a bidirectional import/export script between Git and
Bazaar. As both sides can now both import and export marks, keeping two
repositories in sync is just a matter of keeping the marks files up to date.

This is my first c code that's more than one line, so please don't be too
harsh ;)

 builtin-fast-export.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 8218199..1d5c83d 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -375,30 +375,98 @@ static void handle_tags_and_duplicates(struct path_list *extra_refs)
 	}
 }
 
+static void export_marks(char * file)
+{
+	unsigned int i;
+	uintmax_t mark;
+	struct object_decoration *deco = idnums.hash;
+	FILE *f;
+
+	f = fopen(file, "w");
+	if (!f)
+		error("Unable to open marks file %s for writing", file);
+
+	for (i = 0; i < idnums.size; ++i) {
+		deco++;
+		if (deco && deco->base && deco->base->type == 1) {
+			mark = (uint32_t *) deco-> decoration - (uint32_t *)NULL;
+			fprintf(f, ":%" PRIuMAX " %s\n", mark, sha1_to_hex(deco->base->sha1));
+		}
+	}
+	if (ferror(f) || fclose(f)) {
+		error("Unable to write marks file %s.", file);
+	}
+}
+
+static void import_marks(char * input_file)
+{
+	char line[512];
+	FILE *f = fopen(input_file, "r");
+	if (!f)
+		die("cannot read %s: %s", input_file, strerror(errno));
+
+	while (fgets(line, sizeof(line), f)) {
+		uintmax_t mark;
+		char *end;
+		unsigned char sha1[20];
+		struct object *object;
+
+		end = strchr(line, '\n');
+		if (line[0] != ':' || !end)
+			die("corrupt mark line: %s", line);
+		*end = 0;
+		mark = strtoumax(line + 1, &end, 10);
+		if (!mark || end == line + 1
+			|| *end != ' ' || get_sha1(end + 1, sha1))
+			die("corrupt mark line: %s", line);
+
+		object = parse_object(sha1);
+		if (!object)
+			die ("Could not read blob %s", sha1_to_hex(sha1));
+
+		if (object->flags & SHOWN)
+			error("Object %s was already has a mark", sha1);
+
+		add_decoration(&idnums, object, ((uint32_t *)NULL) + mark);
+		if (last_idnum < mark)
+			last_idnum = mark;
+
+		object->flags |= SHOWN;
+	}
+	fclose(f);
+}
+
 int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits = { 0, 0, NULL };
 	struct path_list extra_refs = { NULL, 0, 0, 0 };
 	struct commit *commit;
+	char *export_filename, *import_filename;
 	struct option options[] = {
 		OPT_INTEGER(0, "progress", &progress,
 			    "show progress after <n> objects"),
 		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, "mode",
 			     "select handling of signed tags",
 			     parse_opt_signed_tag_mode),
+		OPT_STRING(0, "export-marks", &export_filename, "FILE", "Dump marks to this file"),
+		OPT_STRING(0, "import-marks", &import_filename, "FILE", "Import marks from this file"),
 		OPT_END()
 	};
 
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
 
+
 	init_revisions(&revs, prefix);
 	argc = setup_revisions(argc, argv, &revs, NULL);
 	argc = parse_options(argc, argv, options, fast_export_usage, 0);
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
 
+	if (import_filename)
+		import_marks(import_filename);
+
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
 
 	if (prepare_revision_walk(&revs))
@@ -421,5 +489,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	handle_tags_and_duplicates(&extra_refs);
 
+	if (export_filename)
+		export_marks(export_filename);
+
 	return 0;
 }
-- 
1.5.6.rc0.165.ge08d6b.dirty
