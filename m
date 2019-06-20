Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142881F461
	for <e@80x24.org>; Thu, 20 Jun 2019 20:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfFTUJu (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 16:09:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56968 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfFTUJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 16:09:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E79951679F0;
        Thu, 20 Jun 2019 16:09:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S/SNJErbbWPGkEgx5S9U8zgx8DA=; b=ZEZxM6
        OCz23NP83ddvBR0w5P+nk+c85UiPOWqSSmidbjWYqIAGJMWOjOjVNWrGhIP98l9E
        6irtqXiYP36uqZFFYlJ7lTOumMP7oSbxJ2Aj2ofsdX48YCtSJs1HpGJCmRvdUPCt
        avKn0HN3TM6tRrOsOv0FQlG4uzESVV0JWptQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oiWEO5yRJOgkaqDCI9nEYXmFZtKV1ADf
        nYB+g9mnYlNtxjfbvVIp+A9LuBYFuO75A/gHE7mHPIq8dEARfaW+jWM0zfGXZ0Xm
        KA9dtJ01y2Il8snpKZHPJDvh4AaJd+OT2Vhzneqz1FdY7D0XYxOiNsRlL/YJEHUJ
        ppajvZA16W4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE00B1679EF;
        Thu, 20 Jun 2019 16:09:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33F321679EE;
        Thu, 20 Jun 2019 16:09:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>, git@vger.kernel.org,
        newren@gmail.com, t.gummerer@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com
Subject: Re: [GSoC][PATCH v5 4/5] cherry-pick/revert: add --skip option
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
        <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
        <20190618170650.22721-5-rohit.ashiwal265@gmail.com>
        <xmqqr27oq5z1.fsf@gitster-ct.c.googlers.com>
        <76359a86-0eb1-dd87-c36f-7bd2df8b0ae5@gmail.com>
Date:   Thu, 20 Jun 2019 13:09:46 -0700
In-Reply-To: <76359a86-0eb1-dd87-c36f-7bd2df8b0ae5@gmail.com> (Phillip Wood's
        message of "Thu, 20 Jun 2019 10:57:44 +0100")
Message-ID: <xmqqimt0m31x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A175DC0-9397-11E9-95E5-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> This one, and the in_progress_advice emitted from the patch 1/5, are
>> both bad in that they make calls to advise() without guarding it
>> with an advice.* configuration variable.
>
> I'm not sure we have one for cherry-pick/revert/rebase. At the moment
> they print advice advice for a failed pick unconditionally...

Yes, 1/5 does not introduce a new problem; it just makes it worse by
allowing the misdesign survive another update.  The one introduced
by 4/5 is genuinely new.

> ... Maybe that
> should be checking advice.resolveConflict though.

I think that is a sensible one, rather than inventing a new knob.

