From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] git submodule split
Date: Sun, 06 Apr 2014 18:08:32 +0200
Message-ID: <53417C00.3090805@web.de>
References: <87sipviel4.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Michal Sojka <sojkam1@fel.cvut.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 18:09:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWpd9-00056O-TS
	for gcvg-git-2@plane.gmane.org; Sun, 06 Apr 2014 18:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbaDFQIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 12:08:36 -0400
Received: from mout.web.de ([212.227.17.11]:56451 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650AbaDFQIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2014 12:08:34 -0400
Received: from [192.168.178.41] ([84.132.149.70]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MAvCS-1Wggzd00k0-009uEB; Sun, 06 Apr 2014 18:08:33
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <87sipviel4.fsf@steelpick.2x.cz>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:jMrVVICD80r3ljHwE9J2xDNkqDXH/lwkvY7MOcx9Mh34NitXg1W
 ZhpLPmK7QkIPzKphLk5sq60Aw7jfBMyWqtDs8n+yUPZL7lH6EEJxbo9SrBDtoHtQqARAzvN
 dmT4Mee1AT5cTIi5vSbQIOBeL+QqYcH29YW4OR3C/P3PSbHD0ktODcLK9DG6Bdtwnl8kwLs
 0dPgkvdAVlB+TBJPMtCiQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245789>

Am 02.04.2014 23:52, schrieb Michal Sojka:
> Hello,
> 
> I needed to convert a subdirectory of a repo to a submodule and have the
> histories of both repos linked together. I found that this was discussed
> few years back [1], but the code seemed quite complicated and was not
> merged.
> 
> [1]: http://git.661346.n2.nabble.com/RFC-What-s-the-best-UI-for-git-submodule-split-tp2318127.html
> 
> Now, the situation is better, because git subtree can already do most of
> the work. Below is a script that I used to split a submodule from my
> repo. It basically consist of a call to 'git subtree split' followed by
> 'git filter-branch' to link the histories together.
> 
> I'd like to get some initial feedback on it before attempting to
> integrate it with git sources (i.e. writing tests and doc). What do you
> think?

Why do want to rewrite the whole history of the superproject,
wouldn't it suffice to turn a directory into a submodule with
the same content in a simple commit? Don't get me wrong, I'm
not against adding such a functionality to contrib, I'm just
trying to understand the motivation for your script.

> Thanks,
> -Michal
> 
> 
> #!/bin/sh
> 
> set -e
> 
> . git-sh-setup
> 
> url=$1
> dir=$2
> 
> test -d "$dir" || die "$dir is not a directory"
> 
> # Create subtree corresponding to the directory
> subtree=$(git subtree split --prefix="$dir")
> 
> subtree_tag=tmp/submodule-split-$$
> git tag $subtree_tag $subtree
> superproject=$PWD
> export subtree subtree_tag superproject
> 
> # Replace the directory with submodule reference in the whole history
> git filter-branch -f --index-filter "
>     set -e
>     # Check whether the $dir exists in this commit
>     if git ls-files --error-unmatch '$dir' > /dev/null 2>&1; then
> 
>         # Find subtree commit corresponding to the commit in the
>         # superproject (this could be made faster by not running git log
>         # for every commit)
>         subcommit=\$(git log --format='%T %H' $subtree |
>      	    grep ^\$(git ls-tree \$GIT_COMMIT -- '$dir'|awk '{print \$3}') |
>      	    awk '{print \$2}')
> 
>         # filter-branch runs the filter in an empty work-tree - create the
>         # future submodule in it so that the 'git submodule add' below
>         # does not try to clone it.
>         if ! test -d '$dir'; then
>      	    mkdir -p '$dir'
>      	    ( cd '$dir' && clear_local_git_env && git init --quiet && git pull $superproject $subtree_tag )
>         fi
> 
>         # Remove all files under $dir from index so that the 'git
>         # submodule add' below does not complain.
>         git ls-files '$dir'|git update-index --force-remove --stdin
> 
>         # Add the submodule - the goal here is to create/update .gitmodules
>         git submodule add $url '$dir'
> 
>         # Update the submodule commit hash to the correct value
>         echo \"160000 \$subcommit	$dir\"|git update-index --index-info
>     fi
> "
> 
> # Replace the directory in the working tree with the submodule
> ( cd "$dir" && find -mindepth 1 -delete && git init && git pull $superproject $subtree_tag )
> 
> # Clean up
> git tag --delete $subtree_tag
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
