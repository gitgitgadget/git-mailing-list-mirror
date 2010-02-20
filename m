From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 12/12] notes: add shorthand --ref to override GIT_NOTES_REF
Date: Sat, 20 Feb 2010 23:16:33 +0100
Message-ID: <eb6ad05f34ee1ad2285320ca2df6bb84e4be2bd5.1266703765.git.trast@student.ethz.ch>
References: <cover.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 00:31:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nixe7-0006OX-43
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 23:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921Ab0BTWR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 17:17:27 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:6942 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756869Ab0BTWRU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 17:17:20 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:58 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:40 +0100
X-Mailer: git-send-email 1.7.0.137.gfe3f1
In-Reply-To: <cover.1266703765.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140573>

Adds a shorthand option that overrides the GIT_NOTES_REF variable, and
hence determines the notes tree that will be manipulated.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-notes.txt |    4 ++++
 builtin-notes.c             |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 92f1249..dcdcc95 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -115,6 +115,10 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the note message.
 
+--ref <ref>::
+	Manipulate the notes tree in <ref>.  This overrides both
+	GIT_NOTES_REF and the "core.notesRef" configuration.
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
diff --git a/builtin-notes.c b/builtin-notes.c
index 19dd3ab..8cc0037 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -430,6 +430,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	const char *rewrite_cmd = NULL;
+	const char *override_notes_ref = NULL;
 	struct option options[] = {
 		OPT_GROUP("Notes options"),
 		OPT_CALLBACK('m', "message", &msg, "MSG",
@@ -442,6 +443,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 			   "reuse specified note object", parse_reuse_arg),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
+		OPT_STRING(0, "ref", &override_notes_ref, "notes_ref",
+			   "use notes from <notes_ref>"),
 		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
 			   "load rewriting config for <command> (implies --stdin)"),
 		OPT_END()
@@ -451,6 +454,9 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage, 0);
 
+	if (override_notes_ref)
+		setenv("GIT_NOTES_REF", override_notes_ref, 1);
+
 	if (argc && !strcmp(argv[0], "list"))
 		list = 1;
 	else if (argc && !strcmp(argv[0], "add"))
-- 
1.7.0.59.g783f8
