From: Jeff King <peff@peff.net>
Subject: thin packs ending up fat
Date: Thu, 12 Jan 2012 17:15:23 -0500
Message-ID: <20120112221523.GA3663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 23:15:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlSvn-0005KA-13
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 23:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab2ALWPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 17:15:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36339
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203Ab2ALWP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 17:15:29 -0500
Received: (qmail 4607 invoked by uid 107); 12 Jan 2012 22:22:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jan 2012 17:22:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jan 2012 17:15:23 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188485>

[This ended up long; the gist of it is that we often fail to find thin
 deltas, making small fetches much bigger than they could be. Read on
 for details].

Recently I was doing some work related to bundles containing thin packs,
and I wanted to generate some thin packs. Much to my surprise, all of my
packs ended up having no thin objects!

It turns out that when packing a subset of a fully packed repo (as we do
for a bundle or for a fetch), we tend not to make thin packs at all.
The culprit is this logic in try_delta:

        /*
         * We do not bother to try a delta that we discarded
         * on an earlier try, but only when reusing delta data.
         */
        if (reuse_delta && trg_entry->in_pack &&
            trg_entry->in_pack == src_entry->in_pack &&
            trg_entry->in_pack_type != OBJ_REF_DELTA &&
            trg_entry->in_pack_type != OBJ_OFS_DELTA)
                return 0;

This does not try to delta objects which are found in the same pack,
under the assumption that we would have tried them last time and found
that they didn't work. For a complete repack, it works well. We don't
miss useful deltas, and it saves a lot of CPU time.

For a thin pack, though, it means we'll typically fail to actually use
the boundary objects. I think what happens is this:

  1. You start at commit C which contains a file with content A. You
     build commit C', which contains content A'.

  2. You repack the repository, putting A and A' in the pack. Our delta
     rules tend to create deltas in reverse-recency order, so A
     typically is stored as a delta based on A', and A' is stored
     whole.

  3. You try to create a thin pack (e.g., with "git bundle create
     foo.bundle C..C'"). We know that we want to send A', and that we
     can assume the other side has A to use as a base in our thin pack.

     But the logic above says "A and A' are both in the same pack, and
     we didn't find a delta for A'. They must not be a good match". But
     in this case it is because our deltas go in the reverse direction,
     and we never tried them.

So I did a little experimenting (scripts and inputs are at the end of
the email). I generated a thin pack for a subset of objects from my
fully packed repo, measuring the size of the resulting pack and the CPU
time used. I did this both with stock git, and a version of git with the
above optimization removed.

I used two datasets to generate the input to pack-objects. In the first,
I used the reflog entries from my refs/remotes/origin/master ref. That
simulates the workload of upload-packs performed for me by kernel.org
over the last month or so. In the second dataset, I took packed the
objects between git v1.0.0 and v1.1.0, between v1.1.0 and v1.2.0, and so
on. This was an attempt to simulate somebody who fetches much less
frequently, or perhaps somebody who generates bundles to sneaker-net
individual versions.

For each dataset, I calculated the average size (in bytes) over all of
the generated packs in the dataset and the average CPU time used per
pack (in seconds).

                  dataset
            | fetches | tags
---------------------------------
     before | 53358   | 2750977
size  after | 32315   | 2652939
     change |   -39%  |      -4%
---------------------------------
     before |  0.18   | 1.12
CPU   after |  0.19   | 1.50
     change |    +5%  |     +33%

For the case of small, frequent packs, we saved a lot of space for a
little bit of extra CPU. But for larger packs, our savings were much
more limited, and we spent a lot more CPU time.  That makes sense; this
is really beneficial for finding extra matches at the boundaries, and
for cases where you can avoid sending an entire undeltified object at
all for a given path.

So I think this is worth pursuing as an optimization to save bandwidth
on transfers, but it would require figuring out the right times to turn
it on. My initial idea was that we would want it off whenever we were
doing a thin pack. But the "tags" dataset shows that it's probably not
worth the trouble for large packs due to the extra CPU time.

I have a feeling that the case it is generally catching is this "reverse
delta" case. I.e., A is based off of B, we are including B, but A is
available as a thin base. But that can probably be extended into a delta
chain (A is based from B which is based on C; we want to include B and
C, but can build off of A as a base. We'll keep the delta from B to C,
but we would want to delta C off of A). So detecting that they are part
of the same chain might require walking the chains.

Maybe it is enough to simply turn off this optimization if the potential
delta source is not being included in the pack (i.e., we are using
--thin and it is a boundary object). Because if both objects are being
sent, we will just end up reusing the delta that goes in the reverse
direction anyway.

Or maybe there is some other clever way of detecting this situation. I'm
open to suggestions.

-Peff

---
This is the test script I used (feed the dataset files on stdin, get
lines of sizes and CPU times on stdout):

-- >8 --
#!/bin/sh

while read revs; do
	for i in $revs; do
		echo $i
	done >input
	echo >&2 "==> $revs"
	time -o time.out -f "%e" \
		git pack-objects --thin --revs --stdout <input >pack.out
	echo "`stat --format=%s pack.out` `cat time.out`"
done
-- 8< --

and the "fetch" dataset:

-- >8 --
8b0e15fa95e11965f18c8d2585dc8ffd9bfc9356 ^7f41b6bbe3181dc4d1687db036bf22316997a1bf
34c4461ae3b353e8c931565d5527b98ed12e3735 ^8b0e15fa95e11965f18c8d2585dc8ffd9bfc9356
463b0ea22b5b9a882e8140d0308433d8cbd0d1fe ^34c4461ae3b353e8c931565d5527b98ed12e3735
288396994f077eec7e7db0017838a5afbfbf81e3 ^463b0ea22b5b9a882e8140d0308433d8cbd0d1fe
05f6edcd2a418a88eeb953d51408a6aeef312f5c ^288396994f077eec7e7db0017838a5afbfbf81e3
08cfdbb88cd6225b4fc4b8a3cecd0e01758c835d ^05f6edcd2a418a88eeb953d51408a6aeef312f5c
87009edcbd0b4987ccb7ba050a1efe368a315753 ^08cfdbb88cd6225b4fc4b8a3cecd0e01758c835d
8963314c77af9a4eda5dcbdbab3d4001af83ad81 ^87009edcbd0b4987ccb7ba050a1efe368a315753
10b2a48113b8ab6b8f48229eb40fc3637ce025ae ^8963314c77af9a4eda5dcbdbab3d4001af83ad81
997a1946a55cafb992c4ba8e5e0795aa73f5a4a9 ^10b2a48113b8ab6b8f48229eb40fc3637ce025ae
e8e1c29021da446d0c50573ef9619bf74f515c20 ^997a1946a55cafb992c4ba8e5e0795aa73f5a4a9
87bf9a7048c623b3567f612ca3e67a0d412fc83d ^e8e1c29021da446d0c50573ef9619bf74f515c20
ee6dfb2d83ba1b057943e705f707fa27e34e47f9 ^87bf9a7048c623b3567f612ca3e67a0d412fc83d
4cb6764227173a6483edbdad09121651bc0b01c3 ^ee6dfb2d83ba1b057943e705f707fa27e34e47f9
8a042478967679b0dab3137f5f18367a0ffdc48a ^4cb6764227173a6483edbdad09121651bc0b01c3
248dbbe83256202f0edd6e1468d01cfbe27fd733 ^8a042478967679b0dab3137f5f18367a0ffdc48a
bc1bbe0c19a6ff39522b4fa3259f34150e308e1f ^248dbbe83256202f0edd6e1468d01cfbe27fd733
4d2440fe0daa9ad1556dfd220af8b3a883cf849d ^bc1bbe0c19a6ff39522b4fa3259f34150e308e1f
f56ef114eeefee755f422e6cbef2d83974cb90f1 ^4d2440fe0daa9ad1556dfd220af8b3a883cf849d
e14d63198867c545d0662afc00bf7be048bf2231 ^f56ef114eeefee755f422e6cbef2d83974cb90f1
017d1e134545db0d162908f3538077eaa1f34fb6 ^e14d63198867c545d0662afc00bf7be048bf2231
fc14b89a7e6899b8ac3b5751ec2d8c98203ea4c2 ^017d1e134545db0d162908f3538077eaa1f34fb6
406da7803217998ff6bf5dc69c55b1613556c2f4 ^fc14b89a7e6899b8ac3b5751ec2d8c98203ea4c2
7e02a6c63a183270b726bb21640059ae16fa48ae ^406da7803217998ff6bf5dc69c55b1613556c2f4
4cb5d10b14dcbe0155bed9c45ccb94e83bd4c599 ^7e02a6c63a183270b726bb21640059ae16fa48ae
9859a023fef30ffebdd22ad9639c587ac720b8b6 ^4cb5d10b14dcbe0155bed9c45ccb94e83bd4c599
57526fde5df201a99afa6d122c3266b3a1c5673a ^9859a023fef30ffebdd22ad9639c587ac720b8b6
73c6b3575bc638b7096ec913bd91193707e2265d ^57526fde5df201a99afa6d122c3266b3a1c5673a
10f4eb652ee4e592f91f638e579d1afcb96c0408 ^73c6b3575bc638b7096ec913bd91193707e2265d
ee228024933069b93ce23a1bd5eeb7ae12c792f2 ^10f4eb652ee4e592f91f638e579d1afcb96c0408
d16520499d2652b5b59dfb25f9cf2d56a4c6913a ^ee228024933069b93ce23a1bd5eeb7ae12c792f2
876a6f4991abdd72ea707b193b4f2b831096ad3c ^d16520499d2652b5b59dfb25f9cf2d56a4c6913a
8d68493f20db71abeb77adc251b2a116fe45cdaa ^876a6f4991abdd72ea707b193b4f2b831096ad3c
3daff7c31998faedbe0dd7e2b8651e351be40d64 ^8d68493f20db71abeb77adc251b2a116fe45cdaa
e443bdfe1e8e1ef8b3665cfd1c1295bd73e13773 ^3daff7c31998faedbe0dd7e2b8651e351be40d64
5d6dfc7cb140a6eb90138334fab2245b69bc8bc4 ^e443bdfe1e8e1ef8b3665cfd1c1295bd73e13773
ec330158ec04849fe5ff2cb8749797cd63ae592b ^5d6dfc7cb140a6eb90138334fab2245b69bc8bc4
17b4e93d5b849293e6a3659bbc4075ed8a6e97e2 ^ec330158ec04849fe5ff2cb8749797cd63ae592b
4570aeb0d85f3b5ff274b6d5a651c2ee06d25d76 ^17b4e93d5b849293e6a3659bbc4075ed8a6e97e2
247f9d23da8cfd255533433ad2aa07d172afac0b ^4570aeb0d85f3b5ff274b6d5a651c2ee06d25d76
eac2d83247ea0a265d923518c26873bb12c33778 ^247f9d23da8cfd255533433ad2aa07d172afac0b
beecc7ab65b31c5471331e64acaa3f722125ea67 ^eac2d83247ea0a265d923518c26873bb12c33778
7e521640c80b4bb871bca7a9259621a7abb303e7 ^beecc7ab65b31c5471331e64acaa3f722125ea67
0e1cfc52de002e2d9b0e6562e8672fee3bf45a67 ^7e521640c80b4bb871bca7a9259621a7abb303e7
-- 8< --

and the "tags" dataset:

-- >8 --
v1.1.0 ^v1.0.0
v1.2.0 ^v1.1.0
v1.3.0 ^v1.2.0
v1.4.0 ^v1.3.0
v1.5.0 ^v1.4.0
v1.6.0 ^v1.5.0
v1.7.0 ^v1.6.0
-- 8< --
