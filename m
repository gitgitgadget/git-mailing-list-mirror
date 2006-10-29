X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sylvain Beucler <beuc@gnu.org>
Subject: Re: Overwriting bare repositories' master
Date: Sun, 29 Oct 2006 23:21:51 +0100
Message-ID: <20061029222151.GB24385@localhost.localdomain>
References: <20061029210333.GG12285@localhost.localdomain> <7vslh6zstt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 22:22:37 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vslh6zstt.fsf@assigned-by-dhcp.cox.net>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Ovh-Remote: 82.238.35.175 (perso.beuc.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30469>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeJ2m-0004Hk-OM for gcvg-git@gmane.org; Sun, 29 Oct
 2006 23:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030388AbWJ2WWK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 17:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWJ2WWJ
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 17:22:09 -0500
Received: from 42.mail-out.ovh.net ([213.251.189.42]:19158 "EHLO
 42.mail-out.ovh.net") by vger.kernel.org with ESMTP id S1030388AbWJ2WWH
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 17:22:07 -0500
Received: (qmail 25018 invoked by uid 503); 29 Oct 2006 22:21:50 -0000
Received: from b6.ovh.net (HELO mail139.ha.ovh.net) (213.186.33.56) by
 42.mail-out.ovh.net with SMTP; 29 Oct 2006 22:21:50 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50) by b0.ovh.net with
 SMTP; 29 Oct 2006 22:22:06 -0000
Received: from perso.beuc.net (HELO localhost.localdomain) (82.238.35.175) by
 ns0.ovh.net with SMTP; 29 Oct 2006 22:22:03 -0000
Received: from me by localhost.localdomain with local (Exim 4.63)
 (envelope-from <beuc@beuc.net>) id 1GeJ2N-0006vC-PA; Sun, 29 Oct 2006
 23:21:51 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sun, Oct 29, 2006 at 01:59:42PM -0800, Junio C Hamano wrote:
> Sylvain Beucler <beuc@gnu.org> writes:
> 
> > I tried and I found something that doesn't seem to follow the
> > documentation:
> >
> > repo_one$ git push Beuc@cvs.sv.gnu.org:/srv/git/sources/administration.git \
> >   master:refs/heads/master
> > # [OK]
> > repo_two$ git push --force Beuc@cvs.sv.gnu.org:/srv/git/administration.git \
> >   +refs/heads/master:refs/heads/master
> > updating 'refs/heads/master'
> >   from ee3bda653dfabaf0f78f2a9977abec180f2b19dc
> >   to   c9a726b610bafc82142a16af80b83d28375ca619
> > Generating pack...
> > Done counting 0 objects.
> > Total 0, written 0 (delta 0), reused 0 (delta 0)
> > Unpacking 0 objects
> > error: denying non-fast forward; you should pull first
> >
> > From man git-push:
> > "If the optional plus + is used, the remote ref is updated even if it
> > does not result in a fast forward update."
> >
> > This also makes one wonder how the 'pu' git branch is updated.
> >
> > One the one hand, this means that sysadmin intervention is required to
> > reset such a repository, which is bad. One the other hand, this is
> > also a security because users cannot erase history, even if there a
> > cron job to prune&pack the git repositories, which is good.
> >
> > Is this by design? Or should it work?
> 
> I suspect (because I cannot see your .git/config in the
> repository; which would say "[core] sharedrepository = 1" if my
> suspicion is correct) that this is fairly new heavyhanded safety
> valve added by the list around mid September, with this:
> 
>     commit 11031d7e9f34f6a20ff4a4bd4fa3e5e3c0024a57
>     Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>     Date:   Thu Sep 21 01:07:54 2006 +0200
> 
>         add receive.denyNonFastforwards config variable
> 
>         If receive.denyNonFastforwards is set to true,
>         git-receive-pack will deny non fast-forwards, i.e. forced
>         updates. Most notably, a push to a repository which has that
>         flag set will fail.
> 
>         As a first user, 'git-init-db --shared' sets this flag,
>         since in a shared setup, you are most unlikely to want
>         forced pushes to succeed.
> 
> The reasoning is exactly as you guessed.
> 
> I think the intention of the patch is that the repository
> administrators are expected to either (1) adjust the
> non-fast-forwarding branch to fast-forward (by reset --hard to
> an ancestor of what you are trying to push into), (2)
> temporarily disable the safety value by editing .git/config, or
> (3) instead of pushing into it, force fetching into it from the
> repository machine.
> 
> It is doing what it was designed to do.  It is a different issue
> if the design is good, but rewinding the public branch is not
> something even a repository administrator should take lightly
> and not expected to happen often (except in cases like yours
> where the administrator is tipping his toe into the water), so I
> think overall the current behaviour is an acceptable balance
> between safety and convenience.
> 
> My public repository is not shared (only I can push into it) so
> this is a non-issue for my 'pu' branch.


You perfectly guessed the situation.

Setting denyNonFastforwards=false allowed the forced push to succeed.
For reference the config file was
(http://cvs.sv.gnu.org/r/test.git/config):
[core]
	repositoryformatversion = 0
	filemode = true
	sharedrepository = 1
[receive]
	denyNonFastforwards = true

This sounds like a sound design :)

-- 
