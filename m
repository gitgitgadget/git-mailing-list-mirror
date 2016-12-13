Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C9320451
	for <e@80x24.org>; Tue, 13 Dec 2016 22:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbcLMWsv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 17:48:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52579 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750776AbcLMWsv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 17:48:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3044655AF9;
        Tue, 13 Dec 2016 17:48:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7iGMlAteWQC02TevXHSwNYmTMuE=; b=T2t5FQ
        QG5h8jJLvNXzTvli9FxS3sKu2mcS51C5I04PUUYd5wskRswqdZVqI+NveUKdtLM/
        LTiQHx+2J/jyUOLsDXppDvSHnA9FFMIzLUOC28qw7XgM5Bjayl/ZR2MXQBQGan5E
        K4UMQ02rm3GY7ShXzzOTFyg5ujJycJY/eOvLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HqQEhgZzKRCcP9I6AqV8sljn3I/pmkkH
        Cb9PyepkDNhN7oGl7G+/F2P2DvAitykq9XQe9BQ1zflX98EY6VdEo7WVUOrnP6hO
        T6cZhnVfO13r86ZTCBZL3lgsOK93yeapjt7cxO63+w+6B8DtBIRx5b7oZ8QzBciA
        /iBZ2KRTjR8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 287AA55AF8;
        Tue, 13 Dec 2016 17:48:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E38755AF5;
        Tue, 13 Dec 2016 17:48:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fix pushing to //server/share/dir paths on Windows
References: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
Date:   Tue, 13 Dec 2016 14:48:47 -0800
In-Reply-To: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org> (Johannes Sixt's
        message of "Tue, 13 Dec 2016 22:32:01 +0100")
Message-ID: <xmqqpokvzbqo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F99D728-C186-11E6-9DE7-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> There is a change in behavior: \\server\share is not transformed
> into //server/share anymore, but all subsequent directory separators
> are rewritten to '/'. This should not make a difference; Windows can
> handle the mix.

I saw Dscho had a similar "windows can handle the mix" change in an
earlier development cycle, I think, and this is being consistent.

>  Another long-standing bug uncovered by the quarantine series.
>
>  Dscho, it looks like this could fix the original report at
>  https://github.com/git-for-windows/git/issues/979
>
>  This patch should cook well because of the change in behavior.
>  I would not be surprised if there is some fall-out.
>
>  The other bug I'm alluding to, I still have to investigate. I do
>  not think that it can be counted as fall-out.
>
>  path.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Thanks.

> diff --git a/path.c b/path.c
> index 52d889c88e..02dc70fb92 100644
> --- a/path.c
> +++ b/path.c
> @@ -991,7 +991,7 @@ const char *remove_leading_path(const char *in, const char *prefix)
>   *
>   * Performs the following normalizations on src, storing the result in dst:
>   * - Ensures that components are separated by '/' (Windows only)
> - * - Squashes sequences of '/'.
> + * - Squashes sequences of '/' except "//server/share" on Windows

"on windows" because offset_1st_component() does the magic only
there?  Makes sense.

>   * - Removes "." components.
>   * - Removes ".." components, and the components the precede them.
>   * Returns failure (non-zero) if a ".." component appears as first path
> @@ -1014,17 +1014,23 @@ const char *remove_leading_path(const char *in, const char *prefix)
>  int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
>  {
>  	char *dst0;
> -	int i;
> -
> -	for (i = has_dos_drive_prefix(src); i > 0; i--)
> -		*dst++ = *src++;
> -	dst0 = dst;
> +	int offset;
>  
> -	if (is_dir_sep(*src)) {
> +	/*
> +	 * Handle initial part of absolute path: "/", "C:/", "\\server\share/".
> +	 */
> +	offset = offset_1st_component(src);
> +	if (offset) {
> +		/* Convert the trailing separator to '/' on Windows. */
> +		memcpy(dst, src, offset - 1);
> +		dst += offset - 1;
>  		*dst++ = '/';
> -		while (is_dir_sep(*src))
> -			src++;
> +		src += offset;
>  	}
> +	dst0 = dst;

By resetting dst0 here, we ensure that up_one that is triggered by
seeing "../" will not escape the \\server\share\ part, which makes
sense to me.

> +	while (is_dir_sep(*src))
> +		src++;
>  
>  	for (;;) {
>  		char c = *src;
