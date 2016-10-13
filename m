Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AE220989
	for <e@80x24.org>; Thu, 13 Oct 2016 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933133AbcJMSS0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 14:18:26 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:41722 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934791AbcJMSSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 14:18:25 -0400
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u9DIII9m010900
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Oct 2016 18:18:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.13.8/8.14.4) with ESMTP id u9DIIHlV017559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Oct 2016 18:18:17 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u9DIIFF0032125;
        Thu, 13 Oct 2016 18:18:16 GMT
Received: from [10.175.175.217] (/10.175.175.217)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Oct 2016 11:18:14 -0700
Subject: Re: Huge performance bottleneck reading packs
To:     Jeff King <peff@peff.net>
References: <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <d727ee5d-5f0f-e6df-3f83-35fe74641ace@oracle.com>
Date:   Thu, 13 Oct 2016 20:18:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2016 05:26 PM, Jeff King wrote:
> On Thu, Oct 13, 2016 at 09:20:07AM +0200, Vegard Nossum wrote:
>
>>> Does the patch below help?
>>
>> Yes, ~2m10s -> ~1m25s when I test a git fetch this morning (the other
>> variation in time may be due to different CPU usage by other programs,
>> but I ran with/without the patch multiple times and the difference is
>> consistent).
>> [...]
>> There are some 20k refs on the remote, closer to 25k locally.
>
> OK, that makes some sense. For whatever reason, your remote has a bunch
> of tags that point to objects you do not already have. That could
> happen, I think, if the remote added a lot of tags since you cloned
> (because clone will grab all of the tags), but those tags do not point
> to history that you are otherwise fetching (since fetch by default will
> "auto-follow" such tags).
>
> It might be interesting to see the results of:
>
>   # all the objects we have
>   git cat-file --batch-all-objects --batch-check='%(objectname)' >us
>
>   # all the objects the remote is advertising
>   git ls-remote origin | cut -f1 | sort -u >them
>
>   # what they are advertising that we don't have
>   comm -13 us them | wc -l
>
> My guess is that the number is relatively high. And that would explain
> why nobody else has really complained much; such a pattern is probably
> uncommon.

I get ~3,700 objects "they are advertising that we don't have".

They are all indeed tags which I don't have (nor want) locally.

>> The fetch doesn't actually get anything from the remote as everything is
>> already up to date (that makes the 2m40s times even more frustrating in
>> a way :-)). Here's count-objects:
>
> If the fetch is largely a noop, then that makes me wonder why we are
> spending even a minute in the "good" case. I wonder if there is some

It was user time I reported and this is over network, so some of it
might be IO wait on the network? With the (first) patch:

$ time git fetch

real    1m9.248s
user    0m40.808s
sys     0m2.996s

Also see the profile data below.

> other spot that is wasting CPU on some inefficient data structure
> related to the number of refs you have. If you can do any profiling that
> points to a hot spot, that would be interesting to see (and also whether
> a gc improves things).
>
> I see in find_non_local_tags() that we build up a sorted string_list via
> repeated calls to string_list_insert(), which will keep the thing sorted
> at each stage. That's not as efficient as just sorting at the end, but I
> think it's probably OK in practice because we actually feed it via
> for_each_ref(), whose output is sorted, and so we'd always just be
> appending to the end.

So without your patch I get these numbers:

   %   cumulative   self              self     total
  time   seconds   seconds    calls   s/call   s/call  name
  37.34     29.83    29.83 1948265116     0.00     0.00  strip_suffix_mem
  27.56     51.85    22.02    11358     0.00     0.01 
prepare_packed_git_one
  14.24     63.23    11.38 1924457702     0.00     0.00  strip_suffix
   4.88     67.13     3.90 26045319     0.00     0.00  find_pack_entry_one
   4.17     70.46     3.33 84828149     0.00     0.00  hashcmp
   3.28     73.08     2.62 79760199     0.00     0.00  hashcmp
   2.44     75.03     1.95                             const_error

the call graph data shows all the reprepare_packed_git() calls to come
from a chain like this:

do_for_each_ref
do_for_each_ref_iterator
ref_iterator_advance
files_ref_iterator_advance
ref_resolves_to_object
has_sha1_file
has_sha1_file_with_flags
reprepare_packed_git

the do_for_each_ref() calls come from prepare_replace_object(),
do_fetch(), find_common(), everything_local(),
check_for_new_submodule_commits(), and find_non_local_tags().

With your (first) patch I get this instead:

   %   cumulative   self              self     total
  time   seconds   seconds    calls  ms/call  ms/call  name
  29.41      0.25     0.25  4490399     0.00     0.00  hashcmp
  16.47      0.39     0.14   843447     0.00     0.00  find_pack_entry_one
  10.59      0.48     0.09    60490     0.00     0.00 
unpack_object_header_buffer
   4.71      0.52     0.04   167441     0.00     0.00  lookup_object
   3.53      0.55     0.03   843447     0.00     0.00  fill_pack_entry
   3.53      0.58     0.03   213169     0.00     0.00 
check_refname_component
   2.35      0.60     0.02   550723     0.00     0.00  strip_suffix_mem
   2.35      0.62     0.02   214607     0.00     0.00  insert_obj_hash
   2.35      0.64     0.02   158866     0.00     0.00  hashcmp
   2.35      0.66     0.02   153936     0.00     0.00 
nth_packed_object_offset

Do you have all the profile data you were interested in before I try a
'git gc'?

I really appreciate the quick response and the work you put into fixing
this, even when it's my fault for disabling gc, thanks!


Vegard
