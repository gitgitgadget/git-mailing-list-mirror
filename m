Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA4C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 01:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiADBVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 20:21:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54017 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiADBVH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 20:21:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CDBA171A97;
        Mon,  3 Jan 2022 20:21:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=LgAED9U6gbVJZ46jQs2a+xgbMKz4gYUNQB+PgXnx8Q8=; b=IL2W
        DM8K5iKlTOkNMDDZqNAyrVFR0kWXJ9aOE7Vci9eRz9/sW5m4rTO2HE/2sIp6kSLo
        4BmELsJO+LpKirDkch3E0haqgycN7UBZcLgZ21O05EaG+gALOWdfOaV/nP75XpPs
        EPwFfKlHZsznGRZPJnU9h3dVJ2J8waOHCG62wJo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64148171A96;
        Mon,  3 Jan 2022 20:21:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B3B28171A95;
        Mon,  3 Jan 2022 20:21:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 6/8] ls-tree.c: support --object-only option for
 "git-ls-tree"
References: <cover.1641043500.git.dyroneteng@gmail.com>
        <cb881183cb7179e3e7e983b7c9ffe115f845115c.1641043500.git.dyroneteng@gmail.com>
Date:   Mon, 03 Jan 2022 17:21:02 -0800
Message-ID: <xmqqh7akgutd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9581C18E-6CFC-11EC-90E9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> A simple refactoring was done to the "show_tree" function, intead by
> using bitwise operations to recognize the format for printing to
> stdout. The reason for doing this is that we don't want to increase
> the readability difficulty with the addition of "-object-only",
> making this part of the logic easier to read and expand.

The resulting code looks unnecessarily complex and brittle; some
SHOW_FOO mean SHOW_FOO_ONLY_AND_NOTHING_ELSE while other SHOW_BAR
means SHOW_BAR_BUT_WE_MAY_SHOW_OTHER_THINGS_IN_LATER_PART, and the
distinction is not clear from their names (which means it is hard
to later extend and enhance the behaviour of the code).

> +	if (!(shown_bits ^ SHOW_FILE_NAME)) {

Is the use of XOR operator significant here?

I.e. "if (shown_bits & SHOW_FILE_NAME)" would have been a much more
natural way to guard "this is a block that shows the file name",
than "the result MUST BE all bits off if we flip SHOW_FILE_NAME bit
off".  If various SHOW_FOO bits are meant to be mutually exclusive,
then "if ((shown_bits & SHOW_FILE_NAME) == SHOW_FILE_NAME)" would
also make sense, but as I said upfront, it is unclear to me if
shown_bits are meant to be a collection of "this bit means this
field is shown (and it implies nothing else)", so I dunno.
