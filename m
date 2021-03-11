Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0213C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 21:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6985F64F9A
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 21:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhCKVV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 16:21:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59361 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKVVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 16:21:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADA4CB599A;
        Thu, 11 Mar 2021 16:21:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lFjsL1ra8usgi6hwDCYDLEet2NM=; b=etOakl
        lygBcjNPe88spUvC7RIQkfqjD64vIn2MuoXUe4D6jZQAhC7qrvToxXKMEIPi3a1P
        32y6BrNXpZlWPooG35HR2AwY75zxrWTRRVdrViq1l+z9DWEAtfultYxouXXtij8E
        aAXILq32XO/o0USIFW1rWGc/auYztaqai822M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nqx5HY5v6A9gS5vSChLbWg4lkiMg4+1+
        71PqB9K29W2EAfA1/fIc/QUIGXHpRiYQEtRfzQNSZFl5j2whmX8OmTwgPCaOLtGy
        BdZ3B+eQ8/lYLDUwmsyfFAePOmFB3BwntpT6Jj/CUwcd8m3tXSeeaRdSFVCH/E37
        EZvevza9/tw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A49BFB5998;
        Thu, 11 Mar 2021 16:21:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2986DB5995;
        Thu, 11 Mar 2021 16:21:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <xmqq4khih3gj.fsf@gitster.g>
        <20210311172251.2307015-1-jonathantanmy@google.com>
Date:   Thu, 11 Mar 2021 13:21:38 -0800
In-Reply-To: <20210311172251.2307015-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 11 Mar 2021 09:22:51 -0800")
Message-ID: <xmqqzgz9bd3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C475DEC2-82AF-11EB-B923-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Since we are not in the business of writing a performant HTTP
>> downloader, if we can update the codepath not to rely on our http.c
>> code, and instead spawn one of the command line tools written
>> specifically for the "download a single large file over HTTP"
>> usecase (like curl, wget or aria2c), wait for it to do its thing and
>> then concentrate on the processing specific to Git (like running
>> index-pack with various options), it would take us closer to the
>> "make clone resumable" dream, wouldn't it?
>> 
>> Thanks.
>
> We would have to figure out how to communicate any Git HTTP config
> variables to curl/wget etc. (and also declare a dependency on such a
> tool), but that could be done.

Sure, and we do not have to go all the way there in a single step.

We'd likely need to ship with a basic "download from this URL and
store it in this specified temporary file" (or "to this fd") and use
it as the default downloader.  We just need to design the interface
to that downloader (i.e. which we want to make replaceable) to be
not too intimate with the details of the side that spawns the
downloader (i.e. git and git-fetch), and other people can write
replacement as a thin wrapper around curl/wget etc. to contribute to
us.

Thanks.
