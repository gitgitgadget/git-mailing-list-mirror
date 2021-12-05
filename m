Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56440C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 20:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhLEUtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 15:49:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62556 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhLEUtt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 15:49:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B247BFAD5F;
        Sun,  5 Dec 2021 15:46:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mkEyMC49UEGOSfqQq5hLolW1uMdL525KWaH+fc
        JDVBs=; b=QrCHS1mK9l1y3lVqWVIvDicIZrgV9/IZ8ph4gqbJJdsVRmtAV/slAh
        vedME8iLQ1jwwUc6AVBPfNAuR7vFUsJJ8eYufZPzbBDqMyPXhLF3oZfRLyV0Nhgy
        cUidN3UJo9Vizf6qUh3B2oop9yl9gw+rtTx8Sg0dUTBudPQxKl2/A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A94D3FAD5E;
        Sun,  5 Dec 2021 15:46:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12675FAD5D;
        Sun,  5 Dec 2021 15:46:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: Re: [PATCH 12/17] builtin/repack.c: support generating a cruft pack
References: <cover.1638224692.git.me@ttaylorr.com>
        <a05675ab834ac5e8bc3ab72847b0621a563e0e1b.1638224692.git.me@ttaylorr.com>
Date:   Sun, 05 Dec 2021 12:46:19 -0800
In-Reply-To: <a05675ab834ac5e8bc3ab72847b0621a563e0e1b.1638224692.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 29 Nov 2021 17:25:33 -0500")
Message-ID: <xmqqk0gikcf8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6718CDD0-560C-11EC-9AFB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various thoughts on just this part, as the hunk got my attention
while merging with other topics in 'seen'.

> +	if (pack_everything & PACK_CRUFT && delete_redundant) {
> +		if (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE))
> +			die(_("--cruft and -A are incompatible"));
> +		if (keep_unreachable)
> +			die(_("--cruft and -k are incompatible"));
> +		if (!(pack_everything & ALL_INTO_ONE))
> +			die(_("--cruft must be combined with all-into-one"));
> +	}

The "reuse similar messages for i18n" topic will encourage us to
turn this part into:

	if (pack_everything & PACK_CRUFT && delete_redundant) {
		if (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE))
			die(_("%s and %s are mutually exclusive"),
			    "--cruft", "-A");
		if (keep_unreachable)
			die(_("%s and %s are mutually exclusive"),
			    "--cruft", "-k");
		if (!(pack_everything & ALL_INTO_ONE))
			die(_("--cruft must be combined with all-into-one"));
	}

The conditionals are a bit unpleasant to read and maintain, but I
guess we cannot help it?

Saying ALL_INTO_ONE is a bit unfriendly to the end user, who would
probably not know that it is the name the code gave to the bit that
is turned on when given an option externally known under a different
name (is that "-a"?).

If "--cruft" must be used with "all into one", I wonder if it makes
sense to make it imply that?  Not in the sense that OPT_BIT()
initially flips the ALL_INTO_ONE bit on upon seeing "--cruft", but
after parse_options() returns, we check PACK_CRUFT and if it is on
turn ALL_INTO_ONE also on (so even if '-a' gains '--all-into-one'
option, the user won't break us by giving "--no-all-into-one" after
they gave us "--cruft")?  I didn't think about this part thoroughly
enough, though.

Thanks.






