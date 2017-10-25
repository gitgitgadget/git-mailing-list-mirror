Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336EA1FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 05:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbdJYFAh (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 01:00:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64562 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750822AbdJYFAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 01:00:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2B1FACCC0;
        Wed, 25 Oct 2017 01:00:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Uou+BM6gAhjlLoEe3JgzKTxGQE=; b=q1NkaZ
        O9YcAuSkOGBnJyhYjrb+S8nwaOYOx+7OdmKqkhQEU1L2ok7d/oQ/1+M7ET0nRIHR
        0ADpJiqMpXpnNWtWhiJgjzjKcLRFTfHve8yBKuy25QfT1pdlR3f4iOpJ5V281oMY
        nzCR2xxYZ2557zk7pqfSAqbZziL4Pz5gJ2ncc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F6pc1Y1N3wYIIxLFBNdvw3wwnwlivbF8
        oKRjTnVEpz6Tu9ND6IWDE6d//58+4GjC83h1Q6mh/bP0Trzzj5HcYAW4Nid5qQLA
        L5p98yBcxuwnYSUbIkd3TIMATqeRexnHoxb020mYHN16iH+ndg83A3KcCYchuX2b
        ffKEPRLL1Jw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E97ABACCBF;
        Wed, 25 Oct 2017 01:00:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E396ACCB1;
        Wed, 25 Oct 2017 01:00:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/13] WIP Partial clone part 1: object filtering
References: <20171024185332.57261-1-git@jeffhostetler.com>
Date:   Wed, 25 Oct 2017 14:00:32 +0900
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Tue, 24 Oct 2017 18:53:19 +0000")
Message-ID: <xmqqmv4fizyn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E57B2E4-B941-11E7-8498-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> I've been working with Jonathan Tan to combine our partial clone
> proposals.  This patch series represents a first step in that effort
> and introduces an object filtering mechanism to select unwanted
> objects.
>
> [1] traverse_commit_list and list-objects is extended to allow
>     various filters.
> [2] rev-list is extended to expose filtering.  This allows testing
>     of the filtering options.  And can be used later to predict
>     missing objects before commands like checkout or merge.
> [3] pack-objects is extended to use filtering parameters and build
>     packfiles that omit unwanted objects.
>
> This patch series lays the ground work for subsequent parts which
> will extend clone, fetch, fetch-pack, upload-pack, fsck, and etc.

OK, thanks for working well together.  So does this (1) build on
Jonathan's fsck-squelching series, or (2) ignores that and builds
filtering first, potentially leaving the codebase to a broken state
where it can create fsck-unclean repository until Jonathan's series
is rebased on top of this, or (3) something else?  [*1*]

I also saw a patch marked as "this is from Jonathan's earlier work",
taking the authorship (which to me implies that the changes were
extensive enough), so I am a bit at loss envisioning how this piece
fits in the bigger picture together with the other piece.


[Footnote]

*1* Not having the answer to this question does bother me, but it is
    perfectly fine if the answer is (2), especially while the series
    is in a WIP state.

