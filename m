From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v6 1/7] pull: rename pull.rebase to pull.mode
Date: Fri, 02 May 2014 16:45:55 -0400
Message-ID: <53640403.30600@bbn.com>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com> <1398988808-29678-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 22:46:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKLW-0004Do-TA
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbaEBUqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:46:11 -0400
Received: from smtp.bbn.com ([128.33.0.80]:28840 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbaEBUqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 16:46:10 -0400
Received: from socket.bbn.com ([192.1.120.102]:41343)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WgKLD-000NH4-Ur; Fri, 02 May 2014 16:45:55 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id AFDFF3FE47
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1398988808-29678-2-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247973>

On 2014-05-01 20:00, Felipe Contreras wrote:
> Also 'branch.<name>.rebase' to 'branch.<name>.pullmode'.
> 
> This way we can add more modes and the default can be something else,
> namely it can be set to merge-ff-only, so eventually we can reject
> non-fast-forward merges by default.
> 
> The old configurations still work, but get deprecated.

s/get/are/

> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/config.txt   | 39 ++++++++++++++++++++++-----------------
>  Documentation/git-pull.txt |  2 +-
>  branch.c                   |  4 ++--
>  builtin/remote.c           | 14 ++++++++++++--
>  git-pull.sh                | 31 +++++++++++++++++++++++++++++--
>  t/t3200-branch.sh          | 40 ++++++++++++++++++++--------------------
>  t/t5601-clone.sh           |  4 ++--
>  7 files changed, 88 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c26a7c8..c028aeb 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -708,7 +708,7 @@ branch.autosetupmerge::
>  branch.autosetuprebase::
>  	When a new branch is created with 'git branch' or 'git checkout'
>  	that tracks another branch, this variable tells Git to set
> -	up pull to rebase instead of merge (see "branch.<name>.rebase").
> +	up pull to rebase instead of merge (see "branch.<name>.pullmode").
>  	When `never`, rebase is never automatically set to true.
>  	When `local`, rebase is set to true for tracked branches of
>  	other local branches.

Should branch.autosetuprebase be replaced with a new
branch.autosetupmode setting?

> @@ -764,15 +764,17 @@ branch.<name>.mergeoptions::
>  	option values containing whitespace characters are currently not
>  	supported.
>  
> -branch.<name>.rebase::
> -	When true, rebase the branch <name> on top of the fetched branch,
> -	instead of merging the default branch from the default remote when
> -	"git pull" is run. See "pull.rebase" for doing this in a non
> -	branch-specific manner.
> +branch.<name>.pullmode::
> +	When "git pull" is run, this determines if it would either merge or
> +	rebase the fetched branch.

To me this sentence implies that 'rebase' would rebase the fetched
branch onto HEAD, when it's actually the other way around.

>                                  The possible values are 'merge',
> +	'rebase', and 'rebase-preserve'.

While the name 'merge' is mostly self-explanatory, I think it needs
further clarification:  Does 'merge' imply --no-ff?  Or --ff?  Or the
value of merge.ff?  Which side will be the first parent?

Similarly, 'rebase' could use some clarification:
  * the local branch is rebased onto the pulled branch, not the other
    way around
  * it doesn't simply do 'git rebase FETCH_HEAD' -- it also walks the
    reflog of the upstream ref until it finds an ancestor of the local
    branch

>                                        See "pull.mode" for doing this in a
> +	non branch-specific manner.

I find this sentence to be a bit unclear and would prefer something
like:  "Defaults to the value of pull.mode."

>  +
> -	When preserve, also pass `--preserve-merges` along to 'git rebase'
> -	so that locally committed merge commits will not be flattened
> -	by running 'git pull'.
> +	When 'rebase-preserve', also pass `--preserve-merges` along to
> +	'git rebase' so that locally committed merge commits will not be
> +	flattened by running 'git pull'.
> ++
> +	It was named 'branch.<name>.rebase' but that is deprecated now.

To me this sentence implies that .rebase was simply renamed to .pullmode
with no other changes.  I'd prefer something like this:

branch.<name>.rebase::
    Deprecated in favor of branch.<name>.pullmode.

(Same goes for pull.rebase.)

>  +
>  *NOTE*: this is a possibly dangerous operation; do *not* use
>  it unless you understand the implications (see linkgit:git-rebase[1]
> @@ -1881,15 +1883,18 @@ pretty.<name>::
>  	Note that an alias with the same name as a built-in format
>  	will be silently ignored.
>  
> -pull.rebase::
> -	When true, rebase branches on top of the fetched branch, instead
> -	of merging the default branch from the default remote when "git
> -	pull" is run. See "branch.<name>.rebase" for setting this on a
> -	per-branch basis.
> +pull.mode::
> +	When "git pull" is run, this determines if it would either merge or
> +	rebase the fetched branch. The possible values are 'merge',
> +	'rebase', and 'rebase-preserve'. See "branch.<name>.pullmode" for doing
> +	this in a non branch-specific manner.
> ++
> +	When 'rebase-preserve', also pass `--preserve-merges` along to
> +	'git rebase' so that locally committed merge commits will not be
> +	flattened by running 'git pull'.
> ++
>  +
> -	When preserve, also pass `--preserve-merges` along to 'git rebase'
> -	so that locally committed merge commits will not be flattened
> -	by running 'git pull'.

The default value should be documented.  Also, rather than copy+paste
the description from branch.<name>.pullmode, I'd prefer a brief
reference.  For example:

pull.mode::
    See branch.<name>.pullmode.  Defaults to 'merge'.

-Richard
