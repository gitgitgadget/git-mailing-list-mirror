From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Wed, 15 Mar 2006 22:37:09 -0800
Message-ID: <7voe06dhey.fsf@assigned-by-dhcp.cox.net>
References: <20060314211022.GA12498@localhost.localdomain>
	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	<20060314224027.GB14733@localhost.localdomain>
	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
	<7vek13ieap.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Qingning Huo <qhuo@mayhq.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 07:37:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJm6q-0004xR-UH
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 07:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWCPGhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 01:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbWCPGhO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 01:37:14 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:24201 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751637AbWCPGhM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 01:37:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060316063335.BCJX17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Mar 2006 01:33:35 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 15 Mar 2006 14:51:30 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17627>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 15 Mar 2006, Junio C Hamano wrote:
>> 
>> If we do the dash-form for consistency's sake, we should do
>> PATH="`git --exec-path`:$PATH" in git-setup-sh when/before we do
>> so.
>
> Yes. That would make sense too. Then git-setup-sh would look more like 
> what the builtin git.c does.

I actually think what git.c does is _wrong_.

Believe it or not, there are people with bizarre configurations
just like Qingning's is bizarre in different sense [*1*].  They
have diff they do not like (either broken or inadequete)
installed under /usr/bin, and they install GNU diff under
/home/$u/bin, and have their PATH set so that /home/$u/bin/diff
is found before /usr/bin/diff (up to here, there is nothing
bizarre).  However, somehow they have the latest "git" installed
under /usr/bin (this _is_ the bizarre part).

Earlier, we prepended GIT_EXEC_PATH to user-supplied PATH when
C-level routines needed to exec git programs.  This breaks that
"bizarre" setup -- for such a setup, GIT_EXEC_PATH is currently
set to /usr/bin and when we try to exec "diff", we ended up
running /usr/bin/diff.  So in order to work this around, we
introduced exec[vl]_git_cmd() wrappers which use --exec-path
(if the command supports per invocation override), GIT_EXEC_PATH
environment, and then gitexecdir in Makefile when it was built,
in this order.  "git" wrapper should know about this, but the
older code was never removed when we introduced exec_cmd.c.

I think we need to do something like the attached patch.

[Footnote]

*1* I first wrote "configuration even more bizarre than
Qingning's", but before sending the message out I came to
senses.  We have to admit that that configuration is quite
unusual, and I would say it is the one more bizarre than the one
in question here.  When people have standard system executable
directories such as /usr/bin and /bin and private directories
like /home/$u/bin and /usr/local/bin on their PATH, private
directories always come before the system directories, so that
things in the system directories (often you do not have write
permission to) can be overriden by private directories (which is
under your control).

-- >8 --

diff --git a/git.c b/git.c
index 0b40e30..25e6a4e 100644
--- a/git.c
+++ b/git.c
@@ -219,25 +219,6 @@ static void cmd_usage(int show_all, cons
 	exit(1);
 }
 
-static void prepend_to_path(const char *dir, int len)
-{
-	char *path, *old_path = getenv("PATH");
-	int path_len = len;
-
-	if (!old_path)
-		old_path = "/usr/local/bin:/usr/bin:/bin";
-
-	path_len = len + strlen(old_path) + 1;
-
-	path = malloc(path_len + 1);
-
-	memcpy(path, dir, len);
-	path[len] = ':';
-	memcpy(path + len + 1, old_path, path_len - len);
-
-	setenv("PATH", path, 1);
-}
-
 static void show_man_page(const char *git_cmd)
 {
 	const char *page;
@@ -447,18 +428,6 @@ int main(int argc, const char **argv, ch
 	}
 	argv[0] = cmd;
 
-	/*
-	 * We search for git commands in the following order:
-	 *  - git_exec_path()
-	 *  - the path of the "git" command if we could find it
-	 *    in $0
-	 *  - the regular PATH.
-	 */
-	if (exec_path)
-		prepend_to_path(exec_path, strlen(exec_path));
-	exec_path = git_exec_path();
-	prepend_to_path(exec_path, strlen(exec_path));
-
 	/* See if it's an internal command */
 	handle_internal_command(argc, argv, envp);
 
