Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3003C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E8120708
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tqrkbh0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGHXFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:05:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56512 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHXFo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 19:05:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E20D56D3F2;
        Wed,  8 Jul 2020 19:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2CzNLTqZKZpkux3Mj0UjBnYRs2o=; b=Tqrkbh
        0OCnycVugA/R1dwtFr1qEseNME2ttwaOOfQQ07tNsZBW7VAdCyH7uHrm620t09HH
        xTRTqK4tnsi5qpwPdq7Yp7mpTl2hXPiEYkIVfa7K7MEkSPlDpBSzNPp9roEkvMdY
        B1qdfuuR4XPoME6VCgVV9CQtLe7DZRg5P6zPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SSOkj2n4XH8ffikC43XXQmtfFtG8zYjm
        MfI88YQ0kQM2DclhzVXyA2ViTT1fNDIDr0FDkpNu74/Rd1woEo9MT9bycDe0NbuL
        SGODLiKVS1PSMoM38hJ6cWon+5XFkcIhzolKJnFl6UpTgpuNaoKH4lQMk4tQ+DuK
        dLW9MTaisRQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA6A66D3F1;
        Wed,  8 Jul 2020 19:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A6B26D3F0;
        Wed,  8 Jul 2020 19:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 4/4] ref-filter: add support for %(contents:size)
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200707174049.21714-5-chriscool@tuxfamily.org>
Date:   Wed, 08 Jul 2020 16:05:40 -0700
In-Reply-To: <20200707174049.21714-5-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 7 Jul 2020 19:40:49 +0200")
Message-ID: <xmqq36611ubf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B84FEB0-C16F-11EA-8A7B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +# We cannot use test_atom to check contents:size of signed tags due to sanitize_pgp
> +test_tag_contents_size_pgp () {
> +	ref="$1"
> +	test_expect_success $PREREQ "basic atom: $ref contents:size" "
> +		git cat-file tag $ref | tail -n +6 | wc -c >expected &&
> +		git for-each-ref --format='%(contents:size)' $ref >actual &&
> +		test_cmp expected actual
> +	"
> +}

Of course, this will BREAK the tests on macOS and possibly others
with "wc" that emits leading whitespaces before the number.

The tip of 'seen' has been failing ever since this topic was merged
there e.g. https://travis-ci.org/github/git/git/jobs/705986794

Thanks.

