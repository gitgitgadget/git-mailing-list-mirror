Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3178202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 18:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932396AbdJZSL2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 14:11:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:15528 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932332AbdJZSL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 14:11:27 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5D27884568;
        Thu, 26 Oct 2017 14:11:27 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C1F728455C;
        Thu, 26 Oct 2017 14:11:26 -0400 (EDT)
Subject: Re: [PATCH 01/13] dir: allow exclusions from blob in addition to file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
 <20171024185332.57261-2-git@jeffhostetler.com>
 <xmqq60b3iv79.fsf@gitster.mtv.corp.google.com>
 <b063dec4-b9c4-7145-9b57-7df22ccbc655@jeffhostetler.com>
 <xmqqpo9afu3s.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c881d4d1-f9c0-0360-a149-2cee12f144ee@jeffhostetler.com>
Date:   Thu, 26 Oct 2017 14:11:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqpo9afu3s.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 11:47 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> The existing code handles use cases where you want to read the
>> exclusion list from a pathname in the worktree -- or from blob
>> named in the index when the pathname is not populated (presumably
>> because of the skip-worktree bit).
>>
>> I was wanting to add a more general case (and perhaps my commit
>> message should be improved).  I want to be able to read it from
>> a blob not necessarily associated with the current commit or
>> not necessarily available on the local client, but yet known to
>> exist.
> 
> Oh, I understand the above two paragraphs perfectly well, and I
> agree with you that such a helper to read from an arbitrary blob is
> a worthy thing to have.  I was merely commenting on the fact that
> such a helper that is meant to be able to handle more general cases
> is not used to help the more specific case that we already have,
> which was a bit curious.
> 
> I guess the reason why it is not done is (besides expediency)
> because the model the new helper operates in would not fit well with
> the existing logic flow, where everything is loaded into core
> (either from the filesystem or from a blob) and then a common code
> parses and registers; the helper wants to do the reading (only) from
> the blob, the parsing and the registration all by itself, so there
> is not much that can be shared even if the existing code wanted to
> reuse what the helper offers.
> 
> The new helper mimicks the read_skip_worktree_file_from_index()
> codepath to massage the data it reads from the blob to buf[] but not
> really (e.g. even though it copies and pastes a lot, it forgets to
> call skip_utf8_bom(), for example).  We may still want to see if we
> can share more so that we do not have to worry about these tiny
> differences between codepaths.

I'm going to extract this commit, refactor it to try to share
more code with the existing read_skip_worktree_file_from_index()
and submit it as a separate patch series so that we can discuss
it in isolation without the rest of the partial-clone code getting
in the way.

The call to skip_utf8_bom() was captured in the new
add_excludes_from_buffer() routine that both add_excludes()
and my new add_excludes_from_blob_to_list() call.

> 
>> With my "add_excludes_from_blob_to_list()", we can request a
>> blob-ish expression, such as "master:enlistments/foo".  In my
>> later commits associated with clone and fetch, we can use this
>> mechanism to let the client ask the server to filter using the
>> blob associated with this blob-ish.  If the client has the blob
>> (such as during a later fetch) and can resolve it, then it can
>> and send the server the OID, but it can also send the blob-ish
>> to the server and let it resolve it.
> 
> Security-minded people may want to keep an eye or two open for these
> later patches---extended SHA-1 expressions is a new attack surface
> we would want to carefully polish and protect.
> 
