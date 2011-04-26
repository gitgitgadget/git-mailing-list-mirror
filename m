From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 2/2] format-patch: show notes as message after the ---
Date: Tue, 26 Apr 2011 10:54:29 +0200
Message-ID: <826def15eb7204ee30fc4c358f72103ec75b4e42.1303808057.git.git@drmicha.warpmail.net>
References: <cb2af8d1ef663a68ea96dbb916dcfa0aee71abcb.1303808057.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 10:54:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEe2a-000103-AN
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 10:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402Ab1DZIye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 04:54:34 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:60358 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752304Ab1DZIyd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 04:54:33 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 316702040A
	for <git@vger.kernel.org>; Tue, 26 Apr 2011 04:54:33 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 26 Apr 2011 04:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=CVylpMcg6sKMURcrEjZ968rg0sY=; b=c3PEVu6O3cDni8cPcSR/LJDm3Q3qaYConsT0VP62dnFHACEqJw7bEAb3LkPqLaIgUp/931KfvfF99DGReYiSLXKXfOnjQS/rgksCkLVcefSmrhW4LyTur9XrSmcOsNmSVg1n5B7CuzEehcioIF8CIbPIPXGLy1zF+TNHoZdye18=
X-Sasl-enc: 55C751Eo5NK5lUu+J1s2TMdIDDA7shta0yO7+FtrM+OM 1303808072
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B5474409FC;
	Tue, 26 Apr 2011 04:54:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.270.gafca7
In-Reply-To: <cb2af8d1ef663a68ea96dbb916dcfa0aee71abcb.1303808057.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172080>

When requesting notes with "--notes", "format-patch" produces notes
within the commit message which "am" misunderstands as being part of the
message.

Change this so that notes are displayed after an additional "---". Any
"am" (old or new) will ignore that, so that it is a safe place for
additional comments:

Log message
"---"
notes
"---"
diffstat
patch

(The first "---" appears only when there is a note, of course.)

Later on (say with "--format-notes") the output format can be changed
easily to accomodate a future "am" which knows how to create notes from
such patches.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Reducing the output format to one "---" only is not only complicated (the notes
separator is generated in a quite different place from the patch separator)
but also unnecessary (am reads the patch anyways) and not even preferable (to
give a clear separation of the parts).
---
 builtin/log.c |    4 +++-
 notes.c       |    2 ++
 notes.h       |    3 +++
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5e71caa..67aed94 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1159,8 +1159,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
 
-	if (rev.show_notes)
+	if (rev.show_notes) {
 		init_display_notes(&rev.notes_opt);
+		rev.show_notes = NOTES_DASH;
+	}
 
 	if (!use_stdout)
 		output_directory = set_outdir(prefix, output_directory);
diff --git a/notes.c b/notes.c
index a013c1b..b8b737e 100644
--- a/notes.c
+++ b/notes.c
@@ -1233,6 +1233,8 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (msglen && msg[msglen - 1] == '\n')
 		msglen--;
 
+	if (flags & NOTES_DASH)
+		strbuf_addstr(sb, "---\n");
 	if (flags & NOTES_SHOW_HEADER) {
 		const char *ref = t->ref;
 		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
diff --git a/notes.h b/notes.h
index 81d16e3..17150d5 100644
--- a/notes.h
+++ b/notes.h
@@ -238,6 +238,7 @@ void free_notes(struct notes_tree *t);
 /* Flags controlling how notes are formatted */
 #define NOTES_SHOW_HEADER 1
 #define NOTES_INDENT 2
+#define NOTES_DASH 4
 #define NOTES_DEFAULT (NOTES_SHOW_HEADER | NOTES_INDENT)
 
 /*
@@ -284,6 +285,8 @@ void init_display_notes(struct display_notes_opt *opt);
  *
  * - NOTES_INDENT: indent the notes by 4 places
  *
+ * - NOTES_DASH: prepend a "---" line
+ *
  * You *must* call init_display_notes() before using this function.
  */
 void format_display_notes(const unsigned char *object_sha1,
-- 
1.7.5.270.gafca7
