From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 20:35:48 -0800
Message-ID: <AANLkTik01sVOKD+gW_BembUDN-LRbqJsPCCBBVyJJ11T@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home> <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home> <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 <alpine.LFD.2.00.1101282055190.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 29 05:41:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pj2cq-0000YC-Hz
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 05:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab1A2EgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 23:36:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37160 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab1A2EgK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 23:36:10 -0500
Received: by fxm20 with SMTP id 20so4045277fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 20:36:09 -0800 (PST)
Received: by 10.102.244.18 with SMTP id r18mr1847058muh.5.1296275768948; Fri,
 28 Jan 2011 20:36:08 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Fri, 28 Jan 2011 20:35:48 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101282055190.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165653>

On Fri, Jan 28, 2011 at 20:08, Nicolas Pitre <nico@fluxnic.net> wrote:
>> pack is actually smaller 376.30 MiB vs. C Git's 380.59 MiB. =A0I poi=
nt
>> out this data because improvements made to JGit may show similar
>> improvements to CGit given how close they are in running time.
>
> What are those improvements?

None right now.  JGit is similar to CGit algorithm-wise.  (Actually it
looks like JGit has a faster diff implementation, but that's a
different email.)

If you are asking about why JGit created a slightly smaller pack
file... it splits the delta window during threaded delta search
differently than CGit does, and we align our blocks slightly
differently when comparing two objects to generate a delta sequence
for them.  These two variations mean JGit produces different deltas
than CGit does.  Sometimes we are smaller, sometimes we are larger.
But its a small difference, on the order of 1-4 MiB for something like
linux-2.6.  I don't think its worthwhile trying to analyze the
specific differences in implementations and retrofit those differences
into the other one.

What I was trying to say was, _if_ we made a change to JGit and it
dropped the running time, that same change in CGit should have _at
least_ the same running time improvement, if not better.  I was
pointing out that this cached-pack change dropped the running time by
1 minute, so CGit should also see a similar improvement (if not
better).  I would prefer to test against CGit for this sort of thing,
but its been too long since I last poked pack-objects.c and the
revision code in CGit, while the JGit equivalents are really fresh in
my head.

> Now, the fact that JGit is so close to CGit must be because the actua=
l
> cost is outside of them such as within zlib, otherwise the C code sho=
uld
> normally always be faster, right?

Yup, I mostly agree with this statement.  CGit does a lot of
malloc/free activity when reading objects in.  JGit does too, but we
often fit into the young generation for the GC, which sometimes can be
faster to clean and recycle memory in.  We're not too far off from C
code.

But yes... our profile looks like this too:

> Looking at the profile for "git rev-list --objects --all > /dev/null"
> for the object enumeration phase, we have:
>
> # Samples: 1814637
> #
> # Overhead =A0 =A0 =A0 =A0 =A0Command =A0Shared Object =A0Symbol
> # ........ =A0............... =A0............. =A0......
> #
> =A0 =A028.81% =A0 =A0 =A0 =A0 =A0 =A0 =A0git =A0/home/nico/bin/git =A0=
[.] lookup_object
> =A0 =A012.21% =A0 =A0 =A0 =A0 =A0 =A0 =A0git =A0/lib64/libz.so.1.2.3 =
=A0[.] inflate
> =A0 =A010.49% =A0 =A0 =A0 =A0 =A0 =A0 =A0git =A0/lib64/libz.so.1.2.3 =
=A0[.] inflate_fast
> =A0 =A0 7.47% =A0 =A0 =A0 =A0 =A0 =A0 =A0git =A0/lib64/libz.so.1.2.3 =
=A0[.] inflate_table
> =A0 =A0 6.66% =A0 =A0 =A0 =A0 =A0 =A0 =A0git =A0/lib64/libc-2.11.2.so=
 =A0[.] __GI_memcpy
> =A0 =A0 5.66% =A0 =A0 =A0 =A0 =A0 =A0 =A0git =A0/home/nico/bin/git =A0=
[.] find_pack_entry_one
> =A0 =A0 2.98% =A0 =A0 =A0 =A0 =A0 =A0 =A0git =A0/home/nico/bin/git =A0=
[.] decode_tree_entry
> [...]
>
> So we've got lookup_object() clearly at the top.

Isn't this the hash table lookup inside the revision pool, to see if
the object has already been visited?  That seems horrible, 28% of the
CPU is going to probing that table.

> =A0I suspect the
> hashcmp() in there, which probably gets inlined, is responsible for m=
ost
> cycles.

Probably true.  I know our hashcmp() is inlined, its actually written
by hand as 5 word compares, and is marked final, so the JIT is rather
likely to inline it.

> =A0There is certainly a better way here, and probably in JGit you
> rely on some optimized facility provided by the language/library to
> perform that lookup. =A0So there is probably some easy improvements t=
hat
> can be made here.

Nope.  Actually we have to bend over backwards and work against the
language to get anything even reasonably sane for performance.  Our
"solution" in JGit has actually been used by Rob Pike to promote his
Go programming language and why Java sucks as a language.  Its a great
quote of mine that someone dragged up off the git@vger mailing list
and started using to promote Go.

At least once I week I envy how easy it is to use hashcmp() and
hashcpy() inside of CGit.  JGit's management of hashes is sh*t because
we have to bend so hard around the language.

> Otherwise it is at least 12.21 + 10.49 + 7.47 + 2.71 =3D 32.88% spent
> directly in the zlib code, making it the biggest cost.

Yea, that's what we have too, about 33% inside of zlib code... which
is the same implementation that CGit uses.

> =A0This is rather
> unavoidable unless the data structure is changed.

We already knew this from our pack v4 experiments years ago.

> =A0And pack v4 would
> probably move things such as find_pack_entry_one, decode_tree_entry,
> process_tree and tree_entry off the radar as well.

This is hard to do inside of CGit if I recall... but yes, changing the
way trees are handled would really improve things.

> The object writeout phase should pretty much be network bound.

Yes.

>> I fully implemented the reuse of a cached pack behind a thin pack id=
ea
>> I was trying to describe in this thread. =A0It saved 1m7s off the JG=
it
>> running time, but increased the data transfer by 25 MiB.
>
> Yeah... this sucks.

Very much.  :-(

But this is a fundamental issue with our incremental fetch support
anyway.  In this exact case if the client was at that 1 month old
commit, and fetched current master, he would pull 25 MiB of data.. but
only needed about 4-6 MiB worth of deltas if it was properly delta
compressed against the content we know he already has.  Our server
side optimization of only pushing the immediate "have" list of the
client into the delta search window limits how much we can compress
the data we are sending.  If we were willing to push more in on the
server side, we could shrink the incremental fetch more.  But that's a
CPU problem on the server.

--=20
Shawn.
