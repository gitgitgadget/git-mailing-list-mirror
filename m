From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Thu, 07 Sep 2006 22:30:51 -0700
Message-ID: <7vac5ancvo.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	<7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
	<46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jon Smirl" <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 07:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLYwz-00050V-9W
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 07:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbWIHFae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 01:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbWIHFae
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 01:30:34 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37760 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1752194AbWIHFad (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 01:30:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908053032.CUY21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 8 Sep 2006 01:30:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KhWP1V00S1kojtg0000000
	Fri, 08 Sep 2006 01:30:25 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 8 Sep 2006 15:54:11 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26676>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 9/8/06, Junio C Hamano <junkio@cox.net> wrote:
> ...
>> Anyway, it is a useful feature, an important operation, and
>> it involves a lot of thinking (and hard work, obviously).
>>
>> I will not think about this anymore, until I have absolutely
>> nothing else to do for a solid few days, but you probably
>> haven't read this far ;-).
>
> For when you come back, then. I agree this is rather complicated, so
> much so that I suspect that we may be barking up the wrong tree.
>
> People who want shallow clones are actually asking for a "light"
> clone, in terms of "how much do I need to download". If everyone has
> the whole commit chain (but may be missing olden blobs, and even
> trees), the problem becomes a lot easier.

No, I do not think so.  You are just pushing the same problem to
another layer.

Reachability through commit ancestry chain is no more special
than reachability through commit-tree or tree-containment
relationships.  The grafts mechanism happen to treat commit
ancestry more specially than others, but that is not inherent
property of git [*1*].  It is only an implementation detail (and
limitation -- grafts cannot express anything but commit
ancestry) of the current system.

But let's touch a slightly different but related topic first.
People do not ask for shallow clones.  They just want faster
transfer of "everything they care about".  Shallow and lazy
clones are implementation techniques to achieve the goal of
making everything they care about appear available, typically
taking advantage of the fact that people care about recent past
a lot more than they do about ancient history.

Shallow clones do so by explicitly saying "sorry you told me
earlier you do not care about things older than X so if you now
care about things older than X please do such and such to deepen
your history".  What you are saying is a variant of shallow that
says "NAK; commits I have but trees and blobs associated with
such an old commit you have to ask me to retrieve from
elsewhere".  Lazy clones do so by "faulting missing objects on
demand" [*2*].  That is essentially automating the "please do
such and such" part.  So they are all not that different.

Now, first and foremost, while I would love to have a system
that gracefully operates with a "sparse" repository that lacks
objects that should exist from tag/commit/tree/blob reachability
point of view, it is an absolute requirement that I can tell why
objects are missing from a repository when I find some are
missing by running fsck-objects [*3*].  If repository is a
shallow clone, not having some object may be expected, but I
want to be able to tell repository corruption locally even in
that case, so "assume lack of object is perhaps it was not
downloaded by shallow cloning" is an unacceptable attitude, and
"when you find an object missing from your repository, you can
ask the server [*4*], and if the server does not have it then
you know your repository is corrupt otherwise it is Ok" is a
wrong answer.

I talked about the need of upload-pack protocol extension to
exchange grafts information between uploader and downloader to
come up with the resulting graft and update the grafts in
downloaded repository after objects tranfer is done.  It is
needed because by having such cauterizing graft entries I can be
sure that the repository is not corrupt when fsck-objects that
does look at grafts says "nothing is missing".  Jon talked about
"fault-in on demand and leave stub objects until downloading the
real thing"; those stub objects are natural extension of grafts
facility but extends to trees and blobs.  Either of these would
allow me to validate the sparse repository locally.

Now I'll really shut up ;-).


[*1*] For example, rev-list --object knows that it needs to show
the tree-containment when given only a tree object without any commit.

[*2*] You probably could write a FUSE module that mount on
your .git/objects, respond to accesses to .git/objects/??
directory and files with 38-byte hexadecimal names under them by
talking to other repositories over the wire.  No, I am not going
to do it, and I will probably not touch it even with ten-foot
pole for reasons I state elsewhere in this message.

[*3*] The real fsck-objects always looks at grafts.  The
fictitious version of fsck-objects I am talking about here is
the one that uses parents recorded on the "parent " line of
commit objects, that is, the true object level reachability.

[*4*] In git, there is no inherent server vs client or upstream
vs downstream relationship between repositories.  You may be
even fetching from many people and do not have a set upstream at
all.  Or you are _the_ upstream, and your notebook has the
latest devevelopment history, and after pushing that latest
history to your mothership repository, you may decide you do not
want ancient development history on a puny notebook, and locally
cauterize the history on your notebook repository and prune
ancient stuff.  The objects missing from the notebook repository
are retrievable from your mothership repository again if/when
needed and you as the user would know that (and if you are lucky
you may even remember that a few months later), but git doesn't,
and there is no reason for git to want to know it.  If we want
to do "fault-in on demand", we need to add a way to say "it is
Ok for this repository to be incomplete -- objects that are
missing must be completed from that repository (or those
repositories)".  But that's quite a special case of having a
fixed upstream.
