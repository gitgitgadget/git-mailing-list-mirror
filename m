From: Johan Herland <johan@herland.net>
Subject: [RFC 08/11] Teach foreign transport code to perform the "capabilities"
 command
Date: Mon, 27 Jul 2009 03:04:16 +0200
Message-ID: <1248656659-21415-9-git-send-email-johan@herland.net>
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
	id 1MVEfU-0004JH-UQ
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 03:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbZG0BFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 21:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbZG0BFt
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 21:05:49 -0400
Received: from mx.getmail.no ([84.208.15.66]:43173 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755465AbZG0BFs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 21:05:48 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF0078M1PNZF40@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:47 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF004SX1O2UG30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:47 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.27.5416
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248656659-21415-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124151>

The features reported by the vcs helper are stored in the foreign_data struct
which is expanded for this purpose.

In the process, we also change the capabilities command slightly to expect
one feature per line (instead of all features on a single line). This enables
us to add features in the future that take one or more arguments. To terminate
the list of features, a blank line is output at the end.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-vcs.txt |    8 ++--
 transport-foreign.c       |   83 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-vcs.txt b/Documentation/git-vcs.txt
index febe415..85656d4 100644
--- a/Documentation/git-vcs.txt
+++ b/Documentation/git-vcs.txt
@@ -33,10 +33,10 @@ The output of each command must be produced on the helper's standard output.
 The helper's standard error stream can be used for status/progress messages.
 
 'capabilities'::
-	Outputs a single line with a list of feature names separated
-	by spaces. Each of these indicates a supported feature of the
-	helper, and the caller will only attempt operations that are
-	supported.
+	Outputs a list of feature names, one per line. Each of these
+	indicates a supported feature of the helper, and the caller
+	will only attempt operations that are supported.
+	The output list shall be terminated with a blank line.
 
 'list'::
 	Outputs the names of refs, one per line. These may be
diff --git a/transport-foreign.c b/transport-foreign.c
index 29aad77..be0a587 100644
--- a/transport-foreign.c
+++ b/transport-foreign.c
@@ -8,38 +8,81 @@
 
 struct foreign_data
 {
-	struct child_process *importer;
+	struct child_process importer;
+
+	/* capabilities */
+	unsigned export:1;
+	unsigned export_branch:1;
+	unsigned export_merges:1;
 };
 
+static void get_foreign_capabilities(struct foreign_data *fdata)
+{
+	struct strbuf buf;
+	FILE *file;
+
+	write(fdata->importer.in, "capabilities\n", 13);
+
+	strbuf_init(&buf, 0);
+	file = fdopen(fdata->importer.out, "r");
+	while (1) {
+		char *eon;
+		if (strbuf_getline(&buf, file, '\n') == EOF)
+			break;
+
+		if (!*buf.buf)
+			break;
+
+		eon = strchr(buf.buf, ' ');
+		if (eon)
+			*eon = '\0';
+
+		/* parse features */
+		if (!strcmp(buf.buf, "export"))
+			fdata->export = 1;
+		else if (!strcmp(buf.buf, "export-branch"))
+			fdata->export_branch = 1;
+		else if (!strcmp(buf.buf, "export-merges"))
+			fdata->export_merges = 1;
+		else
+			die("Invalid feature '%s'", buf.buf);
+
+		strbuf_reset(&buf);
+	}
+
+	strbuf_release(&buf);
+}
+
 static struct child_process *get_importer(struct transport *transport)
 {
-	struct child_process *importer = transport->data;
-	if (!importer) {
+	struct foreign_data *fdata = (struct foreign_data *) transport->data;
+	if (!fdata) {
 		struct strbuf buf;
-		importer = xcalloc(1, sizeof(*importer));
-		importer->in = -1;
-		importer->out = -1;
-		importer->err = 0;
-		importer->argv = xcalloc(3, sizeof(*importer->argv));
+		fdata = xcalloc(1, sizeof(*fdata));
+		fdata->importer.in = -1;
+		fdata->importer.out = -1;
+		fdata->importer.err = 0;
+		fdata->importer.argv = xcalloc(3, sizeof(*fdata->importer.argv));
 		strbuf_init(&buf, 80);
 		strbuf_addf(&buf, "vcs-%s", transport->remote->foreign_vcs);
-		importer->argv[0] = buf.buf;
-		importer->argv[1] = transport->remote->name;
-		importer->git_cmd = 1;
-		start_command(importer);
-		transport->data = importer;
+		fdata->importer.argv[0] = buf.buf;
+		fdata->importer.argv[1] = transport->remote->name;
+		fdata->importer.git_cmd = 1;
+		start_command(&fdata->importer);
+		get_foreign_capabilities(fdata);
+		transport->data = fdata;
 	}
-	return importer;
+	return &fdata->importer;
 }
 
 static int disconnect_foreign(struct transport *transport)
 {
-	struct child_process *importer = transport->data;
-	if (importer) {
-		write(importer->in, "\n", 1);
-		close(importer->in);
-		finish_command(importer);
-		free(importer);
+	struct foreign_data *fdata = (struct foreign_data *) transport->data;
+	if (fdata) {
+		write(fdata->importer.in, "\n", 1);
+		close(fdata->importer.in);
+		finish_command(&fdata->importer);
+		free(fdata);
 		transport->data = NULL;
 	}
 	return 0;
-- 
1.6.4.rc3.138.ga6b98.dirty
