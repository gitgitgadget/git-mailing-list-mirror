From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] launch_editor(): allow spaces in the filename
Date: Mon, 10 Mar 2008 21:42:47 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803102140280.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Zeng.Shixin@gmail.com, theevancarroll@gmail.com,
	git@vger.kernel.org, gitster@poxbox.com
X-From: git-owner@vger.kernel.org Mon Mar 10 21:43:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYoqO-0003tc-TS
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 21:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbYCJUmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 16:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbYCJUmn
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 16:42:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:40666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750929AbYCJUmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 16:42:43 -0400
Received: (qmail invoked by alias); 10 Mar 2008 20:42:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 10 Mar 2008 21:42:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19F0TBS1BJFmX/ZsVhjuDWIO4dTf3+4/YtvsQZV2z
	QPboc/cB3x7eVO
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76754>


For some reason, the construct

	sh -c "$0 \"$@\"" <editor> <file>

does not pick up quotes in <editor> as expected.  So replace $0 with
<editor>.

This fixes

	git config core.editor "c:/Program Files/What/Ever.exe"

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Incidentally, this fixes issue 78 in msysGit.

	Zeng (is this the correct way to address you?), Evan, please test.

 builtin-tag.c     |    6 +++++-
 t/t7005-editor.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 28c36fd..8dd959f 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -50,12 +50,15 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 		size_t len = strlen(editor);
 		int i = 0;
 		const char *args[6];
+		struct strbuf arg0;
 
+		strbuf_init(&arg0, 0);
 		if (strcspn(editor, "$ \t'") != len) {
 			/* there are specials */
+			strbuf_addf(&arg0, "%s \"$@\"", editor);
 			args[i++] = "sh";
 			args[i++] = "-c";
-			args[i++] = "$0 \"$@\"";
+			args[i++] = arg0.buf;
 		}
 		args[i++] = editor;
 		args[i++] = path;
@@ -63,6 +66,7 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 
 		if (run_command_v_opt_cd_env(args, 0, NULL, env))
 			die("There was a problem with the editor %s.", editor);
+		strbuf_release(&arg0);
 	}
 
 	if (!buffer)
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index c1cec55..5395b74 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -89,6 +89,34 @@ do
 	'
 done
 
+test_expect_success 'editor with a space' '
+
+	if echo "echo space > \"\$1\"" > "e space.sh"
+	then
+		chmod a+x "e space.sh" &&
+		GIT_EDITOR="./e\ space.sh" \
+			git --exec-path=. commit --amend &&
+		test space = "$(git show -s --pretty=format:%s)"
+	else
+		say "Skipping; FS does not support spaces in filenames"
+	fi
+
+'
+
+unset GIT_EDITOR
+test_expect_success 'core.editor with a space' '
+
+	if test -f "e space.sh"
+	then
+		git config core.editor \"./e\ space.sh\" &&
+		git --exec-path=. commit --amend &&
+		test space = "$(git show -s --pretty=format:%s)"
+	else
+		say "Skipping; FS does not support spaces in filenames"
+	fi
+
+'
+
 TERM="$OLD_TERM"
 
 test_done
-- 
1.5.4.4.643.g7cb9b.dirty
