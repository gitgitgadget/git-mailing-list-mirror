From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/6] Add check_repo_format check for all major operations.
Date: Tue, 22 Nov 2005 00:29:29 -0800
Message-ID: <7vlkzhf5li.fsf@assigned-by-dhcp.cox.net>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
	<113261929333-git-send-email-matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 09:31:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeTX0-0007NP-6d
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 09:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVKVI3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 03:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVKVI3d
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 03:29:33 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:35068 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750873AbVKVI3d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 03:29:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122082858.NLDQ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 03:28:58 -0500
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <113261929333-git-send-email-matlads@dsmagic.com> (Martin
	Atukunda's message of "Tue, 22 Nov 2005 03:28:13 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12537>

Martin Atukunda <matlads@dsmagic.com> writes:

> The git-* command set uses 3 entry points in order to prepare
> to work with a git repo: enter_repo, get_git_dir, and obviously
> setup_git_directory.

Thanks, but I think this one is wrong.

> diff --git a/environment.c b/environment.c
> index 6a961ca..458eff8 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -37,6 +37,9 @@ static void setup_git_env(void)
>  	git_graft_file = getenv(GRAFT_ENVIRONMENT);
>  	if (!git_graft_file)
>  		git_graft_file = strdup(git_path("info/grafts"));
> +
> +	/* check the repo */
> +	check_repo_format();
>  }

> diff --git a/setup.c b/setup.c
> index 8597424..934f9a3 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -97,6 +97,9 @@ const char *setup_git_directory(void)
>  	static char cwd[PATH_MAX+1];
>  	int len, offset;
>  
> +	get_git_dir(1);
> +	check_repo_format();
> +
>  	/*
>  	 * If GIT_DIR is set explicitly, we're not going
>  	 * to do any discovery

In setup_git_env() you have only read GIT_DIR environment but
have not done the toplevel discovery.  Especially, this is
called from get_git_dir(), and you call that as the first thing
as setup_git_directory().  However, that function is supposed to
be callable by processes that are in a subdirectory, without
GIT_DIR explicitly specified, and the place get_git_dir() is
called in that function is way before the discovery of the
toplevel happens.  Until then, you do not know where your .git/
directory or .git/config file is. If you start in Documentation
subdirectory in git project, your setup_git_directory() would
first call get_git_dir(), which says "I assume the config file
is at ./.git/config -- oh there is no such thing".  At that
point you are checking Documentation/.git/config.  

It would happen to work because you intend to allow version 0
repository for any future version of tool, and even if this
codepath mistakenly thinks the repository is version 0, it does
not hurt, as long as your setup_git_directory() calls
check_repo_format again after doing the toplevel discovery and
checks the true .git/config file, but I do not think you have
that call in the current series yet.  Even if you had, this does
not feel quite right to me.
