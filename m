From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow default core.logallrefupdates to be overridden with template's config
Date: Tue, 23 Jan 2007 17:34:04 -0800
Message-ID: <7v64axmcmr.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701230754p3425ded4k1f37dd26500c1744@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 02:34:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9X1k-0005nD-Gh
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097AbXAXBeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933100AbXAXBeI
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:34:08 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:50554 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933097AbXAXBeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:34:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124013404.KXGM29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Tue, 23 Jan 2007 20:34:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EpaN1W01N1kojtg0000000; Tue, 23 Jan 2007 20:34:23 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701230754p3425ded4k1f37dd26500c1744@mail.gmail.com>
	(Alex Riesen's message of "Tue, 23 Jan 2007 16:54:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37588>

> ---
>  builtin-init-db.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 8e7540b..1865489 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -257,7 +257,9 @@ static int create_default_files(const char *git_dir, const char *template_path)
>  	}
>  	else {
>  		git_config_set("core.bare", "false");
> -		git_config_set("core.logallrefupdates", "true");
> +		/* allow template config file to override the default */
> +		if (log_all_ref_updates == -1)
> +		    git_config_set("core.logallrefupdates", "true");
>  	}
>  	return reinit;
>  }

It is sensible to let the user say "I do not want steenking
reflogs" (or "I love reflogs and want one everywhere").  But I
think the above is not really doing that.

We seem to read ~/.gitconfig while running git-init-db, and I do
not think doing so necessarily is a bug.  After all, there may
be some configurations you would want to have in ~/.gitconfig to
control the way git-init-db operates (right now I do not think
there is any).

That makes your new check depend on what is in ~/.gitconfig when
core.logallrefupdates is not set (either true or false) in the
template config.

Forgetting the case of having the variable in ~/.gitconfig, what
does it mean to have core.logallrefupdates set in a template
config?  Setting it to true is obvious -- "I want reflogs
everywhere", and I think it happens with or without your patch,
because create_default_files() copies the template.

However, when set to false, your check says "Do not set it
per-repo".  This tells git to follow the default "use reflog in
non-bare repositories" and it does not mean "I do not want
steenking reflogs anywhere".  So I think at least you would need
to check for (log_all_ref_updates == 0) and set it explicitly to
"false".

While on the topic of config files, we should fix the config
reader not to allow per-repository variables in ~/.gitconfig
(issuing warning and ignoring, or erroring out), as some
variables such as core.sharedrepository are inherently per
repository.  core.repositoryformatversion has the same issue,
but we do set it per repository explicitly with init-db, which
makes sure that whatever value in ~/.gitconfig is ignored.
