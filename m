Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1271F461
	for <e@80x24.org>; Thu, 22 Aug 2019 15:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbfHVPt3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 11:49:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64113 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbfHVPt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 11:49:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 311FB175790;
        Thu, 22 Aug 2019 11:49:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c7HKDKmWE7pWWBA5s57qbCOVbCc=; b=g+N/ih
        1aF8fWw5hcDkhVGWbHNE7rxgYLG4LShExX1KNBWuu8F1rMaqfZn9awl7LWsYxDv4
        FZ4EarHud729Uv6NwzNdynRlcvNWXbPA+8/AXaOYVVHKdvM+/iPbT9pzi8mntoRV
        ob0Pdb0NUu5c7K+k6Cd/kdgJd8VqyT6LlmMEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mIoG9XAm2yB+orzhXHdgSA6DZXVv1ZPv
        hKXyWhP61YO3kB5jduq2zjmxwUFG3nH3L5+hGEcfHMKho5g9w+ppGPa7HPMT0gFS
        C7JezDPcaklO0Auw+GQHmUqNkG3WEkGaGY+Kxob6filj8uvcNiTnMJosx8a6XAgl
        3lV0i7HlhrU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29B8B17578F;
        Thu, 22 Aug 2019 11:49:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 942F117578E;
        Thu, 22 Aug 2019 11:49:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ben Wijen <ben@wijen.net>, git@vger.kernel.org,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/1] rebase.c: make sure the active branch isn't moved when autostashing
References: <20190820201237.10205-1-ben@wijen.net>
        <20190821182941.12674-1-ben@wijen.net>
        <20190821182941.12674-2-ben@wijen.net>
        <nycvar.QRO.7.76.6.1908221418540.46@tvgsbejvaqbjf.bet>
Date:   Thu, 22 Aug 2019 08:49:26 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908221418540.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 22 Aug 2019 14:27:29 +0200 (CEST)")
Message-ID: <xmqqftltqjy1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C1A31B2-C4F4-11E9-8D77-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As with this commit the reset must never change the active branch,
>> the 'HEAD is now at ...' message has now been removed.
>
> Actually, I am not so sure that I like this change.
>
> Previously, users had a chance to figure out to which revision the
> worktree was reset, before switching the branch (because switching the
> branch we _do_, via `git checkout master`).

Hmph, that only happens when --autostash is in effect and actually
had created a stash, no?  If your working tree is clean, or if you
did not pass --autostash, "HEAD is now at ..." is not reported.
I am not sure why that particular piece of information is only
useful in the case we actually created a stash and unnecessary if we
did not create a stash.

When we do not create a stash, the output starts from "First,
rewinding head to replay your work on top of it...", which sort of
gives a warm and fuzzy impression that it is reporting what it is
doing, but without giving the most useful information (i.e. what
"it" refers to).

Because I am all for preserving the existing behaviour as much as
possible when fixing real bugs, I would not strongly object to your
idea of resurrecting the message.  But I am not sure if the existing
message was all that useful in the first place.  I'd rather see
these messages that were only emitted when --autostash was given
removed first (like this patch does), and then the "First rewinding..."
message reworded to show where we rebuilt the history on top of.

Other than that, thanks for a good review, and thanks Ben for
working on this.
