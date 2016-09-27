Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0722C207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 04:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750756AbcI0EBV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 00:01:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60769 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750744AbcI0EBT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 00:01:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AEFD41228;
        Tue, 27 Sep 2016 00:01:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UkGpF0xS3fMZMQk/rXx1eb2jbLg=; b=sfNXtr
        jnbpgasZC2wMBKHoGu1QbKUzxgYugTtmI8Bgfbs+AmOUStsu2Em7F030KZAYHVXK
        uT2qTaVJw9hRwUlaGlJqGzIp9pOwPGXPYuXtCT0inJyzlYxaHJatzOLJ8zjONLar
        cayjiW/ewdy2iBLQfaBj3X5EhQiuJqhWUWHbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HJIKPWRbbBcPs+6IZA13EKfdGjwCnGnA
        hS92Vih7RrRCT1NdTNFP0YdGnglkrm+px1w2DExNUE+L5EkwQcsIcLfoPgMWBKkQ
        Z6z/052VfwU/UzZES4XM8hZbDHF4s7Gt+3PWkVpKDXc91NoxQFasmRfSO6KZYNLg
        WdUvTBuUfUg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6121941227;
        Tue, 27 Sep 2016 00:01:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD87441226;
        Tue, 27 Sep 2016 00:01:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] tree-walk: be more specific about corrupt tree errors
References: <1474935093-26757-1-git-send-email-dturner@twosigma.com>
Date:   Mon, 26 Sep 2016 21:01:15 -0700
In-Reply-To: <1474935093-26757-1-git-send-email-dturner@twosigma.com> (David
        Turner's message of "Mon, 26 Sep 2016 20:11:31 -0400")
Message-ID: <xmqqtwd2ng8k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0ACEDB68-8467-11E6-B64D-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> From: Jeff King <peff@peff.net>
>
> When the tree-walker runs into an error, it just calls
> die(), and the message is always "corrupt tree file".
> However, we are actually covering several cases here; let's
> give the user a hint about what happened.
>
> Let's also avoid using the word "corrupt", which makes it
> seem like the data bit-rotted on disk. Our sha1 check would
> already have found that. These errors are ones of data that
> is malformed in the first place.
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1007-hash-object.sh           |  15 +++++++++++++--
>  t/t1007/.gitattributes           |   1 +
>  t/t1007/tree-with-empty-filename | Bin 0 -> 28 bytes
>  t/t1007/tree-with-malformed-mode | Bin 0 -> 39 bytes
>  tree-walk.c                      |  12 +++++++-----
>  5 files changed, 21 insertions(+), 7 deletions(-)
>  create mode 100644 t/t1007/.gitattributes
>  create mode 100644 t/t1007/tree-with-empty-filename
>  create mode 100644 t/t1007/tree-with-malformed-mode

I hate to report this, but this alone, or together with 2/2, when
merged to 'pu', I cannot get them to pass the tests in my automated
integration tests, even though they seem to pass when the problematic
tests are run manually.  I do not see offhand anything suspicious
(like something that may be racy) in these two patches but I haven't
figured out where it goes wrong.

If somebody manages to find breakages in today's 'pu', please (1) do
not be too alarmed, and (2) help figure out where things are broken.

Thanks.
