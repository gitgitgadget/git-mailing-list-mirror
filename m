Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB5F20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 14:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbdK2Ovi (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 09:51:38 -0500
Received: from siwi.pair.com ([209.68.5.199]:18533 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753395AbdK2Ovh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 09:51:37 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4C1C1844DA;
        Wed, 29 Nov 2017 09:51:36 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E82B1844D4;
        Wed, 29 Nov 2017 09:51:35 -0500 (EST)
Subject: Re: [PATCH v5 5/6] rev-list: add list-objects filtering support
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jonathantanmy@google.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <20171121205852.15731-1-git@jeffhostetler.com>
 <20171121205852.15731-6-git@jeffhostetler.com>
 <20171122200853.GB11671@aiede.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <679d4985-884a-c27e-8dd4-10d79b60534d@jeffhostetler.com>
Date:   Wed, 29 Nov 2017 09:51:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171122200853.GB11671@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/22/2017 3:08 PM, Jonathan Nieder wrote:
> Hi,
> 
> Jeff Hostetler wrote:
> 
>> Teach rev-list to use the filtering provided by the
>> traverse_commit_list_filtered() interface to omit
>> unwanted objects from the result.
>>
>> Object filtering is only allowed when one of the "--objects*"
>> options are used.
> 
> micronit: the line widths seem to be uneven in these commit messages,
> which is a bit distracting when reading.

ok

> 
>> When the "--filter-print-omitted" option is used, the omitted
>> objects are printed at the end.  These are marked with a "~".
>> This option can be combined with "--quiet" to get a list of
>> just the omitted objects.
> 
> Neat.  Can you give a quick example?

I can put part of this in the V6 version, but here is a quick example.

     $ git rev-list --objects HEAD
     0629eb0173b5de0fb664e24bd4292988b2af1290
     b2eaab8088df7ddad7f134e7b5144892b9646749
     21b9d3ce3550213ac7de1391a518ab83f16912a2
     3760f5a324c290c4f3518f087e2bdedd9d8f9ce4 large.1000
     b3b5c5d37a767d73101e5a27393af2682bda4fd7 large.10000
     472cd9f4ed2a4804bcc2a2865e1a3ae00742eb01
     
     $ git rev-list --objects HEAD --filter=blob:none --filter-print-omitted
     0629eb0173b5de0fb664e24bd4292988b2af1290
     b2eaab8088df7ddad7f134e7b5144892b9646749
     21b9d3ce3550213ac7de1391a518ab83f16912a2
     472cd9f4ed2a4804bcc2a2865e1a3ae00742eb01
     ~3760f5a324c290c4f3518f087e2bdedd9d8f9ce4
     ~b3b5c5d37a767d73101e5a27393af2682bda4fd7
     
     $ git rev-list --objects HEAD --filter=blob:limit=5000 --filter-print-omitted
     0629eb0173b5de0fb664e24bd4292988b2af1290
     b2eaab8088df7ddad7f134e7b5144892b9646749
     21b9d3ce3550213ac7de1391a518ab83f16912a2
     3760f5a324c290c4f3518f087e2bdedd9d8f9ce4 large.1000
     472cd9f4ed2a4804bcc2a2865e1a3ae00742eb01
     ~b3b5c5d37a767d73101e5a27393af2682bda4fd7
     
     $ git rev-list --objects HEAD --filter=blob:limit=5000 --filter-print-omitted --quiet
     ~b3b5c5d37a767d73101e5a27393af2682bda4fd7


> 
> Using --quiet for this feels a bit odd, since it previously meant
> to print nothing to stdout.  I wonder if there's another way ---
> e.g.
> 
> 	--print-omitted=(yes|no|only)

Yeah, now that you say that it does seem a little odd.  I could
go either way here.  My expected usage was to be able to do a
commits-and-trees fetch and then do before doing a checkout, do
a narrow fetch of just the blobs in the tip that were omitted
when the commit and trees were received.

> 
> If I wanted to list all objects matching a filter, even objects
> that are not reachable from any ref, is there a way to do that?
> (Just curious, trying to think about this interface.)

I'm building on rev-list, so you can give it one or more refs or
revision ranges and it will traverse all of them and print any OIDs
it finds during the traversal.

I don't know of any way to visit unreachable objects, without using
something like GC.

> 
>> Add t6112 test.
> 
> This part doesn't need to be in the commit message.  More generally,
> anything I could more easily learn from the code or diffstat doesn't
> need to be in the commit message: the commit message is about the
> "why" more than the details of what in the code changed.
> 

ok

>> In the future, we will introduce a "partial clone" mechanism
>> wherein an object in a repo, obtained from a remote, may
>> reference a missing object that can be dynamically fetched from
>> that remote once needed.  This "partial clone" mechanism will
>> have a way, sometimes slow, of determining if a missing link
>> is one of the links expected to be produced by this mechanism.
> 
> Does this mean the <filter-spec>s will be part of the wire protocol?
> I'll look more carefully at them below with that in mind.

yes.  a later commit will send the given <filter-spec> to the
server.  the idea is that clone and fetch will accept a filter
argument, pass that to the server, and have upload-pack/pack-objects
generate an incomplete packfile that omits unwanted objects.

so you could do something like:

     $ git clone --no-checkout --filter=blob:none URL .

then either [1] explicitly request the omitted blobs/objects for a
tip commit or (in the case of a sparse-checkout) just the blobs
for a portion of a tip commit and then do a normal checkout.
or [2] rely on the (future) fetch-objects code to dynamically
fetch the required omitted blobs during a checkout.

Or if you know you (probably) never want gigantic blobs, do
something like:

     $ git clone --filter=blob:limit=1m URL .

which would give you a mostly complete view repo, but just exclude
files > 1MB.  Those blobs could then be demand loaded as needed
later.


> 
>> This patch introduces handling of missing objects to help
>> debugging and development of the "partial clone" mechanism,
>> and once the mechanism is implemented, for a power user to
>> perform operations that are missing-object aware without
>> incurring the cost of checking if a missing link is expected.
> 
> I had trouble understanding what this paragraph is about.  Can you
> give an example?

The concept of filtering during a clone or fetch leads to
intentionally omitted objects (from the point of view of the
filter-er -- usually the server).  The receiving client now
has "intentionally missing" objects.  The "promisor" concept
will be introduced later to address them.

Certain git operations fail when there are missing objects
(because git assumes any missing object is a corruption of some
kind).  There are times, however, when we want to allow the
operation to continue without error and without accidentally
demand loading the missing objects.

In the context of this commit, I added an option to rev-list
to print the missing objects seen during a traversal.  This
is independent of filtering.  For example, the client could
do a partial clone and then ask to see what blobs it would
need to checkout master:

     $ git clone --no-checkout --filter=blob:none URL .
     [...]

     $ git rev-list --objects HEAD --filter=blob:none --filter-print-omitted --quiet
     ~975fbec8256d3e8a3797e7a3611380f27c49f4ac
     ~3760f5a324c290c4f3518f087e2bdedd9d8f9ce4
     ~587be6b4c3f93f93c489c0111bba5596147a26cb

     $ git rev-list --objects master --missing=print --quiet
     ?975fbec8256d3e8a3797e7a3611380f27c49f4ac
     ?3760f5a324c290c4f3518f087e2bdedd9d8f9ce4
     ?587be6b4c3f93f93c489c0111bba5596147a26cb

Note that this 2nd invocation of rev-list does not know about the
filtering criteria used for the clone (or the last fetch); it
just knows what blobs are currently missing from the local repo.

Note that the missing-list may be a subset of that printed by
the --filter-print-omitted option because of demand loading
or changing filter criteria over successive fetches.  So there
may be fewer actual missing blobs than what a filtering traversal
would report.

So the 2nd invocation can be used as debugging for later
partial clone, partial fetch, and pack-object commands.
As of this state in the patch series (part 1), the --missing
option is mainly for debugging.

I also allow --missing=allow-any to not complain if any
objects are missing.  In a later commit we'll add --missing=allow-promisor
to say only allow intentionally missing objects, but still fail
for unexpected missing objects (corruptions).

This is better seen in the next commit in this series which
adds the --missing option to pack-objects.  Normally, pack-objects
would only be run on a server with a complete view of the repo,
but it could be run on a partial clone and that invocation would
stumble over missing objects.  So in that more advanced usage,
it could be helpful.  For example, a repo serving as a proxy
could do a partial clone/fetch to avoid large objects and serve
that same subset to end-clients without fear of getting a missing
object error.

> 
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   Documentation/git-rev-list.txt      |   4 +-
>>   Documentation/rev-list-options.txt  |  36 ++++++
>>   builtin/rev-list.c                  | 108 ++++++++++++++++-
>>   t/t6112-rev-list-filters-objects.sh | 225 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 370 insertions(+), 3 deletions(-)
>>   create mode 100755 t/t6112-rev-list-filters-objects.sh
> 
> Looks reasonably concise, good.
> 
> [...]
>> --- a/Documentation/git-rev-list.txt
>> +++ b/Documentation/git-rev-list.txt
>> @@ -47,7 +47,9 @@ SYNOPSIS
>>   	     [ --fixed-strings | -F ]
>>   	     [ --date=<format>]
>>   	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
>> -	       [ --unpacked ] ]
>> +	       [ --unpacked ]
>> +	       [ --filter=<filter-spec> [ --filter-print-omitted ] ] ]
> 
> Does this mean --filter is only useful with --objects?  E.g. I can't
> use it to filter commits?

Right --filter only works with --objects because we need
to force the full traversal of each commit.  And right, I'm
not looking to filter commits at this point.  rev-list and friends
already have command line args to handle various refs and ranges.
And we already have shallow clone.  So I didn't want to alter the
existing commit iteration mechanism.

> 
>> +	     [ --missing=<missing-action> ]
> 
> --missing=(error|allow-any|print) would be more informative and about
> equally concise.
> 
> Since this is mainly for debugging, does it have a different
> compatibility guarantee from other options?  Could it be named
> accordingly to set expectations?

that version of the doc formatting is fine.

as for the naming, i'd rather keep it as is since i think it will
have uses than just debugging.


> 
> [...]
>> +The form '--filter=blob:none' omits all blobs.
> 
> Sounds sensible.
> 
>> ++
>> +The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
>> +or units.  The value may be zero.
> 
> On second thought, doesn't blob:limit=0 mean blob:none is not needed?
> Is it for future consistency with tree:none?

yes, blob:none and blob:limit=0 now mean the same thing.  they didn't
at one point -- an earlier version of the latter also included an ".git*"
special files regardless of size.  that got taken out recently.  so i'm
ok with getting rid of the former if we want.

WRT to tree:none, i have not gone deep on any tree filters yet.  But I
could envision, a tree:none and maybe an enhanced sparse filter.
Mainly because I was focusing on blobs.

There are some round-trip issues with filtering trees that we'll get
into later with fetch and/or dynamic object loading and I wanted to
avoid that for the moment.

> 
> What units do [kmg] use? Are they GB, GiB, or one of the variants in
> between?

powers of 1024.  i'll add that to the text.  thanks.

> 
>> ++
>> +The form '--filter=sparse:oid=<oid-ish>' uses a sparse-checkout
>> +specification contained in the object (or the object that the expression
>> +evaluates to) to omit blobs that would not be not required for a
>> +sparse checkout on the requested refs.
> 
> This one makes me a little nervous because it would mean we're
> planning on adding sparse-checkout specifications to the wire
> protocol.  Maybe that's okay --- they're already part of the on-disk
> format --- but it makes me nervous because the sparse-checkout format
> is not so great, as I believe MS has already noticed.
> 
> What is an <oid-ish>?  Can it just say <blob>?  How would this one
> work when passed over the wire?

I should have said <blob-ish>.  If I want to do a partial clone that
only gives me the blobs that I would need to do a sparse checkout,
I could use this.  I suggest a <blob-ish> here so that the client
could say something like "<ref>:<path>" (e.g. "master:my_work_area.txt")
in addition to allowing an actual SHA1.  Much more convenient when
the client doesn't yet have the repo cloned and can't lookup any SHAs
locally.

> 
>> ++
>> +The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
>> +specification contained in <path>.
> 
> Is this <path> relative to the cwd of the caller, or is it within some
> commit?

I initially envisioned this for local debugging so that I could
say "git fetch --filter=sparse:path=.git/info/sparse-checkout".
I currently allow it in the protocol to the server as I think
there may be uses for it (with appropriate guards).

> 
> Sorry it took so long to send this feedback / these questions.
> Hopefully it's useful nevertheless.
> 
> Thanks and hope that helps,
> Jonathan
> 

Very helpful.  Thanks!
Jeff

