From: Steven Grimm <koreth@midwinter.com>
Subject: Re: StGIT (or guilt) + git-svn?
Date: Wed, 25 Jul 2007 14:35:16 +0800
Message-ID: <46A6EF24.4040606@midwinter.com>
References: <46A5D279.7060601@midwinter.com> <20070724112706.GA9540@dervierte> <46A5EE4B.7020905@midwinter.com> <20070724234817.GA29700@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'git' <git@vger.kernel.org>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 08:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDaT1-0001k4-0Y
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 08:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbXGYGfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 02:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbXGYGfW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 02:35:22 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:40551
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1753652AbXGYGfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 02:35:21 -0400
Received: (qmail 29862 invoked from network); 25 Jul 2007 06:35:21 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=lekpO2atAY7yY8ETHQt2I2KBi57JU9THIthoLJY14B9/LF/8avgT0H2wV4eZCrBG  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 25 Jul 2007 06:35:21 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <20070724234817.GA29700@dervierte>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53667>

Steven Walter wrote:
> You certainly could do local versioning this way, but it isn't how I
> accomplish the same thing.  I keep another branch on top of my "public"
> svn commits for local stuff.  If I always run git-svn dcommit from the
> public branch, the local changes will stay local.  After committing, I
> just have to rebase the local branch on onto git-svn.

Do you mix your public and private commits on the private branch, then 
cherry-pick some of them over to the public branch before running 
dcommit? Or do you have some other workflow?

That was actually my first suggestion to him, but he pointed out (and I 
had to agree) that that would mean he's always just one mistake away 
from publishing his local changes. All it takes is getting interrupted 
for a moment and mistakenly thinking he already switched to the public 
branch. He wants some less human-error-prone way to tell the system that 
a particular change and/or a particular file is not intended for 
publication, and for the system to just honor that without further human 
intervention.

Actually, one could argue that the above isn't a git-svn issue at all. 
You could reasonably want the same thing from git-push too (and even 
from pull, though that'd be trickier.) I guess it'd take the form of 
marking a commit as local-only, and having the system automatically 
rebase all the local-only commits on top of the public ones.

Maybe a wrapper than maintains a pair of underlying git branches for 
each user-visible branch would work. If you have a branch "foo" with 
some public and some private changes (private ones in lower case here):

A---B---C---D---e---f---g   foo
            ^ foo-public

Now if you commit a new private revision, it's like normal:

A---B---C---D---e---f---g---h   foo
            ^ foo-public

But if you commit a new public revision, we do something like

git commit
git checkout foo-public
git cherry-pick foo
git checkout foo
git rebase foo-public

to get

A---B---C---D---H---e---f---g   foo
                ^ foo-public

Then, when it comes time to do the push / dcommit, we always switch to 
the foo-public branch first. We push / dcommit, then checkout foo and 
rebase it on foo-public again (since svn dcommit will leave foo-public 
pointing at a different revision.)

This seems like it should work in the context of git-svn with its 
mostly-linear history. Not sure if it'd fall flat on its face in the 
presence of lots of branching and merging.

I also suspect I've more or less just described StGIT and this would be 
a big waste of time to reinvent from scratch.

-Steve
