Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E694EB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 15:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjFZP6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFZP6c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 11:58:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F9991
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:58:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F0192F810;
        Mon, 26 Jun 2023 11:58:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tGZ+dh//n1M+OvEVKe1QhtqvwlYVRJLy8c4dbe
        I5/go=; b=Fx26FmNXgzp+TaGlLuo7ZGeKiwUOYLWE0ANAXPM+BsEHq7pW7CwecG
        tEbzKGle5MjKa1QVTzwsTk8Pn1bWVG8oEOyzkyIcueVutAReU7VEr5gnmOJZRGW4
        iL/foK0hFMWxDKKnVehp41shxt0NC8ILx23HEcuB1/zhHGYZfJx6Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0736D2F80F;
        Mon, 26 Jun 2023 11:58:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1DCC92F80D;
        Mon, 26 Jun 2023 11:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] apply: improve error messages when reading patch
References: <pull.1552.git.1687772253869.gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 08:58:27 -0700
In-Reply-To: <pull.1552.git.1687772253869.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Mon, 26 Jun 2023 09:37:33 +0000")
Message-ID: <xmqqjzvq5i70.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A3F1FDC-143A-11EE-BB8F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Commit f1c0e3946e (apply: reject patches larger than ~1 GiB, 2022-10-25)
> added a limit on the size of patch that apply will process to avoid
> integer overflows. The implementation re-used the existing error message
> for when we are unable to read the patch. This is unfortunate because (a) it
> does not signal to the user that the patch is being rejected because it
> is too large and (b) it uses error_errno() without setting errno.

Good description of the issue, and ...

>  static int read_patch_file(struct strbuf *sb, int fd)
>  {
> -	if (strbuf_read(sb, fd, 0) < 0 || sb->len >= MAX_APPLY_SIZE)
> -		return error_errno("git apply: failed to read");
> -
> +	if (strbuf_read(sb, fd, 0) < 0)
> +		return error_errno(_("failed to read patch"));
> +	else if (sb->len >= MAX_APPLY_SIZE)
> +		return error(_("patch too large"));

... quite obvious improvement.  Nice.

Will queue.  Thanks.
