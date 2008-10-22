From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Working with remotes; cloning remote references
Date: Wed, 22 Oct 2008 16:59:58 +0200
Message-ID: <48FF3FEE.8020209@drmicha.warpmail.net>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 17:01:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsfDD-00041Y-1G
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 17:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbYJVPAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 11:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbYJVPAF
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 11:00:05 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50103 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753772AbYJVPAE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2008 11:00:04 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7F450182717;
	Wed, 22 Oct 2008 11:00:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 22 Oct 2008 11:00:02 -0400
X-Sasl-enc: fdHjxhTSzC7/b1d+70dD0R61zBW+CKvbmGyWPOHD8qto 1224687601
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6736420A0F;
	Wed, 22 Oct 2008 11:00:01 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <48FDF28A.9060606@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98874>

Marc Branchaud venit, vidit, dixit 10/21/08 17:17:
> I believe git lets you track the origin's _branches_ not the origin's 
> _remotes_.  I don't think --mirror does what I'm looking for, because 
> (side effects aside) it only deals with branches, not remotes.
> 
> I find myself getting confused, and I think it's because the files in 
> .git/refs/remotes/ are indeed tracking branches on remote repositories. 
>   So I think our conversation gets a bit circular because our ideas of a 
> "remote" differ.

Yes, I think there are multiple uses:

- a remote repository (referenced to by an URL)
- a remote config (as created by git remote add)
- a remote branch (a branch in your local repo which is a copy of a
branch in a remote repo; stored under refs/remotes, never to be modified
locally)
- a (remote) tracking branch (a local branch which is set up to pull
from a remote branch by default)

Only the first of these 4 is something resides "remotely". Of course,
"remote URL" could be a path on the local file system or even ".".

> "git remote add" does two things (maybe more?): It adds a [remote] 
> section to the .git/config file, and it adds a branch reference in 
> .git/refs/remotes/. 

Yes.

> I think what I'd like is for the clone to be able 
> to obtain both these things from the origin.  The reason I think it's 
> useful is that it would let the clone pull directly from the origin's 
> remote repositories, without having to directly specify the remote 
> repository's URL and branch name.
> 
> Fundamentally, I'm looking to do exactly
> 
> 	clone/$ git pull -s subtree /path/to/ThingOne master
> 
> i.e. pull stuff from one of main's remotes directly into the clone.  But 
> I want to replace the "/path/to/ThingOne master" part with something 
> that means "use whatever URL and branch name was defined in the origin 
> for this remote".
> 
> My questions are:  Am I right in thinking this is desirable? 

I've got the strong impression you desire it...

Seriously, it seems desirable in cases where the remote URL changes
frequently; say, because the upstream maintainer (maintainer of
ThingOne) gets hit by a bus frequently, or walks the wrong streets in LA
at the wrong time of the day. (I guess my seriousness ended with the
";".) Clones would follow those changes transparently then (if that
feature existed).

> Is there 
> already some way to do this? 

None that I know of.

> If not, is it something worth 
> implementing?  (I'm happy to roll up my own sleeves here...)

First you should decide whether it is worth for you. Comments on the
list tend to kick in once people see a proposed implementation. A viable
strategy could be, mimicking git submodule behaviour in part:

- Implement "git remote export reponame" which takes an existing remote
config from .git/config, writes it to .gitremotes and checks in (or
better: stages for commit) the file .gitremotes [you would use this on main]

- Implement "git remote import" which reads the file .gitremotes and
adds remote config to .git/config. [you would use this on clones]

- Change "git remote update" to take updates to .gitremotes into account
before doing its usual routine (perhaps based on a config with default
off, or a command line option, or better both)

Downside is that .gitremotes is tracked would show up as a file in the
repo, but I can't come up with a better way which is as simple as the
above. .gitremotes could be stored in a specially named branch, though.

> I hope that clarifies things.  Sorry for taking so long to get here!

Don't worry. I take partial blame ;)
And thanks for trying to match up your workflow with git.

Cheers,
Michael
