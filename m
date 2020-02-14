Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F54CC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157D7206B6
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IB7BusNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgBNR4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:56:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50673 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbgBNRz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 12:55:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDE933C9B7;
        Fri, 14 Feb 2020 12:55:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6AbVkntna/zQeNKbnaDuPdNcTXQ=; b=IB7Bus
        NNZjraOt8/YDrM5gYhRoSGi69m8HVkSQlUSA0LWc62taPknabCNWw7uVF+TED0y/
        LOpxuwUo6+/SgqD2uTvm/fWiqdmMtB1BiHxe2/lQj/fVTXq5tXOnC8nbEBxt7sHI
        Ip0Mx/foM6HWbmUpKBUaEcf0RYlzuUg4qHTpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TbSX7A6l/FVRJQ8hPCxmknbMcXnkrlxm
        9UFFQE0GwwGBJAUMv+W94WP7q8uvSlUel9/hCPrNpOHSdf48YEU7Xv70IqkrJr4e
        VfpPf7PrcS/eGa7vNxXN5BHqphiodMLds/0BQEeqvt7QeErJXshVfvtmKnYBGj/N
        CnqmOXotks8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C636F3C9B6;
        Fri, 14 Feb 2020 12:55:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C5AF3C9B3;
        Fri, 14 Feb 2020 12:55:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH] credential.c: fix credential reading with regards to CR/LF
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 09:55:54 -0800
In-Reply-To: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 14 Feb 2020 13:49:56
        +0000")
Message-ID: <xmqqmu9lnjdh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FA00078-4F53-11EA-8BBC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Nikita Leonov <nykyta.leonov@gmail.com>
>
> This fix makes using Git credentials more friendly to Windows users. In
> previous version it was unable to finish input correctly without
> configuration changes (tested in PowerShell, CMD, Cygwin).
>
> We know credential filling should be finished by empty input, but the
> current implementation does not take into account CR/LF ending, and
> hence instead of the empty string we get '\r', which is interpreted as
> an incorrect string.
>
> So this commit changes default reading function to a more Windows
> compatible reading function.
>
> Signed-off-by: Nikita Leonov <nykyta.leonov@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

In the older days, strbuf_getline() used to be what we have as
strbuf_getdelim() today, i.e. explicitly request what record
separator to use to grab a line.

The use of strbuf_getline_lf() we see in the pre-image of this patch
came from 8f309aeb ("strbuf: introduce strbuf_getline_{lf,nul}()",
2016-01-13), which mechanically replaced the use of
strbuf_getline(... '\n'), in anticipation for later effort to
identify ones that are better to accept CRLF and turn them into
_crlf variant.  Later all the callers of (old) strbuf_getline() went
away, and strbuf_getline_crlf() that allowed both LF and CRLF
termination (which is most friendly to human-readable line of text)
took over the shortest and sweetest name, strbuf_getline().

So, the "later" effort just happend to this code.  It was a bit
overdue, but it's better late than never.

>  credential.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/credential.c b/credential.c
> index 62be651b03..65989dfa4d 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -146,7 +146,7 @@ int credential_read(struct credential *c, FILE *fp)
>  {
>  	struct strbuf line = STRBUF_INIT;
>  
> -	while (strbuf_getline_lf(&line, fp) != EOF) {
> +	while (strbuf_getline(&line, fp) != EOF) {
>  		char *key = line.buf;
>  		char *value = strchr(key, '=');

There are many more conversions of strbuf_getline(..., '\n') to
strbuf_getline_lf(...) made by 8f309aeb to other parts of credential
stuff.  Has anybody from the Windows side made sure these other ones
are also better to accept CRLF, too?  

I'd wait for a bit to hear either "oh, we found two more and here is
an updated patch" or "we looked at them and this is the only one",
before touching this patch.

Thanks.



