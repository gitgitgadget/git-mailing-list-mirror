From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 20:39:34 -0500
Message-ID: <20091031013934.GD5160@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:29:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N42mw-0005Cw-Qu
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 02:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584AbZJaB3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 21:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757563AbZJaB3O
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 21:29:14 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:48639 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257AbZJaB3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 21:29:14 -0400
Received: by ywh40 with SMTP id 40so3211473ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 18:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=V+I0ojQIApKkxKO9OsDChybCdmxBln+9U6O8I4X+QcQ=;
        b=OGpj/b0QEmFylGPlr10LsCn0AyCLBQNeMfFfm0FbOkwR0s2WIm78Hu0QgAWH99dN7r
         7Ofq0tsGj5aKPh85LjPm3FHZ1IWqyaQkeZ+ifCyGUCcsU6sbV4vV3iZkaLBZx6b6F9Tu
         Xb3b9X9M7duYue9AizHfu9wxpE69AOV+MtxIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yC//8LiOWQ12/8/o4skT0TXrH7V6tICAbux7izZwSPLzlVJRzsp5J0bkDOnAa6JO9O
         qoaw5iP0oKqWnuT7QZ9C/p+rUBb3dWo3TrOWjycMQZJbkcf8xaqRe5COYuPofomDzVOF
         i2m3VT9u0JmiGwlJeaTEiCRw0pLk8PdZXj5No=
Received: by 10.150.24.14 with SMTP id 14mr4209319ybx.256.1256952558616;
        Fri, 30 Oct 2009 18:29:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm409907gxk.3.2009.10.30.18.29.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 18:29:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031012050.GA5160@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131816>

From: Johannes Sixt <j6t@kdbg.org>

Expose the command used by launch_editor() for scripts to use.
This should allow one to avoid searching for a proper editor
separately in each command.

If no satisfactory GIT_EDITOR could be chosen, let "git var -l"
output a warning.  This warning goes to stderr so as not to
confuse scripts.  Example:

	core.logallrefupdates=true

	*** Please tell me who you are.

	Run

	  git config --global user.email "you@example.com"
	  git config --global user.name "Your Name"

	to set your account's default identity.
	Omit --global to set the identity only in this repository.

	GIT_COMMITTER_IDENT=user <user@domain> 1256952739 -0500
	GIT_AUTHOR_IDENT=user <user@domain> 1256952739 -0500
	warning: GIT_EDITOR: terminal is dumb, but EDITOR unset

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---

 Documentation/git-var.txt |    8 ++++++++
 cache.h                   |    1 +
 editor.c                  |   14 ++++++++++++--
 var.c                     |   21 ++++++++++++++++++++-
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index e2f4c09..89e4b4f 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -36,6 +36,14 @@ GIT_AUTHOR_IDENT::
 GIT_COMMITTER_IDENT::
     The person who put a piece of code into git.
 
+GIT_EDITOR::
+    Text editor for use by git commands.  The value is meant to be
+    interpreted by the shell when it is used.  Examples: `~/bin/vi`,
+    `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
+    --nofork`.  The order of preference is the `$GIT_EDITOR`
+    environment variable, then `core.editor` configuration, then
+    `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
+
 Diagnostics
 -----------
 You don't exist. Go away!::
diff --git a/cache.h b/cache.h
index 96840c7..311cfe1 100644
--- a/cache.h
+++ b/cache.h
@@ -750,6 +750,7 @@ extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
+extern const char *git_editor(void);
 
 struct checkout {
 	const char *base_dir;
diff --git a/editor.c b/editor.c
index 3f13751..4f98b72 100644
--- a/editor.c
+++ b/editor.c
@@ -2,7 +2,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 
-int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+const char *git_editor(void)
 {
 	const char *editor = getenv("GIT_EDITOR");
 	const char *terminal = getenv("TERM");
@@ -16,11 +16,21 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		editor = getenv("EDITOR");
 
 	if (!editor && terminal_is_dumb)
-		return error("terminal is dumb, but EDITOR unset");
+		return NULL;
 
 	if (!editor)
 		editor = "vi";
 
+	return editor;
+}
+
+int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+{
+	const char *editor = git_editor();
+
+	if (!editor)
+		return error("terminal is dumb, but EDITOR unset");
+
 	if (strcmp(editor, ":")) {
 		size_t len = strlen(editor);
 		int i = 0;
diff --git a/var.c b/var.c
index 125c0d1..399f409 100644
--- a/var.c
+++ b/var.c
@@ -8,6 +8,21 @@
 
 static const char var_usage[] = "git var [-l | <variable>]";
 
+static const char *editor(int flag)
+{
+	const char *pgm = git_editor();
+
+	if (!pgm) {
+		if (flag & IDENT_ERROR_ON_NO_NAME)
+			die("terminal is dumb, but EDITOR unset");
+		if (flag & IDENT_WARN_ON_NO_NAME)
+			warning("GIT_EDITOR: terminal is dumb, "
+				"but EDITOR unset");
+	}
+
+	return pgm;
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -15,14 +30,18 @@ struct git_var {
 static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
+	{ "GIT_EDITOR", editor },
 	{ "", NULL },
 };
 
 static void list_vars(void)
 {
 	struct git_var *ptr;
+	const char *val;
+
 	for (ptr = git_vars; ptr->read; ptr++)
-		printf("%s=%s\n", ptr->name, ptr->read(IDENT_WARN_ON_NO_NAME));
+		if ((val = ptr->read(IDENT_WARN_ON_NO_NAME)))
+			printf("%s=%s\n", ptr->name, val);
 }
 
 static const char *read_var(const char *var)
-- 
1.6.5.2
