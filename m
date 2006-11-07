X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Tue, 7 Nov 2006 02:25:24 +0100
Message-ID: <200611070225.24956.Josef.Weidendorfer@gmx.de>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de> <7vd580azbb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 01:30:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <7vd580azbb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31036>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhFmn-0006Dj-07 for gcvg-git@gmane.org; Tue, 07 Nov
 2006 02:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753910AbWKGB3x (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 20:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbWKGB3x
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 20:29:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:18662 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1753910AbWKGB3w (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 20:29:52 -0500
Received: (qmail invoked by alias); 07 Nov 2006 01:29:50 -0000
Received: from p5496B896.dip0.t-ipconnect.de (EHLO noname) [84.150.184.150]
 by mail.gmx.net (mp042) with SMTP; 07 Nov 2006 02:29:50 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tuesday 07 November 2006 01:13, Junio C Hamano wrote:

> I wonder if it is more consistent and easy to use to just make
> this:
> 
> 	git checkout origin/next
> 
> a synonym to:
> 
> 	git checkout -b origin/next remotes/origin/next
> 
> when remotes/origin/next exists and heads/origin/next does not.

Interesting.

I wonder how often there is a real need for that long branch names.
IMHO this convenience behavior of git-checkout should target
the majority of possible use cases. Is it really better to default
to long branch names instead of asking for explicit branch name
in the rare case of conflict (ie. multiple remote repositories with
same branch names and you want to develop on both these branches
locally)?

Suppose developer2 uses this scheme, and has a local development
branch "junio/next", which is based on your "next" branch.
Now I want to work on the "next" branch of developer2, getting
a local branch name "developer2/junio/next".

> Then "git checkout origin/next" would always mean "I want to
> switch to the branch I use to hack on the branch 'next' Junio
> has".  Do it once and you will get exactly my tip, hack on it,
> switch out of it and then do it again and you won't lose your
> previous work but just switch to that branch.

Ah, now I understand your thinking.
I admit it has a compelling elegance.

However.
Would it not be confusing for newbies (and not only for them) to
first reference the remote branch with "origin/next", and afterwards, you
get your own development branch by using the exactly same name?

IMHO this kind of aliasing is awkward. When you want to start another
topic branch on the remote branch, or want to reference the remote
branch for diffs, you have to explicitly specify "remotes/origin/next",
making for more typing.

> That is, something like this...
> 
> ---
> 
> diff --git a/git-checkout.sh b/git-checkout.sh
> index 119bca1..f6486c6 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
> @@ -4,6 +4,16 @@ USAGE='[-f] [-b <new_branch>] [-m] [<bra
>  SUBDIRECTORY_OK=Sometimes
>  . git-sh-setup
>  
> +# Automatic forking of local branch based on remote
> +if test $# = 1 &&
> +   git show-ref --verify --quiet -- "refs/remotes/$1" &&
> +   ! git show-ref --verify --quiet -- "refs/heads/$1"
> +then
> +	set x -b "$1" "remotes/$1"
> +	echo >&2 "* Forking local branch $1 off of remotes/$1..."
> +	shift
> +fi

I didn't know about "set x" before.
Thanks, you never end learning :-)

"git-checkout remotes/origin/next" does not work as expected,
and if fixed, it still should guard against an existing
local branch "origin/next", don't you think?
(Ok, it does not work in my patch, too.)

What do you think about the setup of the default for "git-pull"?

