Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975DB20899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbdHQRuQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:50:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60410 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753462AbdHQRuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:50:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99A9FAFAB7;
        Thu, 17 Aug 2017 13:50:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M8zD8OgBMCtjWwzaQrVYYOMq/yw=; b=HpxX+s
        yrsukdItfemdqVtz3JHYOA6TaqwvzIaxBLzkqpiXZCDW36x3zqwAp8axI1+z1w79
        w7Eal12NbxrpWvYesUyMPhh+IyjYhk8ZCM5K2EFkim3YTAd9t9A4O8x8t7FbzR8+
        26DtOJphacigoCkYfSGfkfUTMqroWSMJBxx5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l0Ry95TDzjxoEOzNhDpn9Of/hiQ1k7p0
        bi9406L0DiwB9wF7hNb8Q+iEkvVmuiF523sPkA+d1MHYmTECYW7mIKtkNff+mMXK
        Gz4r+zrWBAaXmEf6wkZESEGitD+b+6SJuuYHhXCXf6QX7S2L8E7cclMVazi/DJOM
        eUZ463c3dsM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75D4CAFAB4;
        Thu, 17 Aug 2017 13:50:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84CC7AFAB1;
        Thu, 17 Aug 2017 13:50:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 19/19] Convert xdiff-interface to size_t
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
        <1502914591-26215-20-git-send-email-martin@mail.zuhause>
Date:   Thu, 17 Aug 2017 10:49:59 -0700
In-Reply-To: <1502914591-26215-20-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Wed, 16 Aug 2017 22:16:31 +0200")
Message-ID: <xmqqwp62gk3c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E3F39D2-8374-11E7-B932-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> diff --git a/combine-diff.c b/combine-diff.c
> index acf39ec..ad5d177 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -343,7 +343,7 @@ struct combine_diff_state {
>  	struct sline *lost_bucket;
>  };
>  
> -static void consume_line(void *state_, char *line, unsigned long len)
> +static void consume_line(void *state_, char *line, size_t len)
>  {
>  	struct combine_diff_state *state = state_;
>  	if (5 < len && !memcmp("@@ -", line, 4)) {

This is a correct logical consequence of making consume_fn to take
size_t.

> diff --git a/diff.c b/diff.c
> index c12d062..f665f8d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -406,7 +406,7 @@ static struct diff_tempfile {
>  	struct tempfile tempfile;
>  } diff_temp[2];
>  
> -typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
> +typedef size_t (*sane_truncate_fn)(char *line, size_t len);

It turns out that this type, the member of this type in ecb struct, and
a conditional call to the function when it is not NULL, are all unused.
If this were used, this conversion is correct ;-)

> @@ -4536,7 +4536,7 @@ struct patch_id_t {
>  	int patchlen;
>  };
>  
> -static int remove_space(char *line, int len)
> +static size_t remove_space(char *line, size_t len)
>  {
>  	int i;
>  	char *dst = line;

This function may also want to be rewritten.  The loop counter and
array index "i" is used this way:

	for (i = 0; i < len i++)
		if (!isspace((c = line[i]))
			*dst++ = c;
	return dst - line;

So you are still risking data loss (later parts of line[] may not be
scanned due to int possibly being narrower than size_t).

Turning "len" and the return type into size_t is absolutely the
right thing to do, and it is tempting to turn "i" also into size_t,
but we may just want to scan the thing with another pointer, i.e.

        size_t remove_space(char *line, size_t len)
        {
                char *src = line;
                char *dst = line;

                while (src < line + len) {
                        char c = *src++;
                        if (!isspace(c))
                                *dst++ = c;
                }
                return dst - line;
        }

Changes to size_t from types other than "ulong" is worth looking at
twice for a potential issue like this.

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index d82cd4a..f12285d 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -26,7 +26,7 @@ static int parse_num(char **cp_p, int *num_p)
>  	return 0;
>  }
>  
> -int parse_hunk_header(char *line, int len,
> +int parse_hunk_header(char *line, size_t len,
>  		      int *ob, int *on,
>  		      int *nb, int *nn)
>  {

This is a correct conversion for the purpose of this series, but the
implementation of this function before (and after) this patch is
already incorrect.  It does not pay any attention to "len", and
neither the helper function this function uses, parse_num(), is
told how many bytes are remaining on the line to be parsed, so it
will happily go beyond "len".

The two things we may want to fix is obviously outside the scope of
this series, but they should be fixed (not necessarily by you) after
this series once the codebase solidifies, or before this series as
preliminary clean-up.

Thanks.
