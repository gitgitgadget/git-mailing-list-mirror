From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Sat, 10 Aug 2013 14:12:46 +0530
Message-ID: <CALkWK0kpqyxTyai2Lue7=D4z0kvhxuxKdYSWekT22zUhRis0Og@mail.gmail.com>
References: <7v61vihg6k.fsf@alter.siamese.dyndns.org> <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org> <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org> <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net> <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
 <20130809221615.GA7160@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 10:44:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V84mK-0001hg-JE
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 10:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968455Ab3HJIng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 04:43:36 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:37465 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968451Ab3HJIn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 04:43:29 -0400
Received: by mail-bk0-f41.google.com with SMTP id na10so1327077bkb.0
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 01:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5M6iH7nqShc6OwYd10ltRAJOF4LeIbf/M5OCcMY5unM=;
        b=ePRu4Gm7UfOz1em3q+wjheu/mhpOuNCTBThJju3wSQFfYMoCEwB7ujzbZB5cZlhpLe
         61rfhiWNrRIxdojIsH98LvND50zhyifVYg8ZxcaWqgGyCELaw4lPV0y6hpOmoqosm65t
         1zDZCl7aalh/28jNP+s9sPL5s3ZNlZBKMtXZ8Rz8Z3LQ2F1VSvoTm77BWW09CsmU6Hka
         0aWRbVr3i5wqpvLSxBkFqb3bcTu57Ho38p40ONCG0peotPsOEji/4P/rO7dGK+UYfFui
         cN2cmXoZLqSXbzULxjrzgwsn2Sg180GRGrgJH+xc12YlWEzw11R7g03lKvb2pybP6pPR
         TquQ==
X-Received: by 10.204.202.207 with SMTP id ff15mr2611881bkb.155.1376124208085;
 Sat, 10 Aug 2013 01:43:28 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Sat, 10 Aug 2013 01:42:46 -0700 (PDT)
In-Reply-To: <20130809221615.GA7160@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232078>

Jeff King wrote:
> [...]

First off, thanks for the fabulous writeup. I hope more contributors
read this, and get interested in tackling the problems.

> You are missing a step in the preparation of the delta list. If we
> already have a delta on-disk, we will check whether it is usable and
> keep a note in the list (see check_object). Then when we
> prepare the list of objects to delta, it is omitted from the list (see
> prepare_pack).

Ah, prepare_pack() calls get_object_details(), which then calls
check_object(): reuse_delta is what I was looking for.

> That is why you may see a much smaller number objects in the progress
> eye candy for "Compressing objects..." than we are actually sending.

I see.

> As Junio mentioned, that is what "--thin" is about; the sender omits the
> base and the receiver adds it back in ("index-pack --fix-thin").

Yeah, I read about the --thin option. However, it's only for
network-packs (i.e --stdout; why?). Also, is it turned on by default?
The documentation says so, but I ran it and found that the value of
thin is 0 in builtin/push.c:316. What is going on?

> And if
> you think about it, that is likely where most of Martin's "317 packs
> turned into 8MB" space savings are coming from.

Thin packs have nothing to do with git-exproll per-se, but I think I
understand why pack generations work.

> The reason we do not store thin-packs on disk is that you
> run into problems with cycles in the delta graph (e.g., A deltas against
> B, which deltas against C, which deltas against A; at one point you had
> a full copy of one object which let you create the cycle, but you later
> deleted it as redundant with the delta, and now you cannot reconstruct
> any of the objects).

Ah, that's why.

> Somebody pushes X, which deltas against Y. They send only the delta for
> X->Y, but the receiver stores that delta plus a full copy of Y, even
> though we already have Y in another pack. Repacking throws away the
> extra copy of Y.

Right, I got that.

> And that is why something like Junio's suggestion of "do not traverse
> history; just concatenate the packs and throw away duplicate objects"
> might be helpful. You would not find new deltas, but you would get rid
> of these duplicate objects, and doing so would be relatively cheap.

... but we've already determined that git pack-objects does a good job
of reusing deltas, so I'm not sure what we can do over and above this.

If I understand correctly, the proposal is to use existing (but
sub-optimal) deltas more aggressively when repacking?

> Another solution could involve not writing the duplicate of Y in the
> first place.

> [...]

> You could possibly solve this with cycle detection, though it would be
> complicated (you need to do it not just when getting rid of objects, but
> when sending a pack, to make sure you don't send a cycle of deltas that
> the other end cannot use). You _might_ be able to get by with a kind of
> "two-level" hack: consider your main pack as "group A" and newly pushed
> packs as "group B". Allow storing thin deltas on disk from group B
> against group A, but never the reverse (nor within group B). That makes
> sure you don't have cycles, and it eliminates even more I/O than any
> repacking solution (because you never write the extra copy of Y to disk
> in the first place). But I can think of two problems:

Hm, having two kinds of packs: full packs and thin packs, and
different codepaths to handle them.

>   1. You still want to repack more often than every 300 packs, because
>      having many packs cost both in space, but also in object lookup
>      time (we can do a log(N) search through each pack index, but have
>      to search linearly through the set of indices).

Once you narrow it down to a pack-index, you can bisect it since the
table is sorted. How do you find the right pack-index though? Do I
have to do the bisection-search on each one to see if the object
exists? Can this be improved by generating a global index for all
packs that contains packfile-name in addition to offset for each
object?

>   2. As you accumulate group B packs with new objects, the deltas that
>      people send will tend to be against objects in group B. They are
>      closer to the tip of history, and therefore make better deltas for
>      history built on top.

Actually, I'm not sure it's worth the additional complexity at all.
Keeping packs self-contained means that simpler code and easier
isolation in the face of corruption: the space isn't a big trade-off,
unless there are lots of really tiny packs (in which case we
consolidate them into larger packs).

The way I see it, we'll be saving on some IO by creating thin packs.
But the trade-off seems to be quite heavy: self-contained packs means
that I can just mmap() that pack-index, look for objects and apply
deltas without bothering about any other packs. Thin packs means that
I'll have to mmap() a lot more than one pack-index, and spend a lot
more time searching for the base object to apply the delta to, right?

> That's all just off the top of my head. There are probably other flaws,
> too, as I haven't considered it too hard. But if you are really
> concerned about I/O on a busy repo (and I think for hosting sites, it is
> a real problem), the best-performing solution will probably not involve
> packs at all, but some kind of delta-capable storage that you can
> incrementally add to without rewriting the whole repository. The
> downside is that it would be significantly more complicated.

I think packs are an excellent solution. The reason is quite simple:
if you use incremental delta storage, those deltas will be useless
(aka. completely suboptimal) after a few days of additional data.
Generating effective deltas is an expensive operation that involves
lining up objects using heuristics (like size), and sliding windows
over them to get the most optimal delta. If you generate lots of
suboptimal deltas, pack-objects can't reuse them and your server will
not be able to do network operations effectively.

> It's actually list-objects.c, and no, it is not unique to packing (you
> can run the same code with "git rev-list --objects"). The CPU time for such
> a traversal is generally spent in:
>
>   1. Accessing commit objects data from disk (this shows up as libz in
>      perf runs).
>
>   2. Accessing tree object data from disk (libz again).
>
>   3. Reconstructing tree deltas (this shows up as memcpy in perf, but of
>      course we have to access base objects, which increases item 2).
>
>   4. Converting sha1s into "struct object" via hash table lookup
>      (lookup_object in perf).

Makes sense.

> Generation numbers can make some commit walks faster by cutting off the
> traversal early. But they don't really apply here, for a few reasons.
> One, our worst case is actually a full clone or prune, and there is no
> cutoff; we must go down to the roots. Two, we use commit timestamps as a
> proxy for generation numbers. Most of the traversal algorithms use the
> timestamps in a priority queue, and are written such that we always get
> the right answer in the face of skewed timestamps, but we may go deeper
> than necessary if they are skewed.

Yeah, I noticed. The main advantage of using generation numbers seemed
to be the elimination of SLOP from revision.c:limit_list(); slightly
cleaner code, but not much else. I was wondering if there was
something more to it.

> The exception is the depth-first
> "tag --contains" algorithm, which typically goes to the roots (and if
> you limit on timestamp, will give the wrong answer in the face of skew).
> And that is the algorithm that is sped up by having generation numbers.

Ah, I see.

> So I do not think they help with (1). You can speed up (1) by storing
> commit information in a more readily accessible format (e.g., see the
> "commit metapack" patches I posted in March or April of this year). But
> you cannot win all that much here. Try "git rev-list --all" on the
> kernel versus "git rev-list --objects --all". The former touches only
> the commits, and takes about 5 seconds. The latter touches all objects
> and takes about 30 seconds. So even if you could make the commit access
> and traversal instantaneous, you could save only 5 out of 30 seconds.

Oh, ouch. I haven't gotten around to reading the "commit metapack" series yet.

> For (2), I experimented with leaving tree objects uncompressed in the
> pack. It does help (and you do not lose much space, because tree objects
> compress horribly, as they are mostly random sha1 bytes). But not that
> much.

Interesting point: tree objects cannot be compressed: if I do one
file/directory rename, the old 20-byte hash and new 20-byte hash have
no relationship to each other: so, we're wasting time trying to find
patterns (for compression) in trees. But yeah, eliminating tree
compression might not help much, because there are so few trees: on a
typical repository, there are very few renames.

> For (3), we keep a cache of delta bases to avoid re-accessing the same
> tree bases over and over. Usually this works fine, but I can into a case
> recently where "rev-list --objects" was halved by bumping
> core.deltabasecachelimit from its default of 16m to 128m (this
> particular repository had some large trees, and a very odd pattern of
> merges that I think made the locality of tree access very poor).

Yeah, I saw the LRU delta_base_cache in sha1_file.c. It's probably
already as optimal as it can be.

> Which leaves (4), the hash lookup. We have to do a _lot_ of these,
> because we have to look up each entry of each tree. So we end up looking
> up the same sha1s over and over again (e.g., we see that "Makefile" is at
> sha1 "1234abcd", and we output it. Then we go to the tree of the parent
> commit, and we look at its "Makefile" entry. Guess where it almost
> certainly still points, because any given commit only touches a handful
> of paths?).
>
> There have been several attempts to make this faster. Micro-optimizing
> hashcmp, which helps a little. I looked at quadratic probing in the hash
> table, and Junio looked at cuckoo hashing.  Neither provided good
> results. I looked at exploiting locality of the repeated lookups, which
> resulted in 9a41448.

To lower the cost of linear lookup during a collision, you move the
object you hit up the chain for subsequent lookups. Very interesting.

> But ultimately, something like reachability bitmaps is going to perform
> a lot better, because you can avoid doing the traversal at all. Another
> solution which we've discussed but AFAIK nobody has ever implemented is
> having a cache to show which entries changed between two trees (e.g.,
> the tree of a commit and the tree of one of its children). That would
> let us skip the repeated hash lookups (you would know whether you
> already processed the child's tree and its entries, and if so, you know
> that you only need to process the differences to get complete coverage).

It'll take me some time to digest this information and come up with
questions/ patches.

Thanks for the food for thought.
