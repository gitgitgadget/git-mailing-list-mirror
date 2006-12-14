X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH] git-reset [--mixed] <tree> [--] <paths>...
Date: Thu, 14 Dec 2006 11:47:18 +0100
Message-ID: <slrneo2atm.nqa.Peter.B.Baumann@xp.machine.xx>
References: <7vwt4u96e8.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Thu, 14 Dec 2006 10:48:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 94
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34308>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guo89-00009U-AL for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750731AbWLNKr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWLNKr5
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:47:57 -0500
Received: from main.gmane.org ([80.91.229.2]:38931 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1750731AbWLNKrz
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 05:47:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Guo7s-0001I6-Dh for git@vger.kernel.org; Thu, 14 Dec 2006 11:47:44 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 11:47:44 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 14 Dec 2006 11:47:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-12-14, Junio C Hamano <junkio@cox.net> wrote:
> Sometimes it is asked on the list how to revert selected path in
> the index from a tree, most often HEAD, without affecting the
> files in the working tree.  A similar operation that also
> affects the working tree files has been available in the form of
> "git checkout <tree> -- <paths>...".
>
> By definition --soft would never affect either the index nor the
> working tree files, and --hard is the way to make the working
> tree files as close to pristine, so this new option is available
> only for the default --mixed case.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>
>  * I haven't looked at Documentation/git-reset.txt recently.  It
>    most likely needs not just addition to describe this new
>    format, but more a heavier rewrite similar to what we made to
>    git-commit documentation recently.
>
>  git-reset.sh |   68 +++++++++++++++++++++++++++++++++++++++------------------
>  1 files changed, 46 insertions(+), 22 deletions(-)
>
> diff --git a/git-reset.sh b/git-reset.sh
> index 03d2c3b..e95c252 100755
> --- a/git-reset.sh
> +++ b/git-reset.sh
> @@ -1,35 +1,59 @@
>  #!/bin/sh
> -
> -USAGE='[--mixed | --soft | --hard]  [<commit-ish>]'
> +#
> +# Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
> +#
> +USAGE='[--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]'
>  SUBDIRECTORY_OK=Yes
>  . git-sh-setup
>  
> +update= rev= reset_type=--mixed
> +
> +while case $# in 0) break ;; esac
> +do
> +	case "$1" in
> +	--mixed | --soft | --hard)
> +		reset_type="$1"
> +		;;
> +	--)
> +		break
> +		;;
> +	-*)
> +		usage
> +		;;
> +	*)
> +		rev=$(git-rev-parse --verify "$1") || exit
> +		shift
> +		break
> +		;;
> +	esac
> +	shift
> +done
> +
> +: ${rev=HEAD}
> +rev=$(git-rev-parse --verify $rev^0) || exit
> +
> +# Skip -- in "git reset HEAD -- foo" and "git reset -- foo".
> +case "$1" in --) shift ;; esac
> +
> +# git reset --mixed tree [--] paths... can be used to
> +# load chosen paths from the tree into the index without
> +# affecting the working tree nor HEAD.
> +if test $# != 0
> +then
> +	test "$reset_type" == "--mixed" ||
> +		die "Cannot do partial $reset_type reset."
> +	git ls-tree -r --full-name $rev -- "$@" |
> +	git update-index --add --index-info || exit
> +	git update-index --refresh
> +	exit
> +fi
> +

Why not make

	git-reset --hard <treeish> -- file

aquivalent to

	git-checkout <treeish> -- file

-Peter

PS:	Your patch didn't apply cleanly. And I couldn't find the blobs
	03d2c3b..e95c252 even after pulling (pu, next, master) in my
	git repository
