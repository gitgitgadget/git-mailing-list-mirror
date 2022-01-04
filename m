Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C429EC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 02:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiADCQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 21:16:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50823 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiADCQr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 21:16:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 676DC171FD6;
        Mon,  3 Jan 2022 21:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=e//g44nskzD28ESHD7oAf4733Nudf89PS2Tblb0n9Do=; b=ggK1
        VbZEIr9IAw72krjs+044R9h+/jHAUKmJqa0HWUWKDT/U2orVxI4pCFcXkwzwAbvp
        OQV1Wl0/4yrIoTF+Zt3UUahjNbCgkSwHdWphQRwoQc6U3ZB5hoH0PVGLc2HSGIzM
        UE3z+Vts+kwVBnmC8+jzYUwefWTEAG1Hwsc0l0o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FA4D171FD5;
        Mon,  3 Jan 2022 21:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BEFB9171FD4;
        Mon,  3 Jan 2022 21:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 2/2] name-rev.c: use strbuf_getline instead of
 limited size buffer
References: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
        <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
        <e4bd09ccf75d48e7c6e8c4901395449bf79aa3c3.1641221261.git.gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 18:16:42 -0800
Message-ID: <xmqqr19ofdo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C547444-6D04-11EC-B923-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Using a buffer limited to 2048 is unnecessarily limiting. Switch to
> using a string buffer to read in stdin for annotation.
>
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
>  builtin/name-rev.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 21370afdaf9..85993bc2b38 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -625,12 +625,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  	if (annotate_stdin) {
>  		struct strbuf sb = STRBUF_INIT;
>  
> -		while (!feof(stdin)) {
> -			char *p = fgets(buffer, sizeof(buffer), stdin);
> -			if (!p)
> -				break;
> -			name_rev_line(p, &data);
> +		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {

As we are reading text, I wonder if it makes more sense to just use
strbuf_getline() that is meant to use the definition of "line" that
honors the platform convention (i.e. on Windows, '\r\n' is taken as
the EOL marker).

> +			name_rev_line(sb.buf, &data);
>  		}
> +		strbuf_release(&sb);
>  	} else if (all) {
>  		int i, max;

Other than that, looking good.

Thanks.
