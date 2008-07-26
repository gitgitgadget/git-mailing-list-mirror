From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/7] builtin-help: make list_commands() a bit more generic
Date: Sat, 26 Jul 2008 23:40:25 +0200
Message-ID: <3db8fbf82ab865b9dab5899f9a7e867ef005ecb6.1217108282.git.vmiklos@frugalware.org>
References: <cover.1217108282.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Sat Jul 26 23:41:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMrVc-0002VK-B8
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 23:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757880AbYGZVj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757746AbYGZVj7
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 17:39:59 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:39752 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109AbYGZVj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 17:39:59 -0400
Received: from vmobile.example.net (dsl5401C493.pool.t-online.hu [84.1.196.147])
	by yugo.frugalware.org (Postfix) with ESMTP id EAD7A1DDC5B;
	Sat, 26 Jul 2008 23:39:56 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id AF1C51AA738; Sat, 26 Jul 2008 23:40:25 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <Pine.GSO.4.62.0807261319310.16184@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90286>

That function now takes two paramters to control the prefix of the
listed commands, and a second parameter to specify the title of the
table. This can be useful for listing not only all git commands, but
specific ones, like merge strategies.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Jul 26, 2008 at 01:28:39PM -0500, Jonathan Nieder <jrnieder@uchicago.edu> wrote:
> >     if (main_cmds.cnt) {
> > -           printf("available git commands in '%s'\n", exec_path);
> > +           printf("available %s in '%s'\n", title, exec_path);
> >             printf("----------------------------");
> >             mput_char('-', strlen(exec_path));
> >             putchar('\n');
>
> Should this be
>
>       printf("available %s in '%s'\n", title, exec_path);
>       printf("----------------");
>       mput_char('-', strlen(exec_path) + strlen(title));
>       putchar('\n');
>
> ?
>
> (same question goes for the if(other_cmds.cnt) block, too)

Right. Here is an updated patch.

Also available at git://repo.or.cz/git/vmiklos.git, branch 'merge-custom'.

 help.c |   18 ++++++++++--------
 help.h |    1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/help.c b/help.c
index d71937e..ec7999d 100644
--- a/help.c
+++ b/help.c
@@ -501,23 +501,25 @@ static unsigned int load_command_list(const char *prefix)
 	return longest;
 }
 
-static void list_commands(void)
+void list_commands(const char *prefix, const char *title)
 {
-	unsigned int longest = load_command_list(NULL);
+	unsigned int longest = load_command_list(prefix);
 	const char *exec_path = git_exec_path();
 
 	if (main_cmds.cnt) {
-		printf("available git commands in '%s'\n", exec_path);
-		printf("----------------------------");
-		mput_char('-', strlen(exec_path));
+		printf("available %s in '%s'\n", title, exec_path);
+		printf("----------------");
+		mput_char('-', strlen(title) + strlen(exec_path));
 		putchar('\n');
 		pretty_print_string_list(&main_cmds, longest);
 		putchar('\n');
 	}
 
 	if (other_cmds.cnt) {
-		printf("git commands available from elsewhere on your $PATH\n");
-		printf("---------------------------------------------------\n");
+		printf("%s available from elsewhere on your $PATH\n", title);
+		printf("---------------------------------------");
+		mput_char('-', strlen(title));
+		putchar('\n');
 		pretty_print_string_list(&other_cmds, longest);
 		putchar('\n');
 	}
@@ -697,7 +699,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
-		list_commands();
+		list_commands("git-", "git commands");
 		printf("%s\n", git_more_info_string);
 		return 0;
 	}
diff --git a/help.h b/help.h
index 73da8d6..0741662 100644
--- a/help.h
+++ b/help.h
@@ -2,5 +2,6 @@
 #define HELP_H
 
 int is_git_command(const char *s, const char *prefix);
+void list_commands(const char *prefix, const char *title);
 
 #endif /* HELP_H */
-- 
1.6.0.rc0.14.g95f8.dirty
