Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B571F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbdAYXZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:25:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51281 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751857AbdAYXZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:25:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88E3B64944;
        Wed, 25 Jan 2017 18:25:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RrtvDLRT0urXNq37z0ribKmKEe4=; b=w8QZCA
        EN5MyoV4UbuKpg27btWbBisP+sWZXH1iEGHxn216W9rRIhinsbWoTHa5X/T0w7Ef
        pXLPz4YJN1RduGU6+agu/GMrlIYXU08WeoiDujRTsukiC31iv6qFbTLM3qVJuKQX
        ixzEQIGO+BmF7DXLV93OlYuQTt4btXbQaYkzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rtLx65/bY+bOzGASESWHluZYCMubjCLW
        Px/WN+9XRCBsxfd+17Klh9g7WWab7EZVlbbiLIGJY3t4RaIP9fNnwvM1xixwlKML
        UzfFtcdN7RdHS/7aS5F2MQg+qWEI5BXn0NUupQWQZwdw8OsnGGAE+aeqwMyVg0X3
        EvlIJVqw9oM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65CDC64943;
        Wed, 25 Jan 2017 18:25:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC3F064941;
        Wed, 25 Jan 2017 18:25:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] revision.c: refactor ref selection handler after --exclude
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
        <20170125125054.7422-1-pclouds@gmail.com>
        <20170125125054.7422-5-pclouds@gmail.com>
        <20170125205718.ksqstdnazmgbkehy@sigill.intra.peff.net>
        <20170125212721.7tbxkqsdtsv2n5mx@sigill.intra.peff.net>
        <CA+P7+xovOx9ebo6MU0e4v==+76jtoMXz45+LnBPFifHbjqFU4w@mail.gmail.com>
Date:   Wed, 25 Jan 2017 15:25:55 -0800
In-Reply-To: <CA+P7+xovOx9ebo6MU0e4v==+76jtoMXz45+LnBPFifHbjqFU4w@mail.gmail.com>
        (Jacob Keller's message of "Wed, 25 Jan 2017 13:30:20 -0800")
Message-ID: <xmqqlgty7md8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F6DE514-E355-11E6-92FD-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Jan 25, 2017 at 1:27 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Jan 25, 2017 at 03:57:18PM -0500, Jeff King wrote:
>>
>>> IOW, the ref-selector options build up until a group option is given,
>>> which acts on the built-up options (over that group) and then resets the
>>> built-up options. Doing "--unrelated" as above is orthogonal (though I
>>> think in practice nobody would do that, because it's hard to read).
>>
>> So here's what I would have expected your series to look more like (with
>> probably one patch adding clear_ref_selection_options, and the other
>> adding the decorate stuff):
>>
>
> I agree that this is how I would have expected it to work as well.

That makes three of us ;-)
