Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6823DC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 19:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D15206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 19:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dk9Oe/oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgC0TSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:18:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63922 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0TSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 15:18:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4029B7D54;
        Fri, 27 Mar 2020 15:18:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2XxztuLkhV5n3l94YF7ioglcW+Y=; b=Dk9Oe/
        oPj+2g6InTiA2aL/ZkdpA+6JsnhMqi4cpl9wtzIoP7ZUTk2bcihDrwBj+OI4MECb
        hpuGPbE1rQKHbQpE3uWPmm6jpez1v94+LW2XU6G+wsLow1GOa5OZMSL5omLYWoad
        cjK9TBE7siTCD7q6yZg8HQTCXNEYzYSU7DjFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yFF4flBP2UokJFATiP9eQk5vMeOa+JkS
        P5eq8T3a5z2tyOTCy6Ei6KZdyPaRZ3oEi0GHSR6gvNrJoHotlgeNY/4NOUvK70cH
        veMWOvmJgdsJkW4Lpjnadj17hL/SuJ4tH0ZoVsls0+Hv0oyP0gkrIajQGeexuqd0
        ZOEtDMXs6e8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AAE8EB7D52;
        Fri, 27 Mar 2020 15:18:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F258CB7D51;
        Fri, 27 Mar 2020 15:18:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib-functions: make packetize() more efficient
References: <20200327080210.GA604725@coredump.intra.peff.net>
        <20200327080300.GA605934@coredump.intra.peff.net>
Date:   Fri, 27 Mar 2020 12:18:34 -0700
In-Reply-To: <20200327080300.GA605934@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 27 Mar 2020 04:03:00 -0400")
Message-ID: <xmqq1rpdhaid.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C19357E2-705F-11EA-91B3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The packetize() function takes its input on stdin, and requires 4
> separate sub-processes to format a simple string. We can do much better
> by getting the length via the shell's "${#packet}" construct. The one
> caveat is that the shell can't put a NUL into a variable, so we'll have
> to continue to provide the stdin form for a few calls.

Yuck.  Binary protocol and shell variables do not mix well.

Documentation/CodingGuidelines forbids ${#parameter} in the first
place and we seem to use it only when we know we are using bash.

Perhaps we should start considering to lift it.  I dunno.

> +# convert function arguments or stdin (if not arguments given) to pktline
> +# representation. If multiple arguments are given, they are separated by
> +# whitespace and put in a single packet. Note that data containing NULs must be
> +# given on stdin, and that empty input becomes an empty packet, not a flush
> +# packet (for that you can just print 0000 yourself).

>  packetize() {
> +	if test $# -gt 0
> +	then
> +		packet="$*"
> +		printf '%04x%s' "$((4 + ${#packet}))" "$packet"

This allows 

		packetize "want $hash_head"

to be written like so:

		packetize want "$hash_head"

which maybe is a handy thing to do.

> +	else
> +		cat >packetize.tmp &&
> +		len=$(wc -c <packetize.tmp) &&
> +		printf '%04x' "$(($len + 4))" &&
> +		cat packetize.tmp &&
> +		rm -f packetize.tmp

	perl -e '
		my $data = do { local $?; <STDIN> };
                printf "%04x%s", length($data), $data;
	'

That's one process but much heavier than cat/wc/printf/cat, I guess.

> +	fi
>  }
>  
>  # Parse the input as a series of pktlines, writing the result to stdout.
