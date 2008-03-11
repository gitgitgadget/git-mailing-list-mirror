From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] launch_editor(): allow spaces in the filename
Date: Tue, 11 Mar 2008 10:56:30 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111046220.3873@racer.site>
References: <alpine.LSU.1.00.0803102140280.3975@racer.site> <7v1w6ii0a1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Zeng.Shixin@gmail.com, theevancarroll@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:57:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ1EW-0004gF-Eu
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYCKJ42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbYCKJ42
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:56:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:39548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752065AbYCKJ41 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:56:27 -0400
Received: (qmail invoked by alias); 11 Mar 2008 09:56:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 11 Mar 2008 10:56:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19O5BUFfHpO+NnG//JbUDvzxneANnfIRvkhIyzvrA
	tNWGIjsHBol/qU
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1w6ii0a1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76826>


For some reason, the construct

	sh -c "$0 \"$@\"" <editor> <file>

does not pick up quotes in <editor> as expected.  So replace $0 with
<editor>.

This fixes

	git config core.editor '"c:/Program Files/What/Ever.exe"'

In other words, you can specify an editor with spaces in its path using a
config containing something like this:

	[core]
		editor = \"c:/Program Files/Darn/Spaces.exe\"

NOTE: we cannot just replace the $0 with \"$0\", because we still want 
this to work:

	[core]
		editor = emacs -nw

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 10 Mar 2008, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > For some reason, the construct
	> >
	> > 	sh -c "$0 \"$@\"" <editor> <file>
	> >
	> > does not pick up quotes in <editor> as expected.  So replace 
	> > $0 with <editor>.
	> >
	> > This fixes
	> >
	> > 	git config core.editor "c:/Program Files/What/Ever.exe"
	> 
	> Ah, I misread your patch.  The above example needs to be fixed 
	> as discussed, but what the patch does to builtin-tag.c is fine.

	Here comes the fixed commit message and...

	> > diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
	> > index c1cec55..5395b74 100755
	> > --- a/t/t7005-editor.sh
	> > +++ b/t/t7005-editor.sh
	> > @@ -89,6 +89,34 @@ do
	> >  	'
	> >  done
	> >  
	> > +test_expect_success 'editor with a space' '
	> > +
	> > +	if echo "echo space > \"\$1\"" > "e space.sh"
	> > +	then
	> > +		chmod a+x "e space.sh" &&
	> > +		GIT_EDITOR="./e\ space.sh" \
	> > +			git --exec-path=. commit --amend &&
	> 
	> Why do you need --exec-path=. to tell the newly built git to 
	> find its subcommands from t/trash directory, when you give an explicit 
	> instruction to find GIT_EDITOR in "./"?

	... the fixed tests.

	I copied this piece from the earlier tests.  Probably it is only 
	needed to avoid "vi" from being found in the PATH (--exec-path's argument 
	is prepended to the PATH).

 builtin-tag.c     |    6 +++++-
 t/t7005-editor.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletions(-)

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
index c1cec55..6a74b3a 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -89,6 +89,33 @@ do
 	'
 done
 
+test_expect_success 'editor with a space' '
+
+	if echo "echo space > \"\$1\"" > "e space.sh"
+	then
+		chmod a+x "e space.sh" &&
+		GIT_EDITOR="./e\ space.sh" git commit --amend &&
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
+		git commit --amend &&
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
