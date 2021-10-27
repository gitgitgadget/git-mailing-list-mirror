Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48A8C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 23:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBFA608FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 23:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhJ0XrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:47:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60559 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0XrS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 19:47:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 219AA14CDEA;
        Wed, 27 Oct 2021 19:44:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kqrQiApdXv+OynFUVhCC9IQu3FAAJwlNaT31BG
        2mwnI=; b=mKfyI4ps6LExj/7LTywuOufOW7pvq3cOrGx5G+htjfBwhHBZ72MKHX
        WBz+KS3+LjDZFwsFApAv9wO3j2JA5Sz4cN0mFDUboru6+ESKolnL8JOHBXrBrlJl
        LVKiwe9qWbLthR9SP8wB9uzffsYogHxd8ZLj+lNcFjtpaCcCVL2YQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B49614CDE9;
        Wed, 27 Oct 2021 19:44:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 723B914CDE8;
        Wed, 27 Oct 2021 19:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH v2 5/9] builtin/repack.c: avoid leaking child arguments
References: <cover.1635282024.git.me@ttaylorr.com>
        <bcd12ecab81029be825a646348cb7ae69970a819.1635282024.git.me@ttaylorr.com>
Date:   Wed, 27 Oct 2021 16:44:48 -0700
In-Reply-To: <bcd12ecab81029be825a646348cb7ae69970a819.1635282024.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 26 Oct 2021 17:01:16 -0400")
Message-ID: <xmqqzgqut4lr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFAFCCCC-377F-11EC-AD0A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> @@ -586,8 +588,10 @@ static int write_midx_included_packs(struct string_list *include,
>  		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
>  
>  	ret = start_command(&cmd);
> -	if (ret)
> +	if (ret) {
> +		child_process_clear(&cmd);
>  		return ret;
> +	}

This happens only when start_command() returns an error.  But the
function always calls child_process_clear() before doing so.

So I am not sure if this hunk is needed.  It didn't exist in v1, if
I recall correctly.  Am I missing something obvious?

> @@ -608,9 +612,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	struct pack_geometry *geometry = NULL;
>  	struct strbuf line = STRBUF_INIT;
>  	struct tempfile *refs_snapshot = NULL;
> -	int i, ext, ret;
> +	int i, ext, ret = 0;
>  	FILE *out;
>  	int show_progress = isatty(2);
> +	int cmd_cleared = 0;
>  
>  	/* variables to be filled by option parsing */
>  	int pack_everything = 0;
> @@ -794,7 +799,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  	ret = start_command(&cmd);
>  	if (ret)
> -		return ret;
> +		goto cleanup;

Likewise, at this point, start_command() should have already cleared
cmd before it returned an error, no?

> @@ -818,8 +823,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	}
>  	fclose(out);
>  	ret = finish_command(&cmd);
> +	cmd_cleared = 1;
>  	if (ret)
> -		return ret;
> +		goto cleanup;

And cmd is also cleared after we pass this point.  So perhaps after
the cleanup label, there is no need to call child_process_clear() at
all, no?
