From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Pushing to GitHub doesn't push all branches
Date: Fri, 10 Jul 2009 17:51:57 +0200
Message-ID: <4A57639D.4020305@drmicha.warpmail.net>
References: <h37fga$5ie$1@ger.gmane.org> <4A575416.2090304@drmicha.warpmail.net> <h37lh2$q3s$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 17:53:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPIOe-0000hj-Vl
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 17:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZGJPwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 11:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbZGJPwQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 11:52:16 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43322 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753208AbZGJPwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 11:52:16 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id EC2363B0CAA;
	Fri, 10 Jul 2009 11:52:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 10 Jul 2009 11:52:14 -0400
X-Sasl-enc: kgF7ii1eV0qTnmODoY/Fyn9P7ZnCyz8G4OLyv06UTbDQ 1247241134
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5BAA351ED;
	Fri, 10 Jul 2009 11:52:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <h37lh2$q3s$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123059>

Graeme Geldenhuys venit, vidit, dixit 10.07.2009 17:07:
> Michael J Gruber wrote:
>>
>> You really mirrored your repo: All your "lost" branches are remotes on
>> the github side as well. That has two consequences:
> 
> The two branches that are of most importance to me, is "trunk" and 
> "fixes_2_2" as found in the SubVersion repository.
> 
> refs/remotes/trunk
> refs/remotes/fixes_2_2
> 
> 
> So should I have only pushed the above mentioned branches, but as "true" 
> heads in GitHub. Geesh, I hope I am understanding what I am typing, 
> because I feel a bit lost now. :-)
> 
> Is there any way to clean up the mess available on GitGub? So that 'git 
> ls-remote ...' will only show the real remotes.... Or should there be no 
> remotes on GitHub?
> 
> Sorry, I'm fairly new to Git and it feels like I jumped into the deap 
> end here. ;-)
> 
>> (assuming there are only svn branches) into proper heads on github, i.e.
>> a refspec like '+refs/remotes/*:refs/*' for your pushes.
> 
> I'll read the man pages on what that refspec means...  If I manage to 
> only push 'trunk' which is master under git and 'fixes_2_2' which will 
> be some other name under git, how to I keep both those in sync with the 
> SubVersion repository.
> 
> At the moment I have a cronjob that executes the following every 30 minutes.
> ====================
> cd /mnt/samba/git/fpc.git/
> $GIT checkout master
> $GIT svn rebase
> $GIT gc --auto
> $GIT push origin master
> ====================
> 
> Does 'git svn rebase' get all branch or does it just update "master" 
> (Trunk from SubVersion)?
> 
> I apologise for all the questions...

Please don't! That's what we're here for ;)

A while ago I suggested that by default, no clone (whether git or
git-svn) should have a master branch. I guess your example shows why. If
you use that repo (/mnt/samba/git/fpc.git) only for converting from svn
to git, not for doing local work, then you don't need any master branch.
But git-svn will stubbornly recreate one.

Similarly (under the same assumption), you don't need to rebase at all.
All you need is "git svn fetch", which populates the branches under
remotes/.

You can safely delete the bogus remote branches on github using

git push origin :refs/remotes/trunk

etc., i.e.

git for-each-ref --shell --format="git push -f origin :%(refname)"
refs/remotes/|while read line; do eval $line;done

(all on one line)

Then it's probably beneficial to do something like

git config remote.origin.push '+refs/remotes/*:refs/heads/*'

so that you have a nice default refspec for origin. [You may think about
renaming origin to destination, though ;) ]

Cheers,
Michael
