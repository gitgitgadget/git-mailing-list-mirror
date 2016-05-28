From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
Date: Sat, 28 May 2016 10:29:11 +0200
Message-ID: <87shx2oaaw.fsf@fencepost.gnu.org>
References: <1464356141-3797-1-git-send-email-dak@gnu.org>
	<alpine.DEB.2.20.1605271633230.4449@virtualbox>
	<87d1o7pkyy.fsf@fencepost.gnu.org>
	<alpine.DEB.2.20.1605280815040.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 28 10:30:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Ze5-00034x-IH
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 10:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbcE1Iaf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2016 04:30:35 -0400
Received: from eggs.gnu.org ([208.118.235.92]:43940 "EHLO eggs.gnu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbcE1Iab convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2016 04:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6Zdb-00059B-Vj
	for git@vger.kernel.org; Sat, 28 May 2016 04:30:29 -0400
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on eggs.gnu.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_50,RP_MATCHES_RCVD
	autolearn=disabled version=3.3.2
Received: from fencepost.gnu.org ([2001:4830:134:3::e]:36815 helo=lola.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6ZdT-00057j-Rq; Sat, 28 May 2016 04:30:20 -0400
Received: by lola.localdomain (Postfix, from userid 1000)
	id 7AA66E248E; Sat, 28 May 2016 10:29:11 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.20.1605280815040.4449@virtualbox> (Johannes
	Schindelin's message of "Sat, 28 May 2016 08:37:14 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4830:134:3::e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295807>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 27 May 2016, David Kastrup wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>=20
>> > On Fri, 27 May 2016, David Kastrup wrote:
>> >
>> >> pressure particularly when the history contains lots of merges fr=
om
>> >> long-diverged branches.  In practice, this optimization appears t=
o
>> >> behave quite benignly,
>> >
>> > Why not just stop here?
>>=20
>> Because there is a caveat.
>>=20
>> > I say that because...
>> >
>> >> and a viable strategy for limiting the total amount of cached blo=
bs in a
>> >> useful manner seems rather hard to implement.
>> >
>> > ... this sounds awfully handwaving.
>>=20
>> Because it is.
>
> Hrm. Are you really happy with this, on public record?

Shrug.  git-blame has limits for its memory usage which it generally
heeds, throwing away potentially useful data to do so.  git-blame -C ha=
s
a store of data retained outside of those limits because nobody bothere=
d
reining them in, and this patch similarly retains data outside of those
limits, though strictly limited to the pending priority queue size whic=
h
controls the descent in reverse commit time order.

In actual measurements on actual heavy-duty repositories I could not
discern a difference in memory usage after the patch.  The difference i=
s
likely only noticeable when you have lots of old long branches which is
not a typical development model.

The current data structures don't make harder constraints on memory
pressure feasible, and enforcing such constraints would incur a lot of
swapping (not by the operating system which does it more efficiently
particularly since it does not need to decompress every time, but by th=
e
application constantly rereading and recompressing data).

git-blame -C cares jack-shit about that (and it's used by git-gui's
second pass if I remember correctly) and nobody raised concerns about
its memory usage ever.

I've taken out a lot of hand-waving of the "eh, good enough" kind from
git-blame.  If one wanted to have the memory limits enforced more
stringently than they currently are, one would need a whole new layer o=
f
=46IFO and accounting.  This is not done in the current code base for
existing functionality.

And nobody bothered implementing it in decades or complaining about it
in spite of it affecting git-blame -C (and consequently git-gui blame).

Yes, this patch is another hand waving beside an already waving crowd.
I am not going to lie about it but I am also not going to invest the
time to fix yet another part of git-blame that has in decades not shown
to be a problem anybody considered worth reporting let alone fixing.

The limits for git-blame are set quite conservative: on actual develope=
r
systems, exceeding them by a factor of 10 will not exhaust the availabl=
e
memory.  And I could not even measure a difference in memory usage in a
small sample set of large examples.

That's good enough for me (and better than the shape most of git-blame
was in before I started on it and also after I finished), but it's stil=
l
hand-waving.  And it's not like it doesn't have a lot of company.

>> > Since we already have reference counting, it sounds fishy to claim
>> > that simply piggybacking a global counter on top of it would be
>> > "rather hard".
>>=20
>> You'll see that the patch is from 2014.
>
> No I do not. There was no indication of that.

I thought that git-send-email/git-am retained most patch metadata as
opposed to git-patch, but you are entirely correct that the author date
is nowhere to be found.  Sorry for the presumption.

>> When I actively worked on it, I=A0found no convincing/feasible way t=
o
>> enforce a reasonable hard limit.  I am not picking up work on this
>> again but am merely flushing my queue so that the patch going to
>> waste is not on my conscience.
>
> Hmm. Speaking from my point of view as a maintainer, this raises a
> yellow alert. Sure, I do not maintain git.git, but if I were, I would
> want my confidence in the quality of this patch, and in the patch
> author being around when things go south with it, strengthened. This
> paragraph achieves the opposite.

It's completely reasonable to apply the same standards here as with an
author having terminal cancer.  I am not going to be around when things
go South with git-blame but I should be very much surprised if this
patch were significantly involved.

>> > Besides, -C is *supposed* to look harder.
>>=20
>> We are not talking about "looking harder" but "taking more memory
>> than the set limit".
>
> I meant to say: *of course* it uses more memory, it has a much harder
> job.

Still a non-sequitur.  If you apply memory limits harder, it will still
achieve the same job but finish later due to (decompressing) swapping.

>> > Also: is there an easy way to reproduce your claims of better I/O
>> > characteristics? Something like a command-line, ideally with a fil=
e
>> > in git.git's own history, that demonstrates the I/O before and
>> > after the patch, would be an excellent addition to the commit
>> > message.
>>=20
>> I've used it on the wortliste repository and system time goes down
>> from about 70 seconds to 50 seconds (this is a flash drive).  User
>> time from about 4:20 to 4:00.  It is a rather degenerate repository
>> (predominantly small changes in one humongous text file) so savings
>> for more typical cases might end up less than that.  But then it is
>> degenerate repositories that are most costly to blame.
>
> Well, obviously I did not mean to measure time, but I/O.

System time on a SSD is highly correlated with I/O for this task.
Actually, so is system time on a hard drive, it just takes more real
time (waiting for I/O to complete) then as well.

>> > Further: I would have at least expected some rudimentary discussio=
n
>> > why this patch -- which seems to at least partially contradict
>> > 7c3c796 (blame: drop blob data after passing blame to the parent,
>> > 2007-12-11) -- is not regressing on the intent of said commit.
>>=20
>> It is regressing on the intent of said commit by _retaining_ blob
>> data that it is _sure_ to look at again because of already having
>> this data asked for again in the priority queue.  That's the point.
>> It only drops the blob data for which it has no request queued yet.
>> But there is no handle on when the request is going to pop up until
>> it actually leaves the priority queue: the priority queue is a heap
>> IIRC and thus only provides partial orderings.
>
> Again, this lowers my confidence in the patch. Mind you, the patch
> could be totally sound! Yet its commit message, and unfortunately eve=
n
> more so the discussion we are having right now, offer no adequate
> reason to assume that. If you, as the patch author, state that you ar=
e
> not sure what this thing does exactly,

Uh, I very definitely know what this thing does exactly.  I never state=
d
otherwise.

> we must conservatively assume that it contains flaws.

It has consequences without a theoretical hard limit on memory usage bu=
t
where every additional retained blob will provably be needed.

Basically, you don't want to apply this patch because I know what I'm
doing and documenting it and the underlying rationale without
sugar-coating.

That's perfectly fine with me.  It matches my expectations and
experience.

>> >> diff --git a/builtin/blame.c b/builtin/blame.c
>> >> index 21f42b0..2596fbc 100644
>> >> --- a/builtin/blame.c
>> >> +++ b/builtin/blame.c
>> >> @@ -1556,7 +1556,8 @@ finish:
>> >>  	}
>> >>  	for (i =3D 0; i < num_sg; i++) {
>> >>  		if (sg_origin[i]) {
>> >> -			drop_origin_blob(sg_origin[i]);
>> >> +			if (!sg_origin[i]->suspects)
>> >> +				drop_origin_blob(sg_origin[i]);
>> >>  			origin_decref(sg_origin[i]);
>> >>  		}
>> >
>> > It would be good to mention in the commit message that this patch =
does not
>> > change anything for blobs with only one remaining reference (the c=
urrent
>> > one) because origin_decref() would do the same job as drop_origin_=
blob
>> > when decrementing the reference counter to 0.
>>=20
>> A sizable number of references but not blobs are retained and needed=
 for
>> producing the information in the final printed output (at least when
>> using the default sequential output instead of --incremental or
>> --porcelaine or similar).
>
> Sorry, please help me understand how that response relates to my
> suggestion to improve the commit message.

Blobs and origins don't have separate reference counts.  This patch has
the same effect as maintaining such separate counts explicitly.  Since
the majority of commits lead to some lines in the current source (apart
from commits being weeded out by later refactoring/reimplementation),
this means that the majority of origins never reach a reference count o=
f
0 before the end of the run.

>> > In fact, I suspect that simply removing the drop_origin_blob() cal=
l
>> > might result in the exact same I/O pattern.
>>=20
>> It's been years since I actually worked on the code but I'm still
>> pretty sure you are wrong.
>
> The short version of your answer is that you will leave this patch in
> its current form and address none of my concerns because you moved on=
,
> correct? If so, that's totally okay, it just needs to be spelled out.

Yes, that's it.  You'll notice that the code change itself is both
minuscule as well purely functional, so it contains nothing
copyrightable.  I'm perfectly fine with anybody else writing whatever
commit message he wants based on whatever additional testing he wants
and claiming whole credit for what indeed amounts to being the actually
hard work, given the Git maintainership which is dependent on judging
quality by how a patch author advertises his code when the author is no=
t
a frequent contributor.  I've not authored more than a dozen or two
patches spread out over more of a decade.  If you do git-blame on them,
I doubt you'll find any that ever caused problems or that called for
refactoring/replacement.

Nevertheless, I clearly am not a regular and different standards apply.
I'm fine with that.  It's off my lawn, my responsibility, and my
conscience.

--=20
David Kastrup
