From: Junio C Hamano <junkio@cox.net>
Subject: Re: FW: Git pulls failing on ia64 test tree?
Date: Wed, 14 Sep 2005 10:25:31 -0700
Message-ID: <7vk6hjlfxw.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F046279C5@scsmsx401.amr.corp.intel.com>
	<7vbr2vob6w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 19:27:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFb0q-0000hy-Oj
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 19:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVINRZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 13:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVINRZe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 13:25:34 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:25514 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030293AbVINRZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 13:25:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914172533.UVQT11315.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 13:25:33 -0400
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <7vbr2vob6w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 14 Sep 2005 09:39:51 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8542>

Junio C Hamano <junkio@cox.net> writes:

> "Luck, Tony" <tony.luck@intel.com> writes:
>
>> I've set up objects/info/alternates to point at linus' tree and deleted
>> all the packs from my tree.  The web view at kernel.org/git looks ok,
>> so I think those changes are ok.
>>
>> So what am I missing?
>
> Let me take a look at your tree on master while I'll try to pull
> from your public tree and see if I can reproduce.

Ah, you deleted packs from your repository, which I missed when
I first saw your message.

The objects/info/alternates mechanism is currently only known to
the git that operates on the machine that has the file -- client
side does not make use of that information.  That means only
git-daemon and 'git native protocol over ssh' (not the commit
walker ssh-fetch) can deal with such a repository right now,
because they run git on the side your repository is.  Gitweb
also obviously runs git on the machine a copy of repository is,
so you would not see problems.

The recommendation by Linus to "point him with alternate to
borrow his objects" is a sound one in the long term, but I think
it was a bit premature in practice -- the client side tools are
not ready for that yet.  From the original error report:

 > error: Could not read 9401c705f2a6a7e5df102f6443dba395c3c5e5a8
 > error: Could not read 357d596bd552ad157a906289ab13ea6ba7e66e3d
 > Updating from aa2dca4563b0629ecd9d9994dfdf39f29ff1b43f to 
6c141f61ee4f5fba63d9c54e03cb2faa6877bf1a.
 > fatal: failed to unpack tree object 6c141f61ee4f5fba63d9c54e03cb2faa6877bf1a
 > $

The first two "Could not read" are talking about objects only
found in Linus' repository -- your objects/ hierarchy does not
have them.  Rsync transport slurps everything under _your_
objects/ hierarchy [*1*] and does not know that your objects/
hierarchy is incomplete and needs to borrow from Linus' objects/
directory.  If the downloader has the objects found in Linus'
repository that is fine but otherwise he has problems.

As a workaround, please do this:

    cd /pub/scm/linux/kernel/git/aegl/linux-2.6.git/
    ln ../../torvalds/linux-2.6.git/objects/pack/* objects/pack/.
    mv objects/info/alternates objects/info/alternates+
    GIT_DIR=. git fetch ../../torvalds/linux-2.6.git/
    GIT_DIR=. git fsck-objects
    mv objects/info/alternates+ objects/info/alternates

The 'git fetch' step would complain about a couple of commits
you have but there is no need to worry -- we are deliberately
"corrupting" your repository by temporarily moving alternates
away so that it can fetch missing objects from Linus repository.
The fsck-objects should then report no missing objects.

Sorry for this very unpleasant experience git has caused you
X-<.

[Footnotes]

*1* BTW, I just spotted a bug there -- since we now have
objects/info subdirectory, we should exclude that when copying.

*2* Ideally I would have liked to do git-relink after 'git fetch'
from Linus repo in the above, but it does not seem to want to
relink a naked repository...  I should bug Ryan about it.
