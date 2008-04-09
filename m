From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Tue, 08 Apr 2008 21:39:01 -0700
Message-ID: <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; delsp=yes; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 06:40:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjS6a-0004nC-Ao
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 06:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbYDIEjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 00:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbYDIEjb
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 00:39:31 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:52849 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYDIEjb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 00:39:31 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m394dUhO024509
	for <git@vger.kernel.org>; Tue, 8 Apr 2008 21:39:30 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZ100B01JKAAR00@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Tue, 08 Apr 2008 21:39:30 -0700 (PDT)
Received: from [192.168.0.102]
 (c-76-21-110-21.hsd1.ca.comcast.net [76.21.110.21])
 by fe-sfbay-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb
 28 2007)) with ESMTPSA id <0JZ100HNXJLU4M40@fe-sfbay-09.sun.com>; Tue,
 08 Apr 2008 21:39:30 -0700 (PDT)
In-reply-to: <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79071>

On Apr 8, 2008, at 8:33 PM, Avery Pennarun wrote:

> On Tue, Apr 8, 2008 at 11:03 PM, Roman Shaposhnik <rvs@sun.com> wrote:
>> On Apr 8, 2008, at 2:01 PM, Avery Pennarun wrote:
>>> The way to understand git-submodule's operation is in terms of  
>>> what it
>>> actually does.  Roughly speaking, git-submodule-add puts things into
>>> .gitmodules and .git/config;
>>
>> I could be mistaken, but I don't think "git submodule add" does  
>> anything
>> to the .git/config. In fact, how settings migrate between .gitmodules
>> and .git/config has been a long standing source of slight confusion
>> for me.
>>
>> Please correct me if I'm wrong, but it seems that the only reason
>> for the file .gitmodules to be there at all is because it can be
>> revved through commits, just as any file under Git's control.
>> .git/config doesn't have such a property. Other than that, it is not
>> really needed, right?
>
> You have the last paragraph right, but I think the first paragraph  
> wrong :)

Well, may be we are talking about slightly different things, or   
there's a version mismatch,
but here's what I get with 1.5.4.5:
    $ git init
    $ git submodule add /tmp/GIT/1
    Initialized empty Git repository in /tmp/GIT/3/1/.git/
     $ cat .git/config
     [core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
Now, .gitmodules is there alright, so if I do:
     $ git submodule init
I get the migration of settings to .git/config:
      $ cat .git/config
      [core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
      [submodule "1"]
	url = /tmp/GIT/1/.git

>> Speaking of complications, it took me awhile to realize that 90%
>> of the Submodule magic seems to be based on the secret ability of
>> tree objects to hold references not only to blobs and trees but
>> also to *commits*:
>
> Indeed, this is the majority of the coolness right there.  The rest of
> the screwiness with .gitmodules and so on is really just to support
> fetching the objects for the submodules from repos than the primary
> supermodule one.

Yeap. It all reminds me a bit of symbolic links in file systems. With  
the
key difference being that symbolic links can only point to an object,
where we can actually reference a particular *state* of that object.

I like this ability very much. It comes especially handy when a single
component participates in multiple superprojects (being referenced
as a submodule) and every single one of them can reference a state
of the component that they like.

That said, I still can't quite figure out how to do a very basic thing:
how can I change the SHA1 that a tree objects refers to without
checking out a corresponding submodule first? IOW, suppose I've
just cloned ~/Superproject into /tmp/super-clone. All of the submodules
are still empty (nothing has been cheked out into them yet) and all
I want to do is to bump the version of one submodule
     /tmp/super-clone/foo
and then push the changes back to the ~/Superproject, so that everybody
who pulls from it get the newer foo. It seems that the procedure  
outlined
in Git's manual seems to be pretty heavyweight for such a simple thing.

>> That's exactly what makes me doubtful about .gitmodules being the
>> best place for storing the url, but then again, I don't have any
>> better ideas. :-( Yet ;-)
>
> There's definitely no better place; .git/config isn't versioned, and
> URLs don't belong in the tree objects themselves, which are otherwise
> location-neutral and transport-neutral.

Agreed. But I guess I'd be less confused if "git submodule" didn't muck
with .git/config at all. Or are there any other consumers of the  
information
that it puts there (except itself)?

> In my own use case, I think having all the objects from the
> supermodule *and* submodules all be in the same repo is what I want.
> This kind of obviates the need for .gitmodules entirely, if
> git-checkout and friends will do the right thing.  I think I'll submit
> some patches eventually once I have this figured out properly.

Hm. But what about those who might want to pull from you? .git/config
doesn't propagate, which means that they'll be kind of stuck, don't
you think?

Thanks,
Roman.
