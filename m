X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Wed, 6 Dec 2006 13:36:46 +0100
Message-ID: <slrnendeau.7j4.Peter.B.Baumann@xp.machine.xx>
References: <200612061207.23437.andyparkins@gmail.com>
NNTP-Posting-Date: Wed, 6 Dec 2006 12:37:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 73
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33445>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grw1W-0002aW-Hr for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760561AbWLFMhP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760562AbWLFMhP
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:37:15 -0500
Received: from main.gmane.org ([80.91.229.2]:33907 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760561AbWLFMhN
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:37:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Grw1M-0001qs-Db for git@vger.kernel.org; Wed, 06 Dec 2006 13:37:08 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 13:37:08 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 13:37:08 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-12-06, Andy Parkins <andyparkins@gmail.com> wrote:
> Without any specification in the .git/config file, git-pull will execute
> "git-pull origin"; which in turn defaults to pull from the first "pull"
> definition for the remote, "origin".
>
> This is a difficult set of defaults to track for a new user, and it's
> difficult to see what tells git to do this (especially when it is
> actually hard-coded behaviour).  To ameliorate this slightly, this patch
> explicitly specifies the default behaviour during a clone using the
> "branch" section of the config.
>
> For example, a clone of a typical repository would create a .git/config
> containing:
>   [remote "origin"]
>   url = proto://host/repo.git
>   fetch = refs/heads/master:refs/remotes/origin/master
>   [branch "master"]
>   remote = origin
>   merge = refs/heads/master
>
> The [branch "master"] section is such that there is no change to the
> functionality of git-pull, but that functionality is now explicitly
> documented.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> This is really to help newbies.  By explicitly documenting the default
> behaviour, it makes it clearer what is going on.  It also means no routing
> through documentation to find out what config option needs changing.
>

I second that. It took me a while to understand why the first entry in
remotes/origin merged with the current branch. I thought it was a bug
because sometimes it did the right thing and once in a while nothing
went wrong.

Obviously, it have switched the branch. I even tried to made this
"buggy" behaviour reproducable to write a bugreport, but after several
days the light goes on and I just felt a little bit stupid :-)

> It's possible that we would want to remove the default behaviour entirely
> if there is no "branch" definition in the config.  That would prevent
> accidents by users who don't know what pull does fully yet.
>

I'm not absolutly sure about this, but with --use-separate-remote this makes
sense, because you can easly teach someone new to git that the changes
from the remote branches are under refs/remotes/<branches> and (s)he
could merge it with git-pull . refs/remotes/$branch

No more clueless users why git pull on master branch updated the working
tree and git pull an other branch does nothing.

-Peter

>  git-clone.sh |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/git-clone.sh b/git-clone.sh
> index 826fdda..992cb7c 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -413,7 +413,9 @@ then
>  			rm -f "refs/remotes/$origin/HEAD"
>  			git-symbolic-ref "refs/remotes/$origin/HEAD" \
>  				"refs/remotes/$origin/$head_points_at"
> -		esac
> +		esac &&
> +		git-repo-config branch."$head_points_at".remote "$origin" &&
> +		git-repo-config branch."$head_points_at".merge "refs/heads/$head_points_at"
>  	esac
>  
>  	case "$no_checkout" in
