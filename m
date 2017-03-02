Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9681F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 19:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbdCBTTc (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 14:19:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61666 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752083AbdCBTTa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 14:19:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77EA481E21;
        Thu,  2 Mar 2017 13:36:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s2fR1s5QXRfAMBnyyQu7bzdnda8=; b=NKu3w/
        zgBQWDZsnBYOfRGaQWRG1jTECY3hoebV3RXgKkfLncbSQ/aNgho8LYN/xyG6pt9r
        iYM95RZ/aV4VOL4b2nV7oU529BOyn8Ykm1W1xipG3zItExBu/LTGD8wMpPwhUbAt
        MbnIFKSsi1YdLsx+ruBbD9tWNHAtc8+7XwIu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mloHe4BC3ucQHOborWPy9kTaoxzT8zr6
        O67aMZQVemFWhg3s6K1hEOdGvtiBzqkmI3W3yT3COPzpjG9nlhBdFMSiADfNK2dO
        ZTtSr/AphUb82412b6I5PqfZYVMZMxcc4Ax43CjRKnvtrgHixGnMTuaGmvF7aWWQ
        9KaJZ5rjfqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7016E81E20;
        Thu,  2 Mar 2017 13:36:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CDD1281E1F;
        Thu,  2 Mar 2017 13:36:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peartben@gmail.com, benpeart@microsoft.com
Subject: Re: [PATCH 1/3] revision: unify {tree,blob}_objects in rev_info
References: <cover.1487984670.git.jonathantanmy@google.com>
        <cover.1487984670.git.jonathantanmy@google.com>
        <06a84f8c77924b275606384ead8bb2fd7d75f7b6.1487984670.git.jonathantanmy@google.com>
        <xmqq1suij8kr.fsf@gitster.mtv.corp.google.com>
        <20170228215937.yd4juycjf7y3vish@sigill.intra.peff.net>
Date:   Thu, 02 Mar 2017 10:36:29 -0800
In-Reply-To: <20170228215937.yd4juycjf7y3vish@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Feb 2017 16:59:37 -0500")
Message-ID: <xmqq7f47cyqa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2766630A-FF77-11E6-A2CF-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 28, 2017 at 01:42:44PM -0800, Junio C Hamano wrote:
>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> > It could be argued that in the future, Git might need to distinguish
>> > tree_objects from blob_objects - in particular, a user might want
>> > rev-list to print the trees but not the blobs. 
>> 
>> That was exactly why these bits were originally made to "appear
>> independent but in practice nobody sets only one and leaves others
>> off".  
>> 
>> And it didn't happen in the past 10 years, which tells us that we
>> should take this patch.
>
> I actually have a patch which uses the distinction. It's for
> upload-archive doing reachability checks (which seems rather familiar to
> what's going on here).

OK.  Thanks for stopping me ;-)
