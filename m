From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Confusing git pull error message
Date: Mon, 05 Oct 2009 13:32:34 +0200
Message-ID: <4AC9D952.3050108@viscovery.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com> <20090912211119.GA30966@coredump.intra.peff.net> <7v1vmar353.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 13:38:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mult8-00024n-OZ
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 13:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbZJELdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 07:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbZJELdX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 07:33:23 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3677 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbZJELdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 07:33:22 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mulnu-0003jd-U4; Mon, 05 Oct 2009 13:32:42 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A12B2BC81; Mon,  5 Oct 2009 13:32:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v1vmar353.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129554>

Junio C Hamano schrieb:
> Jeff King <peff@peff.net> writes:
>> I think it is enough for git-pull to just check whether the config
>> exists, and if so, guess that the ref was simply not fetched. IOW,
>> this:
> 
> Thanks.
> 
> I saw some discussion on improving the wording.  Here is what I plan to
> commit.
> 
> diff --git a/git-pull.sh b/git-pull.sh
> index 0bbd5bf..2c2fa79 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -89,6 +89,8 @@ error_on_no_merge_candidates () {
>  	done
>  
>  	curr_branch=${curr_branch#refs/heads/}
> +	upstream=$(git config "branch.$curr_branch.merge" ||
> +			git config "branch.$curr_branch.rebase")
>  
>  	if [ -z "$curr_branch" ]; then
>  		echo "You are not currently on a branch, so I cannot use any"
> @@ -96,7 +98,7 @@ error_on_no_merge_candidates () {
>  		echo "Please specify which branch you want to merge on the command"
>  		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
>  		echo "See git-pull(1) for details."
> -	else
> +	elif [ -z "$upstream" ]; then
>  		echo "You asked me to pull without telling me which branch you"
>  		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
>  		echo "your configuration file does not tell me either.	Please"
> @@ -114,6 +116,10 @@ error_on_no_merge_candidates () {
>  		echo "    remote.<nickname>.fetch = <refspec>"
>  		echo
>  		echo "See git-config(1) for details."
> +	else
> +		echo "Your configuration specifies to merge the ref"
> +		echo "'${upstream#refs/heads/}' from the remote, but no such ref"
> +		echo "was fetched."
>  	fi
>  	exit 1
>  }

Unfortunately, this is not water-tight. See what I just observed:

  $ git pull hk
  From /exports/repos/hk/viscovery
     9455552..6429037  master     -> hk/master
  Your configuration specifies to merge the ref
  'master' from the remote, but no such ref
  was fetched.

The message is confusing when it says "'master' was not fetched" when
clearly master _was_ fetched.

More importantly, the message is wrong to say that "Your configuration
specifies to merge the ref 'master' from the remote", because I have this
configuration:

  $ git config -l | egrep '^(remote|branch)'
  remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
  remote.origin.url=/exports/repos/js/viscovery
  branch.master.remote=origin
  branch.master.merge=refs/heads/master
  remote.hk.url=/exports/repos/hk/viscovery
  remote.hk.fetch=+refs/heads/*:refs/remotes/hk/*

i.e. while on master, I merge master from "origin", not from "hk".

-- Hannes
