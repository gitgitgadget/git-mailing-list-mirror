From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Working with remotes; cloning remote references
Date: Mon, 20 Oct 2008 15:22:44 +0200
Message-ID: <48FC8624.9090807@fastmail.fm>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 19:59:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krujq-0004hd-2O
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 15:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYJTNWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 09:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYJTNWt
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 09:22:49 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49610 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751673AbYJTNWt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2008 09:22:49 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 1701E18163C;
	Mon, 20 Oct 2008 09:22:48 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 20 Oct 2008 09:22:48 -0400
X-Sasl-enc: wVY9SUiHOkGXWN128EvcWlVVlINHAoZNs56x3TwLR3Fk 1224508967
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 19E4C1B7E6;
	Mon, 20 Oct 2008 09:22:46 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <48F8ECA2.3040208@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98684>

Marc Branchaud venit, vidit, dixit 17.10.2008 21:50:
> Michael J Gruber wrote:
>> "pull -s strategy repo master" does a fetch followed by "merge -s
>> strategy repomaster", where repomaster is the ref for master on repo.
>> So, if you got that branch (repomaster=ThingOne/master) by cloning from
>> main you can do the merge (subtree or other) on your clone, even without
>> the remote repo config for ThingOne on clone.
> 
> I'm afraid I'm having trouble translating what you're saying into actual 
> git commands (or are you proposing some new git functionality?).  How 
> would I get the ThingOne/master branch into the clone?

Sorry for being cryptic. What I meant was: The clones don't need the
full remote config of main in order to get main's remote branches for
the ThingOne remote. Say, main stores the remote tracking branches for
ThingOne in "refs/remotes/ThingOne", using an appropriate remote config.
Then a clone could use the refspec
"refs/remotes/ThingOne/*:refs/remotes/ThingOne/*" (when fetching from
main) in order to fetch those branches, without having a remote config
for ThingOne on the clone. Concretely:

git config remote.main.fetch
'+refs/remotes/ThingOne/*:refs/remotes/ThingOne/*'

on a clone which has a remote config "main" for the main repo.

> After some more thought I realized that the clone can just pull directly 
> from the ThingOne repository:
> 
> clone/$ git pull -s subtree git://thing/ThingOne.git master

I thought that's what you were trying to avoid...

> (I'm still getting used to git's ability to match commit IDs from 
> anywhere -- it's magic! :) )

... but this explains everything ;)

> This goes a long way to where we want to be, in that we don't have to do 
> our merging work in the original main repository.
> 
> It would be nice, though, if the clone were able to use the main 
> repository's definition of the ThingOne remote.  I can think of some 
> plausible scenarios where a person could get confused about which 
> repo/branch they're supposed to pull.  It's easy to recover from that 
> kind of mistake, but there'd be less chance of a mistake if one could 
> tell git to "pull from X as defined in the origin repository".

I think the approach I outlined above could solve this: main prepares
everything to be pulled under refs/remotes/ThingOne, and clones (i.e.
clone users) are told to fetch with a refspec like above. This way they
get a copy of main's remote tracking branches for ThingOne. (Maybe you
use one branch only, then the refspec is even simpler.)

> And actually, git's remote functionality feels a bit crippled if clones 
> can't make some use of the origin's remotes.  Is there a reason for 
> keeping remote definitions out of a clone?

Say A and B are working on a project C. Then, typically, A is interested
in B's work on C, i.e. some of B's local branches, but not on B's remote
 tracking branches: A tracks a "central" C already, just like B does,
and remote tracking branches don't carry any "value adding" by the
cloner, they're just a local unmodified copy of the remote.

But you can always add a refspec like above.

Michael
