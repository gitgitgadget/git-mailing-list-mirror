From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Working with remotes; cloning remote references
Date: Tue, 21 Oct 2008 11:49:20 +0200
Message-ID: <48FDA5A0.8030506@drmicha.warpmail.net>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 11:50:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsDsu-0000yS-K9
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 11:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbYJUJtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 05:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYJUJtZ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 05:49:25 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:46305 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750955AbYJUJtY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2008 05:49:24 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E37A2181E1A;
	Tue, 21 Oct 2008 05:49:22 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 21 Oct 2008 05:49:22 -0400
X-Sasl-enc: oeTMOmddJKe+hHYEnNytSazZu+KWy/Rh9Wb796S+Bf6h 1224582562
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 102EDE466;
	Tue, 21 Oct 2008 05:49:21 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <48FCB6B8.6090708@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98767>

Marc Branchaud venit, vidit, dixit 10/20/08 18:50:
> Thanks for the explicit instructions, but I think I'm still missing 
> something.  Here's exactly what I'm trying, just to make sure I'm not 
> doing something odd.
> 
> First I set up the remote in the main repo:
> 
> main/$ git remote add -f ThingOne git://thing/ThingOne.git
> main/$ git merge -s ours --no-commit ThingOne/master
> main/$ git read-tree --prefix=thing-one/ -u ThingOne/master
> main/$ git commit -m "Adding ThingOne"
> 
> Then I make a clone, fetch main's refs to ThingOne, and try to pull in 
> changes from ThingOne by using those refs:
> 
> $ git clone /path/to/main clone
> $ cd clone
> clone/$ git config remote.origin.fetch \
>          '+refs/remotes/ThingOne/*:refs/remotes/ThingOne/*'

If you want to fetch main's local branches also, use option "--add" here
so that you don't override the default fetch refspec (forgot last time,
sorry).

> clone/$ git fetch
>  From /path/to/main/
>   * [new branch]      ThingOne/master -> ThingOne/master 
> 
> clone/$ git pull -s subtree git://thing/ThingOne.git ThingOne/master
> fatal: Couldn't find remote ref ThingOne/master

because on ThingOne there is no such ref.

> The config & fetch commands indeed add a 
> .git/refs/remotes/ThingOne/master file to the clone, but I'm missing the 
> magic words for how to use that ref.

I thought you wanted to avoid pulling directly from ThingOne to clone?
If you pull directly you might as well set up the same remote config as
on main: for the correct pull line you need to know the same info as for
the correct remote config.

git fetch
git merge -s subtree remotes/ThingOne/master

should do the trick. If that works you can set up things so that pulling
from origin (pulling when you're in your integration branch) does that
merge automatically, using branch.integrationbranch.remote=origin,
branch.integrationbranch.merge=remotes/ThingOne/master (untested ;) ).

To be clear: The idea here is that main decides which ThingOne branch to
store in remotes/ThingOne/master and where to get it from; clones always
pull that one.

> Also:
> 
> Michael J Gruber wrote:
>>> And actually, git's remote functionality feels a bit crippled if clones 
>>> can't make some use of the origin's remotes.  Is there a reason for 
>>> keeping remote definitions out of a clone?
>> Say A and B are working on a project C. Then, typically, A is interested
>> in B's work on C, i.e. some of B's local branches, but not on B's remote
>>  tracking branches: A tracks a "central" C already, just like B does,
>> and remote tracking branches don't carry any "value adding" by the
>> cloner, they're just a local unmodified copy of the remote.
> 
> I can appreciate that, but the approach leads to two consequences that I 
> suggest should be avoidable:
> 
> 1. A and B both have to set up the references to C themselves.  A can't 
> just piggyback on whatever B has already set up.  (This is the impetus 
> for my original message.)
> 
> 2. Suppose B is just a repository that's being shared between A and D -- 
> i.e. there's no B entity doing any work directly in B.  In this case if 
> A (or D) wants to change B's reference to C (say, to track a new branch 
> in C), they can't: B has to be changed directly, and nothing can be done 
> in a clone to accomplish this.
> 
> I admit I'm picking at nits here -- obviously someone is able to access 
> the B repo and do whatever needs doing.  I just feel that there are some 
> situations where you want the origin's remotes in your clone, and some 
> where you don't, and git should let you decide.

Well, it let's you decide: It tracks local branches by default, and
using additional "git config" you can track remotes as well. You can
also use the "--mirror" option to "git clone" or "git remote add", but
that has other side effects.

Cheers,
Michael
