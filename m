From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 11/11] notes: add shorthand --ref to override GIT_NOTES_REF
Date: Tue, 23 Feb 2010 01:42:29 +0100
Message-ID: <cb91ce31f300d774d230eaf7f57c37955caca673.1266885599.git.trast@student.ethz.ch>
References: <cover.1266885599.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjisL-0002rD-L3
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 01:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab0BWAnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 19:43:25 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:48627 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873Ab0BWAnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 19:43:07 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 01:42:52 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 01:42:34 +0100
X-Mailer: git-send-email 1.7.0.218.g73a398
In-Reply-To: <cover.1266885599.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140755>

Adds a shorthand option that overrides the GIT_NOTES_REF variable, and
hence determines the notes tree that will be manipulated.  It also
DWIMs a refs/notes/ prefix.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Changes since v4:
* doc tweaks

 Documentation/git-notes.txt |    5 +++++
 builtin-notes.c             |   16 ++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 92f1249..467a963 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -115,6 +115,11 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the note message.
 
+--ref <ref>::
+	Manipulate the notes tree in <ref>.  This overrides both
+	GIT_NOTES_REF and the "core.notesRef" configuration.  The ref
+	is taken to be in `refs/notes/` if it is not qualified.
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
diff --git a/builtin-notes.c b/builtin-notes.c
index 026cfd3..2e45be9 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -447,6 +447,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	const char *rewrite_cmd = NULL;
+	const char *override_notes_ref = NULL;
 	struct option options[] = {
 		OPT_GROUP("Notes options"),
 		OPT_CALLBACK('m', "message", &msg, "MSG",
@@ -459,6 +460,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 			   "reuse specified note object", parse_reuse_arg),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
+		OPT_STRING(0, "ref", &override_notes_ref, "notes_ref",
+			   "use notes from <notes_ref>"),
 		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
 			   "load rewriting config for <command> (implies --stdin)"),
 		OPT_END()
@@ -468,6 +471,19 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage, 0);
 
+	if (override_notes_ref) {
+		struct strbuf sb = STRBUF_INIT;
+		if (!prefixcmp(override_notes_ref, "refs/notes/"))
+			/* we're happy */;
+		else if (!prefixcmp(override_notes_ref, "notes/"))
+			strbuf_addstr(&sb, "refs/");
+		else
+			strbuf_addstr(&sb, "refs/notes/");
+		strbuf_addstr(&sb, override_notes_ref);
+		setenv("GIT_NOTES_REF", sb.buf, 1);
+		strbuf_release(&sb);
+	}
+
 	if (argc && !strcmp(argv[0], "list"))
 		list = 1;
 	else if (argc && !strcmp(argv[0], "add"))
-- 
1.7.0.218.g73a398
