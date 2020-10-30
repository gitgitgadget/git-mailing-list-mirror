Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4321DC4741F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CEC206DD
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 18:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N1FzetOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgJ3Smb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 14:42:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62169 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3Sma (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 14:42:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCA4E8626C;
        Fri, 30 Oct 2020 14:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pCMz+dVOTLxwcXk3nkH820KFJgU=; b=N1Fzet
        Oo7WKUTldg8PTr2LL1PEC1EcvOdj4xmzH+sAoxi848m3gCT6dxI7zi2vlvgmiUY7
        U1+3aR68BxP0K4ZbytS1jpHy2hTOLLUZm7G457L5UKXmMSfYuok3Qjt1Sr5czR8y
        ZLh449Ypcp14Wzeft6Rziq1b/nzLYEFolCRDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CgwI17vbY4X36KtBwl8jR2a+BOHu5J5Y
        cCvhZWmVL2rd/0rpVX+pwRlW2AIbxC6Dlfm3LK/wIzkt0wlnvqE68teglTJ2ykZ8
        FfcoWT6wf7FrdcP8VRMOXWmfcllOWE79ndpG0keArUo+uHwUoAlEeaAOh3+aZk16
        4Wa7+AuNBP4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C49C48626B;
        Fri, 30 Oct 2020 14:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55D5D8626A;
        Fri, 30 Oct 2020 14:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Duvall <dan@mutual.io>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to
 haves
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
        <1604029402-19593-1-git-send-email-dan@mutual.io>
Date:   Fri, 30 Oct 2020 11:42:25 -0700
In-Reply-To: <1604029402-19593-1-git-send-email-dan@mutual.io> (Daniel
        Duvall's message of "Thu, 29 Oct 2020 20:43:22 -0700")
Message-ID: <xmqq7dr7369a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A801FF92-1ADF-11EB-A450-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Duvall <dan@mutual.io> writes:

> diff --git a/upload-pack.c b/upload-pack.c
> index 3b858eb..2b128e4 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1344,7 +1344,18 @@ void upload_pack(struct upload_pack_options *options)
>  				   PACKET_READ_DIE_ON_ERR_PACKET);
>  
>  		receive_needs(&data, &reader);
> -		if (data.want_obj.nr) {
> +
> +		/*
> +		 * An EOF at this exact point in negotiation should be
> +		 * acceptable from stateless clients as they will consume the
> +		 * shallow list before doing subsequent rpc with haves/etc.
> +		 */
> +		if (data.stateless_rpc)
> +			reader.options |= PACKET_READ_GENTLE_ON_EOF;
> +
> +		if (data.want_obj.nr &&
> +		    packet_reader_peek(&reader) != PACKET_READ_EOF) {
> +			reader.options ^= PACKET_READ_GENTLE_ON_EOF;

I am a bit puzzled why it is sensible to

  (1) unconditionally
  (2) toggle

the GENTLE bit.

>  			get_common_commits(&data, &reader);
>  			create_pack_file(&data, NULL);
>  		}

If we are not doing stateless_rpc, we call get_common_commits() with
a reader that is gentle on eof, which is not an intended behaviour
change, no?

I would have understood if this were more like

	if (data.stateless_rpc)
		reader.options |= PACKET_READ_GENTLE_ON_EOF;

	if (data.want_obj.nr &&
	    packet_reader_peek(&reader) != PACKET_READ_EOF) {
		if (data.stateless_rpc)
			reader.options &= ~PACKET_READ_GENTLE_ON_EOF;

i.e. only when we know we set the bit when the bit was originally
clear, revert to the original state.

	Note. initially I thought we may need to check the original
	value of the bit in reader.options before flipping it on,
	but this packet_reader has freshly been initialized in the
	inner block we see here, so we know that nobody other than
	this new code would have set the bit.

Or for that matter, just unconditionally turn it off, e.g.

	if (data.want_obj.nr &&
	    packet_reader_peek(&reader) != PACKET_READ_EOF) {
		reader.options &= ~PACKET_READ_GENTLE_ON_EOF;

Puzzled...
