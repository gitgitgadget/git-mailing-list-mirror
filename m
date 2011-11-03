From: Shawn Pearce <spearce@spearce.org>
Subject: Re: New Feature wanted: Is it possible to let git clone continue last
 break point?
Date: Wed, 2 Nov 2011 21:19:03 -0700
Message-ID: <CAJo=hJt2kU10r5rq23qgimtW8dmzu-N92vjO_hNBbVVsKSpDmg@mail.gmail.com>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
 <20111031090717.GA24978@elie.hsd1.il.comcast.net> <20111102220614.GB14108@sigill.intra.peff.net>
 <7vwrbigna7.fsf@alter.siamese.dyndns.org> <20111102232735.GA17466@sigill.intra.peff.net>
 <CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com> <20111103024248.GA9492@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 03 05:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLoo3-0007PY-0O
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 05:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab1KCET0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 00:19:26 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53935 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab1KCETZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 00:19:25 -0400
Received: by gyb13 with SMTP id 13so902903gyb.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 21:19:24 -0700 (PDT)
Received: by 10.236.176.201 with SMTP id b49mr10931127yhm.120.1320293964126;
 Wed, 02 Nov 2011 21:19:24 -0700 (PDT)
Received: by 10.147.167.9 with HTTP; Wed, 2 Nov 2011 21:19:03 -0700 (PDT)
In-Reply-To: <20111103024248.GA9492@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184705>

On Wed, Nov 2, 2011 at 19:42, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 02, 2011 at 05:06:53PM -0700, Shawn O. Pearce wrote:
>
> I thought of doing something like that, but I wanted to be able to ma=
ke
> cross-domain links. The "302 to a CDN" thing is a clever hack, but it
> requires more control of the webserver than some users might have. An=
d
> of course it doesn't work for the "redirect to git:// on a different
> server" trick. Or redirect from "git://".

I agree. Later I said I regret this being a bundle file. I also regret
it being this $URL/clone.bundle thing. Its a reasonable quick hack in
Python for repo. Its cheap for my servers to respond 404 Not Found or
302 Found, and cheap to use the CDN. But it isn't the right solution
for git-core.

It has given us some useful information already in the context of
android.googlesource.com. It appears to work quite well for
distributing the large Android operating system. So the notion of
making packs available from another URL than the main repository, and
doing it as primarily a pack and not the native Git protocol, with a
follow-up incremental fetch to bring the client current seems to work.
 :-)

> My thought of having it in "refs/mirrors" is only slightly less hacky=
,
> but I think covers all of those cases. :)

Right, but this would have been a bit more work for me to code in Pytho=
n. :-)

Long term this may be a better approach, because it does allow the
user to control the redirect without having full control over their
HTTP server. It also supports redirections across protocols like you
noted above. So its probably the direction we will see git-core take.

>> Actually, I really think the bundle thing is wasteful.... sendfile()=
 capability.
>
> I didn't quite parse this. You say it is wasteful, but then indicate
> that it can use sendfile(), which is a good thing.

Apparently I was babbling. Based on what else you say, we agree. That
is good enough for me.

> However, I do agree with this:
>
>> Its also expensive for kernel.org to create each Git repository twic=
e
>> on disk. The disk is cheap. Its the kernel buffer cache that is damn=
ed
>> expensive.
>
> Doubling the disk cache required is evil and ugly. I was hoping it
> wouldn't matter because the bundle would be hosted on some far-away C=
DN
> server anyway, though. But that is highly dependent on your setup. An=
d
> it's really just glossing over the fact that you have twice as many
> servers. ;)

Right. :-)

In my opinion this is the important part. We shouldn't double the disk
usage required to support this. Most users can't afford the extra disk
cache or the extra server required to make this work well. But they
can use sendfile() on the server they have and get a lot of
improvement in clone speed due to lower system load, plus resumable
clone for the relatively stable history part.

> Another issue with packs is that they generally aren't supposed to be
> --thin on disk, whereas bundles can be. So I could point you to a
> succession of bundles. Which is maybe a feature, or maybe just makes
> things insanely complex[1].

Actually we can store --thin on disk safely.  Don't laugh until you
finish reading it through.

To build an incremental pack we modify pack-objects to construct a
completed thin pack on disk. Build up the list of objects that you
want in the thin pack, as though it were thin. Use REF_DELTA format to
reference objects that are not in this set but are delta bases. Copy
the necessary delta bases from the base pack over to the thin pack, at
the end just like it would be if received over the wire. The pack is
now self-contained like its supposed to be, but the tail of it is
redundant information.

If you cache alongside of the pack the "thin" object count, the cut
offset of the thin vs. completed bases, and the SHA-1 of the "thin"
pack, you can serve the "thin" pack by copying the header, then the
region of the file up to the cut point, and the final SHA-1. And there
are no pack file format changes involved.

:-)

Obviously this has some downside. Using REF_DELTA instead of OFS_DELTA
for the relatively small number of references from the "thin" part to
the completed part at the tail isn't a big disk space overhead. The
big overhead is storing the boundary data that served as delta bases
at the tail of this incremental pack. But we already do that when you
transfer this section of data over the network and it was more than
100 objects.

So I think we can get away with doing this. The serving repository is
in no worse state than if the owner had just pushed all of that
incremental stuff into the serving repository and it completed as a
thin pack. With only 2 packs in the serving repository (e.g. the
historical stuff that is stable, and the incremental current thin pack
+ completed bases), git gc --auto wouldn't even kick in to GC this
thing for a while *anyway*. So we already probably have a ton of
repositories in the wild that exhibit this disk layout and space
usage, and nobody has complained about it.

=46or a server admin or repository owner who cares about his user's
resumable clone support, carrying around a historical pack and a
single new incremental pack for say 2-3 months before repacking the
entire thing down to 1 new historical pack... the disk space and
additional completed base data is an acceptable cost. We already do
it.

Clients can figure out whether or not they should use an incremental
pack download vs the native Git protocol if the incremental pack does
like a bundle does and stores the base information alongside of it.
Actually you don't want the base (the ^ lines in a bundle), but the
immediate child of those. If the client has any of those children,
there is some chance the client has other objects in the pack and
should favor native protocol. But if the client has none of those base
children, but does have the base, it may be more efficient to download
the entire pack to bring the client current.

The problem with incremental pack updates is balancing the number of
round-trip requests against the update rate of the repository against
the polling frequency of the client. Its not an easy thing to solve.

However, we may be able to do better if the server can do a reasonably
fast concat of these thin pack slices together by writing a new object
header and computing the SHA-1 trailer as it goes. Instead of
computing actual graph connectivity, just concat packs together
between the base children and the requested tips. This probably
requires that the client ask for every branch (e.g. the typical
refs/heads/*:refs/remotes/origin/* refspec) and that branches didn't
rewind. But I think this is so common its perhaps worthwhile to look
into optimizing. But note we can do this in the native protocol at the
server side without telling the client anything, or changing the
protocol. It just isn't resumable without a bit more glue to have a
state marker available to the client. Nor does it work on a CDN
without giving the client more information. :-)

> So the sendfile() stuff would always happen over http.

I'm OK with that. I was just saying we may be able to also support
sendfile() over git:// if the repository owner / git-daemon owner
wants us to. Or if not sendfile(), a simple read-write loop that
doesn't have to look at the data, since the client will validate it
all.

> Yeah, I'm liking that idea. In reference to my [1] above, what I've
> started with is making:
>
> =A0git fetch http://host/foo.bundle

This should work, whether or not we use it for resumable clone. Its
just nice to have that tiny bit of extra glue to make it easy to pull
a bundle. So I'd like this too. :-)

> Pulling down a non-thin packfile makes the problem go away. We can sp=
ool
> it right into objects/pack, index it on the fly, and if all is well,
> move it into its final filename. If the transfer is interrupted, you
> drop what's been indexed so far, finish the transfer, and then re-sta=
rt
> the indexing from scratch (actually, the "on the fly" would probably
> involve teaching index-pack to be clever about incrementally reading =
a
> partially written file, but it should be possible).

I wonder if we can teach index-pack to work with a thin pack on disk
and complete that by appending to the file, in addition to the
streaming from stdin it supports. Seems like that should be possible.
So then you could save a thin pack to a temp file on disk, and thus
could split a bundle header from its pack content, saving them into
two different temp files, allowing index-pack to avoid copying the
pack portion if its non-thin, or if its a huge thin pack.

I did think about doing this in "repo" and decided it was complex, and
not worth the effort. So we spool. 2G+ bundles. Its not the most
pleasant user experience. If I had more time, I would have tried to
split the bundle header from the pack and written the pack directly
off for index-pack to read from disk.
