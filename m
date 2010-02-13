From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 29/30] builtin-notes: Misc. refactoring of argc and exit
 value handling
Date: Sat, 13 Feb 2010 22:28:37 +0100
Message-ID: <1266096518-2104-30-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZJ-0001iD-Qx
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148Ab0BMVaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:30:17 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51565 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758138Ab0BMVaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:30:09 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EH3UE5VE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:30:05 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:30:05 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211825
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139850>

This is in preparation of future patches that add additional subcommands.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-notes.c |   61 ++++++++++++++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/builtin-notes.c b/builtin-notes.c
index 98de115..bbf98a9 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -287,7 +287,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	int list = 0, add = 0, append = 0, edit = 0, show = 0, remove = 0,
 	    prune = 0, force = 0;
-	int given_object;
+	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
 		OPT_GROUP("Notes options"),
@@ -321,8 +321,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		remove = 1;
 	else if (argc && !strcmp(argv[0], "prune"))
 		prune = 1;
-	else if (!argc)
+	else if (!argc) {
 		list = 1; /* Default to 'list' if no other subcommand given */
+		i = 0;
+	}
 
 	if (list + add + append + edit + show + remove + prune != 1)
 		usage_with_options(git_notes_usage, options);
@@ -344,9 +346,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 	}
 
-	given_object = argc == 2;
-	object_ref = given_object ? argv[1] : "HEAD";
-	if (argc > 2 || (prune && argc > 1)) {
+	given_object = argc > i;
+	object_ref = given_object ? argv[i++] : "HEAD";
+
+	if (argc > i || (prune && given_object)) {
 		error("too many parameters");
 		usage_with_options(git_notes_usage, options);
 	}
@@ -369,34 +372,38 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		if (given_object) {
 			if (note) {
 				puts(sha1_to_hex(note));
-				return 0;
+				goto end;
 			}
-		} else
-			return for_each_note(t, 0, list_each_note, NULL);
+		} else {
+			retval = for_each_note(t, 0, list_each_note, NULL);
+			goto end;
+		}
 	}
 
 	/* show command */
 
 	if ((list || show) && !note) {
 		error("No note found for object %s.", sha1_to_hex(object));
-		return 1;
+		retval = 1;
+		goto end;
 	} else if (show) {
 		const char *show_args[3] = {"show", sha1_to_hex(note), NULL};
-		return execv_git_cmd(show_args);
+		retval = execv_git_cmd(show_args);
+		goto end;
 	}
 
 	/* add/append/edit/remove/prune command */
 
 	if (add && note) {
-		if (force)
-			fprintf(stderr, "Overwriting existing notes for object %s\n",
-				sha1_to_hex(object));
-		else {
-			error("Cannot add notes. Found existing notes for object %s. "
-			      "Use '-f' to overwrite existing notes",
+		if (!force) {
+			error("Cannot add notes. Found existing notes for object"
+			      " %s. Use '-f' to overwrite existing notes",
 			      sha1_to_hex(object));
-			return 1;
+			retval = 1;
+			goto end;
 		}
+		fprintf(stderr, "Overwriting existing notes for object %s\n",
+			sha1_to_hex(object));
 	}
 
 	if (remove) {
@@ -408,18 +415,22 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	if (prune) {
 		hashclr(new_note);
 		prune_notes(t);
-	} else {
+		goto commit;
+	} else
 		create_note(object, &msg, append, note, new_note);
-		if (is_null_sha1(new_note))
-			remove_note(t, object);
-		else
-			add_note(t, object, new_note, combine_notes_overwrite);
-	}
-	snprintf(logmsg, sizeof(logmsg), "Note %s by 'git notes %s'",
+
+	if (is_null_sha1(new_note))
+		remove_note(t, object);
+	else
+		add_note(t, object, new_note, combine_notes_overwrite);
+
+commit:
+	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
 		 is_null_sha1(new_note) ? "removed" : "added", argv[0]);
 	commit_notes(t, logmsg);
 
+end:
 	free_notes(t);
 	strbuf_release(&(msg.buf));
-	return 0;
+	return retval;
 }
-- 
1.7.0.rc1.141.gd3fd
