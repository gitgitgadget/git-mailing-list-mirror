Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409A01F462
	for <e@80x24.org>; Mon, 29 Jul 2019 15:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfG2P4P (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 11:56:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50565 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbfG2P4P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 11:56:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B614F15A4F7;
        Mon, 29 Jul 2019 11:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zVTJN2eEULOFWWjMqCPxXQFefGc=; b=AHnt/X
        ZFl2mWqqIo0VZLmviulfizYoVb/LYkneaz1AzvdowTbwM2Ey1mU8zWfB3CZLOsgJ
        AJQ85XDHQWoaI78ZC1YqnyOErfYGsCCThNtKEcP/z+zGjYwyEl2JVpboa9FFjqxq
        KDKP16deRKg0DDTC2aP4hih1dq1PEZ1UEfm/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I8DwACyAUP/b+q4Sf0fcRRwVEv4RQLsQ
        4JKZlHtXS0bDYQ0VOtTDfObGHAiYsKcCYa+ul5s7/LAXq0SLvOhaL5Q0yS1NWdTO
        BOvHCyImdWwN+ruyBwb/PA7BCgILbVC7sUnUh+Q/nubG9zVFd4DIDWGbrTpccdW2
        aIy03+r+tnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A68EF15A4F5;
        Mon, 29 Jul 2019 11:56:12 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD9D515A4F4;
        Mon, 29 Jul 2019 11:56:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/20] merge-recursive: exit early if index != head
References: <20190725174611.14802-1-newren@gmail.com>
        <20190726155258.28561-1-newren@gmail.com>
        <20190726155258.28561-5-newren@gmail.com>
        <xmqqblxgoamb.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHKWV6pNk_72xVTr5-rJ6n71Q9=SFa2H75_FUhJ8DrUQQ@mail.gmail.com>
Date:   Mon, 29 Jul 2019 08:56:10 -0700
In-Reply-To: <CABPp-BHKWV6pNk_72xVTr5-rJ6n71Q9=SFa2H75_FUhJ8DrUQQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 26 Jul 2019 16:26:27 -0700")
Message-ID: <xmqqy30gvnqd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 632BDADA-B219-11E9-AAAE-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Jul 26, 2019 at 12:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > Make sure we do the index == head check at the beginning of the merge,
>> > and error out immediately if it fails.  While we're at it, fix a small
>> > leak in the show-the-error codepath.
>>
>> As the call to repo_index_has_changes() is moved to the very
>> beginning of merge_recursive() and merge_trees(), the workhorse of
>> the merge machinery, merge_trees_internal(), can lose it.
>
> Is this just a re-summarization (a perfectly good one), or a
> suggestion for alternate wording for the commit message?

The usual "thinking aloud to see if I understood the patch and the
author's thought behind it, and give others a chance to correct me"
kind of review.
