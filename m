Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252BDC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 05:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C89613F6
	for <git@archiver.kernel.org>; Tue, 25 May 2021 05:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhEYFE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 01:04:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64102 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhEYFEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 01:04:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90A0BCCB26;
        Tue, 25 May 2021 01:03:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FQvTw67JNfgOPd4VYdhij+X/TOK5+de1x6p0In
        yejNU=; b=uQDEYMfjMv11Cj1ymAMomHr6/bIZWFCY+/+idBP1CbmPBPF5Yrd5nk
        MJPMMGkf1osSUcpjd4aSnWQ00UleB/4GNwcyPAzSRRVVI7hTA+XrZj24JDL8ssLU
        FWRMcDDLXJa3KKgu80AFx0P7F9velE90g+IwjBcGxnOUlDsJZWFL4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87A77CCB25;
        Tue, 25 May 2021 01:03:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19DCECCB24;
        Tue, 25 May 2021 01:03:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/3] [GSOC] ref-filter: support %(contents) for blob, tree
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
        <19413cfdb1ea50de401ab958b954a550b6514688.1621763612.git.gitgitgadget@gmail.com>
Date:   Tue, 25 May 2021 14:03:24 +0900
In-Reply-To: <19413cfdb1ea50de401ab958b954a550b6514688.1621763612.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sun, 23 May 2021 09:53:31
        +0000")
Message-ID: <xmqqfsybh0bn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 890D8F64-BD16-11EB-A1E3-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1292,7 +1326,8 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
>  }
>  
>  /* See grab_values */
> -static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)


As I already said, I do not think %(contents) mixes well with this
use for trees and blobs where you give the raw bytes, since
%(contents) for commit and tag objects was never about the full byte
sequence of the object.  It was to give the unstructured part meant
for human consumption, stripping the structured "header" part of the
object.

Nevertheless, since queuing this topic breaks the build and gets in
the way to find issues in other proposed regression fixes of higher
importance,...

> +static void grab_contents(struct atom_value *val, int deref, void *buf,
> +			  unsigned long buf_size, enum object_type object_type)
>  {
> ...
> +		switch (object_type) {
> +		case OBJ_TAG:
> +		case OBJ_COMMIT: {
> ...
> +				v->s = xmemdupz(bodypos, bodylen);
> +			else if (atom->u.contents.option == C_LENGTH)
> +				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
> ...

Note that this part inherits from the original and knows how to feed
a value to PRIuMAX with correct cast ...

> +				v->s = xmemdupz(bodypos, nonsiglen);
> +			else if (atom->u.contents.option == C_SIG)
> ...
> +		}
> +		case OBJ_BLOB:
> +		case OBJ_TREE: {
> +			if (atom->u.contents.option == C_BARE) {
> +				v->s_size = buf_size;
> +				v->s = xmemdupz(buf, buf_size);
> +			} else if (atom->u.contents.option == C_LENGTH)
> +				v->s = xstrfmt("%"PRIuMAX, buf_size);

... but this one gets sloppy, and breaks the windows-build of
'seen'.  Fix is simple:

+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);

I'll squash it in before rebuilding 'seen'.

