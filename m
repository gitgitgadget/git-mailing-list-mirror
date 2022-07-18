Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1988C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 14:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiGROIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 10:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiGROIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 10:08:46 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E827CD1
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 07:08:44 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D6F193F40F3;
        Mon, 18 Jul 2022 10:08:43 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [74.205.145.90])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A4E8B3F4090;
        Mon, 18 Jul 2022 10:08:43 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] fetch-pack: write effective filter to trace2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20220715172943.2681492-1-jonathantanmy@google.com>
 <770e3c15-90ea-7d6c-4854-608c0ad8cbaa@jeffhostetler.com>
 <xmqqmtdaz0vt.fsf@gitster.g>
Message-ID: <de8d38fc-23e3-b876-87e8-7b4193bff44c@jeffhostetler.com>
Date:   Mon, 18 Jul 2022 10:08:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtdaz0vt.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/15/22 2:28 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> On 7/15/22 1:29 PM, Jonathan Tan wrote:
...
>>> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", "none");
> 
> At the first glance, this seems to lose data, because you should be
> able to use expand_list_objects_filter_spec() to report the filter
> spec.  But this is reporting the filter that was actually in effect,
> so it is OK.
> 
> But the same question about "none" remains.

Yeah, the use of "none" gave me pause, but I didn't have a better idea
at the time.  I guess we have:
(a) requested, supported, used.
(b) "none used because the server doesn't support it" and
(c) "none used because the user didn't request it" cases,
right?

Perhaps it would be better to do:
     if (server_supports_filtering && args->filter_options.choice)
         trace2_data_string("fetch", r, "filter/effective", spec);
     else
         trace2_data_string("fetch", r, "filter/unsupported", spec);

Using two different keywords.

So that the log only contains "filter/effective" when it was actually
used.  And there is no "filter/effective" event when (for whatever
reason) it was not in effect.

Then the "filter/unsupported" event helps you with debugging.  Did they
hit a server that doesn't support filtering or did they have a typo in
their filter spec?

Then don't emit a message at all for the "not requested" case.  And you
can use the Git version number to know how to interpret it.  There are
other places where we don't bother sending messages where the value is
a zero or empty.

Jeff
