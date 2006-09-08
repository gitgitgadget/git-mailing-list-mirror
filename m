From: linux@horizon.com
Subject: Re: Change set based shallow clone
Date: 8 Sep 2006 14:42:15 -0400
Message-ID: <20060908184215.31789.qmail@science.horizon.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 20:42:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLlJ2-0005WI-St
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 20:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWIHSmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 14:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWIHSmV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 14:42:21 -0400
Received: from science.horizon.com ([192.35.100.1]:9800 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750726AbWIHSmT
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 14:42:19 -0400
Received: (qmail 31790 invoked by uid 1000); 8 Sep 2006 14:42:15 -0400
To: jonsmirl@gmail.com, linux@horizon.com
In-Reply-To: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26703>

Thanks for making suggestions.  It's easier to knock straw men down
than make them.  But forgive me if I have fun pointing out the holes...

>> Okay.  Now, the server hasn't heard of one or more of those commit
>> objects, because they're local changes.  What then?
>
> Toss them, if they don't exist on the server the server is going to be
> able to send any objects for them.

Er... that makes "git pull git://git.other-hacker.personal/dir"
impossible.  There's a reason that git can handle this as it presently
exists: 
                  a-b-c-d-e-f <-- HEAD
                 /
Hacker 1: o-o-o-o <-- origin

Hacker 2: o-o-o-o-o-o <-- origin
                     \
                      v-w-x-y <-- HEAD

Suppose hacker 2, who happened to sync with upstream more recently,
wants to pull from hacker 1, in the hopes of building

                  a-b-c-d-e-f
                 /           \
Hacker 2: o-o-o-o-o-o         z <-- HEAD
                     \       /
                      v-w-x-y

This works now, and should continue to work.

> Client would track this incrementally  and not recompute it each time.

Yes, this is probably possible.  I haven't worked it out, but given a
cache of precomputed (commit,depth) numbers, you can trace back from the
new heads until you hit a cache entry.

> If you follow the links in what looks to be a dangling object sooner
> or latter you will run into the root object or a 'not present' object.
> If you hit one of those the objects are not dangling and should be
> preserved.

I don't understand.  It seems like you're saying that any commit without an
ancestor, and all objects recursively pointing to it, are not garbage.
How would anything ever get declared garbage in this case?

> Here is another way to look at the shallow clone problem. The only
> public ids in a git tree are the head and tag pointers. Send these to
> the client. Now let's modify the git tools to fault the full objects
> in one by one from the server whenever a git operation needs the
> object.  Dangling references would point to 'not-present' objects.

Er... that would fault in a gigabyte the first time someone ran gitk,
or several other history-browsing commands.  Don't you need a way to say
"tell the user this isn't present and will take an hour to download"?


Well, thinking, there are actually two shallow clone possibilities:
1) Don't load the unwanted commit objects
2) Clone the commit objects, but not their trees.

The latter would let you browse the commit history, at least.
