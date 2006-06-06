From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git_setup_directory_gently when GIT_DIR is set
Date: Mon, 05 Jun 2006 18:06:07 -0700
Message-ID: <7vmzcr14ao.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606051943540.29608@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vodx74ca9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606060053440.25344@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk67v2o85.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606060117180.25685@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyij2mo8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 03:06:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnQ1R-0006LY-Ns
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 03:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWFFBGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 21:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWFFBGK
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 21:06:10 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:33453 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750891AbWFFBGI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 21:06:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606010608.DFRR19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 21:06:08 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vfyij2mo8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 05 Jun 2006 16:43:51 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21360>

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> Hmph.  Would it be a bug in clone that does not create GIT_DIR
>>> then?
>>
>> I don't think so. The whole point in calling git-init-db is to create 
>> that. GIT_DIR is set so that the otherwise nice work-in-a-subdirectory 
>> does not kick in. Imagine for example:
>>
>> 	git-clone ./. victim
>>
>> (taken straight out of t5400). If GIT_DIR was not set, git-init-db (which 
>> reads repositoryformat from the config if that exists, right?) would find 
>> .git/ in git/t/trash, and _not_ create git/t/trash/victim/.git/.
>
> I know clone currently relies on init-db to create the directory if
> it does not exist (I wrote the code after all).

Ah, I think I see the real problem is.  Alias handling is done
too early, and for commands like init-db that does _not_ even
want to look at an existing repository it tries to use GIT_DIR.

So how about this patch instead on top of yours?

-- >8 --
git alias: try alias last.

This disables alias "foo" from being used for git-foo, and when
we do use alias we check the built-in and then existing command
names first and then alias as the fallback.  This avoids the
problem of common commands used in scripts getting clobbered by
user specific aliases.

---
diff --git a/git.c b/git.c
index 8854472..6db8f2b 100644
--- a/git.c
+++ b/git.c
@@ -202,6 +202,7 @@ int main(int argc, const char **argv, ch
 	char *slash = strrchr(cmd, '/');
 	char git_command[PATH_MAX + 1];
 	const char *exec_path = NULL;
+	int done_alias = 0;
 
 	/*
 	 * Take the basename of argv[0] as the command
@@ -229,7 +230,6 @@ int main(int argc, const char **argv, ch
 	if (!strncmp(cmd, "git-", 4)) {
 		cmd += 4;
 		argv[0] = cmd;
-		handle_alias(&argc, &argv);
 		handle_internal_command(argc, argv, envp);
 		die("cannot handle %s internally", cmd);
 	}
@@ -287,13 +287,21 @@ int main(int argc, const char **argv, ch
 	exec_path = git_exec_path();
 	prepend_to_path(exec_path, strlen(exec_path));
 
-	handle_alias(&argc, &argv);
+	while (1) {
+		/* See if it's an internal command */
+		handle_internal_command(argc, argv, envp);
 
-	/* See if it's an internal command */
-	handle_internal_command(argc, argv, envp);
+		/* .. then try the external ones */
+		execv_git_cmd(argv);
 
-	/* .. then try the external ones */
-	execv_git_cmd(argv);
+		/* It could be an alias -- this works around the insanity
+		 * of overriding "git log" with "git show" by having
+		 * alias.log = show
+		 */
+		if (done_alias || !handle_alias(&argc, &argv))
+			break;
+		done_alias = 1;
+	}
 
 	if (errno == ENOENT)
 		cmd_usage(0, exec_path, "'%s' is not a git-command", cmd);
