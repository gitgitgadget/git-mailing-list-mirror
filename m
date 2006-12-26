From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: What's in git.git (stable)
Date: Tue, 26 Dec 2006 12:25:37 -0800 (PST)
Message-ID: <418215.90592.qm@web31809.mail.mud.yahoo.com>
References: <7vac1fy5ae.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 26 21:25:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzIrv-0006vj-Gv
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 21:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbWLZUZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 15:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWLZUZj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 15:25:39 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:31505 "HELO
	web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932777AbWLZUZi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Dec 2006 15:25:38 -0500
Received: (qmail 90951 invoked by uid 60001); 26 Dec 2006 20:25:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=mysUNAbsPYdptJAhc39tghCh7VAD31d00X6yiDUiBJwEwBdC2+J7MO8aoCYvQ2aIxoqi1GDjm/zmX3FbkE0fqVYZ0S+MTbVZwzTkW/ku9WAR032gDq7OzXNUF/nPkHwrFurAnOi40ccFSBQ8eQSABoRSmbgLiWaEgL5cN9gfA6I=;
X-YMail-OSG: mEEwJKMVM1m3SCcipd3ud8i8cZym4CqopKa.moLUtk6OzVxRCzm0DTPnTG2TJN8xChV15ETeJLjfSdOyLm445KdBj7V5_dK0fXfYNOaUtwe2A0Q0jQOzfn44B2x1TZCNf8rLWt74bvT4hPu4Ebpmkbdgv_zVzQ--
Received: from [71.84.31.238] by web31809.mail.mud.yahoo.com via HTTP; Tue, 26 Dec 2006 12:25:37 PST
To: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vac1fy5ae.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35431>

--- Junio C Hamano <junkio@cox.net> wrote:
> I am not quite sure about that.  An old timer would work in a
> newly cloned repository after all, and what this "newbie
> protection" is breaking is not existing repositories but
> expectation from existing users.

Hmm, "newbie protection" doesn't sound good.  It sounds like
"screw the old-timers and let's change well-established workflow".

The expectation is that one always pulls into origin, merges
into master, and maybe checks out master to see the remote
master.  From then on, they decide what, where and how to
merge (from) master into any local branches, and then
eventually export local branches to the public.

The "^branch.\.*" options seem to be counter-intuitive to
1) git's behavor and 2) see above.

Generally "pulling" a remote master in a local branch, without
the local "origin+master" being fast-forwarded/merged should be
considered non-git-conformant behavior.  Assuming that the local
branch is a branch of master/origin, which is almost ever the case.

> In any case, here is a patch for discussion.
> 
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index f163821..b4d071b 100755
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -145,10 +145,22 @@ canon_refs_list_for_fetch () {
>  			merge_branches=$(git-repo-config \
>  			    --get-all "branch.${curr_branch}.merge")
>  		fi
> -		# If we are fetching only one branch, then first branch
> -		# is the only thing that makes sense to merge anyway,
> -		# so there is no point refusing that traditional rule.
> -		if test $# != 1 && test "z$merge_branches" = z
> +		if test "z$merge_branches" = z &&
> +			# If we are fetching only one branch, then
> +			# first branch is the only thing that makes
> +			# sense to merge anyway, so there is no point
> +			# refusing that traditional rule.
> +			test $# != 1 &&
> +
> +			# Also, old timers have been happily working
> +			# with the first branch rule without having
> +			# any branch.*.merge configuration, so if
> +			# there is none, do not bother with this
> +			# "newbie protection".  A newly cloned
> +			# repository would have branch.master.merge
> +			# set for it.

It should probably have branch.*.remote _and_ branch.*.merge set
for completeness.  Or we should remove the branch.* options
from git-config and leave this up to porcelains.

> +			git repo-config --get-regexp \
> +				'^branch\..*\.merge$' >/dev/null

How does this "set" it?

    Luben


>  		then
>  			merge_branches=..this..would..never..match..
>  		fi
