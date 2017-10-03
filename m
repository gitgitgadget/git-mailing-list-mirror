Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B074A20365
	for <e@80x24.org>; Tue,  3 Oct 2017 07:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbdJCHKX (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 03:10:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57614 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750787AbdJCHKW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 03:10:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1789B6CF9;
        Tue,  3 Oct 2017 03:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gz91Ao4o6OL2qNwiKlcLfaGdVn4=; b=EjPwDK
        jA9nIy1gSS9WUv4mnxdBH9NjarNDf4Sbva/0sydxEjBBBDual+po5L1WU1TNa0oq
        EsO/1VoPvYiJBXISSbo3q0qncZMbrE/U7i2BQ/1bDs2HvDCzdLpwm//pfPLNdCtO
        w2ODr/exvsRyxrwEDHFfR63GkRV+Ew0E99b30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=osm5db2eC/O52HJWYfhy18tq+uFWY7OK
        qiuc4B2RYtQUoUtwoqAPnsM0dI+3xTvIi45NPsU0Oq+z8Y9HZDl/okQ2maYeT3j+
        5DP4VkRvYZCNxCqk+rDsjhcDmtt1XW9rgj9IZFZqmfU65EJxtSU41XuxHINYmVxR
        ryqLTopriyg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 927DDB6CF7;
        Tue,  3 Oct 2017 03:10:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED594B6CEF;
        Tue,  3 Oct 2017 03:10:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
        <20171002230017.GT19555@aiede.mtv.corp.google.com>
        <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
        <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
        <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
Date:   Tue, 03 Oct 2017 16:10:12 +0900
In-Reply-To: <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 3 Oct 2017 02:15:16 -0400")
Message-ID: <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6E369E0-A809-11E7-81D4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd prefer not to revert. I think setting any of the color config to
> "always" in an on-disk file is basically a broken config. It was
> exacerbated by 4c7f1819b, but it was already broken for scripts that
> call "git log" or "git diff", or even just something as simple as piping
> those programs on the command line.

I actually disagree with that reasoning.

We've promised that plumbing commands were safe to use in scripts,
and 4c7f1819 ("make color.ui default to 'auto'", 2013-06-10) got it
closer to breaking it (but not quite), and 136c8c8b finally broke
it.  Setting ui.color=always and shooting themselves in the foot by
seeing ANSI escapes in "git log >file" output is totally user's
choice.  Breaking scripts that carefully chose to use plumbing,
believing our earlier promise, and blaming user's ui.color=always
does not sound quite like the same thing, at least to me.
