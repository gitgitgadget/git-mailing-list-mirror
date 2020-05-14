Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B8C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F53B2054F
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n3fazigw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENS1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 14:27:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57261 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgENS1J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 14:27:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 892C7CDD10;
        Thu, 14 May 2020 14:27:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cLdGcx6dolRLtw8pBzVI/aqT5Bg=; b=n3fazi
        gwX6rtvKk1FoMegE/IVU0AaR6GZBJ9fHpBelzdqKLGoQiB7mFLouiJW5dAIqIkRK
        i23naqA+MfuCclSAoxta3Z8128tKFxgwlbHvhpZv0LGKntYI+TB981v2C1yC9JRs
        3SgZqzJaxwWIvYegBHXfTjQKi2kx7/zhTkT60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ucUjOtZYooqVMFc6RAWxezCEXyFdpsIB
        CnDjO5D/6+edBQJGiOM/A8Ht8zZ9T2zi9O2s4aSLQ9bwYPJod8J2pdudZEodIWXT
        9gGb79L/7bkUey+AJd3tdyIOthAPWPRb8ZSTRnl8DdMmuKVpU7DrvV3spDnVucLA
        pIEJ6ybYgPQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 821F8CDD0F;
        Thu, 14 May 2020 14:27:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8B53CDD0C;
        Thu, 14 May 2020 14:27:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/8] builtin/commit-graph.c: extract 'read_one_commit()'
References: <cover.1588641176.git.me@ttaylorr.com>
        <cover.1589407014.git.me@ttaylorr.com>
        <c37e94907b140f3d2e5a44293f2c1faa6d473712.1589407014.git.me@ttaylorr.com>
        <20200514175646.GA2430834@coredump.intra.peff.net>
        <20200514180200.GA86181@syl.local>
Date:   Thu, 14 May 2020 11:27:00 -0700
In-Reply-To: <20200514180200.GA86181@syl.local> (Taylor Blau's message of
        "Thu, 14 May 2020 12:02:00 -0600")
Message-ID: <xmqq8shuqsnf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81B110A2-9610-11EA-9BA8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>  static int graph_write(int argc, const char **argv)
>  {
> -	struct string_list *pack_indexes = NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list pack_indexes;

I would strongly prefer this to be initialized here, not ...

>  	struct oidset commits = OIDSET_INIT;
>  	struct object_directory *odb = NULL;
> -	struct string_list lines;
>  	int result = 0;
>  	enum commit_graph_write_flags flags = 0;
>
> @@ -209,44 +221,34 @@ static int graph_write(int argc, const char **argv)
>  		return 0;
>  	}
>
> -	string_list_init(&lines, 0);
> -	if (opts.stdin_packs || opts.stdin_commits) {
> -		struct strbuf buf = STRBUF_INIT;
> +	if (opts.stdin_packs) {
> +		string_list_init(&pack_indexes, 0);

... down here.  I know that the use of it is guarded with a ternary
(opts.stdin_packs ? &pack_indexes : NULL), but that is why you need
to UNLEAK() it, intead of unconditionally releasing the strbuf, at
the end of this function, no?

>  		while (strbuf_getline(&buf, stdin) != EOF)
> -			string_list_append(&lines, strbuf_detach(&buf, NULL));
> +			string_list_append(&pack_indexes,
> +					   strbuf_detach(&buf, NULL));
> +	} else if (opts.stdin_commits) {
> +		oidset_init(&commits, 0);
> +		flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
>
> -		if (opts.stdin_packs)
> -			pack_indexes = &lines;
> -		if (opts.stdin_commits) {
> -			struct string_list_item *item;
> -			oidset_init(&commits, lines.nr);
> -			for_each_string_list_item(item, &lines) {
> -				struct object_id oid;
> -				const char *end;
> -
> -				if (parse_oid_hex(item->string, &oid, &end)) {
> -					error(_("unexpected non-hex object ID: "
> -						"%s"), item->string);
> -					return 1;
> -				}
> -
> -				oidset_insert(&commits, &oid);
> +		while (strbuf_getline(&buf, stdin) != EOF) {
> +			if (read_one_commit(&commits, buf.buf)) {
> +				result = 1;
> +				goto cleanup;
>  			}
> -			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
>  		}
> -
> -		UNLEAK(buf);
>  	}
>
>  	if (write_commit_graph(odb,
> -			       pack_indexes,
> +			       opts.stdin_packs ? &pack_indexes : NULL,
>  			       opts.stdin_commits ? &commits : NULL,
>  			       flags,
>  			       &split_opts))
>  		result = 1;
>
> -	UNLEAK(lines);
> +cleanup:
> +	UNLEAK(pack_indexes);
> +	strbuf_release(&buf);
>  	return result;
>  }
>
> --
> 2.26.0.113.ge9739cdccc
