Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F269C47092
	for <git@archiver.kernel.org>; Mon, 31 May 2021 00:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3A860FF1
	for <git@archiver.kernel.org>; Mon, 31 May 2021 00:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEaAqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 20:46:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64017 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhEaAqd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 20:46:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F1DADFAB4;
        Sun, 30 May 2021 20:44:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yQ7eXXfQmpdud1cPWP2VcHEHtjz6SwZbC1qhNoJEkII=; b=b+xi
        aoWHQp1XrJxreB3iQ1zmSrTZVfcJP4WSDAT+6pff2UnDRIMfgqJSjXYsy4hlt+Dz
        coc7cMXEWZESm/Ql4I0ripQzVGdAOLOsdWQEt6u2gQhj9qWCQVcIWOtiZHRNqJBl
        u0njMDlLRYOe0u84LQISFl67QuwCm4VDg0xID9k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34338DFAB3;
        Sun, 30 May 2021 20:44:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9415DFAB2;
        Sun, 30 May 2021 20:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
        <pull.963.v2.git.1622379718.gitgitgadget@gmail.com>
        <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 09:44:51 +0900
Message-ID: <xmqqh7ij20l8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A02F14E-C1A9-11EB-A3C7-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Beyond, `--format=%(raw)` cannot be used with `--python`, `--shell`,
> `--tcl`, `--perl` because if our binary raw data is passed to a variable
> in the host language, the host languages may cause escape errors.

"may cause escape errors" just says you are not escaping correctly
in your code (implying that this patch is not good enough and with
more effort we should be able to fix it to allow binaries), but the
problem is the host languages may not support binaries
(specifically, anything with a NUL in it) at all, which is
fundamentally unfixable, in which case, rejecting is the only
sensible choice.

    ... because the host language may not support a NUL in the variables
    of its string type.

> +The raw data in a object is `raw`, For commit and tag objects, `raw` contain

s/contain/contains/, but more importantly, as we are not introducing
%(header), I do not see why we want to talk about its details.  For
commits and tags, just like for trees and blobs, 'raw' is the raw
data in the object, so beyond "The raw data of a object is %(raw)",
I do not think there is anything to talk about.

> +`header` and `contents` two parts, `header` is structured part of raw data, it
> +composed of "tree XXX", "parent YYY", etc lines in commits , or composed of
> +"object OOO", "type TTT", etc lines in tags; `contents` is unstructured "free
> +text" part of raw object data. For blob and tree objects, their raw data don't
> +have `header` and `contents` parts.


> +	const char *s = buf->buf;
> +	size_t cur_len = 0;
> +
> +	while ((cur_len != buf->len) && (isspace(*s) || *s == '\0')) {
>  		s++;
> +		cur_len++;

Is NUL treated the same as a whitespace letter for the purpose of
determining if a line is empty?  WHY?

