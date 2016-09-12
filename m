Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9389207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 23:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751008AbcILXrG (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 19:47:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60708 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750747AbcILXrF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 19:47:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66DD33CC4A;
        Mon, 12 Sep 2016 19:47:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VbomCVkNN5CXq8jMtU8rQiDH4Ts=; b=nkT8Ts
        GncdAdsZGfb+YBjBSP+uo2VftNvrmjZU/jzvib1DY+zeEPIKoemyCS9cKMmQUPvy
        ERVHEpZrteqOfoxeezr8MOQKvsrfhD/+1kC0bA+o09evjcl/NLb6Fam+B3mTUbPf
        bjZLW1kjuFSu8U0yQHL+2pbGTjCn59s6dYrH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=or0gzTQt0iu58+XFXPD0dZCyYJ2EFyJo
        7HP9g86hAQwga7kx70xULSdCgD/SuKKXmmNSOR7Xdk5Gqqi4TXBKtlL2TScOopCj
        kGLS+WUMjVfOF76rKsxaJvjstrRG2PvP9fowq5NKpkA5gyoiaMdMMFTpYpGgbos7
        68GcTiw+t9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F8513CC49;
        Mon, 12 Sep 2016 19:47:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCF363CC48;
        Mon, 12 Sep 2016 19:47:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 02/10] diff: emit_{add, del, context}_line to increase {pre,post}image line count
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
        <1473572530-25764-3-git-send-email-stefanbeller@gmail.com>
Date:   Mon, 12 Sep 2016 16:47:01 -0700
In-Reply-To: <1473572530-25764-3-git-send-email-stefanbeller@gmail.com>
        (Stefan Beller's message of "Sat, 10 Sep 2016 22:42:02 -0700")
Message-ID: <xmqq60q0y93e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34EE2A68-7943-11E6-A0FF-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <stefanbeller@gmail.com> writes:

> From: Stefan Beller <sbeller@google.com>
>
> At all call sites of emit_{add, del, context}_line we increment the line
> count, so move it into the respective functions to make the code at the
> calling site a bit clearer.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

I am mostly in favor of this change, as the calls to these three
functions are always preceded by increment of these fields, but it
is "mostly" exactly because the reverse is not true.  Namely ...

> @@ -1293,16 +1294,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  
>  	switch (line[0]) {
>  	case '+':
> -		ecbdata->lno_in_postimage++;
>  		emit_add_line(reset, ecbdata, line + 1, len - 1);
>  		break;
>  	case '-':
> -		ecbdata->lno_in_preimage++;
>  		emit_del_line(reset, ecbdata, line + 1, len - 1);
>  		break;
>  	case ' ':
> -		ecbdata->lno_in_postimage++;
> -		ecbdata->lno_in_preimage++;
>  		emit_context_line(reset, ecbdata, line + 1, len - 1);
>  		break;
>  	default:

... there still needs an increment in the context lines, not shown
in the patch, just after this "default:".  I think the patch is OK
as the comment after this "default:" (also not shown in the patch)
makes it clear what is going on.

Thanks.


