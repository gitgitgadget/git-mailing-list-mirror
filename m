Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B4720A40
	for <e@80x24.org>; Sun,  3 Dec 2017 01:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbdLCBCk (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 20:02:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64656 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752074AbdLCBCj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 20:02:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDF06B8990;
        Sat,  2 Dec 2017 20:02:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CGkZBQbSjNINQgYzQyD+w1cyCOo=; b=FWIIvO
        Ea9fXx8VK4aqepTvkN0SlS7ITWxogCjImClgF5LxUVlNzslJ7Du3hiR3QO2UdiP4
        2h4jzo0q4HtIHry5Rj3rVT6iJEXxnclk2fbacfpuqHAPeLxOmNJxaTbQlO1pZvb4
        3JIT0AFoZP7W8igCoelme2czUIKPByMmERWyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ipb8PjltUljjkoNN6owfHuiTzQlm9hck
        vrxM04EaOOt8Tvsj5hG/7H41B7JcibJcPlT2h9Y6ZyVe65rVEnPXs/tq9g3MLol0
        8gzvbvB711bgNDYfCKaGNVo8UYDlTBmWhFxWPTJSRPWreB7mtGDz85v1PyM6OESx
        dIaP4zgB92o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5950B898F;
        Sat,  2 Dec 2017 20:02:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57E75B898E;
        Sat,  2 Dec 2017 20:02:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20171126193813.12531-1-max@max630.net>
        <20171126193813.12531-2-max@max630.net>
        <20171129032214.GB32345@sigill.intra.peff.net>
Date:   Sat, 02 Dec 2017 17:02:37 -0800
In-Reply-To: <20171129032214.GB32345@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 28 Nov 2017 22:22:14 -0500")
Message-ID: <xmqqr2sclj2q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7F39674-D7C5-11E7-AAD8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   3. For large inputs (like incoming packfiles), we connect the
>      descriptor directly to index-pack or unpack-objects, and they try
>      to read to EOF.
>
>      For a well-formed pack, I _think_ this would work OK. We'd see the
>      end of the pack and quit (there's a check for garbage at the end of
>      the pack, but it triggers only for the non-pipe case).
>
>      For a truncated input, we'd hang forever rather than report an
>      error.

Hmm.  index-pack and/or unpack-objects would be fed directly from
the incoming pipe, they are not told how many bytes to expect (by
design), so they try to read to EOF, which may come after the end of
the pack-stream data, and they write the remaining junk to their
standard output IIRC.

For a well-formed pack, the above is what should heppen.

I am having trouble trying to come up with a case where the input
stream is mangled and we cannot detect where the end of the
pack-stream is without reading more than we will be fed through the
pipe, and yet we do not trigger an "we tried to read because the data
we received so far is incomplete, and got an EOF" error.

Wouldn't "early EOF" trigger in the fill() helper that these two
programs have (but not share X-<)?

