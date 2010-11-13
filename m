From: Yann Dirson <ydirson@free.fr>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Sat, 13 Nov 2010 10:51:40 +0100
Message-ID: <20101113095140.GH8911@home.lan>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 13 10:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHCoq-0001FP-JX
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 10:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474Ab0KMJvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 04:51:49 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:51012 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab0KMJvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 04:51:48 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 31136D48002;
	Sat, 13 Nov 2010 10:51:41 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PHClo-0000PQ-UY; Sat, 13 Nov 2010 10:51:40 +0100
Content-Disposition: inline
In-Reply-To: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161386>

On Fri, Nov 12, 2010 at 09:55:49PM +0100, Martin von Zweigbergk wrote:
> With 'git pull --rebase', the user can configure the upstream repository
> to fetch from and reference to rebase against if none is specified on
> the command line.
> 
> However, if, instead of 'git pull --rebase', the user were to do 'git
> fetch' followed by 'git rebase', the upstream branch would need to be
> specified on the command line. This patch teaches 'git rebase' to
> default to the same configured upstream ref as 'git pull --rebase'
> uses.

It is something I've meant to take a stake at since ages, cool!

Note that the same holds for "merge".

> The obvious extension would be to make @{u} the default for 'git merge'
> as well. Any opinions?

Hell, yes :)

> @@ -21,6 +21,10 @@ If <branch> is specified, 'git rebase' will perform an automatic
>  `git checkout <branch>` before doing anything else.  Otherwise
>  it remains on the current branch.
>  
> +If <upstream> is not specified, the upstream configured in
> +branch.<name>.remote and branch.<name>.merge options will be used; see
> +linkgit:git-config[1] for details.
> +

Maybe make explicit that it will abort when no upstream is configured.

> @@ -416,9 +409,31 @@ esac
>  
>  if test -z "$rebase_root"
>  then
> -	# The upstream head must be given.  Make sure it is valid.
> -	upstream_name="$1"
> -	shift
> +	case "$#" in
> +	0)	branch_name=$(git symbolic-ref -q HEAD) &&
> +		upstream_name=$(git for-each-ref \
> +			--format='%(upstream)' ${branch_name})
> +		if test -z $branch_name
> +		then
> +			die "You are not currently on a branch, so I cannot use any
> +'branch.<branchname>.merge' in your configuration file.
> +Please specify which upstream branch you want to use on the command
> +line and try again (e.g. 'git rebase <upstream branch>').
> +See git-rebase(1) for details."
> +		elif test -z $upstream_name
> +		then
> +			die "You asked me to rebase without telling me which branch you
> +want to rebase against, and 'branch.${branch_name#refs/heads/}.merge' in
> +your configuration file does not tell me, either. Please
> +specify which branch you want to use on the command line and
> +try again (e.g. 'git rebase <upstream branch>').
> +See git-rebase(1) for details."
> +		fi
> +		;;
> +	*)	upstream_name="$1"
> +		shift
> +		;;
> +	esac
>  	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
>  	die "invalid upstream $upstream_name"
>  	unset root_flag

What about simply checking if "rev-parse @{u}" succeeds, in which case
we can use upstream_name=@{u} ?  If it fails, then we can do the work
of finding where the config flaw is (and delegate this to a func).
That would help keep the nominal code path short.

-- 
Yann
