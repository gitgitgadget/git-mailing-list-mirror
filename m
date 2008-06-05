From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH v2] builtin-fast-export: Add importing and exporting of revision marks
Date: Thu,  5 Jun 2008 12:52:43 +0200
Message-ID: <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl>
References: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 05 12:53:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4D6C-0005xF-0h
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 12:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbYFEKwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 06:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754969AbYFEKwq
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 06:52:46 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:29187 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945AbYFEKwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 06:52:46 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6304.orange.nl (SMTP Server) with ESMTP id E1B98700008C;
	Thu,  5 Jun 2008 12:52:44 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6304.orange.nl (SMTP Server) with ESMTP id 644047000088;
	Thu,  5 Jun 2008 12:52:44 +0200 (CEST)
X-ME-UUID: 20080605105244410.644047000088@mwinf6304.orange.nl
X-Mailer: git-send-email 1.5.6.rc0.165.ge08d6b.dirty
In-Reply-To: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83900>

This adds the --import-marks and --export-marks to fast-export. These import
and export the marks used to for all revisions exported in a similar fashion
to what fast-import does. The format is the same as fast-import, so you can
create a bidirectional importer / exporter by using the same marks file on
both sides.

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 builtin-fast-export.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 1dfc01e..8aed868 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -352,18 +352,86 @@ static void handle_tags_and_duplicates(struct path_list *extra_refs)
 	}
 }
 
+static void export_marks(char *file)
+{
+	unsigned int i;
+	uint32_t mark;
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
+			mark = (uint32_t *)deco->decoration - (uint32_t *)NULL;
+			fprintf(f, ":%u %s\n", mark,
+				sha1_to_hex(deco->base->sha1));
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
+	FILE *f = fopen(input_file, "r");
+	if (!f)
+		die("cannot read %s: %s", input_file, strerror(errno));
+
+	while (fgets(line, sizeof(line), f)) {
+		uint32_t mark;
+		char *line_end, *mark_end;
+		unsigned char sha1[20];
+		struct object *object;
+
+		line_end = strchr(line, '\n');
+		if (line[0] != ':' || !line_end)
+			die("corrupt mark line: %s", line);
+		*line_end = 0;
+
+		mark = strtoumax(line + 1, &mark_end, 10);
+		if (!mark || mark_end == line + 1
+			|| *mark_end != ' ' || get_sha1(mark_end + 1, sha1))
+			die("corrupt mark line: %s", line);
+
+		object = parse_object(sha1);
+		if (!object)
+			die ("Could not read blob %s", sha1_to_hex(sha1));
+
+		if (object->flags & SHOWN)
+			error("Object %s already has a mark", sha1);
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
+		OPT_STRING(0, "export-marks", &export_filename, "FILE",
+			   "Dump marks to this file"),
+		OPT_STRING(0, "import-marks", &import_filename, "FILE",
+			   "Import marks from this file"),
 		OPT_END()
 	};
 
@@ -376,6 +444,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
 
+	if (import_filename)
+		import_marks(import_filename);
+
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
 
 	if (prepare_revision_walk(&revs))
@@ -398,5 +469,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	handle_tags_and_duplicates(&extra_refs);
 
+	if (export_filename)
+		export_marks(export_filename);
+
 	return 0;
 }
-- 
1.5.6.rc0.165.ge08d6b.dirty
