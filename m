Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B15C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14BA206C3
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ouFw7O/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLMViq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:38:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61104 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLMViq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:38:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E801719E62;
        Fri, 13 Dec 2019 16:38:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G+VIn3Y2crUKjwwm8x2m0bOcBOg=; b=ouFw7O
        /xDesBEcmVOkY0S2WHX/coj35KDaSUJnG3bGjjkDF81axOvgOyIwxDmEpbJgG76F
        AA4xoulH2KZ6FSs1/7shrH3vFlG42guw/Mvl4ao8XznPKgM+Z92FoxR4tSPbM5yZ
        +X5T1kzQAIIrTx5EUrRQxuddWRljvYuKcBMJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HeDxrHBjN5ik40AmGVGT37OYOIdIfW0g
        5HyBWn4LqAM53a0mFEV2ZApqQ+iVIUTEVknMuBpBceGp7y/2peikLYFF+n4ONG52
        FJxXpKhRv963P+oOUuZmhnmwIvluvfKUkRj9QKYn0wxkD/qcgI6TDbNUVfHO4SHj
        CdBe6vuT2rg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFAD319E60;
        Fri, 13 Dec 2019 16:38:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 404B519E5E;
        Fri, 13 Dec 2019 16:38:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 08/15] bugreport: include user interactive shell
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-9-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 13:38:42 -0800
In-Reply-To: <20191213004312.169753-9-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:05 -0800")
Message-ID: <xmqq8snfj47x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF531A8A-1DF0-11EA-9BC7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> It's possible a user may complain about the way that Git interacts with
> their interactive shell, e.g. autocompletion or shell prompt. In that
> case, it's useful for us to know which shell they're using
> interactively.
>
> $SHELL isn't set by every shell, but getenv() returns NULL in the
> event the variable isn't found, so we'll see a line like "$SHELL:
> (null)" to tell us that variable wasn't set.

Do not depend on vsnprintf() from glibc that accepts NULL and shows
"(null)".  You can segfault on systems without glibc that way.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/bugreport.c b/bugreport.c
> index f5598513d9..759cc0b0f8 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -45,6 +45,9 @@ static void get_system_info(struct strbuf *sys_info)
>  	strbuf_addstr(sys_info, gnu_get_libc_version());
>  	strbuf_complete_line(sys_info);
>  
> +	strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
> +		    getenv("SHELL"));
> +
>  	strbuf_addstr(sys_info, "git-http-fetch -V:\n");
>  	get_http_version_info(sys_info);
>  	strbuf_complete_line(sys_info);
