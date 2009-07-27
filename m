From: Johan Herland <johan@herland.net>
Subject: [RFC 09/11] Introduce a 'marks <filename>' feature to the foreign
 transport code
Date: Mon, 27 Jul 2009 03:04:17 +0200
Message-ID: <1248656659-21415-10-git-send-email-johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 03:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVEfV-0004JH-K6
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 03:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbZG0BFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 21:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755465AbZG0BFu
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 21:05:50 -0400
Received: from mx.getmail.no ([84.208.15.66]:48695 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755496AbZG0BFt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 21:05:49 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF0042A1PPSEC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:49 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF004SX1O2UG30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:49 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.27.5416
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248656659-21415-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124150>

The 'marks' feature is reported by the vcs helper when it requires the
fast-import marks database to loaded/saved by the git-fast-import process
that is executed by the foreign transport machinery. The feature is
advertised along with exactly one argument: the location of the file
containing the marks database.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-vcs.txt |    8 ++++++++
 transport-foreign.c       |   32 ++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-vcs.txt b/Documentation/git-vcs.txt
index 85656d4..75815ba 100644
--- a/Documentation/git-vcs.txt
+++ b/Documentation/git-vcs.txt
@@ -65,6 +65,14 @@ there may be other restrictions on what may be exported.
 FEATURES
 --------
 
+'marks' filename::
+	Helper requires the marks from a git-fast-import run to be loaded
+	from, and saved to, the given filename. When this "feature" is
+	advertised, each git-fast-import run must load and save the
+	internal marks database (see the --import-marks and --export-marks
+	option to git-fast-import for more details) located at the given
+	filename.
+
 'export'::
 	Helper supports exporting commits, at least exporting
 	non-merge commits whose parents are not the parents of any
diff --git a/transport-foreign.c b/transport-foreign.c
index be0a587..ae9cb9a 100644
--- a/transport-foreign.c
+++ b/transport-foreign.c
@@ -11,6 +11,7 @@ struct foreign_data
 	struct child_process importer;
 
 	/* capabilities */
+	char *marks_filename;
 	unsigned export:1;
 	unsigned export_branch:1;
 	unsigned export_merges:1;
@@ -38,7 +39,12 @@ static void get_foreign_capabilities(struct foreign_data *fdata)
 			*eon = '\0';
 
 		/* parse features */
-		if (!strcmp(buf.buf, "export"))
+		if (!strcmp(buf.buf, "marks")) {
+			if (!eon)
+				die("Feature 'marks' requires an argument");
+			fdata->marks_filename = xstrdup(eon + 1);
+		}
+		else if (!strcmp(buf.buf, "export"))
 			fdata->export = 1;
 		else if (!strcmp(buf.buf, "export-branch"))
 			fdata->export_branch = 1;
@@ -82,6 +88,7 @@ static int disconnect_foreign(struct transport *transport)
 		write(fdata->importer.in, "\n", 1);
 		close(fdata->importer.in);
 		finish_command(&fdata->importer);
+		free(fdata->marks_filename);
 		free(fdata);
 		transport->data = NULL;
 	}
@@ -91,10 +98,13 @@ static int disconnect_foreign(struct transport *transport)
 static int fetch_refs_via_foreign(struct transport *transport,
 				  int nr_heads, struct ref **to_fetch)
 {
+	struct foreign_data *fdata;
 	struct child_process *importer;
 	struct child_process fastimport;
 	struct ref *posn;
+	struct strbuf export_marks, import_marks;
 	int i, count;
+	FILE *f;
 
 	count = 0;
 	for (i = 0; i < nr_heads; i++) {
@@ -105,12 +115,28 @@ static int fetch_refs_via_foreign(struct transport *transport,
 	}
 	if (count) {
 		importer = get_importer(transport);
+		fdata = (struct foreign_data *) transport->data;
+		strbuf_init(&export_marks, 0);
+		strbuf_init(&import_marks, 0);
 
 		memset(&fastimport, 0, sizeof(fastimport));
 		fastimport.in = importer->out;
-		fastimport.argv = xcalloc(3, sizeof(*fastimport.argv));
+		fastimport.argv = xcalloc(5, sizeof(*fastimport.argv));
 		fastimport.argv[0] = "fast-import";
 		fastimport.argv[1] = "--quiet";
+		if (fdata->marks_filename) {
+			strbuf_addf(&export_marks, "--export-marks=%s",
+				fdata->marks_filename);
+			fastimport.argv[2] = export_marks.buf;
+
+			f = fopen(fdata->marks_filename, "r");
+			if (f) {
+				strbuf_addf(&import_marks, "--import-marks=%s",
+					fdata->marks_filename);
+				fastimport.argv[3] = import_marks.buf;
+				fclose(f);
+			}
+		}
 		fastimport.git_cmd = 1;
 		start_command(&fastimport);
 
@@ -124,6 +150,8 @@ static int fetch_refs_via_foreign(struct transport *transport,
 		}
 		disconnect_foreign(transport);
 		finish_command(&fastimport);
+		strbuf_release(&export_marks);
+		strbuf_release(&import_marks);
 	}
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
-- 
1.6.4.rc3.138.ga6b98.dirty
