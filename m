X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 23:25:35 +0100
Organization: At home
Message-ID: <ekafpm$fs7$1@sea.gmane.org>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 25 Nov 2006 22:24:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 99
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32306>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go5wQ-00080N-5Q for gcvg-git@gmane.org; Sat, 25 Nov
 2006 23:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966865AbWKYWYG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 17:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967264AbWKYWYG
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 17:24:06 -0500
Received: from main.gmane.org ([80.91.229.2]:42935 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966865AbWKYWYD (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 17:24:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Go5wH-0007y6-7H for git@vger.kernel.org; Sat, 25 Nov 2006 23:24:01 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 23:24:01 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 25 Nov 2006
 23:24:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Now separate-remote layout is the default for newly cloned
> repositories, I think it is a good time to make further effort
> to make things easier to use.  Here are some of the ideas off
> the top of my head.
[...]
> * Change the default contents of $GIT_DIR/remotes/origin

The question is: do we continue to use remotes/ file, or do we
save remotes info in the config file: remote.<name>.url,
remote.<name>.fetch, remote.<name>.push and branch.<name>.merge
(in our case '[remote "origin"]' section)?
 
> Currently we list all the remote branches that exist when the
> clone is made, making sure that the branch pointed at by HEAD at
> the remote is listed first.  The intent is to track every branch
> at the remote but merge in the "primary" branch to us.
> 
> Two issues that have been raised about this is:
> 
>  - the intent to track every branch is good, but the current
>    implementation means we would not notice new branches at the
>    remote.
> 
>  - merging the "primary" branch is good only when the user is on
>    the corresponding "primary" branch.  It is usually a wrong
>    thing to do when on another branch.
> 
> The first issue can be solved, with the help of recent "glob
> pattern refspec in fetch" from Andy.  I am thinking about making
> the default contents of $GIT_DIR/remotes/origin to be:
> 
>       URL: <url of the cloned repository>
>       Pull: +refs/heads/<primary>:refs/remotes/<origin>/<primary>
>       Pull: +refs/heads/*:refs/remotes/<origin>/*
> 
> to address this issue.

I hope that it also works with the remote.origin config file
section instead of $GIT_DIR/remotes/origin

>       Side note: <primary> is what HEAD pointed at at the
>         remote when the clone was made, and <origin> is usually
>         'origin' but "git clone -o $origin" can override it.
> 
> Forcing with '+' is debatable, but with separate-remote layout,
> remotes/*/ hierarchy is to track what the remote has, and you
> cannot do much else other than noticing and warning when the
> remote end does funny things to its refs anyway, so I think
> having '+' might be a better default.

Perhaps, perhaps not. It would be nice to have configuration option
that would tell that history of given branch is being changed, and
the ability to ask about it remotely, so git-clone would be able
to add this + _when needed_ automatically.

But it's a fact that with separate remote the need to use fast-forward
check is lessened, and it might be more important to not confuse first
time user with having to modify $GIT_DIR/remotes/origin or remote.origin
config section to fetch from the repository he/she cloned from.

> The right thing to do to address the second issue is less clear.
> If the "upstream" has two more-or-less equally prominent
> branches, say 'main' and 'test', it may make sense to use
> corresponding two branches on the local side and merge 'main'
> from the remote when on local 'main' and merge 'test' when on
> local 'test'.  Even when dealing with a specific topic branch,
> that would hold true for most of the time.  A topic branch
> refs/heads/bug#2073 to work on the bug 2073 can be published at
> the central distribution point.  The proposed updates to
> $GIT_DIR/remotes/origin file would track it with
> refs/remotes/origin/bug#2073 and interested people can create a
> local branch refs/heads/bug#2073 from it and work on it, which
> makes it easy to polish a topic branch in a collaborative way.
> 
> I am not sure if 'merge in corresponding branch' is the only
> valid workflow, however. I am reluctant to make the system
> automatically do so if the solution makes other workflows more
> painful to follow.  Automatically merging remotes/origin/$foo
> when on $foo branch is not good enough, in other words (also,
> there may be a hierarchy under remotes/ other than origin).  It
> might make sense to introduce "Merge: " in remotes/ file and if
> they are present use "Pull: " only to decide what are fetched
> and use "Merge: " to decide what is merged (if we were doing the
> system from scratch, the former would have been named "Fetch: "
> but it is too late now).

If you add "Merge: " in remotes/, then please add it also in
remote section in config file. Config file has now 
branch.<branchname>.merge (and it would be nice if clone would
set ou this for local branches corresponding to remote branches),
but it is not the same.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

