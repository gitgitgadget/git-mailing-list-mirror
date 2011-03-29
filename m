From: Sebastian Thiel <byronimo@googlemail.com>
Subject: Git Pack: Improving cache performance (maybe a good GSoC practice)
Date: Wed, 30 Mar 2011 00:21:23 +0200
Organization: Byronimo
Message-ID: <4D925B63.9040405@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 00:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4hI6-0005uC-93
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 00:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab1C2WVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 18:21:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43939 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1C2WV2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 18:21:28 -0400
Received: by fxm17 with SMTP id 17so609764fxm.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=UtBfQQEiZ2uvtTA5pPaELIL+CwdJWhIbbQqk+sBs12M=;
        b=Of3AcIASxVRI07+fXWJsofM0O311Xw6ZpJeguxzmUKetDPEB65ZW+07I6bcr218AZU
         j7zCj6ccYDn9w5NjzoMAazaXe2p53tTb6KnDlt0xEdPLvBJMgTJkxuh48VqlEURDndBO
         o54b0nQdi/MmfgBiZMfFBrBmsq+1S7LqbrVR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding;
        b=HJqtGSQBX5GRdtETNUsRRdIkRmaT8l9ZdmP2Tp9a1StzVBn3RTtLylSPdJO2CZYXcD
         7ohItetJE3y5qPgaQFcGbOYd5fsyu+ski9vbQn6sKXmvtuO+fC1UkBUFS3ZfXjHv0my4
         C1B/N/mKf1grL3xWaASnggyUpqQd1x0U6F2tY=
Received: by 10.223.78.138 with SMTP id l10mr399542fak.106.1301437287504;
        Tue, 29 Mar 2011 15:21:27 -0700 (PDT)
Received: from [10.0.1.33] (91-65-187-112-dynip.superkabel.de [91.65.187.112])
        by mx.google.com with ESMTPS id j11sm2148434faa.44.2011.03.29.15.21.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 15:21:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15pre) Gecko/20110207 Shredder/3.1.9pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170334>

Hi,

What follows is a summary of how I approached the git cache in order to 
write my own improved version. The conclusions can be found further 
down, in case you want to skip all the extra words for now.

I am currently working on a c++ implementation of the git core, which 
for now includes reading and writing of loose objects, as well as 
reading and verifying pack files. Actually, this is not the first time I 
do this, as I made my first experience in that matter with a pure python 
implementation of the git core 
(https://github.com/gitpython-developers/gitdb). This time though, I 
wanted to see whether I can achieve better performance, and how I can 
make git more suitable to handle big files.

When profiling my initial uncached version of my pack reading 
implementation, I noticed that most of the time was actually spent in 
zlibs inflate method. Apparently, a cache was a good idea - git already 
has one. Ignoring its implementation, I wrote my own naive one right 
away which stored only base objects and inflated deltas. Interestingly, 
this could already double the performance of my test case, which would 
just stream all data of all objects contained in the pack, sha by sha, 
resembling a random access pattern.

To compare my cache with git, I implemented pack verification, which 
basically generates sha1 of all uncompressed objects in the pack, and 
runs a crc32 on the compressed streams. As the objects are streamed 
ordered by offset, the access pattern can be described as sequential.

It came at no surprise, that git would verify my test-pack (aggressively 
packed git source repository with 137k objects, one 27mb pack) much 
faster, i.e. 25%. After some profiling and optimizations, I could bring 
it down to being just 15% faster. Considering that my cache, which only 
got faster in the course of the optimizations, could speed up random 
access by a factor of about 2.5, it was hard to understand that I 
couldn't reach git's performance.

The major difference turned out to be the way the cache works. Git has a 
small delta cache with only 256 [hardcoded] cache entries and a default 
memory limit of 16mb. There it stores fully decompressed objects. It 
maps objects to entries by hashing their pack offsets into the available 
range of entries. When the pack is accessed sequentially, the cache will 
be filled with related uncompressed objects, which can in turn reduce 
the time required to apply the next delta by a huge amount, as only a 
single delta has to be applied instead of a possibly long delta chain. 
As git appears to pack deltas of related objects close to each other 
(regarding their offset in the pack), the cache will be hit quite often 
automatically. As the number of entries is small, and as entries are 
connected using a doubly linked list, reclaiming of memory is rather 
efficient, as it hits the first used objects first, which are unlikely 
to be needed ever again. Collection doesn't necessarily run too often as 
well, as most entries will be overwritten with new data during hash 
collisions.
This cache implementation is clearly suitable for sequential access.

My cache was optimized for random access, hence it stores only base 
objects and uncompressed delta streams, using many more entries to 
achieve good cache hit ratios. The reason for the performance gain of 
the random access cache was that it stores full objects. This fills the 
cache memory up much faster, so having a lot of cache entries makes no 
sense.

Both cache types are optimized for different kinds of access modes, and 
both are required to efficiently deal with everything git usually has to do.
Hence I changed my cache to support both modes, and rerun the pack 
verification test.

The result was better than expected, as the my implementation now takes 
the lead by a tiny amount (25.3s vs. 26.0s) with a 16mb cache size. On 
my way to make it even faster, I experimented with different cache 
sizes, amounts of entries and of course different packs, which ranged 
from 20mb to 600mb, which helped me fine tune the relations of these 
variables.
In the end, with a cache of 27mb, my implementation took 20.6s, whereas 
the git implementation could only improve slightly to finish after 25.3s.
I believe the cause of this is the fixed amount of entries. My cache 
adjusts this amount depending on the packs size, the amount of objects, 
as well as the size of the cache. In the this case, my cache would have 
nearly 1000 entries, which helped to spread the amount of available 
memory. Due to the limited amount of entries, git will not even benefit 
from further increasing the size, whereas I could get as low as 13.5s by 
increasing the cache size to 48mb for instance.

Just for the fun of it, I increased the amount of entries in the git 
cache to the same amount my cache was using, and suddenly git was 
performing equally well, finishing after just 20.8s with a 27mb cache size.

As my random access cache performed worse in sequential access mode, I 
ran a test to see whether the opposite is true as well: Does the 
sequential cache harm performance in random access mode ? The answer is: 
Yes it does ! To show some numbers:  34mb of objects per second could be 
streamed without cache, which was reduced to 28mb/s with a random access 
cache. The cache in that case just causes overhead (especially when 
reclaiming memory), and is hit just rarely.

To test my assumptions not only with my code, but also with git itself, 
I used a test written for git-python, which streams blobs from the 27mb 
git pack. With the default cache, I get 14mb/s. When I removed the 
cache, it was upped to 15mb, which was less than expected, but we must 
not forget the git-python overhead here. Finally, with the sequential 
access cache enabled, its entries increased to 1000, and the cache size 
upped to 27mb, suddenly I would get 34.2mb/s ! A new record, for 
git-python at least ;).

As a final disclaimer, please let me emphasize that the tests I run are 
neither statistically profound, nor are the pack verification tests 
necessarily comparable in all details. Additionally, the git-python 
object throughput tests cannot be directly compared to the c++ test 
which has much less overhead. The tests were made to show performance 
relations and uncover ways to improve performance, and not to claim that 
one implementation is 'better' than the other.

-- Conclusions --
* delta cache needs to deal with random and sequential access.
* current implementation deals with sequential access only, which is 
only suitable for pack verification, and in fact hurts performance in 
other cases if the amount of entries (at least) is not dynamically 
adjusted depending on parameters of the actual pack.
* random access caches work well with plenty of entries, when storing 
only uncompressed deltas and base objects, as reapplying a delta is very 
fast.
* Sequential access caches have to dynamically adjust their amount of 
entries according to the amount of available cache memory and the 
average packed object size, to make best use of the available memory.
* it should be possible to adjust the caching mode at runtime, or to 
fully disable the cache.
* it might be useful/necessary to have one cache per pack sharing global 
memory limits, instead of having one global cache, as caches need to be 
adjusted depending on the actual pack.

In case anyone is interested in having a look at the way the I determine 
the cache parameters (which really are the key to optimizing 
performance), this is the line you would have to focus on: 
https://github.com/Byron/gitplusplus/blob/deltastream/src/git/db/pack_file.cpp#L103. 
The cache is used by the pack stream, whose core is in the 
unpack_object_recursive method (equivalent to unpack_delta_entry in the 
git source): 
https://github.com/Byron/gitplusplus/blob/deltastream/src/git/db/pack_stream.cpp#L247 
.

Kind Regards,
Sebastian
