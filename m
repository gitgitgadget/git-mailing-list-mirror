Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF3BC433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 21:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB7E20706
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 21:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T1eLPNl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHXVWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:22:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64415 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgHXVWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 17:22:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91F397825C;
        Mon, 24 Aug 2020 17:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+H6le21uqgZTuCzie1MFe6azabE=; b=T1eLPN
        l3fNCgznIA3aqmzHZD6zyFpHvddXbvU3WilY6aIgxIPOEsaDMeDt1H2kpQB8MrUR
        i6a46g3vUg0n8JQ+XuGWOl6zVQxIg8U/Q0d6aRchqVaK+yl7sDFHczEKNpfG+1Cj
        bbq0Ob0eEZjKTJsj2BkzS28+3Mha4Cba3z5GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lKgWb+P92Ip+GvYDr+0ga8DaPYL76SAt
        VxaBsQ9hQa33VYbL3hPZOD827l0kKUoJlKkcO4+0H+qm+PsBmKuEBUfXcFlsl+Ao
        YWIFKhP/o88McOPs8V+pe1fajn1AUi9M5oOQ4PFKupuy6cvES/ggpGBOfs2z9GEu
        ka74RiKtZUg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89E897825A;
        Mon, 24 Aug 2020 17:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1ADFE78258;
        Mon, 24 Aug 2020 17:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Ori Bernstein <ori@eigenstate.org>, git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
References: <20200823005236.10386-1-ori@eigenstate.org>
        <20200823031151.10985-1-ori@eigenstate.org>
        <672843a1-b98c-7567-a078-a2dacd4b7074@web.de>
        <20200823134144.d57c80322f479eb554bab9d1@eigenstate.org>
        <ef92391d-09ef-4c27-e6dd-ec7b907174fa@web.de>
        <20200824201208.GA706849@coredump.intra.peff.net>
        <xmqq5z974w50.fsf@gitster.c.googlers.com>
        <20200824205231.GA787628@coredump.intra.peff.net>
Date:   Mon, 24 Aug 2020 14:22:39 -0700
In-Reply-To: <20200824205231.GA787628@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 24 Aug 2020 16:52:31 -0400")
Message-ID: <xmqqft8b3fj4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F093FFD6-E64F-11EA-A9B5-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It may be hard to test, as I suspect modern versions of Git are not
> happy to create such a deep chain. We could test with a lowered value of
> the config option, though.

Yes, that was what I meant.  Start from a 1KB text, create 50
revisions of the file by adding a single line at its end at a time,
pack with depth limit of 100, and then see "git log -p" die when the
allowed max lowered to 10, or something like that.

