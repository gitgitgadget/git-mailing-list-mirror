Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE0EC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 06:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJMGHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 02:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJMGG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 02:06:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E229220E1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 23:06:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D02DB1BAE0A;
        Thu, 13 Oct 2022 02:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=/7hwlN7wJpZf7oDT1ovggtVj/9i3up5VNpcnxl
        nVL7k=; b=bF8n8rTpAhZxo+g3HTyBs7IJuM2bi6bMd1IEkpg2uHYlqfTkMRfVX/
        b8ywNAypyT5t8VinQ8I/84WwXday1OJ6B4d4hTP0KK15xmKtOxazZ+rtYFf1ZYFn
        475mSxrGH+u86E3WnOcZNu/v/a+4W52JQ3ZjtlrAc0ua4Rwphe5CU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8E0A1BAE08;
        Thu, 13 Oct 2022 02:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 097191BAE07;
        Thu, 13 Oct 2022 02:06:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 1/2] notes.c: introduce "--no-blankline" option
In-Reply-To: <20221013055654.39628-2-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Thu, 13 Oct 2022 13:56:53 +0800")
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
        <20221013055654.39628-2-tenglong.tl@alibaba-inc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Wed, 12 Oct 2022 23:06:53 -0700
Message-ID: <xmqqsfjsi7eq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CF8D17A-4ABD-11ED-9EC9-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> +--no-blank-line::
> +	When appending note, do not insert a blank line between
> +	the note of given object and the note to be appended.
> +

--blank-line::
--no-blank-line::
	Controls if a blank line to split paragraphs is inserted
        when appending (the default is true).

> diff --git a/builtin/notes.c b/builtin/notes.c
> index be51f69225..1ca0476a27 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -562,6 +562,7 @@ static int copy(int argc, const char **argv, const char *prefix)
>  static int append_edit(int argc, const char **argv, const char *prefix)
>  {
>  	int allow_empty = 0;
> +	int no_blankline = 0;

Use

	int blankline = 1;

to avoid double negative, which is confusing and error prone.

> @@ -584,6 +585,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  			parse_reuse_arg),
>  		OPT_BOOL(0, "allow-empty", &allow_empty,
>  			N_("allow storing empty note")),
> +		OPT_BOOL(0, "no-blankline", &no_blankline,
> +			N_("do not initially add a blank line")),

	OPT_BOOL(0, "blank-line", &blankline,
		 N_("insert paragraph break before appending to an existing note")),

> @@ -619,7 +622,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  		char *prev_buf = read_object_file(note, &type, &size);
>  
>  		strbuf_grow(&d.buf, size + 1);
> -		if (d.buf.len && prev_buf && size)
> +		if (!no_blankline && d.buf.len && prev_buf && size)
>  			strbuf_insertstr(&d.buf, 0, "\n");

Then, the conditional would read more naturally without double
negation.

		if (blank_line && d.buf.len && prev_buf && size)

I do not know and I am not judging (yet) if the goal of the patch is
sensible (in other words, if we should have such an option), but if
we were to do so, I would expect the implementation to look more
like what I outlined above.

Thanks.
