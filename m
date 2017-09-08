Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75096202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 06:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbdIHGjk (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 02:39:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52282 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753804AbdIHGjj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 02:39:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF7A197A61;
        Fri,  8 Sep 2017 02:39:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s5bVP1ysx2tI/wVTfYciuax0O7E=; b=VmT749
        uHbSZO0YQDp9qfr95qQi2PVX2fYBnMgWs3RB63wDM7U6uSA3pMbgYkm8u58Fk7BI
        1aMfwb7Ku0SofuLQwB42MraAJfORcy+BBbqQ7E/1XT6k3z2axd8XkwVzuiFXMpcf
        0LnsREVxBcgeTy3+bUyFVzu9BINh04Zrhl3uU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fNv6AcPW/Pc31cwEbFQk5zMXi/MyHG8I
        qObmr+LbynRZisxvGgcmNB7tPQI36tk1IZX7eHf4cxROiDqIZvQiQKiwgvw9Hkkx
        q7XeM+sWef0JLeIR6RhIIfV2dcZO6Q1LZQvhK+oDYI6qj//O40myQN5IsdQryXRW
        XYCmSv5hJ60=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5F8C97A60;
        Fri,  8 Sep 2017 02:39:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AEF497A5E;
        Fri,  8 Sep 2017 02:39:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rene Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 27/34] shortlog: release strbuf after use in insert_one_record()
References: <20170830175005.20756-1-l.s.r@web.de>
        <20170830180037.20950-1-l.s.r@web.de>
        <20170830180037.20950-8-l.s.r@web.de>
        <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
        <20170907043354.fwxiifzbqf3yt5rr@sigill.intra.peff.net>
        <xmqqzia61125.fsf@gitster.mtv.corp.google.com>
        <20170908035648.jhm6ypxkwwms4bqu@sigill.intra.peff.net>
        <20170908043633.smytugbn7ge4twlm@sigill.intra.peff.net>
Date:   Fri, 08 Sep 2017 15:39:36 +0900
In-Reply-To: <20170908043633.smytugbn7ge4twlm@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 8 Sep 2017 00:36:34 -0400")
Message-ID: <xmqqk219zobb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C56688C-9460-11E7-81AA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> IOW, something like the patch below, which pushes the re-parsing out to
> the stdin code-path, and lets the internal traversal format directly
> into the final buffer. It seems to be about 3% faster than the existing
> code, and fixes the leak (by dropping that variable entirely).

Wow, that is soooo logical a conclusion that I somewhat feel ashamed
that I didn't think of it myself.  

Nicely done.

>
> -Peff
>
> ---
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 43c4799ea9..e29875b843 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -52,26 +52,8 @@ static void insert_one_record(struct shortlog *log,
>  			      const char *oneline)
>  {
>  	struct string_list_item *item;
> -	const char *mailbuf, *namebuf;
> -	size_t namelen, maillen;
> -	struct strbuf namemailbuf = STRBUF_INIT;
> -	struct ident_split ident;
>  
> -	if (split_ident_line(&ident, author, strlen(author)))
> -		return;
> -
> -	namebuf = ident.name_begin;
> -	mailbuf = ident.mail_begin;
> -	namelen = ident.name_end - ident.name_begin;
> -	maillen = ident.mail_end - ident.mail_begin;
> -
> -	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
> -	strbuf_add(&namemailbuf, namebuf, namelen);
> -
> -	if (log->email)
> -		strbuf_addf(&namemailbuf, " <%.*s>", (int)maillen, mailbuf);
> -
> -	item = string_list_insert(&log->list, namemailbuf.buf);
> +	item = string_list_insert(&log->list, author);
>  
>  	if (log->summary)
>  		item->util = (void *)(UTIL_TO_INT(item) + 1);
> @@ -114,9 +96,33 @@ static void insert_one_record(struct shortlog *log,
>  	}
>  }
>  
> +static int parse_stdin_author(struct shortlog *log,
> +			       struct strbuf *out, const char *in)
> +{
> +	const char *mailbuf, *namebuf;
> +	size_t namelen, maillen;
> +	struct ident_split ident;
> +
> +	if (split_ident_line(&ident, in, strlen(in)))
> +		return -1;
> +
> +	namebuf = ident.name_begin;
> +	mailbuf = ident.mail_begin;
> +	namelen = ident.name_end - ident.name_begin;
> +	maillen = ident.mail_end - ident.mail_begin;
> +
> +	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
> +	strbuf_add(out, namebuf, namelen);
> +	if (log->email)
> +		strbuf_addf(out, " <%.*s>", (int)maillen, mailbuf);
> +
> +	return 0;
> +}
> +
>  static void read_from_stdin(struct shortlog *log)
>  {
>  	struct strbuf author = STRBUF_INIT;
> +	struct strbuf mapped_author = STRBUF_INIT;
>  	struct strbuf oneline = STRBUF_INIT;
>  	static const char *author_match[2] = { "Author: ", "author " };
>  	static const char *committer_match[2] = { "Commit: ", "committer " };
> @@ -134,9 +140,15 @@ static void read_from_stdin(struct shortlog *log)
>  		while (strbuf_getline_lf(&oneline, stdin) != EOF &&
>  		       !oneline.len)
>  			; /* discard blanks */
> -		insert_one_record(log, v, oneline.buf);
> +
> +		strbuf_reset(&mapped_author);
> +		if (parse_stdin_author(log, &mapped_author, v) < 0)
> +			continue;
> +
> +		insert_one_record(log, mapped_author.buf, oneline.buf);
>  	}
>  	strbuf_release(&author);
> +	strbuf_release(&mapped_author);
>  	strbuf_release(&oneline);
>  }
>  
> @@ -153,7 +165,9 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  	ctx.date_mode.type = DATE_NORMAL;
>  	ctx.output_encoding = get_log_output_encoding();
>  
> -	fmt = log->committer ? "%cn <%ce>" : "%an <%ae>";
> +	fmt = log->committer ?
> +		(log->email ? "%cN <%cE>" : "%cN") :
> +		(log->email ? "%aN <%aE>" : "%aN");
>  
>  	format_commit_message(commit, fmt, &author, &ctx);
>  	if (!log->summary) {
