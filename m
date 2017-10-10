Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB60620372
	for <e@80x24.org>; Tue, 10 Oct 2017 01:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754461AbdJJBQi (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 21:16:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64271 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754079AbdJJBQh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 21:16:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D85BCB366E;
        Mon,  9 Oct 2017 21:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vCZgC8qbZ4DZKOu+TqCva51cLKk=; b=VjiWoc
        hVF1S8Kik+FIwlD+hgszpbXH6jPZzIu+pYMsR9+6Vz4u+kFXgANi2wvQJzRwDzEJ
        2j3hLAYMgSKyl042jZDVh4CMXFox/pX1kU0ydvMJxo6/38DZqCaGGyWwOy1W05kD
        TOP9CFSaRfM6NisT/LNm4M7o4ml33ggApPCY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N9yLJHju5KFE2D3Y54WpdamAMHcaIO+A
        TGs36Ua8CZxcQUbdcmQNEGs9dVE91XG26qGJmiJCPfyjeN29eNRUnXOu0D/JYu0D
        SE4oyiR1ehVe66tFWAQdD+d+DG5JqL9rrs3BlAEnlo5TNDy+XZLCrun7ktd4AmT2
        6PjaJTvi/Sw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0093B366D;
        Mon,  9 Oct 2017 21:16:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39ED7B366B;
        Mon,  9 Oct 2017 21:16:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 07/24] refs: convert resolve_refdup and refs_resolve_refdup to struct object_id
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
        <20171009011132.675341-8-sandals@crustytoothpaste.net>
Date:   Tue, 10 Oct 2017 10:16:29 +0900
In-Reply-To: <20171009011132.675341-8-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 9 Oct 2017 01:11:15 +0000")
Message-ID: <xmqqefqbredu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A614BC26-AD58-11E7-BE7C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> All of the callers already pass the hash member of struct object_id, so
> update them to pass a pointer to the struct directly,
>
> This transformation was done with an update to declaration and
> definition and the following semantic patch:
>
> @@
> expression E1, E2, E3, E4;
> @@
> - resolve_refdup(E1, E2, E3.hash, E4)
> + resolve_refdup(E1, E2, &E3, E4)
>
> @@
> expression E1, E2, E3, E4;
> @@
> - resolve_refdup(E1, E2, E3->hash, E4)
> + resolve_refdup(E1, E2, E3, E4)
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

As I mentioned in my response to the cover letter, quite a many of
these now pass NULL (i.e. "I do not care what commit the HEAD is at;
I only am interested in which branch I am on"), making major part of
this patch irrelevant.  The conflict resolution is trivial, and I do
not think rebasing is worth it, though.

