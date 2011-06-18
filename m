From: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 3/6] Include name of notes ref in template when creating/editing notes.
Date: Sat, 18 Jun 2011 23:06:45 +0200
Message-ID: <1308431208-13353-4-git-send-email-ydirson@free.fr>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
Cc: Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 23:07:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY2jt-0007jg-SD
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 23:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab1FRVHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 17:07:19 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:42500 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab1FRVHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 17:07:07 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 84D52D48114;
	Sat, 18 Jun 2011 23:07:01 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.76)
	(envelope-from <ydirson@free.fr>)
	id 1QY2jF-0003V4-Kj; Sat, 18 Jun 2011 23:06:53 +0200
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1308431208-13353-1-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175985>

This will still show for the default "commits" notes:

 # Write/edit notes for the following object:

For other notes refs it will show:

 # Write/edit "foo" notes for the following object:

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 builtin/notes.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index bd342ac..ae89d38 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -91,7 +91,7 @@ static const char * const git_notes_get_ref_usage[] = {
 static const char note_template[] =
 	"\n"
 	"#\n"
-	"# Write/edit the notes for the following object:\n"
+	"# Write/edit %s%s%snotes for the following object:\n"
 	"#\n";
 
 struct msg_arg {
@@ -167,6 +167,7 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 
 	if (msg->use_editor || !msg->given) {
 		FILE *fp;
+		const char *ref = notes_ref_shortname(default_notes_tree.ref);
 
 		/* write the template message before editing: */
 		path = git_pathdup("NOTES_EDITMSG");
@@ -178,7 +179,10 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 			fwrite(msg->buf.buf, 1, msg->buf.len, fp);
 		else if (prev && !append_only)
 			write_note_data(fp, prev);
-		fwrite(note_template, 1, strlen(note_template), fp);
+		if (!ref)
+			fprintf(fp, note_template, "", "", "");
+		else
+			fprintf(fp, note_template, "\"", ref, "\" ");
 
 		write_commented_object(fp, object);
 
-- 
1.7.5.3
