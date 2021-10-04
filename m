Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38413C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDD260FC4
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhJDQSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:18:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58310 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhJDQSi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:18:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23872EAE7D;
        Mon,  4 Oct 2021 12:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Fc0o+T5u3H6qnF0VAbXOCn3NZ
        5TtyfFzNuCN+ExBzUA=; b=katy+9yP7rnF03mpTxQEWDFN5zashs82JMTA8yZ90
        VEqwjBk12wiKTjgq5glay9J8sx8IupZo5fc3ykmFUSZUR00kDZXjL/Pk97S/qfco
        izvhdknvhuhnIXq9hDQeJaMaSrCJTjh0A+WBLWV9HRPAz2jxF7Jrb9RXGO70H4DZ
        YY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B6B5EAE7C;
        Mon,  4 Oct 2021 12:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82902EAE76;
        Mon,  4 Oct 2021 12:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] p5311: handle spaces in wc(1) output
References: <a682e2c8-fecc-906e-0ff6-93de2b311d14@web.de>
        <YVk8SeuDIWwsrdO0@nand.local> <87wnmuo7ii.fsf@evledraar.gmail.com>
Date:   Mon, 04 Oct 2021 09:16:47 -0700
Message-ID: <xmqq5yucydcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 79E67E26-252E-11EC-AD14-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This approach seems like a bit of plastering over the real problem. It'=
s
> fine to use the output of "wc -l" or "wc -c" in the context of the
> shell's whitespace handling. That's why in various places we do:

Sorry, but I am confused.

>     test $(wc -l <$file>) =3D 1
>
> Or similar, but *don't* put that $() in double-quotes. I.e. we're
> relying on the shell's whitespace semantics.
>
> So isn't it better to just pass this through the shell's own handling
> before emitting the data, something like this POC:
>
>     $ stripspace() { var=3D$1; echo $@; }; x=3D$(stripspace "  hi" "  t=
here "); echo "\"$x\""
>     "hi there"

All of the above are not wrong per-se, but if I read the scaffolding
code correctly, the way the output from "wc -c" is used is not via a
variable, but

    test_size_ () {
            say >&3 "running: $2"
            if test_eval_ "$2" 3>"$base".result; then
                    test_ok_ "$1"
            else
                    test_failure_ "$@"
            fi
    }

    test_size () {
            test_wrapper_ test_size_ "$@"
    }

where "$2" gets the script given to test_size, e.g.

 	test_size "size   $title" '
		wc -c <tmp.pack
 	'

the "wc -c" command.  And we just let the command emit its output to
"$base.result" (test_eval_ does the stdout-to-#3 redirection, and we
redirect #3 back to the file here).  So I am not quite sure where in
the current system your suggestion to apply the "substitition will
lose $IFS around values and gets word splitted if you omit dq around
it" would fit to address the issue at hand.

> Of course fixing it up after that in Perl will work just as well, so I
> guess this is just an asthetic preference for having the shell handle
> the shell's output issues with what's guaranteed to be shell-portable
> solutions... :)

Meaning we could rewrite aggregation in shell, then we can say we
are not making Perl clean up after mess sh creates?  I dunno...

Thanks.
