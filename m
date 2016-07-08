Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1503A2023C
	for <e@80x24.org>; Fri,  8 Jul 2016 10:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbcGHKjD (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 06:39:03 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:34236 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbcGHKjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 06:39:00 -0400
Received: from teco.navytux.spb.ru (unknown [178.70.82.177])
	by mail2.tiolive.com (Postfix) with ESMTPSA id CA6EBBF0329;
	Fri,  8 Jul 2016 12:38:56 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bLTBP-0005IG-SO; Fri, 08 Jul 2016 13:38:55 +0300
Date:	Fri, 8 Jul 2016 13:38:55 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160708103855.GD5462@teco.navytux.spb.ru>
References: <20160707190917.20011-1-kirr@nexedi.com>
 <20160707205223.GA11753@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160707205223.GA11753@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Peff first of all thanks for feedback,

On Thu, Jul 07, 2016 at 04:52:23PM -0400, Jeff King wrote:
> On Thu, Jul 07, 2016 at 10:09:17PM +0300, Kirill Smelkov wrote:
> 
> > Starting from 6b8fda2d (pack-objects: use bitmaps when packing objects)
> > if a repository has bitmap index, pack-objects can nicely speedup
> > "Counting objects" graph traversal phase. That however was done only for
> > case when resultant pack is sent to stdout, not written into a file.
> > 
> > We can teach pack-objects to use bitmap index for initial object
> > counting phase when generating resultant pack file too:
> 
> I'm not sure this is a good idea in general. When bitmaps are in use, we
> cannot fill out the details in the object-packing list as thoroughly. In
> particular:
> 
>   - we will not compute the same write order (which is based on
>     traversal order), leading to packs that have less efficient cache
>     characteristics

I agree the order can be not exactly the same. Still if original pack is
packed well (with good recency order), while using bitmap we will tend
to traverse it in close to original order.

Maybe I'm not completely right on this, but to me it looks to be the
case because if objects in original pack are put there linearly sorted
by recency order, and we use bitmap index to set of all reachable
objects from a root, and then just _linearly_ gather all those objects
from original pack by 1s in bitmap and put them in the same order into
destination pack, the recency order won't be broken.

Or am I maybe misunderstanding something?

Please also see below:

>   - we don't learn about the filename of trees and blobs, which is going
>     to make the delta step much less efficient. This might be mitigated
>     by turning on the bitmap name-hash cache; I don't recall how much
>     detail pack-objects needs on the name (i.e., the full name versus
>     just the hash).

If I understand it right, it uses only uint32_t name hash while searching. From
pack-objects.{h,c} :

---- 8< ----
struct object_entry {
	...
	uint32_t hash;                  /* name hint hash */


/*
 * We search for deltas in a list sorted by type, by filename hash, and then
 * by size, so that we see progressively smaller and smaller files.
 * That's because we prefer deltas to be from the bigger file
 * to the smaller -- deletes are potentially cheaper, but perhaps
 * more importantly, the bigger file is likely the more recent
 * one.  The deepest deltas are therefore the oldest objects which are
 * less susceptible to be accessed often.
 */
static int type_size_sort(const void *_a, const void *_b)
{
        const struct object_entry *a = *(struct object_entry **)_a;
        const struct object_entry *b = *(struct object_entry **)_b;

        if (a->type > b->type)
                return -1;
        if (a->type < b->type) 
                return 1;
        if (a->hash > b->hash)
                return -1;
        if (a->hash < b->hash)
                return 1;
	...
---- 8< ----

Documentation/technical/pack-heuristics.txt also confirms this:

---- 8< ----
    ...
    <gitster> The quote from the above linus should be rewritten a
        bit (wait for it):
        - first sort by type.  Different objects never delta with
          each other.
        - then sort by filename/dirname.  hash of the basename
          occupies the top BITS_PER_INT-DIR_BITS bits, and bottom
          DIR_BITS are for the hash of leading path elements.

    ...

    If I might add, the trick is to make files that _might_ be similar be
    located close to each other in the hash buckets based on their file
    names.  It used to be that "foo/Makefile", "bar/baz/quux/Makefile" and
    "Makefile" all landed in the same bucket due to their common basename,
    "Makefile". However, now they land in "close" buckets.
    
    The algorithm allows not just for the _same_ bucket, but for _close_
    buckets to be considered delta candidates.  The rationale is
    essentially that files, like Makefiles, often have very similar
    content no matter what directory they live in.
---- 8< ----


So yes, exactly as you say with pack.writeBitmapHashCache=true (ae4f07fb) the
delta-search heuristics is almost as efficient as with just raw filenames.

I can confirm this also via e.g. (with my patch applied) :

---- 8< ----
$ time echo 0186ac99 | git pack-objects --no-use-bitmap-index --revs erp5pack-plain
Counting objects: 627171, done.
Compressing objects: 100% (176949/176949), done.
50570987560d481742af4a8083028c2322a0534a
Writing objects: 100% (627171/627171), done.
Total 627171 (delta 439404), reused 594820 (delta 410210)

real    0m37.272s
user    0m33.648s
sys     0m1.580s

$ time echo 0186ac99 | git pack-objects --revs erp5pack-bitmap
Counting objects: 627171, done.
Compressing objects: 100% (176914/176914), done.
7c15a9b1eca1326e679297b217c5a48954625ca2
Writing objects: 100% (627171/627171), done.
Total 627171 (delta 439484), reused 594855 (delta 410245)

real    0m27.020s
user    0m23.364s
sys     0m0.992s

$ ll erp5pack-{plain,bitmap}*
	  17561860  erp5pack-bitmap-7c15a9b1eca1326e679297b217c5a48954625ca2.idx
	 238760161  erp5pack-bitmap-7c15a9b1eca1326e679297b217c5a48954625ca2.pack
	  17561860  erp5pack-plain-50570987560d481742af4a8083028c2322a0534a.idx
	 238634201  erp5pack-plain-50570987560d481742af4a8083028c2322a0534a.pack
---- 8< ----

( By the way about pack generated with bitmap retaining close recency
  order:

  ---- 8< ----
  $ git verify-pack -v erp5pack-plain-50570987560d481742af4a8083028c2322a0534a.pack >1
  $ git verify-pack -v erp5pack-bitmap-7c15a9b1eca1326e679297b217c5a48954625ca2.pack >2
  $ grep commit 1 |awk '{print $1}' >1.commit
  $ grep commit 2 |awk '{print $1}' >2.commit
  $ wc -l 1.commit
  46136 1.commit
  $ wc -l 2.commit
  46136 2.commit
  $ diff -u0 1.commit 2.commit |wc -l
  55
  ---- 8< ----
  
  so 55/46136 shows it is very almost the same. )


> There may be other subtle things, too. The general idea of tying the
> bitmap use to pack_to_stdout is that you _do_ want to use it for
> serving fetches and pushes, but for a full on-disk repack via gc, it's
> more important to generate a good pack.

It is better we send good packs to clients too, right? And with
pack.writeBitmapHashCache=true and retaining recency order (please see
above, but again maybe I'm not completely right) to me we should be still
generating a good pack while using bitmap reachability index for object
graph traversal.

> Your use case:
> 
> > git-backup extracts many packs on repositories restoration. That was my
> > initial motivation for the patch.
> 
> Seems to be somewhere in between. I'm not sure I understand how you're
> invoking pack-objects here,

It is just

    pack-objects --revs --reuse-object --reuse-delta --delta-base-offset extractedrepo/objects/pack/pack  < SHA1-HEADS

    https://lab.nexedi.com/kirr/git-backup/blob/7fcb8c67/git-backup.go#L829

> but I wonder if you should be using "pack-objects --stdout" yourself.

I already tried --stdout. The problem is on repository extraction we
need to both extract the pack and index it. While `pack-object file`
does both, for --stdout case we need to additionally index extracted
pack with `git index-pack`, and standalone `git index-pack` is very slow
- in my experience much slower than generating the pack itself:

---- 8< ----
$ time echo 0186ac99 | git pack-objects --stdout --revs >erp5pack-stdout.pack
Counting objects: 627171, done.
Compressing objects: 100% (176914/176914), done.
Total 627171 (delta 439484), reused 594855 (delta 410245)

real    0m22.309s
user    0m21.148s
sys     0m0.932s

$ ll erp5pack-stdout*
        238760161   erp5pack-stdout.pack

$ time git index-pack erp5pack-stdout.pack
7c15a9b1eca1326e679297b217c5a48954625ca2

real    0m50.873s   <-- more than 2 times slower than time to generate pack itself!
user    0m49.300s
sys     0m1.360s

$ ll erp5pack-stdout*
         17561860   erp5pack-stdout.idx
        238760161   erp5pack-stdout.pack
---- 8< ----

So the time for

    `pack-object --stdout >file.pack` + `index-pack file.pack`  is  72s,
    
while

    `pack-objects file.pack` which does both pack and index     is  27s.
    
And even

    `pack-objects --no-use-bitmap-index file.pack`              is  37s.


I've tried to briefly see why index-pack is so slow and offhand I can
see that it needs to load all objects, decompresses them etc (maybe I'm
not so right here - I looked only briefly), while pack-objects while
generating the pack has all needed information directly at hand and thus
can emit index much more easily.

For sever - clients scenario, index-pack load is put onto clients thus
offloading server, but for my use case where extracted repository is on
the same machine the load does not go away.

That's why for me it makes more sense to emit both pack and its index in
one go.

Still it would be interesting to eventually see why index-pack is so
anomaly slow.

> But even if it is the right thing for your use case to be using bitmaps
> to generate an on-disk bitmap, I think we should be making sure it
> _doesn't_ trigger when doing a normal repack.

So seems the way forward here is to teach pack-objects not to silently
drop explicit --use-pack-bitmap for cases when it can handle it?
(currently even if this option was given, for !stdout cases pack-objects
simply drop use_bitmap_index to 0).

And to make sure default for use_bitmap_index is 0 for !stdout cases?

Or are we fine with my arguments about recency order staying the same
when using bitmap reachability index for object graph traversal, and this
way the patch is fine to go in as it is?

Thanks again,
Kirill
