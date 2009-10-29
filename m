From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC 2/2] Provide a build time default-editor setting
Date: Thu, 29 Oct 2009 12:50:13 +0100
Message-ID: <4AE98175.504@viscovery.net>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>	 <7vskd3o11t.fsf@alter.siamese.dyndns.org>	 <20091029073224.GA15403@progeny.tock>	 <20091029075021.GC15403@progeny.tock> <117f2cc80910290336k1e7b5877uc472ad511bb6f5ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: David Roundy <roundyd@physics.oregonstate.edu>
X-From: git-owner@vger.kernel.org Thu Oct 29 12:50:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3TWV-0006Cv-Du
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 12:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbZJ2LuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 07:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbZJ2LuP
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 07:50:15 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7446 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbZJ2LuO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 07:50:14 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N3TW9-0003O7-Sz; Thu, 29 Oct 2009 12:50:14 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 901244E4; Thu, 29 Oct 2009 12:50:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <117f2cc80910290336k1e7b5877uc472ad511bb6f5ae@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131584>

David Roundy schrieb:
> Any chance this will be exported as plumbing? I know it's pretty
> high-level, but it'd be handy to have be able to write `git editor
> $FILENAME` and just have it do the right thing.  This would also mean
> that the perl scripts below could be simplified.

Something like below? Possible usage in shell scripts:

	editor=$(git var GIT_EDITOR)
	"$editor" "$filename"

-- Hannes

PS: warning: linewrapped.

Subject: [PATCH] Teach git var about GIT_EDITOR

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 cache.h  |    1 +
 editor.c |   13 +++++++++++--
 var.c    |    6 ++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index a5eeead..3103dda 100644
--- a/cache.h
+++ b/cache.h
@@ -750,6 +750,7 @@ extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const
char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
+extern const char *git_editor();

 struct checkout {
 	const char *base_dir;
diff --git a/editor.c b/editor.c
index 4d469d0..bd8c828 100644
--- a/editor.c
+++ b/editor.c
@@ -2,7 +2,7 @@
 #include "strbuf.h"
 #include "run-command.h"

-int launch_editor(const char *path, struct strbuf *buffer, const char
*const *env)
+const char *git_editor()
 {
 	const char *editor, *terminal;

@@ -16,11 +16,20 @@ int launch_editor(const char *path, struct strbuf
 	terminal = getenv("TERM");
 	if (!editor && (!terminal || !strcmp(terminal, "dumb")))
-		return error("Terminal is dumb but no VISUAL nor EDITOR defined.");
+		return "/dev/null";

 	if (!editor)
 		editor = "vi";

+	return editor;
+}
+
+int launch_editor(const char *path, struct strbuf *buffer, const char
*const *env)
+{
+	const char *editor = git_editor();
+
+	if (!strcmp(editor, "/dev/null"))
+		return error("Terminal is dumb but no VISUAL nor EDITOR defined.");
 	if (strcmp(editor, ":")) {
 		size_t len = strlen(editor);
 		int i = 0;
diff --git a/var.c b/var.c
index 125c0d1..48d8b9a 100644
--- a/var.c
+++ b/var.c
@@ -8,6 +8,11 @@

 static const char var_usage[] = "git var [-l | <variable>]";

+static const char *editor(int unused)
+{
+	return git_editor();
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -15,6 +20,7 @@ struct git_var {
 static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
+	{ "GIT_EDITOR", editor },
 	{ "", NULL },
 };

-- 
1.6.5.rc2.47.g49402
