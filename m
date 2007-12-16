From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Allow commit (and tag) messages to be edited when $EDITOR has arguments
Date: Sat, 15 Dec 2007 17:12:01 -0800
Message-ID: <20071216011201.GA10867@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 02:12:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3i3T-0007YQ-KP
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 02:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493AbXLPBMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 20:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756483AbXLPBME
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 20:12:04 -0500
Received: from tater.midwinter.com ([216.32.86.90]:47056 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756002AbXLPBMB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 20:12:01 -0500
Received: (qmail 10969 invoked by uid 1001); 16 Dec 2007 01:12:01 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68423>

Users who do EDITOR="/usr/bin/emacs -nw" or similar were left unable to
edit commit messages once commit became a builtin, because the editor
launch code assumed that $EDITOR was a single pathname.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

	Looked around but didn't see an existing "build a char* array
	out of a delimited string" function in the git source; if one
	exists, of course it should be used instead of my pair of loops
	here.

 builtin-tag.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 274901a..dace758 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -47,10 +47,35 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 		editor = "vi";
 
 	if (strcmp(editor, ":")) {
-		const char *args[] = { editor, path, NULL };
+		char *editor_copy, *c;
+		int args_size = 3, args_pos = 0;
+		char **args;
+
+		/* Parse the editor command, since it can contain arguments.
+		 * First count the number of arguments so we can allocate an
+		 * appropriately-sized arg array.
+		 */
+		editor_copy = xstrdup(editor);
+		for (c = editor_copy; *c != '\0'; c++) {
+			if (*c == ' ') {
+				args_size++;
+			}
+		}
+
+		args = xmalloc(sizeof(char *) * args_size);
+		for (c = strtok(editor_copy, " "); c != NULL;
+		     c = strtok(NULL, " ")) {
+			args[args_pos++] = c;
+		}
+
+		args[args_pos++] = path;
+		args[args_pos++] = NULL;
 
 		if (run_command_v_opt_cd_env(args, 0, NULL, env))
 			die("There was a problem with the editor %s.", editor);
+
+		free(args);
+		free(editor_copy);
 	}
 
 	if (!buffer)
-- 
1.5.4.rc0
