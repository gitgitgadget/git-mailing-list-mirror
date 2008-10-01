From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: regression: stash show -p (was [PATCH maint] git-stash.sh: don't
 default to refs/stash if invalid ref supplied)
Date: Wed, 01 Oct 2008 14:53:55 -0500
Message-ID: <DDpCKmlWUqX7hHbNNF45UGo81L7NuUHMbU3vXSfhHU60An5PUqIvRA@cipher.nrlssc.navy.mil>
References: <klevRMI-z5Id8iuqn2rqrKQZ8LdPNE4lABeC502X9y1Es5wwQ-s8GA@cipher.nrlssc.navy.mil> <twy9P1UnbmZHs2ZDeFBjSzrleLQ225-I7ESNrFkwoXZL-mJCTf4hYw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: mattjackets <mattlist@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Oct 01 21:55:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl7n3-0006mo-F6
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 21:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbYJATyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 15:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbYJATyE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 15:54:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36914 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbYJATyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 15:54:01 -0400
Received: by mail.nrlssc.navy.mil id m91Jrt2m002203; Wed, 1 Oct 2008 14:53:56 -0500
In-Reply-To: <twy9P1UnbmZHs2ZDeFBjSzrleLQ225-I7ESNrFkwoXZL-mJCTf4hYw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 01 Oct 2008 19:53:55.0900 (UTC) FILETIME=[6FF91FC0:01C923FF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97259>


Thanks to the patch referenced in the subject, 'git stash show -p'
no longer works if a revision is _not_ supplied.

This is because the argument list passed to show_stash() is not empty,
so the default $ref_stash@{0} is not appended.

This brings me back to an unanswered question, "Should rev-parse fall
back to its --default argument when an invalid ref is supplied?". The
documentation does not imply that it should.

>From Documentation/git-rev-parse.txt:

   --default <arg>::
        If there is no parameter given by the user, use `<arg>`
        instead.

Currently a rev-parse invocation like:

    $ git rev-parse --default HEAD a_non_existent_ref

will fall back to operating on HEAD. Is this correct? Could there be
some part of git that depends on this behavior? filter-branch is now
the only script which uses the --default option of rev-parse, not sure
about the c code.

-brandon



Brandon Casey wrote:
> apply_stash() and show_stash() each call rev-parse with
> '--default refs/stash' as an argument. This option causes rev-parse to
> operate on refs/stash if it is not able to successfully operate on any
> element of the command line. This includes failure to supply a "valid"
> revision. This has the effect of causing 'stash apply' and 'stash show'
> to operate as if stash@{0} had been supplied when an invalid revision is
> supplied.
> 
> e.g. 'git stash apply stahs@{1}' would fall back to
>      'git stash apply stash@{0}'
> 
> This patch modifies these two functions so that they avoid using the
> --default option of rev-parse.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> This should fix the case I mention above, but it does not fix the
> case where a non-existent reflog entry is specified. In this case
> the last entry will be selected.
> 
> 	$ git stash list
> 	stash@{0}: WIP on master: c050772... small java change
> 	stash@{1}: WIP on master: c050772... small java change
> 	stash@{2}: WIP on master: c050772... small java change
> 	stash@{3}: WIP on master: c050772... small java change
> 	$ git stash apply stash@{10}
> 	warning: Log for 'stash' only has 4 entries.
> 	# On branch master
> 	# Changed but not updated:
> 	... etc.
> 
> stash@{3} was applied.
> 
> Luckily, the dangerous case has no effect.
> 
> 	$ git stash drop stash@{10}
> 	Dropped stash@{10} (b7a2467e58109c92d799d059f508f35853d0bff7)
> 	$ git stash list
> 	stash@{0}: WIP on master: c050772... small java change
> 	stash@{1}: WIP on master: c050772... small java change
> 	stash@{2}: WIP on master: c050772... small java change
> 	stash@{3}: WIP on master: c050772... small java change
> 
> -brandon
> 
> 
>  git-stash.sh |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index d799c76..6bd2572 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -144,7 +144,14 @@ show_stash () {
>  	then
>  		flags=--stat
>  	fi
> -	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@")
> +
> +	if test $# = 0
> +	then
> +		set x "$ref_stash@{0}"
> +		shift
> +	fi
> +
> +	s=$(git rev-parse --revs-only --no-flags "$@")
>  
>  	w_commit=$(git rev-parse --verify "$s") &&
>  	b_commit=$(git rev-parse --verify "$s^") &&
> @@ -163,13 +170,19 @@ apply_stash () {
>  		shift
>  	esac
>  
> +	if test $# = 0
> +	then
> +		set x "$ref_stash@{0}"
> +		shift
> +	fi
> +
>  	# current index state
>  	c_tree=$(git write-tree) ||
>  		die 'Cannot apply a stash in the middle of a merge'
>  
>  	# stash records the work tree, and is a merge between the
>  	# base commit (first parent) and the index tree (second parent).
> -	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@") &&
> +	s=$(git rev-parse --revs-only --no-flags "$@") &&
>  	w_tree=$(git rev-parse --verify "$s:") &&
>  	b_tree=$(git rev-parse --verify "$s^1:") &&
>  	i_tree=$(git rev-parse --verify "$s^2:") ||
