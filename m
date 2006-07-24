From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Allow an alias to start with "-p"
Date: Mon, 24 Jul 2006 14:10:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607241408170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607190125150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xmjh5sv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 14:10:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4zGs-00038j-QY
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 14:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWGXMKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 08:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWGXMKr
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 08:10:47 -0400
Received: from mail.gmx.net ([213.165.64.21]:2974 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932126AbWGXMKr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jul 2006 08:10:47 -0400
Received: (qmail invoked by alias); 24 Jul 2006 12:10:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 24 Jul 2006 14:10:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xmjh5sv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24141>

    
Now, something like

	[alias]
		pd = -p diff

works as expected.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

On Sun, 23 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now, something like
> >
> > 	[alias]
> > 		pd = -p diff
> >
> > works as expected.
> 
> I like what it wants to do but I am afraid this leads to an
> unmaintainable code (a micronit that already shows what I mean
> is that you can say "git --paginate diff", but you cannot say
> "pd = --paginate diff" in the configuration file).
> 
> Is there a cleaner way to do it without duplicating the argument
> loop of git.c::main()?

This patch uses a better approach: instead of duplicating the option
parsing of the git wrapper, it refactors the code into the new function
handle_options().

In related news, this function would be the perfect candidate to set 
GIT_DIR without environment variables...

 git.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index ee5a0e8..8d7c644 100644
--- a/git.c
+++ b/git.c
@@ -35,6 +35,27 @@ static void prepend_to_path(const char *
 	setenv("PATH", path, 1);
 }
 
+static int handle_options(const char*** argv, int* argc)
+{
+	int handled = 0;
+
+	while (*argc > 0) {
+		const char *cmd = (*argv)[0];
+		if (cmd[0] != '-')
+			break;
+
+		if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
+			setup_pager();
+		} else
+			die ("Unknown option: %s", cmd);
+
+		(*argv)++;
+		(*argc)--;
+		handled++;
+	}
+	return handled;
+}
+
 static const char *alias_command;
 static char *alias_string = NULL;
 
@@ -106,7 +127,7 @@ static int handle_alias(int *argcp, cons
 
 	subdir = setup_git_directory_gently(&nongit);
 	if (!nongit) {
-		int count;
+		int count, option_count;
 		const char** new_argv;
 
 		alias_command = (*argv)[0];
@@ -114,6 +135,10 @@ static int handle_alias(int *argcp, cons
 		if (alias_string) {
 
 			count = split_cmdline(alias_string, &new_argv);
+			option_count = handle_options(&new_argv, &count);
+			memmove(new_argv - option_count, new_argv,
+					count * sizeof(char *));
+			new_argv -= option_count;
 
 			if (count < 1)
 				die("empty alias for %s", alias_command);
@@ -264,6 +289,7 @@ int main(int argc, const char **argv, ch
 	if (!strncmp(cmd, "git-", 4)) {
 		cmd += 4;
 		argv[0] = cmd;
+		handle_alias(&argc, &argv);
 		handle_internal_command(argc, argv, envp);
 		die("cannot handle %s internally", cmd);
 	}
@@ -273,13 +299,12 @@ int main(int argc, const char **argv, ch
 
 	/* Look for flags.. */
 	while (argc > 1) {
-		cmd = *++argv;
+		argv++;
 		argc--;
 
-		if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
-			setup_pager();
-			continue;
-		}
+		handle_options(&argv, &argc);
+			
+		cmd = *argv;
 
 		if (strncmp(cmd, "--", 2))
 			break;
