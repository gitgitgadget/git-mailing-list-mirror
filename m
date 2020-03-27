Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0400C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C625206DB
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NKFKuynF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgC0V6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:58:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61448 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0V6k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 17:58:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAF576356C;
        Fri, 27 Mar 2020 17:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Ik7LjPMlSOF5TJsi4lNHy2sgnk=; b=NKFKuy
        nFQEKxcKdqfpQoB59FAVBleo45drUEEdd6vTc6KxmTodWy3zcVexfSvgCRQb+qPx
        Q2+omEJAiqnyvaFuUYQaXyuyY5+Snbw2IN4dmumTDN46okVX9qt8wcqTURSQqxn4
        sSvBf9EAMMUnJ9pdLt9NzMnyZ0OffESE36WyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AghCvjGqcYTRGzEnsTbfr70WkmXp8jRm
        opJ8UUKKmF/m6QX8JudAHh5UGAICCLbUZYrIHlZkkIWjbK1mVVp5KNCgaLMdz9HS
        HBlCNYBn51Sz8KiqsFFf/MbZeEV/sHRYvrFoU+IFzld/hHhVMIKR8TWUwpqoe8M7
        aY7d29dcJIg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E189B6356B;
        Fri, 27 Mar 2020 17:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EF9D6356A;
        Fri, 27 Mar 2020 17:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 8/9] update-ref: read commands in a line-wise fashion
References: <cover.1585129842.git.ps@pks.im>
        <1db63f97ec78fad794cec51c5d96b093f7cd2440.1585129843.git.ps@pks.im>
Date:   Fri, 27 Mar 2020 14:58:38 -0700
In-Reply-To: <1db63f97ec78fad794cec51c5d96b093f7cd2440.1585129843.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 25 Mar 2020 10:54:22 +0100")
Message-ID: <xmqqo8she9yp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DA5C810-7076-11EA-92AA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>  static const struct parse_cmd {
>  	const char *prefix;
> -	const char *(*fn)(struct ref_transaction *, const char *, const char *);
> +	void (*fn)(struct ref_transaction *, const char *, const char *);
> +	unsigned extra_lines;

Define and explain the meaning of extra_lines in a comment.  Without
it, the most natural way to infer what the variable means by readers
would be that "update" command sometimes receives up to two more
lines but it also is perfectly normal if there is no extra line.

But I am not sure if that is what is going on.

"update" _always_ needs exactly two more input "lines" when the
input is NUL delimited, perhaps, and it is an _error_ if there are
not these two lines, no?

The name of the field should make such details clear.

>  } commands[] = {
> -	{ "update", parse_cmd_update },
> -	{ "create", parse_cmd_create },
> -	{ "delete", parse_cmd_delete },
> -	{ "verify", parse_cmd_verify },
> -	{ "option", parse_cmd_option },
> +	{ "update", parse_cmd_update, 2 },
> +	{ "create", parse_cmd_create, 1 },
> +	{ "delete", parse_cmd_delete, 1 },
> +	{ "verify", parse_cmd_verify, 1 },
> +	{ "option", parse_cmd_option, 0 },
>  };
> +		/* Read extra lines if NUL-terminated */
> +		for (j = 0; line_termination == '\0' && j < cmd->extra_lines; j++)
> +			if (strbuf_appendwholeline(&input, stdin, line_termination))
> +				break;

And this code does not barf if you get a premature EOF and let the
call to cmd->fn() go through, which sounds buggy.

> +		cmd->fn(transaction, input.buf + strlen(cmd->prefix),
> +			input.buf + input.len);
>  	}
>  
>  	if (ref_transaction_commit(transaction, &err))

Thanks.
