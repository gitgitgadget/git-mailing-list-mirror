From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/11] Micro-optimizing lookup_object()
Date: Thu, 11 Aug 2011 10:53:05 -0700
Message-ID: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:53:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZRm-0008JJ-D9
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab1HKRxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855Ab1HKRxV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CA524170
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=lZhdc92Jf7YIPhOKz/7UcTz0ZVI
	=; b=Cg69het6l7+6+PEYING3pTWsc1CaioXEVbnJgfgwZO+a8Cis4s506w2RoJ3
	LvU+C08cstQWLcAqfFWUhRFvH0uzSZIIpyj0asKz8aQazkVSHaVv6RgMXzBeGxWu
	UqOVnDqu676RmTobq1cVj477Q+WVnFgl82T0j3asVyb0Sqcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=B5Aquo+195uxlu1/X1ZoSedqlDGFO
	Hl5//UjO2Z3q3lNYpGq21waij6cZ4YVfgW10KLFWICSPAYGD5TWVHcrR6YS85i0e
	2IdWG7UggElE8p7M0mgFinkW6dyQGX87h3p+SBm42hFJnKnG2aJQipHdUUmTGs1O
	YB9lSdxDD5ud3M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 442A1416F
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93AC4416E for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
X-Pobox-Relay-ID: CB240E32-C442-11E0-8CBE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179115>

I noticed that a typical "git repack -a -d -f" spends about 50% of the
time during the "Counting objects" phase inside lookup_object(). The
look-up is implemented as a hashtable with linear probing that limits the
maximum load-factor to 50%, and during repacking the Linux kernel
repository, we count 2,139,209 objects, and the worst case we probe 50
hash entries to find a single object in the hash table due to slot
collisions. The lookup_object() function is called 88,603,392 times.

After cleaning up the existing code a bit, this series adds "--count-only"
option to "pack-objects" to tell it to stop after the "Counting objects"
phase for benchmarking purposes. To emulate the "Counting objects" phase
of a full repack, we can run this (perhaps under "/usr/bin/time"):

  git pack-objects --count-only --keep-true-parents --honor-pack-keep \
      --non-empty --all --reflog --no-reuse-delta \
      --delta-base-offset --stdout </dev/null >/dev/null

On my development box, the slightly cleaned-up existing linear probing
code gives (best of three runs with hot cache):

  31.89user 2.16system 0:34.16elapsed 99%CPU (0avgtext+0avgdata 2965264maxresident)k
  0inputs+0outputs (0major+225336minor)pagefaults 0swaps

Then the series replaces lookup_object(), insert_obj_hash() and
grow_object_hash() with a naive implementation of cuckoo hashing that uses
two hash functions. The performance is not very impressive, and this wastes
too much memory, due to its rather poor strategy to re-grow the table size:

  32.04user 3.43system 0:35.58elapsed 99%CPU (0avgtext+0avgdata 8178672maxresident)k
  0inputs+0outputs (0major+1206546minor)pagefaults 0swaps

As we have 20-byte object names as the hash key material, we could easily
extend this to use 5 hash functions instead of 2. This reduces the memory
usage by improving the load factor, but we spend extra cycles in lookup:

  31.66user 2.14system 0:33.91elapsed 99%CPU (0avgtext+0avgdata 2874176maxresident)k
  0inputs+0outputs (0major+225342minor)pagefaults 0swaps

At this step with 5-way cuckoo, we are slightly better than the original
linear probing. By using smaller number of hash functions, we can reduce
the cycles we need in lookup, while we lose on the load factor.

Here is what we get from the code with 4 hashes:

  30.88user 2.32system 0:33.31elapsed 99%CPU (0avgtext+0avgdata 3135984maxresident)k
  0inputs+0outputs (0major+290857minor)pagefaults 0swaps

And here is with 3 hashes:

  30.68user 2.26system 0:33.05elapsed 99%CPU (0avgtext+0avgdata 3660832maxresident)k
  0inputs+0outputs (0major+421963minor)pagefaults 0swaps

The best balance is somewhere between 3-hash and 4-hash, it seems. We are
getting ~4% runtime performance improvements (31.89 vs 30.68).

Just as a sanity check, the final patch in the series reduces the number
of hashes back to 2, which yields a similar performance characteristics
from the original "naive" cuckoo implementation:

  31.06user 3.22system 0:34.39elapsed 99%CPU (0avgtext+0avgdata 8176512maxresident)k
  0inputs+0outputs (0major+1206542minor)pagefaults 0swaps

The real optimization opportunity _may_ be to reduce the calls we make to
the function---we are calling lookup() 40+ times on one object. But that
is outside the scope of this series.

This series is not for application but primarily is to serve as the
supplimental data for the above numbers. A re-rolled series that consists
of the earlier clean-ups and then a patch to replace the linear probing
with 4-way cuckoo will be queued instead in 'pu'.

Junio C Hamano (11):
  object.c: code movement for readability
  object.c: remove duplicated code for object hashing
  pack-objects --count-only
  object: next_size() helper for readability
  object hash: we know the table size is a power of two
  object: growing the hash-table more aggressively does not help much
  object: try naive cuckoo hashing
  object: try 5-way cuckoo -- use all 20-bytes of SHA-1
  object: try 4-way cuckoo
  object: try 3-way cuckoo
  object: try 2-way cuckoo again

 builtin/pack-objects.c |    7 +++
 object.c               |  138 +++++++++++++++++++++++++++++-------------------
 2 files changed, 91 insertions(+), 54 deletions(-)

-- 
1.7.6.433.g1421f
