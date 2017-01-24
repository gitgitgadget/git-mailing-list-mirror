Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF5C20A17
	for <e@80x24.org>; Tue, 24 Jan 2017 02:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750733AbdAXCs6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 21:48:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54222 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750703AbdAXCs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 21:48:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F32C6203B;
        Mon, 23 Jan 2017 21:48:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T432iZlM91b3NcxH3sR+MKakKwo=; b=Kly3CB
        yCC7nZUyp/SC/U+t3jWwejZ8IZL+tAFgiVyRMolPbI4p+PqqQwPw0RkcQpR0pkFP
        QRWPxYjQ0PYzrKpHnpg6bviHWStyGxoS84YLMgJVzHZDtXtlOOUJmXx9NE7NY9sQ
        /OLLtCBHP+EEyxJKQJJdy7CUSGLhV+AuPEQk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fqVFRkufs1Oo/1f0xvA8qYFgbhfK1Dkn
        ZQ7SYTQmhV1iUKv2RLaQrTILN5gw7BbI5/pE78l+f1mta2YhiyVMbnoGA0Vkug8o
        x3z00fsxubejz9+aWYB5pVXqo2YK4Ys46D1Iy3FoDdEtx8ghpOaqpqvWx4OEfNNp
        BKmvZzXYmmA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27C2F6203A;
        Mon, 23 Jan 2017 21:48:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80DAF62038;
        Mon, 23 Jan 2017 21:48:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Panteleev <git@thecybershadow.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/5] show-ref: Detect dangling refs under --verify as well
References: <20170123180059.4288-1-git@thecybershadow.net>
        <20170123180059.4288-5-git@thecybershadow.net>
Date:   Mon, 23 Jan 2017 18:48:54 -0800
In-Reply-To: <20170123180059.4288-5-git@thecybershadow.net> (Vladimir
        Panteleev's message of "Mon, 23 Jan 2017 18:00:58 +0000")
Message-ID: <xmqqefztp3zd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B4E688-E1DF-11E6-AF43-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vladimir Panteleev <git@thecybershadow.net> writes:

> Move detection of dangling refs into show_one, so that they are
> detected when --verify is present as well as when it is absent.
>
> Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
> ---
>  builtin/show-ref.c  | 16 ++++++++--------
>  t/t1403-show-ref.sh | 22 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index ab8e0dc41..107d05fe0 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -22,6 +22,14 @@ static void show_one(const char *refname, const struct object_id *oid)
>  	const char *hex;
>  	struct object_id peeled;
>  
> +	/* This changes the semantics slightly that even under quiet we
> +	 * detect and return error if the repository is corrupt and
> +	 * ref points at a nonexistent object.
> +	 */

This is my fault from more than 10 years ago, but I think the
comment shouldn't have been here (or at its original location).  It
talks about the behaviour change relative to the previous version
when the comment was added, i.e. cf0adba788 ("Store peeled refs in
packed-refs file.", 2006-11-19).

I'll remove it after the series settles.
