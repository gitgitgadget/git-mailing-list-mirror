Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FCD207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 23:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbcILXfw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 19:35:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63425 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750747AbcILXfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 19:35:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 397643CAE1;
        Mon, 12 Sep 2016 19:35:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X9xKZ9/RdxbZLJZO89wYJ6Z2yy8=; b=RL5+rh
        vNhCTdGLJYljxda6gK2gYZkc9VHGZJ/+wqh5SMbAsnZcleneduWsHGQN4OkS8J7w
        LSsYHVC2b+y78aMl7qwOdbpYVWF6tKuTnejP9PWskfhNhtG0DlEcEwoiD/8Erx6E
        Ss2xGbhTbIOU+Mx0K2EaHmglwqrZlsdcgNYM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ukJxih2TGGXZBfcYyeJpiiApYB6O8z1G
        ieYZwQvdd1QLZUK68OgI2MLHgWGJ5AZ7cJioaGLH0u28YoXlV4o1lHOezKMya2GY
        TpfdX9liwKbwxuyZ97JsxZnALgV4Mv+wdj2D8XjjL1aZuZmmWB5Eq5nbX3pioWmb
        orjqDRC8edA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31D443CAE0;
        Mon, 12 Sep 2016 19:35:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE1C43CADF;
        Mon, 12 Sep 2016 19:35:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/10] diff: move line ending check into emit_hunk_header
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
        <1473572530-25764-2-git-send-email-stefanbeller@gmail.com>
Date:   Mon, 12 Sep 2016 16:35:47 -0700
In-Reply-To: <1473572530-25764-2-git-send-email-stefanbeller@gmail.com>
        (Stefan Beller's message of "Sat, 10 Sep 2016 22:42:01 -0700")
Message-ID: <xmqqa8fcy9m4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A314E06A-7941-11E6-B477-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <stefanbeller@gmail.com> writes:

> From: Stefan Beller <sbeller@google.com>
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

The reason being...?

"Doing this would not change any behaviour and would not break
anything" may be true, but that is not a reason to do a change.

Hopefully it will become clear why this is needed once we look at a
later patch in the series.

>  diff.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index cc8e812..aa50b2d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -610,6 +610,9 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
>  	}
>  
>  	strbuf_add(&msgbuf, line + len, org_len - len);
> +	if (line[org_len - 1] != '\n')
> +		strbuf_addch(&msgbuf, '\n');
> +
>  	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
>  	strbuf_release(&msgbuf);
>  }
> @@ -1247,8 +1250,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  		len = sane_truncate_line(ecbdata, line, len);
>  		find_lno(line, ecbdata);
>  		emit_hunk_header(ecbdata, line, len);
> -		if (line[len-1] != '\n')
> -			putc('\n', o->file);
>  		return;
>  	}
