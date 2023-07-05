Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDBAEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 22:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGEW12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 18:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjGEW11 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 18:27:27 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5811726
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 15:27:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00FBE18B48B;
        Wed,  5 Jul 2023 18:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=u7mbxnpLoP5N
        +5zUPpkZFIlvnPcxTrX0QuRPHz5rwCA=; b=uP8JcWoPyeZUvAdLl4lCsVWRWoe4
        XaqEHLtqscQxvST9t6H+zTCmJUvUnrpeue5IcKdWrzYc06Cqc+gz2GmB7U58xtaj
        sSOosZP68OBGlRSEXdxm9hrXm8S+2H7iraCCIZs6l/PtpLd2ezzhJV4xv7H2biNR
        SfUWN4vvBW9gtGM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBDC718B48A;
        Wed,  5 Jul 2023 18:27:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5826B18B489;
        Wed,  5 Jul 2023 18:27:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: don't check string length in packet_length()
References: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de>
        <xmqqttui3nqn.fsf@gitster.g>
        <32f41065-a78c-aa60-0d78-4dbfa8827b1a@web.de>
        <xmqq4jmiyu7s.fsf@gitster.g>
        <6f984150-5a98-b2b8-1791-b101f5953b7a@web.de>
Date:   Wed, 05 Jul 2023 15:27:24 -0700
In-Reply-To: <6f984150-5a98-b2b8-1791-b101f5953b7a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 5 Jul 2023 23:11:15 +0200")
Message-ID: <xmqqsfa2uh83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E0A5972-1B83-11EE-9568-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Sure, that's done.  If any of the four characters is not a hexadecimal
> digit then packet_length() returns a negative value, before and after
> the change.

Ah, it is the beauty of hexval[] table ;-)

So as long as we are sure that we are not running beyond the end of
the buffer, we are OK.  And as I already said, I think "this change
is safe for our two callers; those adding more callers in the future
are better be very careful" is probably good enough for this one.

hex.h:hex2chr() says "don't run over the end of short strings", but
as far as I can see it does not check any such thing; find a page of
memory, whose next page is unmapped, and pointing *s at the last
byte of that page and calling it will happily run over the end and
would cause SIGBUS.  The function assumes that such a short string
is always NUL terminated, which is not a great way to guarantee that
we do not run over the end of strings.
