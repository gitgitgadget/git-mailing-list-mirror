Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01661C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3196109E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbhDLS1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 14:27:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56559 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhDLS1a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 14:27:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F999AAFC3;
        Mon, 12 Apr 2021 14:27:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YvVUP82bKR4y3+EGdzuHGAuEjl8=; b=VrNPJt
        G+NIGDgqJgMHKKoK+xgVIAKC2ZBMSz4uagVtRZRDOJTIiPJRmdMEBfYwJ2XOVOii
        QMXCRQP99oTpBMWxNDXLsHBIcpitsgDqdVKqTy0jvSHnHfmNM8Ja48i548gMcunF
        qXGxcbiym3I7MYY5RDAUWbbNgjYiOQPZFrQNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wdOpznnTdolrlujKrtZUUwbEK/gW9Yza
        eSxqrztgoC9mYpCTOugqXBV0QR+XaNCrqy3hCUr/XsfeuHh1HtZAtX6B0V6JjUEt
        3XCsYiX4QTTIh/DvpdOt8hYi7ZRb76mOSRlb55XmipdRfQ1tv7kDZ3OGOO4hMrns
        4nKSf08CTu8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 586E9AAFC2;
        Mon, 12 Apr 2021 14:27:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4D56AAFBE;
        Mon, 12 Apr 2021 14:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jerry Zhang <jerry@skydio.com>,
        Git Mailing List <git@vger.kernel.org>, ross@skydio.com,
        Abraham Bachrach <abe@skydio.com>, brian.kubisiak@skydio.com
Subject: Re: [PATCH v5] git-apply: allow simultaneous --cached and --3way
 options
References: <20210407180349.10173-1-jerry@skydio.com>
        <20210408021344.8053-1-jerry@skydio.com>
        <CABPp-BGFjZajiEMcJ7-WMPNaHJd3_eA3g1Wc-5HzBZMuA_7h+Q@mail.gmail.com>
Date:   Mon, 12 Apr 2021 11:27:10 -0700
In-Reply-To: <CABPp-BGFjZajiEMcJ7-WMPNaHJd3_eA3g1Wc-5HzBZMuA_7h+Q@mail.gmail.com>
        (Elijah Newren's message of "Mon, 12 Apr 2021 08:40:52 -0700")
Message-ID: <xmqq1rbfe4u9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B21FD5B8-9BBC-11EB-9AF5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Apr 7, 2021 at 7:13 PM Jerry Zhang <jerry@skydio.com> wrote:
>>
>> "git apply" does not allow "--cached" and
>> "--3way" to be used together, since "--3way"
>> writes conflict markers into the working tree.
>>
>> Allow "git apply" to accept "--cached" and
>> "--3way" at the same time.  When a single file
>> auto-resolves cleanly, the result is placed in the
>> index at stage #0 and the command exits with 0
>> status.
>
> Should this instead read:
>   "...placed in the index at stage #0.  If all files auto-resolve
> cleanly, the command exits with 0 status."
> or something like that?

Perhaps.

>>  For a file that has a conflict which
>> cannot be cleanly auto-resolved, the original
>> contents from common ancestor (stage #1), our
>> version (stage #2) and the contents from the
>> patch (stage #3) are left at separate stages.
>> No attempt is made to resolve the conflict at
>> the content level, and the command exists with
>
> s/exists/exits/

Will squash it in.
