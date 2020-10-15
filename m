Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58279C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFE720679
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxkVz856"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbgJOTN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:13:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59984 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgJOTN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:13:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00D0689738;
        Thu, 15 Oct 2020 15:13:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=66awHqjb0HlECbUvq0IUiXt89I0=; b=hxkVz8
        56qWKMdoPFfyAnj+y5e3QPCicys8vzguPcaj67QWvp5NC8bbNuIFAhLVtbDA05HT
        wS2EA4dDEwMtrrKDViej3agRG2d/Bn1FAF/tWJ7kuXJJCzLoeBo0M4R5cI1Pyh6T
        a6R3Bddfa0kDapk9tSyF8bYWrGMiVQdWzqWF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mr86VA3L/7T5/g0eLrxGHWY+fS9qp2JF
        0j/UmYTs5RmDtLFU5i6SGdFGxEco2KR3Q/uyu+SVasezoPTLE0WUnDdzbF5thG6J
        T9uX1D8y5dqnGmUzKFSXCll3YZLxAhMhh3uJY/kxdevlP0v2n2HST52oThnxRW6i
        E2OYIXdcq3Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED4DB89736;
        Thu, 15 Oct 2020 15:13:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7878B89735;
        Thu, 15 Oct 2020 15:13:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
        <20201015012636.GA387901@coredump.intra.peff.net>
        <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
        <20201015153849.GA551964@coredump.intra.peff.net>
        <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
        <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
        <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
        <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
        <20201015185853.GA1108210@coredump.intra.peff.net>
Date:   Thu, 15 Oct 2020 12:13:53 -0700
In-Reply-To: <20201015185853.GA1108210@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Oct 2020 14:58:53 -0400")
Message-ID: <xmqqft6ffgjy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 913B980C-0F1A-11EB-956B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Looking over the thread, I don't see any problems pointed out (though
> as your diff below shows, the original patch missed the re-ordering
> required for the submodule mapping call).
>
> So I'd prefer my patch because of that fix and because of the tests.

Oh, no question about that.  I would take a fresh fix that was done
on a more recent codebase than the one that was 4 months old and had
to be rebased.  Having a test too is a huge plus.

Thanks.  And by the way, thanks for the "-cooking -announce" tip ;-)

