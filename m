From: Junio C Hamano <gitster@pobox.com>
Subject: Re: msysgit, help: teach git help to open html from /doc/git/html/
Date: Sat, 11 Aug 2007 14:43:52 -0700
Message-ID: <7vps1tlpbb.fsf@assigned-by-dhcp.cox.net>
References: <51772B53-642F-4D52-9CF3-906A21FC0D6F@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Aug 11 23:44:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJyka-0008Lb-2a
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 23:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761369AbXHKVnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759861AbXHKVnz
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 17:43:55 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43707 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759579AbXHKVny (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 17:43:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811214354.IULA7956.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 17:43:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aljt1X00A1kojtg0000000; Sat, 11 Aug 2007 17:43:53 -0400
In-Reply-To: <51772B53-642F-4D52-9CF3-906A21FC0D6F@zib.de> (Steffen Prohaska's
	message of "Sat, 11 Aug 2007 22:44:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55635>

Steffen Prohaska <prohaska@zib.de> writes:

> Junio,
> are you interested in such patches at this time. The patch doesn't
> interfere with the existing code, but clutters it with ifdefs.

Actually "showing HTML pages upon 'git help' request" makes
sense even on Unixen.  I think a patch to help.c::cmd_help()
that allows the user to specify alternate action before going to
the codepath to call show_man_page(help_cmd) would make sense,
like the attached patch.

Having said that, a patch that makes the build procedure depend
on the presense of the html branch is unacceptable, as that
branch does not even exist in my private build repository.  If
you are building html pages from the source, it surely would
make sense.

---
 cache.h       |    3 +++
 config.c      |    5 +++++
 environment.c |    1 +
 help.c        |    3 ++-
 4 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 4507404..d7aeaaf 100644
--- a/cache.h
+++ b/cache.h
@@ -597,4 +597,7 @@ extern void *convert_sha1_file(const char *path, const unsigned char *sha1, unsi
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
 
+/* help.c - show manual page for the named command */
+extern char *custom_help_cmd;
+
 #endif /* CACHE_H */
diff --git a/config.c b/config.c
index dc3148d..8a9d0b7 100644
--- a/config.c
+++ b/config.c
@@ -431,6 +431,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.helpcmd")) {
+		custom_help_cmd = xstrdup(value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index b5a6c69..05c4ba5 100644
--- a/environment.c
+++ b/environment.c
@@ -34,6 +34,7 @@ char *pager_program;
 int pager_in_use;
 int pager_use_color = 1;
 char *editor_program;
+char *custom_help_cmd;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
diff --git a/help.c b/help.c
index 1cd33ec..49db50d 100644
--- a/help.c
+++ b/help.c
@@ -168,6 +168,7 @@ static void list_common_cmds_help(void)
 static void show_man_page(const char *git_cmd)
 {
 	const char *page;
+	const char *help = custom_help_cmd ? custom_help_cmd : "man";
 
 	if (!prefixcmp(git_cmd, "git"))
 		page = git_cmd;
@@ -180,7 +181,7 @@ static void show_man_page(const char *git_cmd)
 		page = p;
 	}
 
-	execlp("man", "man", page, NULL);
+	execlp(help, help, page, NULL);
 }
 
 void help_unknown_cmd(const char *cmd)
