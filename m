Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F90C1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbdCaPmW (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 11:42:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52087 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933114AbdCaPmV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 11:42:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 096C97A3C1;
        Fri, 31 Mar 2017 11:42:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vGyX2zGWS9nmH+1rnWZ+eAv667Y=; b=DZM4QO
        MJd8PoFUH7rTYPzXOKX6GTzV//5HH0XUNWqzwNaUpk0iUTJFLbYLu2tYW176YOyz
        CT23bNM50mouQCLmu1lO24Yh6P8C/oduhSKbfGmy1xEl4FDTtpqH/ls/J86gnJqs
        DPnyiRDI3G/6l2POO1rf62yLGna4Bfydjg4go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mrbj5ClOcc52Vq64LslypYqSDs15srN/
        iOk4d8OacAfIPE6kMEbDs/Fnb2B9Pzskz0IThqqGzTgY4+ozIo/Gbxa8k31CAcDe
        01LCMsAKKJB7jHD7azjk72HjAAE7lJl0+Sz6IKn+GKKWhmcGQ7SSnIEMOEsg+DY/
        00lvyhTBGF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 008D37A3C0;
        Fri, 31 Mar 2017 11:42:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 603147A3BF;
        Fri, 31 Mar 2017 11:42:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v3 14/20] sha1-array: convert internal storage for struct sha1_array to object_id
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
        <20170331014001.953484-15-sandals@crustytoothpaste.net>
Date:   Fri, 31 Mar 2017 08:42:17 -0700
In-Reply-To: <20170331014001.953484-15-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 31 Mar 2017 01:39:55 +0000")
Message-ID: <xmqqefxd1mhy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F3C02DC-1628-11E7-8DF7-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>  	for (i = 0; i < array->nr; i++) {
> -		strbuf_addstr(&joined_hexs, sha1_to_hex(array->sha1[i]));
> +		strbuf_addstr(&joined_hexs, oid_to_hex(array->oid + i));

As I said in the previous round (in my comment on the one that
corresponds to the next patch, which has been updated in this
round), this converts E1[E2] to E1 + E2.

> @@ -621,7 +621,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
>  	argv_array_pushf(&rev_argv, bad_format, oid_to_hex(current_bad_oid));
>  	for (i = 0; i < good_revs.nr; i++)
>  		argv_array_pushf(&rev_argv, good_format,
> -				 sha1_to_hex(good_revs.sha1[i]));
> +				 oid_to_hex(good_revs.oid + i));

Likewise.

> @@ -715,9 +715,9 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
>  	int i, n = 0;
>  
>  	ALLOC_ARRAY(rev, 1 + good_revs.nr);
> -	rev[n++] = get_commit_reference(current_bad_oid->hash);
> +	rev[n++] = get_commit_reference(current_bad_oid);
>  	for (i = 0; i < good_revs.nr; i++)
> -		rev[n++] = get_commit_reference(good_revs.sha1[i]);
> +		rev[n++] = get_commit_reference(good_revs.oid + i);
>  	*rev_nr = n;

Likewise.

> @@ -53,9 +53,9 @@ int sha1_array_for_each_unique(struct sha1_array *array,
>  
>  	for (i = 0; i < array->nr; i++) {
>  		int ret;
> -		if (i > 0 && !hashcmp(array->sha1[i], array->sha1[i-1]))
> +		if (i > 0 && !oidcmp(array->oid + i, array->oid + i - 1))
>  			continue;

Likewise.

> diff --git a/shallow.c b/shallow.c
> index 11f7dde9d9..dc7b67a294 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -273,7 +273,7 @@ static int write_shallow_commits_1(struct strbuf *out, int use_pack_protocol,
>  	if (!extra)
>  		return data.count;
>  	for (i = 0; i < extra->nr; i++) {
> -		strbuf_addstr(out, sha1_to_hex(extra->sha1[i]));
> +		strbuf_addstr(out, oid_to_hex(extra->oid + i));
>  		strbuf_addch(out, '\n');
>  		data.count++;
>  	}

Likewise.

> @@ -417,13 +417,13 @@ void clear_shallow_info(struct shallow_info *info)
>  
>  void remove_nonexistent_theirs_shallow(struct shallow_info *info)
>  {
> -	unsigned char (*sha1)[20] = info->shallow->sha1;
> +	struct object_id *oid = info->shallow->oid;
>  	int i, dst;
>  	trace_printf_key(&trace_shallow, "shallow: remove_nonexistent_theirs_shallow\n");
>  	for (i = dst = 0; i < info->nr_theirs; i++) {
>  		if (i != dst)
>  			info->theirs[dst] = info->theirs[i];
> -		if (has_sha1_file(sha1[info->theirs[i]]))
> +		if (has_object_file(oid + info->theirs[i]))
>  			dst++;
>  	}
>  	info->nr_theirs = dst;

Likewise.

It is so minor that there is no point rerolling the whole thing only
for these, though.

Thanks.

