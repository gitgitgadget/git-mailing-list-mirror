Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E0C6379F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 00:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B2922240
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 00:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ExPatCQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKTAHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 19:07:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54348 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgKTAHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 19:07:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CB178339F;
        Thu, 19 Nov 2020 19:07:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iB8biz4PehG4
        PFqMUaxYH2Ze2H4=; b=ExPatCQYLMfcLFEUewv1+++p8xts54kVDY/1rlJKnf/c
        5m1kmB3I4rrf1RLiftktPjmRg8j2kSLT2WF/eeMH2MSdTDhUc3qSWglUMzDoiRck
        sRGT16NN6zD1ETjjbrYn3RsR40OqTleN5M9kvnXZ2UgYMmiRfEb1TSpTszMkxdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JltWVs
        y8PDs7Ief+CMYHGQTR81MTZyxiTUZMRkmYFMtKG00KStwI6I5zptgS0HhX7eCgkw
        NSJgoQV9H2Z2yWd/Yhw+ggdM1bYzFeWnvW7IPP6kX2gSm/3wwplt3nuxsdpopf6S
        a2xRckD/MkzLsBeBoasT9Ut1ESqv25SVR+niQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 648B18339E;
        Thu, 19 Nov 2020 19:07:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF48C8339D;
        Thu, 19 Nov 2020 19:07:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] tests: make sure nested lazy prereqs work reliably
References: <20201118190414.32616-1-szeder.dev@gmail.com>
        <20201119155824.GB25426@coredump.intra.peff.net>
Date:   Thu, 19 Nov 2020 16:07:17 -0800
In-Reply-To: <20201119155824.GB25426@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 19 Nov 2020 10:58:24 -0500")
Message-ID: <xmqqpn48vqkq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5A1B912C-2AC4-11EB-A133-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 18, 2020 at 08:04:13PM +0100, SZEDER G=C3=A1bor wrote:
>
>> So to prevent nested prereqs from interfering with each other let's
>> evaluate each prereq in its own dedicated directory by appending the
>> prereq's name to the directory name, e.g. 'prereq-test-dir-SYMLINKS'.
>> In the test we check not only that the prereq test dir is still there,
>> but also that the inner prereq can't mess with the outer prereq's
>> files.
>
> That sounds reasonable. I do wonder, though, whether simply creating th=
e
> prereq directory in the _current_ directory would be sufficient. Then
> you'd get prereq-test-dir/prereq-test-dir for a nested invocation. But
> the prereqs aren't supposed to care about which specific directory
> they're in.

True.  That does sound conceptually simpler.  As we've already seen
the patch, I do not mind too deeply either way, though.

Thanks.
