From: Sebastian Thiel <byronimo@googlemail.com>
Subject: Re: Git Pack: Improving cache performance (maybe a good GSoC practice)
Date: Wed, 30 Mar 2011 10:45:20 +0200
Organization: Byronimo
Message-ID: <4D92EDA0.8030309@googlemail.com>
References: <4D925B63.9040405@googlemail.com> <AANLkTin6z3hM7nyMqOUPdHrY9TmRVAzpchM+4O=S7KKj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 30 10:45:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4r1w-0004Af-QF
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 10:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab1C3Ip2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 04:45:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41179 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab1C3IpZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 04:45:25 -0400
Received: by bwz15 with SMTP id 15so787858bwz.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 01:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=a4F1i1r/YqX70EyD+MvIrRpPYmnjEXkeeY0/S7vnZz8=;
        b=xmCtRoANU9ZzDOtWRF/1PGFylpgzQkq8Iq1FtJVp3DOML1v/06vMNGTOJdECjwXMYy
         xhItigpAJNtNza5PuWBmdIJaj1fM5xJIMPuWi1ZzuRR30g0aiksRreAycILqMiOKgu+m
         DSGPfK+VN621TR7b80v8iYQFURPIs9/mabyh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=hBiIf1IW+GJAwzugSeG13bamLabAljkwGUtxtKz0TDy1yqeRQ/x97nad/6WgI2dqnT
         ccJEGzM8jVA0nHYQRkILsNLVk5eHjDDuY0hDEk5ZYCCZxgk5y5eCzCxt5iH47TibU0J/
         Hrqg3+GZ7ArUEO3C6CsTfKR//qXJ0jJKe3eQ4=
Received: by 10.204.136.1 with SMTP id p1mr745141bkt.105.1301474723730;
        Wed, 30 Mar 2011 01:45:23 -0700 (PDT)
Received: from [10.0.1.33] (91-65-187-112-dynip.superkabel.de [91.65.187.112])
        by mx.google.com with ESMTPS id q24sm134353bks.9.2011.03.30.01.45.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 01:45:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15pre) Gecko/20110207 Shredder/3.1.9pre
In-Reply-To: <AANLkTin6z3hM7nyMqOUPdHrY9TmRVAzpchM+4O=S7KKj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170366>

Hi Shawn,

Thank you for your detailed answer, especially about how deltas are 
ordered within the pack. First things first: Where does my random access 
(sha1 by sha1) access pattern come from ?
Its clearly just part of my test, as its easy to just iterate shas in 
the index and query their data in the pack. The pack verification though 
is not using sha1 order, but offset order, iterating the pack from the 
smallest to the largest offset. This is true for the git implementation, 
as well as for my one, which is why I would believe the access pattern 
is quite sequential here.
When reading the reply, at first I thought we agreed that pack 
verification is sequential, but what confused me is one of your last 
statement: "First, pack verification is horrifically random, since its 
by SHA-1 order and not sequential order".

Nonetheless, you are absolutely right that the sha1 ordered access is 
nothing that would usually happen in real life, but I didn't yet 
implement commit walking or tree iteration.

What stays is my observation that a larger, or lets say, more adaptive 
amount of entries, can greatly improve performance. The git-python test 
actually iterates commits, new to old, iterates the respective trees 
depth first, and streams all blobs. As I understand it, this is a common 
access pattern, which would greatly benefit from a larger entry cache. 
It improved performance from 14mb/s to 34mb/s, I used about 1000 entries 
in the cache, and a memory cap of 27mb.
The default pack-verify implementation would also benefit from more 
cache entries
Maybe the default of 256 entries is sufficient if the trees are iterated 
breadth first, but to my mind depth first would be a valid access 
pattern as well.

The simplicity of the cache to me is the right approach, but I cannot 
agree with its statically allocated amount of entries, as it apparently 
doesn't suit any but the smallest packs I tried. Even though it might 
not be statistically relevant, completely disabling the cache boosted 
the git-python test
described previously by 1mb/s, reproducibly, which seems to show that 
the cache can hurt if there aren't enough entries at least.

To my mind, changing the cache to be per-pack with dynamically allocated 
entries depending on the average size of uncompressed objects will help 
performance enough to be worth the effort.

Please see some more comments further down the email.
Kind Regards,
Sebastian

On 03/30/2011 12:45 AM, Shawn Pearce wrote:
> On Tue, Mar 29, 2011 at 15:21, Sebastian Thiel<byronimo@googlemail.com>  wrote:
>> I am currently working on a c++ implementation of the git core, which for
>> now includes reading and writing of loose objects, as well as reading and
>> verifying pack files.
> Have considered wrapping libgit2 with a C++ binding? Just curious.
The project appears to be silent for nearly 5 months now, and it is in a 
rather early stage of development. There is no delta cache yet, nor is 
there a sliding window mmap implementation which would be required on 32 
bit systems, at least if you want to have big file support.
>> Actually, this is not the first time I do this, as I
>> made my first experience in that matter with a pure python implementation of
>> the git core (https://github.com/gitpython-developers/gitdb).
> I think I saw this the other week... why this project vs. using Dulwich[1]?
>
> [1] http://samba.org/~jelmer/dulwich/
Jelmer and I talked about how both projects could benefit from each 
other, but we dropped the idea once it turned out that the licenses are 
quite incompatible (gpl vs. bsd). Besides, I like big file support, 
which also means that the system should internally stream all data, 
using a stream-like interface. Dulwich currently puts all data into RAM, 
and so does git. Gitdb uses stream interfaces exclusively, but 
admittedly I still didn't implement a delta decompression that would 
work without plenty of buffers ... but that's a different topic.
>> This time
>> though, I wanted to see whether I can achieve better performance, and how I
>> can make git more suitable to handle big files.
> A noble goal...
... which can be reached :). Git-like databases could greatly improve 
the performance of existing technologies, like package managers or 
update systems (for games, for instance) if people wouldn't have to 
re-download whole packages although only a few bytes/files changed in 
the new version. Having a customizable git-library for this would allow 
anyone to easily implement his custom git-like database solution to 
optimize these kinds of transfers. This is what drives me.
>> When profiling my initial uncached version of my pack reading
>> implementation, I noticed that most of the time was actually spent in zlibs
>> inflate method.
> Yes. The profile is somewhere in this ballpark if Git is doing
> rev-list --objects, aka the "Counting" phase of a git clone:
>
> - 30% in zlib inflate()
> - 30% in object map lookup/insertion
> - 30% misc. elsewhere
>
>> The major difference turned out to be the way the cache works. Git has a
>> small delta cache with only 256 [hardcoded] cache entries and a default
>> memory limit of 16mb. There it stores fully decompressed objects. It maps
>> objects to entries by hashing their pack offsets into the available range of
>> entries.
> Right, a very simple cache. FWIW, I've tried to use more complex cache
> rules inside of JGit, to no avail. A more complex cache implementation
> (e.g. one that supports a limited number of collisions in the hash
> buckets and uses a full LRU) runs slow enough relative to this simple
> cache that performance actually gets worse.
>
>> When the pack is accessed sequentially, the cache will be filled
>> with related uncompressed objects, which can in turn reduce the time
>> required to apply the next delta by a huge amount, as only a single delta
>> has to be applied instead of a possibly long delta chain.
> Yes... mostly.
>
>> As git appears to
>> pack deltas of related objects close to each other (regarding their offset
>> in the pack),
> This isn't true. Git packs object by time, *not* delta ordering.
> However objects are delta compressed by commonality on tree path *and*
> time. An example repository I like to play with is the linux-2.6
> repository; in that repository the pack is around 370 MiB. If you
> break the pack up into 1 MiB slices by offset, you will find that an
> object at the end of a 50 deep delta chain touches about 50 unique 1
> MiB slices in order to build itself up.  :-)
>
> This is caused by things being clustered by both time and path. If a
> path is heavily modified within a short time period, sure, those will
> be clustered together in the file. But if a path is rarely modified,
> its objects will be distributed throughout the file.
>
>> the cache will be hit quite often automatically.
> The hit rate happens to work well because most uses access less than
> 256 distinct similar things at once. I forget what the stats are for
> the linux-2.6 repository, but I think there are less than 256 unique
> directories. As Git walks through the history sequentially from
> most-recent to least-recent, its priming the cache with objects that
> have very short delta chains and are thus more likely to be used as
> delta bases for objects later in the file. Since each directory or
> file acts as a delta base for someone else later, its likely to be in
> this cache as the reader walks backwards through time. As bases
> switch, the cache is updated at a relatively low penalty, because the
> new base was itself recently accessed using the base that is already
> in the cache.
>
> The simple % 256 rule the cache uses is effective because objects are
> pretty randomly allocated as far as offsets go in the file. We just
> damn lucky. :-)
>
>> This cache implementation is clearly suitable for sequential access.
> Yes.
>
>> Both cache types are optimized for different kinds of access modes, and both
>> are required to efficiently deal with everything git usually has to do.
>> Hence I changed my cache to support both modes, and rerun the pack
>> verification test.
>>
>> The result was better than expected, as the my implementation now takes the
>> lead by a tiny amount (25.3s vs. 26.0s) with a 16mb cache size. On my way to
> This isn't a very significant speed difference given the differences
> in implementation. We're not really looking to shave 3% off the
> running time for operation X, we're looking to shave>10%.
>
>> make it even faster, I experimented with different cache sizes, amounts of
>> entries and of course different packs, which ranged from 20mb to 600mb,
>> which helped me fine tune the relations of these variables.
>> In the end, with a cache of 27mb, my implementation took 20.6s, whereas the
> OK, this is pretty significant. Saving 21% of the running time, at the
> expense of an extra 11M of working set.
>
> But the verify pack workload is pretty useless, nobody accesses data
> by SHA-1 order. Most uses of Git are going backwards through time. log
> and blame are the two notable things that happen *a lot* and that
> users complain about being slow. These also aren't random accesses,
> there is a definite pattern and the pattern can be exploited. I'm
> really only interested in improving these two patterns.
>
> As far as verify-pack improving, Junio improved it by switching to use
> index-pack with the new --verify flag. There really isn't a faster way
> to scan through a pack than the way index-pack does it.
>
> So, all I'm trying to say is, verify-pack isn't the right thing to
> target when you are looking at "how do I make Git faster".
>
I couldn't find the index-pack --verify flag in 1.7.4.2 - but maybe it 
is even more bleeding edge, or I am looking in the wrong place.
>> -- Conclusions --
>> * delta cache needs to deal with random and sequential access.
> I'm not sure where the random access case is coming from. Who is doing
> random access except verify-pack?
>
See top of reply.
>> * current implementation deals with sequential access only, which is only
>> suitable for pack verification,
> Not true. First, pack verification is horrifically random, since its
> by SHA-1 order and not sequential order. Second, every other use of
> the pack data is generally sequential in time, because every other use
> is starting from the current revisions as found from the refs and
> walking backwards in time, which is forwards sequentially in the pack.
>
