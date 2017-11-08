Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A604C1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 05:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750988AbdKHFBr (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 00:01:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53924 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750964AbdKHFBq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 00:01:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E5E0B2504;
        Wed,  8 Nov 2017 00:01:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mGQAHOqt8xjjkyFeNvP1Hy5vuOg=; b=uSu+6H
        jHJmzCAeHEGuPJqb2Fj7jRc18oesh8q7Xcm5g6sf0xd/8PUfWLKNAO+4abJ9oPqb
        O0q3cPDza9fYJArdJTvy7jWGW5bxYYtGtl/n12YwHg/hSppW1s5KVriGJ7qV7HvS
        OBFN2AyzGDjxNcgosFnAnE0AhPc6egttwosro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gaGxPq3Q6gU9PQAbvs0sJoqf+OuLiT9i
        U/rl4sSrONvrGu75Cl9a+hZJGlURIt5Jhh1MDuQfujmF52m0i5LmX1RHmiJWuedG
        Pl/NhEocIBN2hm3jlpy3MmaVFoE9UDo00Iurijh2ZZyaub3Bl1nRwDz5Gm76PgNM
        KYP1oxp+dHw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45BB5B2503;
        Wed,  8 Nov 2017 00:01:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADEAAB2502;
        Wed,  8 Nov 2017 00:01:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 4/6] list-objects: filter objects in traverse_commit_list
References: <20171107193546.10017-1-git@jeffhostetler.com>
        <20171107193546.10017-5-git@jeffhostetler.com>
        <20171107152034.47686f6ece72ea3d43005b12@google.com>
Date:   Wed, 08 Nov 2017 14:01:43 +0900
In-Reply-To: <20171107152034.47686f6ece72ea3d43005b12@google.com> (Jonathan
        Tan's message of "Tue, 7 Nov 2017 15:20:34 -0800")
Message-ID: <xmqqr2t9l5xk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAADC418-C441-11E7-BF6E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Having said that, though, it might be safer to still introduce one, and
> relax it later if necessary - it is much easier to relax a constraint
> than to increase one.

It would also be more error prone to have such a long switch ()
statement, each of whose case arm needs to be carefully looked at.

While protection against attacks over the wire against the process
that receives the request is necessary and doing the quoting right
at this layer is one valuable component of it, we would need to be
careful about what features we allow the other side to request.  

For example, an innocent-looking use of get_oid_with_context() can
trigger an expensive operation, e.g. "master^{/sekritCodeName}", may
not just waste resources but also may reveal the presence of an
object that we might not want to leak to a stranger.  Limiting such
an abuse must sit at a lot higher layer than a byte-by-byte check
over the request like the code does.
