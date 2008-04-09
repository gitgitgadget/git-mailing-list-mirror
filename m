From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Tue, 08 Apr 2008 20:03:58 -0700
Message-ID: <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 05:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjQur-00062T-No
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 05:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYDIDXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 23:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYDIDXD
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 23:23:03 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:51428 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbYDIDXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 23:23:01 -0400
X-Greylist: delayed 1139 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Apr 2008 23:23:00 EDT
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m39340kZ021477
	for <git@vger.kernel.org>; Tue, 8 Apr 2008 20:04:01 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZ100J01F6G2K00@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Tue, 08 Apr 2008 20:04:00 -0700 (PDT)
Received: from [172.17.85.232] ([38.99.84.36])
 by fe-sfbay-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb
 28 2007)) with ESMTPSA id <0JZ100HDKF6N4M40@fe-sfbay-09.sun.com>; Tue,
 08 Apr 2008 20:04:00 -0700 (PDT)
In-reply-to: <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79067>

On Apr 8, 2008, at 2:01 PM, Avery Pennarun wrote:
> The way to understand git-submodule's operation is in terms of what it
> actually does.  Roughly speaking, git-submodule-add puts things into
> .gitmodules and .git/config;

I could be mistaken, but I don't think "git submodule add" does anything
to the .git/config. In fact, how settings migrate between .gitmodules
and .git/config has been a long standing source of slight confusion
for me.

Please correct me if I'm wrong, but it seems that the only reason
for the file .gitmodules to be there at all is because it can be
revved through commits, just as any file under Git's control.
.git/config doesn't have such a property. Other than that, it is not
really needed, right?

> In other words, git-submodule is very powerful, but also very
> complicated,

Speaking of complications, it took me awhile to realize that 90%
of the Submodule magic seems to be based on the secret ability of
tree objects to hold references not only to blobs and trees but
also to *commits*:
     $ git init
     $ mkdir foo ; cd foo
     $ git init
     $ touch file
     $ git add file
     $ git commit -mInit
     Created initial commit 5a61c46: Init
         0 files changed, 0 insertions(+), 0 deletions(-)
         create mode 100644 file
Now observe:
     $ cd ..
     $ git add foo
     $ git ls-files --stage
     160000 5a61c4698ca56004c2532ce02e6736cfd2e977d1 0	foo
The  '5a61c46' is simply a reference to the commit we've just created.
Of course, it is  insufficient to know what commit "foo" refers
to unless we also know what Git repo this commit resides in. And that's
where the mapping between a path ("foo") and  a url pointing to
the submodule comes into play.

This is a cool property and it lets you build functionality like
"git submodules" in a variety of different ways. I just wish it
was documented somewhere.

> Anyway, in this case, what you need to know is that .git/config
> already contains your submodule information.  Sadly, .gitmodules is
> probably sitting somewhere on your original branch, so it probably
> doesn't exist.  You could remove the entry from .git/config by hand
> and use git-submodule-add again (thus putting it in both places), or
> copy the .gitmodules file from the original branch, or git-cherry-pick
> the commit where you added it.

That's exactly what makes me doubtful about .gitmodules being the
best place for storing the url, but then again, I don't have any
better ideas. :-( Yet ;-)

Thanks,
Roman.
