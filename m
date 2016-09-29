Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C16F207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbcI2S5J (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:57:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55220 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751795AbcI2S5H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:57:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AACB426EC;
        Thu, 29 Sep 2016 14:57:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rYdxuxVK4osc1oFx2Ae1OiyHG8M=; b=k6b4HB
        kyyBp9Gt7P0eKcYOKW75ywuGiyk9BH44qczvgl1FJdlRZzsocxhyX6r5r4EPwv+N
        FmqSESpS74/T6T4CZYpwzPYDyIPT3Sh+azPVBdZdhFsrgQdwNCCBevqBLdcNZaCp
        tH1ZXRF29j4CFpNIpl2RZVsyGmmrwhD0V7rQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SL7VqxajHVAFvSRWicNbkEWE8RVMdZoT
        otUceHj7A+6jstk6pQZhphmG3j5yudAoQ4WrIPS+zDDB3pGXO53HIMIjnDi4aXdo
        ai8Uk+aBX20fJr/M9lQ6i3OJOoKT5hAkh4VVZ++BubDwfunKTY0ijBXmCwkAU9GR
        a693by/zkOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0165C426EB;
        Thu, 29 Sep 2016 14:57:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70633426E9;
        Thu, 29 Sep 2016 14:57:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-3-gitster@pobox.com>
        <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
        <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
        <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 11:57:02 -0700
In-Reply-To: <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 14:26:21 -0400")
Message-ID: <xmqqa8eqfsap.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83136C40-8676-11E6-9D88-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> "either" meaning "we do not need to add --local and we do not need
>> GIT_CONFIG_NOSYSTEM"?
>
> Yes. I didn't test it with your core.abbrev patch 4/4, but I _didn't_
> have to touch their expected output after pointing them at a non-empty
> etc-gitconfig file in the trash directory. Which implies to me they
> don't care either way (which makes sense; they are asking for a specific
> key which is supposed to be found in one of the other files).

There is a bit of problem here, though.

 * If we make t1300 point at its own system-wide config, it will be
   in control of its contents, so "find this key" will find only it
   wants to find (or we found a regression).

 * But then if it ever does something that depends on the default
   value of core.abbrev (or whatever we'd tweak in response to the
   next suggestion by Linus ;-), we cannot really allow it to do
   so.  We'd want t/gitconfig-for-test to be the single place that
   we can tweak these things, but we'll have to know t1300 uses its
   own and need to make the same change there, too.

So, I dunno.
