From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6 11/13] notes: add shorthand --ref to override GIT_NOTES_REF
Date: Wed, 10 Mar 2010 15:05:58 +0100
Message-ID: <dd44a5b7ef528c37293a0aa3df2e5016938d23fa.1268229087.git.trast@student.ethz.ch>
References: <cover.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 15:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpMYp-0004t1-Fj
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 15:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327Ab0CJOGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 09:06:22 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7926 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198Ab0CJOGR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 09:06:17 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:05 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:01 +0100
X-Mailer: git-send-email 1.7.0.2.407.g21ebda
In-Reply-To: <cover.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141898>

Adds a shorthand option that overrides the GIT_NOTES_REF variable, and
hence determines the notes tree that will be manipulated.  It also
DWIMs a refs/notes/ prefix.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
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
1.7.0.2.407.g21ebda
