From: Junio C Hamano <junkio@cox.net>
Subject: Re: git /objects directory created 755 by default?
Date: Tue, 20 Dec 2005 17:37:06 -0800
Message-ID: <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	<7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 02:39:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eosuo-00083c-3c
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 02:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVLUBhK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 20:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVLUBhJ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 20:37:09 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:31900 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932234AbVLUBhI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 20:37:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221013709.RRYF25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Dec 2005 20:37:09 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 20 Dec 2005 15:43:56 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13858>

Junio C Hamano <junkio@cox.net> writes:

> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
>> Since git changed to creating the objects subdirectories "on demand",
>> these are created 755 regardless of the user's umask. This is quite
>> inconvenient in ("cvs style") team-shared repositories, which work
>> great otherwise.
>
> Hmph.
>
> I have 002 as umask. .git/objects or .git/objects/[0-9a-f]{2}
> directories are created 0775 for me.

Martin, is this happening when your developers push into the
shared repo?  If so, do your developers use git-shell?  Do their
umask set properly even when they come over ssh and gets into
noninteractive shell?  What do they see when they do this?

	$ ssh shared.repo.machine.example.com umask

the answer may wall be "What do you think I am, A shell?", or
0022.

The git-shell command is designed to be not git aware (it does
not know how a git repository looks like, nor does not know all
the commands it can handle right now happen to take the
repository directory as their first parameter).  If we do not
mind butchering things, we could introduce:

	[shell]
        	umask = 0002

to the configuration file, and do something like this (not even
compile tested, and I am not sure what else it breaks):

---
diff --git a/shell.c b/shell.c
index cd31618..33898f8 100644
--- a/shell.c
+++ b/shell.c
@@ -1,15 +1,34 @@
 #include "cache.h"
 #include "quote.h"
 
-static int do_generic_cmd(const char *me, char *arg)
+static int shell_umask = 0002; /* default */
+
+static int slurp_repository_umask(const char *var, const char *value)
+{
+	if (!strcmp(var, "shell.umask"))
+		shell_umask = git_config_int(value);
+	else
+		return git_default_config(var, value);
+	return 0;
+}
+
+/*
+ * These commands take arg == git repository directory.
+ */
+static int do_git_repo_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
 
 	if (!arg || !(arg = sq_dequote(arg)))
 		die("bad argument");
 
+	if (!enter_repo(arg, 0))
+		die("'%s': Nah -- not a git repository", arg);
+	git_config(slurp_repository_umask);
+	umask(shell_umask);
+
 	my_argv[0] = me;
-	my_argv[1] = arg;
+	my_argv[1] = ".";
 	my_argv[2] = NULL;
 
 	return execvp(me, (char**) my_argv);
@@ -19,8 +38,8 @@ static struct commands {
 	const char *name;
 	int (*exec)(const char *me, char *arg);
 } cmd_list[] = {
-	{ "git-receive-pack", do_generic_cmd },
-	{ "git-upload-pack", do_generic_cmd },
+	{ "git-receive-pack", do_git_repo_cmd },
+	{ "git-upload-pack", do_git_repo_cmd },
 	{ NULL },
 };
 
