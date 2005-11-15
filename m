From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] C implementation of the 'git' program, take two.
Date: Tue, 15 Nov 2005 15:45:37 -0800
Message-ID: <7vwtj9eaqm.fsf@assigned-by-dhcp.cox.net>
References: <20051115233125.3153B5BF76@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 00:47:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAUh-0008KJ-Ey
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVKOXpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVKOXpk
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:45:40 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:32471 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965083AbVKOXpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:45:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115234504.UZKB20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 18:45:04 -0500
To: exon@op5.se (Andreas Ericsson)
In-Reply-To: <20051115233125.3153B5BF76@nox.op5.se> (Andreas Ericsson's
	message of "Wed, 16 Nov 2005 00:31:25 +0100 (CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11971>

exon@op5.se (Andreas Ericsson) writes:

> This patch provides a C implementation of the 'git' program and
> introduces support for putting the git-* commands in a directory
> of their own.

Very nice, thanks.  Two questions and a half.

> +static void prepend_to_path(const char *dir, int len)
> +{
> +	char *path, *old_path = getenv("PATH");
> +	int path_len = len;
> +
> +	if (!old_path)
> +		old_path = "/bin:/usr/bin:.";

This is to cover strange case and probably would not matter in
practice, but perhaps without current directory?

> +int main(int argc, char **argv, char **envp)
> +{
> +	char git_command[PATH_MAX + 1];
> +	char wd[PATH_MAX + 1];
> +	int i, len, show_help = 0;
> +	char *exec_path = getenv("GIT_EXEC_PATH");
> +
> +	getcwd(wd, PATH_MAX);
> +...
> +	/* allow relative paths, but run with exact */
> +	if (chdir(exec_path)) {
> +		printf("git: '%s': %s\n", exec_path, strerror(errno));
> +		exit (1);
> +	}
> +
> +	getcwd(git_command, sizeof(git_command));
> +	chdir(wd);

Can we always come back from where we started?

> +
> +	len = strlen(git_command);
> +	prepend_to_path(git_command, len);
> +
> +	strncat(&git_command[len], "/git-", sizeof(git_command) - len);
> +	len += 5;
> +	strncat(&git_command[len], argv[i], sizeof(git_command) - len);
> +
> +	if (access(git_command, X_OK))
> +		usage(exec_path, "'%s' is not a git-command", argv[i]);
> +
> +	/* execve() can only ever return if it fails */
> +	execve(git_command, &argv[i], envp);

Shell version for Cygwin seems to do ".exe" at the end --- does
it matter?
