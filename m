Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F451F516
	for <e@80x24.org>; Thu, 28 Jun 2018 16:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965740AbeF1Q4Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:56:24 -0400
Received: from avasout08.plus.net ([212.159.14.20]:40396 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934599AbeF1Q4X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:56:23 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id YaDSfQcTqhidhYaDTf6Ffl; Thu, 28 Jun 2018 17:56:22 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=B6uXLtlM c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=UzDhSKQu6RL8ZGDIOXcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
Date:   Thu, 28 Jun 2018 17:56:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628114912.GA12901@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfM491vy+NKTrn4YrO3qPrGMPMgkBapMMXc3rdvB8U7zqct0tpm7IKPCWjaJ6GSlerqbVTj4aHB6oOna5h9+uwybDw8bhNFobstOZmI7gjMT+/3DaptOL
 fgw/tKEPly4q3ZvWgFicnKXWcIhNzICShS+c1d1EvGSy+0JmTcazyAYy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/06/18 12:49, Jeff King wrote:
> On Wed, Jun 27, 2018 at 07:39:53PM +0100, Ramsay Jones wrote:
> 
>> Since commit ed8b10f631 ("fsck: check .gitmodules content", 2018-05-02),
>> fsck will issue an error message for '.gitmodules' content that cannot
>> be parsed correctly. This is the case, even when the corresponding blob
>> object has been included on the skiplist. For example, using the cgit
>> repository, we see the following:
>>
>>   $ git fsck
>>   Checking object directories: 100% (256/256), done.
>>   error: bad config line 5 in blob .gitmodules
>>   error in blob 51dd1eff1edc663674df9ab85d2786a40f7ae3a5: gitmodulesParse: could not parse gitmodules blob
>>   Checking objects: 100% (6626/6626), done.
>>   $
>>
>>   $ git config fsck.skiplist '.git/skip'
>>   $ echo 51dd1eff1edc663674df9ab85d2786a40f7ae3a5 >.git/skip
>>   $
>>
>>   $ git fsck
>>   Checking object directories: 100% (256/256), done.
>>   error: bad config line 5 in blob .gitmodules
>>   Checking objects: 100% (6626/6626), done.
>>   $
>>
>> Note that the error message issued by the config parser is still
>> present, despite adding the object-id of the blob to the skiplist.
>>
>> One solution would be to provide a means of suppressing the messages
>> issued by the config parser. However, given that (logically) we are
>> asking fsck to ignore this object, a simpler approach is to just not
>> call the config parser if the object is to be skipped. Add a check to
>> the 'fsck_blob()' processing function, to determine if the object is
>> on the skiplist and, if so, exit the function early.
> 
> Yeah, this solution seems sensible. Given that we would never report any
> error for that blob, there is no point in even looking at it. I wonder
> if we ought to do the same for other types, too. Is there any point in
> opening a tree that is in the skiplist?

Note that the 'blob' object has already been 'loaded' at this
point anyway (and the basic 'object' checks have been done).

I did think about this, briefly, but decided that we should
only 'skip' the leaf nodes (blobs). (So, when processing
commits, trees and tags, we should not report an error for
that object-id, but that should not stop us from checking
the tree object associated with a commit, just because of
a problem with the commit message).

[Oh, wait - Hmm, each object could be checked independently
of all others and not used for any object traversal right?
(e.g. using packfile index). I saw fsck_walk() and didn't
look any further ... Ah, broken link check, ... I obviously
need to read the code some more ... :-D ]

>> I noticed recently that the 'cgit.git' repo was complaining when
>> doing an 'git fsck' ...
>>
>> Note that 'cgit' had a '.gitmodules' file and a 'submodule.sh'
>> script back in 2007, which had nothing to do with the current
>> git submodule facilities, ... ;-)
> 
> Yikes. I worried about that sort of regression when adding the
> .gitmodules checks. But this _is_ a pretty unique case: somebody was
> implementing their own version of submodules (pre-git-submodule) and
> decided to use the same name. So I'm not sure if this is a sign that we
> need to think through the regression, or a sign that it really is rare.

I don't have any numbers, but my gut tells me that this would
be very rare indeed. Of course, my gut has been wrong before ... :-D

> One thing we could do is turn the parse failure into a noop. The main
> point of the check is to protect people against the malicious
> .gitmodules bug. If the file can't be parsed, then it also can't be an
> attack vector (assuming the parser used for the fsck check and the
> parser used by the victim behave identically).

Hmm, yeah, but I would have to provide a means of suppressing
the config parser error messages. Something I wanted to avoid. :(

> That wouldn't help with your stray message, of course, but it would
> eliminate the need to deal with the skiplist here (and skiplists aren't
> always easy to do -- for instance, pushing up a non-fork of cgit to
> GitHub would now be rejected because of this old file, and you'd have to
> contact support to resolve it).

Good point.

>> I just remembered that I had intended to review the name of the
>> function that this patch introduces before sending, but totally
>> forgot! :(
>>
>> [Hmm, 'to_be_skipped' -> object_to_be_skipped, object_on_skiplist,
>> etc., ... suggestions welcome!]
> 
> The current name is OK to be, but object_on_skiplist() also seems quite
> obvious.

object_on_skiplist() it is!

Junio, do you want me to address the above 'rejected push'
issue in this patch, or with a follow-up patch? (It should
be a pretty rare problem - famous last words!)

ATB,
Ramsay Jones



