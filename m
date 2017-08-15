Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76010208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbdHOTyc (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:54:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751068AbdHOTyb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:54:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C55E9DFA2;
        Tue, 15 Aug 2017 15:54:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nll3JTL4FKLpWad2yNaBFB5s9AM=; b=mG/gtE
        2lZT6ZWsbMkH7wZCgs+RWPBkPEkPwn5KKyQet1Bq6KM5h7g5sKdH55HhmGV2pEUU
        bb19nCPI5Xu60liD2ZNyEbtvX3OuTCh15m/GsnjTZjPRdr4xOpnNN95jWp79IhqM
        K3ZBEb9BNvbWUscsDoPDY0McUGYFhuqpWeCug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tOSVCGoxqUg3vinjow66gxDebadXl1g3
        39ZeoymKzzZ7X3jsWiTw/qtupvLIhsNkyBIrJYJa8Xa/8uygKP2FmX5Eta/YRzCB
        fB3nWntAhlMHGhPs2zeseNWJdR8LLGYataeU44B6t7FqTfHvjxxuig2PAl0RsEi/
        C8zUj3CwuVE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1505B9DFA1;
        Tue, 15 Aug 2017 15:54:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 794F59DF9F;
        Tue, 15 Aug 2017 15:54:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 3/3] diff: define block by number of non-space chars
References: <cover.1502754962.git.jonathantanmy@google.com>
        <cover.1502491372.git.jonathantanmy@google.com>
        <cover.1502754962.git.jonathantanmy@google.com>
        <41a7ff674072559415f98b81ffde798d94aed2fc.1502754962.git.jonathantanmy@google.com>
Date:   Tue, 15 Aug 2017 12:54:22 -0700
In-Reply-To: <41a7ff674072559415f98b81ffde798d94aed2fc.1502754962.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 14 Aug 2017 16:57:43 -0700")
Message-ID: <xmqqy3qkppxt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8917034E-81F3-11E7-BB65-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The existing behavior of diff --color-moved=zebra does not define the
> minimum size of a block at all, instead relying on a heuristic applied
> later to filter out sets of adjacent moved lines that are shorter than 3
> lines long. This can be confusing, because a block could thus be colored
> as moved at the source but not at the destination (or vice versa),
> depending on its neighbors.
>
> Instead, teach diff that the minimum size of a block is 10
> non-whitespace characters. This allows diff to still exclude
> uninteresting lines appearing on their own (such as those solely
> consisting of one or a few closing braces), as was the intention of the
> adjacent-moved-line heuristic.

I recall that there is a logic backed by a similar rationale in
blame.c::blame_entry_score() but over there we count alnum, not
!isspace, to judge if a block has been split into too small a piece
to be significant.  I do not know which one is better, but if there
is no strong reason, perhaps we want to unify the two, so that we
can improve both heuristics at the same time?
