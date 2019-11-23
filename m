Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F447C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 02:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559F920707
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 02:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ykmZD9r2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfKWCDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 21:03:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53877 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWCDt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 21:03:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A49E79955D;
        Fri, 22 Nov 2019 21:03:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RiMyxV40THCvawDh53DiD+rhsVg=; b=ykmZD9
        r2B7Bj+RFHBhU7Zqu6o+Xtqy5SkczNhI051WXT5Kd3a05U9wMisXHO/Ib8cugFZY
        jh/5o8QBLbrkYSX5aXFPhCY7VLruHn9Y373C4LRU27Mulu3JkmCTDo23niexV6as
        vLXvHC8xNOINqph5WFjIrNR8+gnTUQKU8ctrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K/UP/ZPibgowr6iCJkuyPf7qWPX8lz46
        VMfuMVnOZIUZ/zyTOtv/ptya2yXq243wRpTIuKG5HCCyL/7wTcw6wJmUfhSFkzIL
        ZH7B6202wfRpG7XazpoRZbqdGIQqj+InvL5JajlehQj2o2GivX0Z1rv0NbR2P4cr
        l01M4r009Wg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C1F29955C;
        Fri, 22 Nov 2019 21:03:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C98A59955A;
        Fri, 22 Nov 2019 21:03:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
        <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
        <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 11:03:42 +0900
In-Reply-To: <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 22 Nov 2019 19:43:03
        +0000")
Message-ID: <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AB818D0-0D95-11EA-B1FF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (!(flags & ALLOW_EMPTY)) {
> +		struct commit *first_parent = current_head;
> +
> +		if (flags & AMEND_MSG) {
> +			if (current_head->parents) {

It is not apparent to me that somebody guarantees that this access
is safe; would we need to do things differently when !current_head?

> +				first_parent = current_head->parents->item;
> +				if (repo_parse_commit(r, first_parent)) {
> +					res = error(_("could not parse HEAD commit"));
> +					goto out;
> +				}
> +			} else {
> +				first_parent = NULL;
> +			}
> +		}
