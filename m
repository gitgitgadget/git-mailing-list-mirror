Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A4820196
	for <e@80x24.org>; Wed, 13 Jul 2016 08:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbcGMI1B (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 04:27:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:43956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751278AbcGMI06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 04:26:58 -0400
Received: (qmail 18752 invoked by uid 102); 13 Jul 2016 08:26:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 04:26:59 -0400
Received: (qmail 11602 invoked by uid 107); 13 Jul 2016 08:27:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 04:27:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2016 04:26:53 -0400
Date:	Wed, 13 Jul 2016 04:26:53 -0400
From:	Jeff King <peff@peff.net>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160713082653.GA18144@sigill.intra.peff.net>
References: <20160707190917.20011-1-kirr@nexedi.com>
 <20160707205223.GA11753@sigill.intra.peff.net>
 <20160708103855.GD5462@teco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708103855.GD5462@teco.navytux.spb.ru>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 01:38:55PM +0300, Kirill Smelkov wrote:

> >   - we will not compute the same write order (which is based on
> >     traversal order), leading to packs that have less efficient cache
> >     characteristics
> 
> I agree the order can be not exactly the same. Still if original pack is
> packed well (with good recency order), while using bitmap we will tend
> to traverse it in close to original order.
> 
> Maybe I'm not completely right on this, but to me it looks to be the
> case because if objects in original pack are put there linearly sorted
> by recency order, and we use bitmap index to set of all reachable
> objects from a root, and then just _linearly_ gather all those objects
> from original pack by 1s in bitmap and put them in the same order into
> destination pack, the recency order won't be broken.
> 
> Or am I maybe misunderstanding something?

Yeah, I think you can go some of the way by reusing the order from the
old pack. But keep in mind that the bitmap result may also contain
objects that are not yet packed. Those will just come in a big lump at
the end of the bitmap (these are the "extended entries" in the bitmap
code).

So I think if you were to repeatedly "git repack -adb" over time, you
would get worse and worse ordering as objects are added to the
repository.

As an aside, two other things that pack order matters for: it makes the
bitmaps themselves compress better (because it increases locality of
reachability, so you get nice runs of "1" or "0" bits). It also makes
the pack-reuse code more efficient (since in an ideal case, you can just
dump a big block of data from the front of the pack). Note that the
pack-reuse code that's in upstream git isn't that great; I have a better
system on my big pile of patches to send upstream (that never seems to
get smaller; <sigh>).

> >   - we don't learn about the filename of trees and blobs, which is going
> >     to make the delta step much less efficient. This might be mitigated
> >     by turning on the bitmap name-hash cache; I don't recall how much
> >     detail pack-objects needs on the name (i.e., the full name versus
> >     just the hash).
> 
> If I understand it right, it uses only uint32_t name hash while searching. From
> pack-objects.{h,c} :

Yeah, I think you are right. Not having the real names is a problem for
doing rev-list output, but I think pack-objects doesn't care (though do
note that the name-hash cache is not enabled by default).

> > There may be other subtle things, too. The general idea of tying the
> > bitmap use to pack_to_stdout is that you _do_ want to use it for
> > serving fetches and pushes, but for a full on-disk repack via gc, it's
> > more important to generate a good pack.
> 
> It is better we send good packs to clients too, right? And with
> pack.writeBitmapHashCache=true and retaining recency order (please see
> above, but again maybe I'm not completely right) to me we should be still
> generating a good pack while using bitmap reachability index for object
> graph traversal.

We do want to send the client a good pack, but it's always a tradeoff.
We could spend much more time searching for the perfect delta, but at
some point we have to decide on how much CPU to spend serving them.
Likewise, even if the bitmapped packs we send are in slightly worse
order, saving a minute of CPU time off of every clone of the kernel is a
big deal.

We also take robustness shortcuts when sending to clients. For example,
when doing an on-disk repack we re-crc32 all of the delta data we are
reusing, even if we don't actually inflate it (because we would want to
stop immediately if we see even a single bit flipped on disk). But we
don't check them when sending to a client, because we know they are
going to actually `index-pack` it and get a stronger consistency check
anyway, and don't want to waste server CPU.

The bitmaps are sort of the same. If there is a bug or corruption in the
bitmap, the worst case is that we send a broken pack to the client, who
will complain that we did not give them all of the objects. It's a
momentary problem that can be fixed. If you use them for an on-disk
repack, then the next step is usually to delete all of the old packs. So
a corruption there carries forward, and is irreversible.

As I understand your use case, it is OK to do the less careful things.
It's just that pack-objects until now has been split into two modes:
packing to a file is careful, and packing to stdout is less so. And you
want to pack to a file in the non-careful mode.

> > but I wonder if you should be using "pack-objects --stdout" yourself.
> 
> I already tried --stdout. The problem is on repository extraction we
> need to both extract the pack and index it. While `pack-object file`
> does both, for --stdout case we need to additionally index extracted
> pack with `git index-pack`, and standalone `git index-pack` is very slow
> - in my experience much slower than generating the pack itself:

Ah, right, that makes sense. The packfile does not carry the sha1 of the
objects. A receiving index-pack has to compute them itself, including
inflating and applying all of the deltas! By contrast, a pack to stdout
can be quite quick, because in most cases it can avoid even inflating
most of the data; where possible it just sends the zlib data straight
from disk to the client.

So I do agree "--stdout" is not ideal for you (or at the very least, you
really want pack-objects to generate the index from its internal table
rather than having to reconstruct it just from the pack stream).

> > But even if it is the right thing for your use case to be using bitmaps
> > to generate an on-disk bitmap, I think we should be making sure it
> > _doesn't_ trigger when doing a normal repack.
> 
> So seems the way forward here is to teach pack-objects not to silently
> drop explicit --use-pack-bitmap for cases when it can handle it?
> (currently even if this option was given, for !stdout cases pack-objects
> simply drop use_bitmap_index to 0).
> 
> And to make sure default for use_bitmap_index is 0 for !stdout cases?

I think it would be reasonable to accept "--use-bitmap-index" on the
command line as an override for "yes, really, this is what I want". So
the logic would be something like:

  static int use_bitmap_index_default = 1;
  static int use_bitmap_index = -1;

  ... parse config; if we see pack.usebitmaps, set
      use_bitmap_index_default ...

  ... parse command line, setting use_bitmap_index ...

  /* "soft" reasons not to use bitmaps */
  if (!pack_to_stdout)
	use_bitmap_index_default = 0;

  /* now install our default if the user didn't otherwise specify */
  if (use_bitmap_index < 0)
	use_bitmap_index = use_bitmap_index_default;

  /* "hard" reasons not to use bitmaps; these just won't work at all */
  if (!use_internal_rev_list || is_repository_shallow())
	use_bitmap_index = 0;

-Peff
