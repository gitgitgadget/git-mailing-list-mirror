From: Shawn Pearce <spearce@spearce.org>
Subject: Re: New Feature wanted: Is it possible to let git clone continue last
 break point?
Date: Wed, 2 Nov 2011 17:06:53 -0700
Message-ID: <CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
 <20111031090717.GA24978@elie.hsd1.il.comcast.net> <20111102220614.GB14108@sigill.intra.peff.net>
 <7vwrbigna7.fsf@alter.siamese.dyndns.org> <20111102232735.GA17466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 03 01:07:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLkq1-0003hi-Go
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 01:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab1KCAHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 20:07:16 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39458 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab1KCAHO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 20:07:14 -0400
Received: by ywf7 with SMTP id 7so704258ywf.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 17:07:14 -0700 (PDT)
Received: by 10.147.154.20 with SMTP id g20mr1638144yao.15.1320278834148; Wed,
 02 Nov 2011 17:07:14 -0700 (PDT)
Received: by 10.147.167.9 with HTTP; Wed, 2 Nov 2011 17:06:53 -0700 (PDT)
In-Reply-To: <20111102232735.GA17466@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184687>

On Wed, Nov 2, 2011 at 16:27, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 02, 2011 at 03:41:36PM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>
>> > Which is all a roundabout way of saying that the git protocol is r=
eally
>> > the sane way to do efficient transfers. An alternative, much simpl=
er
>> > scheme would be for the server to just say:
>> >
>> > =A0 - if you have nothing, then prime with URL http://host/bundle
>> >
>> > And then _only_ clone would bother with checking mirrors. People d=
oing
>> > fetch would be expected to do it often enough that not being resum=
able
>> > isn't a big deal.
>>
>> I think that is a sensible place to start.

Yup, I agree. The "repo" tool used by Android does this in Python
right now[1].  Its a simple hack, if the protocol is HTTP or HTTPS the
client first tries to download $URL/clone.bundle. My servers have
rules that trap on */clone.bundle and issue an HTTP 302 Found response
to direct the client to a CDN. Works. :-)

[1] http://code.google.com/p/git-repo/source/detail?r=3Df322b9abb4cadc6=
7b991baf6ba1b9f2fbd5d7812&name=3Dstable

> OK. That had been my original intent, but somebody (you?) mentioned t=
he
> "if you have X" thing at the GitTogether, which got me thinking.
>
> I don't mind starting slow, as long as we don't paint ourselves into =
a
> corner for future expansion. I'll try to design the data format for
> specifying the mirror locations with that extension in mind.

Right. Aside from the fact that $URL/clone.bundle is perhaps a bad way
to decide on the URL to actually fetch (and isn't supportable over
git:// or ssh://)... we should start with the clone case and worry
about incremental updates later.

> Even if the bundle thing ends up too wasteful, it may still be useful=
 to
> offer a "if you don't have X, go see Y" type of mirror when "Y" is
> something efficient, like git:// at a faster host (i.e., the "I built=
 3
> commits on top of Linus" case).

Actually, I really think the bundle thing is wasteful. Its a ton of
additional disk. Hosts like kernel.org want to use sendfile() when
possible to handle bulk transfers. git:// is not efficient for them
because we don't have sendfile() capability.

Its also expensive for kernel.org to create each Git repository twice
on disk. The disk is cheap. Its the kernel buffer cache that is damned
expensive. Assume for a minute that Linus' kernel repository is a
popular thing to access. If 400M of that history is available in a
normal pack file on disk, and again 400M is available as a "clone
bundle thingy", kernel.org now has to eat 800M of disk buffer cache
for that one Git repository, because both of those files are going to
be hot.

I think I messed up with "repo" using a Git bundle file as its data
source. What we should have done was a bog standard pack file. Then
the client can download the pack file into the .git/objects/pack
directory and just generate the index, reusing the entire dumb
protocol transport logic. It also allows the server to pass out the
same file the server retains for the repository itself, and thus makes
the disk buffer cache only 400M for Linus' repository.

> Agreed. I was really trying to avoid protocol extensions, though, at
> least for an initial version. I'd like to see how far we can get doin=
g
> the simplest thing.

One (maybe dumb idea I had) was making the $GIT_DIR/objects/info/packs
file contain other lines to list reference tips at the time the pack
was made. The client just needs the SHA-1s, it doesn't necessarily
need the branch names themselves. A client could initialize itself by
getting this set of references, creating temporary dummy references at
those SHA-1s, and downloading the corresponding pack file, indexing
it, then resuming with a normal fetch.

Then we wind up with a git:// or ssh:// protocol extension that
enables sendfile() on an entire pack, and to provide the matching
objects/info/packs data to help a client over git:// or ssh://
initialize off the existing pack files.


Obviously there is the existing security feature that over git:// or
ssh:// (or even smart HTTP), a deleted or rewound reference stops
exposing the content in the repository that isn't reachable from the
other reference tips. The repository owner / server administrator will
have to make a choice here, either the existing packs are not exposed
as available via sendfile() until after GC can be run to rebuild them
around the right content set, or they are exposed and the time to
expunge/hide an unreferenced object is expanded until the GC completes
(rather than being immediate after the reference updates).

But either way, I like the idea of coupling the "resumable pack
download" to the *existing* pack files, because this is easy to deal
with. If you do have a rewind/delete and need to expunge content,
users/administrators already know how to run `git gc --expire=3Dnow` to
accomplish a full erase. Adding another thing with bundle files
somewhere else that may or may not contain the data you want to erase
and remembering to clean that up is not a good idea.
