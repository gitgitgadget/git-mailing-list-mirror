From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] WIP: git notes copy --stdin
Date: Sun, 14 Feb 2010 22:46:57 +0100
Message-ID: <0b241a335d71bdf56a07a712cb5506e1b1e1db6f.1266183704.git.trast@student.ethz.ch>
References: <cover.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 22:47:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgmJ0-0003BY-Hi
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab0BNVrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 16:47:01 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:21473 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab0BNVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:47:00 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 22:46:58 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 22:46:57 +0100
X-Mailer: git-send-email 1.7.0.224.g30f23.dirty
In-Reply-To: <cover.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139944>

This implements a 'git notes copy --stdin' mode suitable to read the
data fed to the post-rewrite hook.
---

Ok, so I changed my mind and decided to implement the "make it
built-in and configurable" way.  This helper should work.  I spent
some time trying to refactor cmd_notes() into something that can
nicely handle commands that do not fit the normal scheme, but
eventually was too tired to continue and just crafted it in the
existing code in the right place.

If nobody beats me to it I'll pick this up later this week, but
tomorrow will be too busy to even think about it.


 builtin-notes.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/builtin-notes.c b/builtin-notes.c
index 123ecad..3cd9e45 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -278,6 +278,52 @@ int commit_notes(struct notes_tree *t, const char *msg)
 	return 0;
 }
 
+int notes_copy_from_stdin(int force)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct notes_tree *t;
+
+	init_notes(NULL, NULL, NULL, 0);
+	t = &default_notes_tree;
+
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		unsigned char from_obj[20], to_obj[20];
+		struct strbuf **split;
+		const unsigned char *note;
+
+		split = strbuf_split(&buf, ' ');
+		if (!split[0] || !split[1])
+			die("Malformed input line: '%s'.", buf.buf);
+		strbuf_rtrim(split[0]);
+		strbuf_rtrim(split[1]);
+		if (get_sha1(split[0]->buf, from_obj))
+			die("Failed to resolve '%s' as a valid ref.", split[0]->buf);
+		if (get_sha1(split[1]->buf, to_obj))
+			die("Failed to resolve '%s' as a valid ref.", split[1]->buf);
+
+		note = get_note(t, from_obj);
+		if (!force) {
+			const unsigned char *existing_note = get_note(t, to_obj);
+			if (existing_note) {
+				error("Cannot copy notes. Found existing notes for object"
+				      " %s. Use '-f' to overwrite existing notes",
+				      sha1_to_hex(to_obj));
+				return 1;
+			}
+		}
+
+		if (note)
+			add_note(t, to_obj, note, combine_notes_overwrite);
+		else
+			remove_note(t, to_obj);
+
+		strbuf_list_free(split);
+	}
+
+	commit_notes(t, "Notes added by 'git notes copy'");
+	return 0;
+}
+
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
 	struct notes_tree *t;
@@ -301,6 +347,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('C', "reuse-message", &msg, "OBJECT",
 			   "reuse specified note object", parse_reuse_arg),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
+		OPT_BOOLEAN(0, "stdin", &force, "read objects from stdin"),
 		OPT_END()
 	};
 
@@ -351,6 +398,15 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	if (copy) {
 		const char *from_ref;
+		if (stdin) {
+			if (argc > 2) {
+				error("too few parameters");
+				usage_with_options(git_notes_usage, options);
+			} else {
+				retval = notes_copy_from_stdin(force);
+				goto end;
+			}
+		}
 		if (argc < 3) {
 			error("too few parameters");
 			usage_with_options(git_notes_usage, options);
-- 
1.7.0.224.g30f23.dirty
