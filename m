From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Fri, 27 Jun 2008 12:05:39 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806271149580.19665@iabervon.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:07:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGT9-0005rO-77
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbYF0QFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756936AbYF0QFl
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:05:41 -0400
Received: from iabervon.org ([66.92.72.58]:47568 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756430AbYF0QFl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:05:41 -0400
Received: (qmail 7163 invoked by uid 1000); 27 Jun 2008 16:05:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jun 2008 16:05:39 -0000
In-Reply-To: <alpine.DEB.1.00.0806271353350.9925@racer>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86576>

On Fri, 27 Jun 2008, Johannes Schindelin wrote:

> After initializing the config in the newly-created repository, we
> need to unset GIT_CONFIG so that the global configs are read again.

This seems fine to me. OTOH, I'm not sure the environment variable should 
be needed in the first place; I think the config stuff should look in 
git_path("config") without it, and we set the git dir to the one we're 
initializing. So I think the use of the environment variable is just an 
artifact of how the shell script did it and how I was originally calling 
the init_db stuff.

Just removing the "setenv()" line survives all of the tests for me, and I 
remember some of them failing before I'd gotten some sort of solution for 
the config stuff.

> Noticed by Pieter de Bie.

You'd think I would have noticed this, since I mainly decided to convert 
clone to C so that url.insteadOf in global config would let you do "git 
clone work:modulename", but I clearly never tested it.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	On Fri, 27 Jun 2008, Pieter de Bie wrote:
> 
> 	> I sometimes use url.insteadOf to create a shortcut to a central 
> 	> repository. For example, having something like[*1*]
> 	> 
> 	> [url "git://repo.or.cz/git/"]
> 	> 	insteadOf = "repo:"
> 	> 
> 	> in my global gitconfig allows me to do a 'git fetch 
> 	> repo:dscho.git'. I'd also like to use that with git clone :).
> 	> Currently if I try that, I get
> 	> 
> 	> Vienna:~ pieter$ git clone repo:dscho.git
> 	> Initialize dscho/.git
> 	> Initialized empty Git repository in /Users/pieter/dscho/.git/
> 	> ssh: Error resolving hostname repo: nodename nor servname provided,
> 	>	or not known
> 	> fatal: The remote end hung up unexpectedly
> 	> 
> 	> [...]
> 	>
> 	> Is there an easy fix for this?
> 
> 	Yes ;-)
> 
>  builtin-clone.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 17baa20..965b5fc 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -424,6 +424,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	fprintf(stderr, "Initialize %s\n", git_dir);
>  	init_db(option_template, option_quiet ? INIT_DB_QUIET : 0);
>  
> +	/*
> +	 * At this point, the config exists, so we do not need the
> +	 * environment variable.  We actually need to unset it, too, to
> +	 * re-enable parsing of the global configs.
> +	 */
> +	unsetenv(CONFIG_ENVIRONMENT);
> +
>  	if (option_reference)
>  		setup_reference(git_dir);
>  
> -- 
> 1.5.6.173.gde14c
> 
> 
