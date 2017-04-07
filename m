Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACFD020966
	for <e@80x24.org>; Fri,  7 Apr 2017 17:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932921AbdDGRfk (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 13:35:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:33986 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753290AbdDGRfj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 13:35:39 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EFC65845DB;
        Fri,  7 Apr 2017 13:35:37 -0400 (EDT)
Subject: Re: [PATCH v1] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     Stefan Beller <sbeller@google.com>
References: <20170406203732.47714-1-git@jeffhostetler.com>
 <20170406203732.47714-2-git@jeffhostetler.com>
 <CAGZ79kafbRQo2Of0H162ue5YzL7uA2PDu=sTy0=cEOejGTJhyw@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6aa9d888-54e6-4d43-db84-ce4ec4dfaca6@jeffhostetler.com>
Date:   Fri, 7 Apr 2017 13:35:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kafbRQo2Of0H162ue5YzL7uA2PDu=sTy0=cEOejGTJhyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/2017 6:48 PM, Stefan Beller wrote:
> On Thu, Apr 6, 2017 at 1:37 PM,  <git@jeffhostetler.com> wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach traverse_trees_recursive() to not do redundant ODB
>> lookups when both directories refer to the same OID.
>
> And the reason for this is that omitting the second lookup
> saves time, i.e. a lookup in the ODB of a sufficiently large
> repo is slow.
>
> My kneejerk line of thinking:
> * yes, it sounds good to reduce the number of ODB accesses.
> * But if we consider ODB lookups to be slow and we perform
>   a structured access, how about a cache in front of the ODB?
> * We already have that! (sort of..) 9a414486d9 (lookup_object:
>   prioritize recently found objects, 2013-05-01)
> * Instead of improving the caching, maybe change the
>   size of the problem: We could keep the objects of different types
>   in different hash-tables.
>
> object.c has its own hash table, I presume for historical and
> performance reasons, this would be split up to multiple hash
> tables.
>
> Additionally to "object *lookup_object(*sha1)", we'd have
> a function
>
> "object *lookup_object(*sha1, enum object_type hint)"
> which looks into the correct the hash table.
>
> If you were to call just  lookup_object with no hint, then you'd
> look into all the different tables (I guess there is a preferrable
> order in which to look, haven't thought about that).
>
>>
>> In operations such as read-tree, checkout, and merge when
>> the differences between the commits are relatively small,
>> there will likely be many directories that have the same
>> SHA-1.  In these cases we can avoid hitting the ODB multiple
>> times for the same SHA-1.
>
> This would explain partially why there was such a good
> performance boost in the referenced commit above as we
> implicitly lookup the same object multiple times.
>
> Peff is really into getting this part faster, c.f.
> https://public-inbox.org/git/20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net/

That looks interesting, but I question the probabilities for
my use case here.  When walking the trees and files in a single
commit, I have no expectation that I'll see the same tree OID
twice, so the cache is not really useful and may just add
overhead.  However, in a checkout or merge there is a high
expectation of visiting the same tree OID -- and most of the
time they are peers -- since commits tend to only change
isolated parts of the tree.  (I'm not going to worry about the
case where someone moves an entire sub-tree to somewhere else
in the tree and violates my peer assertion.)

I did notice that we do 2 independent passes during checkout.
First to compare the old and new commits.  Then to compare the
new with the worktree.  So we touch each tree object 3 times.

My patch helps the first, but does nothing for the second.
Hopefully the cache is helping it (but I have not measured that).


>
>> TODO This change is a first attempt to test that by comparing
>> TODO the hashes of name[i] and name[i-i] and simply copying
>> TODO the tree-descriptor data.  I was thinking of the n=2
>> TODO case here.  We may want to extend this to the n=3 case.
>
>>
>> ================
>> On the Windows repo (500K trees, 3.1M files, 450MB index),
>> this reduced the overall time by 0.75 seconds when cycling
>> between 2 commits with a single file difference.
>>
>> (avg) before: 22.699
>> (avg) after:  21.955
>> ===============
>
> So it shaves off 4% of the time needed. it doesn't sound like a
> break through, but I guess these small patches add up. :)

Agreed, but on the Windows source repo, it can take 30 seconds to
do a "checkout -b" (without changing the actual HEAD commit).
That's just for the housekeeping of ensuring you get a clean
worktree.  If I can knock off 5% here with minimal impact
and without changing any file formats, I'll take it.

And if I can just repeat that n times...  :-)

>
>>         for (i = 0; i < n; i++, dirmask >>= 1) {
>> -               const unsigned char *sha1 = NULL;
>> -               if (dirmask & 1)
>> -                       sha1 = names[i].oid->hash;
>> -               buf[i] = fill_tree_descriptor(t+i, sha1);
>> +               if (i > 0 && (dirmask & 1) && names[i].oid && names[i-1].oid &&
>> +                       !hashcmp(names[i].oid->hash, names[i-1].oid->hash)) {
>
> Why do we need to check for dirmask & 1 here?
> This ought to be covered by the hashcmp already IIUC.
> So maybe we can pull out the
>                          if (dirmask & 1)
>                                  sha1 = names[i].oid->hash;
> out of the else when dropping that dirmask check?

I was wondering about the test in the else clause.
Just now I put a quick assert in there and it went off,
so I'm not going to change this.

Thanks
Jeff
