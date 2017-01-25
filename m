Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997ED1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbdAYS0k (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:26:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752024AbdAYS0j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:26:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1FFA61753;
        Wed, 25 Jan 2017 13:26:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hHLkadRf0/eTpPb7b6eKmwUqhNY=; b=s0vcFD
        vWgrbBGR48eCNHB4w2wzu0YYR9SlbWuwSXEZmet168KY0QAAxqyyLzuVUpyNT5QG
        xASJAmETWblGWsxaC2bZg1B7dQ5AZYZpdhsF+h1vi6RAojlLQ3qtzaV4Pz3oF8MA
        c8ObohqXzUFhuoVD1j4vReKLFLRoNJf/P+b0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rU3uM/Xpd3ST0YSePJKLufbdP6svzYx3
        3k32m0aTD131h4SZxXwtRHRileMVrOJHgUPpwsdLLyFxsQAs2qY4Qe2EqMHQxUac
        YCnyrJSKPySJGhfZS11Y3oedAbCqQHdiWF1l0reA1YhUaNgCNpr+PDd7hrh3+bFC
        uLlgkSvgrUM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99D0961752;
        Wed, 25 Jan 2017 13:26:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEEF761751;
        Wed, 25 Jan 2017 13:26:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/12] for_each_alternate_ref: handle failure from real_pathdup()
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
        <20170124003827.l2rimgitsyxsvtly@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 10:26:36 -0800
In-Reply-To: <20170124003827.l2rimgitsyxsvtly@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 23 Jan 2017 19:38:27 -0500")
Message-ID: <xmqqziifatcz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF27300A-E32B-11E6-973D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In older versions of git, if real_path() failed to resolve
> the alternate object store path, we would die() with an
> error. However, since 4ac9006f8 (real_path: have callers use
> real_pathdup and strbuf_realpath, 2016-12-12) we use the
> real_pathdup() function, which may return NULL. Since we
> don't check the return value, we can segfault.
>
> This is hard to trigger in practice, since we check that the
> path is accessible before creating the alternate_object_database
> struct. But it could be removed racily, or we could see a
> transient filesystem error.
>
> We could restore the original behavior by switching back to
> xstrdup(real_path()).  However, dying is probably not the
> best option here. This whole function is best-effort
> already; there might not even be a repository around the
> shared objects at all. And if the alternate store has gone
> away, there are no objects to show.
>
> So let's just quietly return, as we would if we failed to
> open "refs/", or if upload-pack failed to start, etc.

That's sensible, methinks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/transport.c b/transport.c
> index c86ba2eb8..74d0e45bd 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1215,6 +1215,8 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
>  	struct alternate_refs_data *cb = data;
>  
>  	other = real_pathdup(e->path);
> +	if (!other)
> +		return 0;
>  	len = strlen(other);
>  
>  	while (other[len-1] == '/')
