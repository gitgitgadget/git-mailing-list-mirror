Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876511F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 21:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbdAZVgv (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 16:36:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62922 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753513AbdAZVgu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 16:36:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BE6D6266A;
        Thu, 26 Jan 2017 16:30:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uw5fWobFvUYQ74ZrUJtw2BYMDTg=; b=MYc/2+
        HjylAPkBOOkmsehcH739bZh/3oCvtcCpuPL496ca7/YsxlWZbGnJAy780lA5AJeF
        OVqeCuB9IOoH72ffvCQ6TTR8Wul6l+XrBrLSdex6fAlLq4A77tTN0Av+tC/fr0CX
        0fCaQRuqrbr0eEgSeERZ/jtONJXbUwplQN+fs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HoOyk4p2HK3untUmkpE4bUhOh8XNg9+H
        G1occqiCrY4YAM/8XOAjN6kTPI8D15vy/wjivVohXQJxjKttPsIICmMYY6Mqs8dB
        66urZCn7X47b/DDuFywhvjxgRBOK5R3o+LjjLaCE4x/zX7Q/0bwOtiYNVB256Uqn
        I0B+BROCLRA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 127C962669;
        Thu, 26 Jan 2017 16:30:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4974962664;
        Thu, 26 Jan 2017 16:30:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: HEAD's reflog entry for a renamed branch
References: <87pojmwq5y.fsf@kyleam.com>
        <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
Date:   Thu, 26 Jan 2017 13:30:54 -0800
In-Reply-To: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 26 Jan 2017 16:12:05 -0500")
Message-ID: <xmqqk29h33w1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8D776A0-E40E-11E6-A5D5-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's unfortunate that there's no message. This is because the rename
> calls delete_ref() under the hood, but that function doesn't take a
> reflog message argument at all. It usually doesn't matter because
> deleting the ref will also delete the reflog.
>
> But as your example shows, deletions _can_ get logged in the HEAD
> reflog; the low-level ref code detects when HEAD points to the updated
> ref and logs an entry there, too.
> ...
> I'd say there are two potential improvements:
>
>   - delete_ref() should take a reflog message argument, in case it
>     updates the HEAD reflog (as a bonus, this will future-proof us for a
>     day when we might keep reflogs for deleted refs).

This sounds sensible.

>   - "git branch -m" does seem to realize when we are renaming HEAD,
>     because it updates HEAD to point to the new branch name. But it
>     should probably insert another reflog entry mentioning the rename
>     (we do for "git checkout foo", even when "foo" has the same sha1 as
>     the current HEAD).

This one I care less (not in the sense that I prefer it not done,
but in the sense that I do not mind it is left unfixed than the
other one you pointed out).
