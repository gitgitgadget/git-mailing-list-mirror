From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 11/13] notes: add shorthand --ref to override GIT_NOTES_REF
Date: Fri, 12 Mar 2010 18:04:35 +0100
Message-ID: <64e07051ff37ccc8528064c0dccc75eeeddf4701.1268413246.git.trast@student.ethz.ch>
References: <cover.1268413246.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 18:06:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq8JT-00018m-Ez
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 18:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758653Ab0CLRFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 12:05:33 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:30419 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758643Ab0CLRF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 12:05:29 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:27 +0100
Received: from localhost.localdomain (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:09 +0100
X-Mailer: git-send-email 1.7.0.2.417.gbc354
In-Reply-To: <cover.1268413246.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142045>

Adds a shorthand option that overrides the GIT_NOTES_REF variable, and
hence determines the notes tree that will be manipulated.  It also
DWIMs a refs/notes/ prefix.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Johan Herland <johan@herland.net>
---


 Documentation/git-notes.txt |    5 +++++
 builtin/notes.c             |   16 ++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 77311bd..02a2baf 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -116,6 +116,11 @@ OPTIONS
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
diff --git a/builtin/notes.c b/builtin/notes.c
index 6c2297a..cb30ad0 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -438,6 +438,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	const char *rewrite_cmd = NULL;
+	const char *override_notes_ref = NULL;
 	struct option options[] = {
 		OPT_GROUP("Notes contents options"),
 		{ OPTION_CALLBACK, 'm', "message", &msg, "MSG",
@@ -455,6 +456,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_GROUP("Other options"),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
+		OPT_STRING(0, "ref", &override_notes_ref, "notes_ref",
+			   "use notes from <notes_ref>"),
 		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
 			   "load rewriting config for <command> (implies --stdin)"),
 		OPT_END()
@@ -464,6 +467,19 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
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
1.7.0.2.417.gbc354
