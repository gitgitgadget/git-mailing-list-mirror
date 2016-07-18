Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421F82018B
	for <e@80x24.org>; Mon, 18 Jul 2016 18:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbcGRSU0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 14:20:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751457AbcGRSUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 14:20:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7699F2C433;
	Mon, 18 Jul 2016 14:20:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=akGKpviCY8D1oxmrvl8bu4PYssY=; b=bsZMhM
	5GPyEk0bqnkDj4bCvLHbf6nWmjVN/uMarjfKIS7g7WP2rA10Nom3JSQOGy9AnzAM
	Sflqcw/9TqlcR4E8+oHC3xGUI4rn+mwYBCKs0yixATPOBE2mp6Q+A/92HyoVariY
	vXkxB6DR3CffxgAFf7C3wa8t66qBJm5fghWZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J/co3qq2DA52VFvta32oCD/zCjIuQXz3
	exYoNME7VyGTD/jF22W1tEaiChcJq/WDwAHsRzwyLQcbadeC5/FJOJrlpoyctFvm
	tIV1cm0tm3tBcpFbKpWXGtfupPv6KwH3IvBaF4mRCHiAkkqD+LW4pBh3t1lWa+bS
	77fgBRXHjJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E7992C432;
	Mon, 18 Jul 2016 14:20:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF53D2C431;
	Mon, 18 Jul 2016 14:20:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
	=?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
References: <20160718064431.GA10819@starla>
	<20160718130405.GA19751@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607181536540.3472@virtualbox>
Date:	Mon, 18 Jul 2016 11:20:19 -0700
In-Reply-To: <alpine.DEB.2.20.1607181536540.3472@virtualbox> (Johannes
	Schindelin's message of "Mon, 18 Jul 2016 15:52:31 +0200 (CEST)")
Message-ID: <xmqqtwfmkduk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A23709C-4D14-11E6-A0B1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hrm. That sounds a little magical, and fragile, to me. What if the next
> person's unzip returns 0 and *still* cannot handle -a?

That is a very sensible line of thought.

> I'd rather do something like

... but the patch presented as an alternative does not seem to
follow that line of thought.  After reading that sensible line of
thought I would have expected to see an auto-detection of the path
and support for features we care about.

Stepping back a bit, why do we even care if "unzip -a" works on
"../$zipfile" and converts things correctly in that check_zip() test
in t5003 in the first place?  It looks more like a test on "unzip"
than making sure we correctly generate a zip archive to me...

> -- snipsnap --
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0055ebb..5b9521e 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -929,7 +929,8 @@ yes () {
>  }
>  
>  # Fix some commands on Windows
> -case $(uname -s) in
> +uname_s=$(uname -s)
> +case $uname_s in
>  *MINGW*)
>  	# Windows has its own (incompatible) sort and find
>  	sort () {
> @@ -1100,6 +1101,7 @@ test_lazy_prereq SANITY '
>  	return $status
>  '
>  
> +test FreeBSD != $uname_s || GIT_UNZIP=${GIT_UNZIP:-/usr/local/bin/unzip}
>  GIT_UNZIP=${GIT_UNZIP:-unzip}
>  test_lazy_prereq UNZIP '
>  	"$GIT_UNZIP" -v
