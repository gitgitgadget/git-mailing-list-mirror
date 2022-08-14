Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A28C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 23:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiHNXMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 19:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHNXMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 19:12:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E73612AF3
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 16:12:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 433B61AE51D;
        Sun, 14 Aug 2022 19:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Lq0IR5pka+skS3ORabe0ED/uBb2tO7H7vlyAxcHh3Sk=; b=RvFv
        9Rs4iLdB5WUtuLm4FifaP3dNrCf1G5PnXRwC0gr072QKefVTpB7pauEnzZW/weA9
        0cvDoiqFJ3+UBkHvzqGnBRqKtZrB4a66+RB3fjDaq9husB4Q3apM9pz0sPS6FpP0
        nY2GWIddONbBHz4MA2xwiS/InA0rMetkONgYclg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CD181AE51C;
        Sun, 14 Aug 2022 19:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E20F31AE51B;
        Sun, 14 Aug 2022 19:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH/RFC 1/1] diff.c: When appropriate, use utf8_strwidth()
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220814133531.16952-1-tboegi@web.de>
Date:   Sun, 14 Aug 2022 16:12:12 -0700
Message-ID: <xmqqfshy773n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 884CB74C-1C26-11ED-81F2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> The choosen solution is to split code in diff.c like this
>
> strbuf_addf(&out, "%-*s", len, name);
>
> into 2 calls, like this:
>
> strbuf_addf(&out, "%s", name);
> if (len > utf8_strwidth(name))
>     strbuf_addchars(&out, ' ', len - utf8_strwidth(name));

Makes sense.  Is utf8_strwidth(name) cheap enough that we can call
it twice in a row on the same string casually, or should we avoid it
with a new variable?

It might be worth doing a helper function, even?

	static inline strbuf_pad(struct strbuf *out, const char *s, size_t width)
	{
		size_t w = utf8_strwidth(s);

		strbuf_addstr(out, s);
		if (w < width)
			strbuf_addchars(out, ' ', width - w);
	}

Other than that, sounds very sensible.

