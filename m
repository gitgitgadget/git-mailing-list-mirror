Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD04202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 01:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdJ0B6i (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 21:58:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62838 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751457AbdJ0B6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 21:58:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A727CADB2D;
        Thu, 26 Oct 2017 21:58:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aAO54eqiCv0D9ICK3/s5WXljunA=; b=XzHzLB
        JYO9+LEkZukCqVANHke/sJ2hrz0aE3mcpAXx6jrFBVgDINkE5Ksu8CDYXAJ0oQi+
        0Xx+zNALs6s9+G92mcMjvvxUupI2xzqI/GZ/oWzX403xWXsAYZI2JEkTi8IBww/u
        f502yjrALxq2BJg5X4oHRWoJd6LMutSfICr3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bBFz7eeIHM56GlbM96BUqBbywFEL2vjO
        Y3pg1sYoBH39rBSGLA7HZwrmiwC1NA4P73QSE7Uap3h8kA217SmtQo3weDiT4pca
        XhtA9Tv+OxMZpJNtZHb0QLJElLWqZjES8psSInjq0jXCoMJXM3QtuEHsjnrCCdZ7
        igSH0ydXq8Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CE05ADB2C;
        Thu, 26 Oct 2017 21:58:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02172ADB2B;
        Thu, 26 Oct 2017 21:58:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     szeder.dev@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com
Subject: Re: [PATCH v3] blame: prevent error if range ends past end of file
References: <20171026153111.21813-1-szeder.dev@gmail.com>
        <20171027005652.7796-1-istephens@atlassian.com>
Date:   Fri, 27 Oct 2017 10:58:34 +0900
In-Reply-To: <20171027005652.7796-1-istephens@atlassian.com> (Isabella
        Stephens's message of "Fri, 27 Oct 2017 11:56:52 +1100")
Message-ID: <xmqqzi8dcpx1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57FC06E2-BABA-11E7-B0A1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Isabella Stephens <istephens@atlassian.com> writes:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 67adaef4d..b5b9db147 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -878,13 +878,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  				    nth_line_cb, &sb, lno, anchor,
>  				    &bottom, &top, sb.path))
>  			usage(blame_usage);
> -		if (lno < top || ((lno || bottom) && lno < bottom))
> +		if ((lno || bottom) && lno < bottom)
>  			die(Q_("file %s has only %lu line",
>  			       "file %s has only %lu lines",
>  			       lno), path, lno);
>  		if (bottom < 1)
>  			bottom = 1;
> -		if (top < 1)
> +		if (top < 1 || lno < top)
>  			top = lno;

This section sanity-checks first and then tweaks the values it
allowed to pass the check.  Because it wants to later fix up an
overly large "top" by capping to "lno" (i.e. total line number), the
patch needs to loosen the early sanity-check.  And the "fixed up"
values are never checked if they are sane.

For example, with an empty file (i.e. lno == 0), you can ask "git
blame -L1,-4 ("i.e. "at most four lines, ending at line #1") and the
code silently accepts the input without noticing that the request is
an utter nonsense; "file X has only 0 lines" error is given a chance
to kick in.

There should be an "is the range sensible?" check after all the
tweaking to bottom and top are done, I think.

>  		bottom--;
>  		range_set_append_unsafe(&ranges, bottom, top);
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index 661f9d430..728209fa3 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -216,14 +216,13 @@ test_expect_success 'blame -L with invalid start' '
>  '
>  
>  test_expect_success 'blame -L with invalid end' '
> -	test_must_fail git blame -L1,5 tres 2>errors &&
> -	test_i18ngrep "has only 2 lines" errors
> +	git blame -L1,5 tres >out &&
> +	test_line_count = 2 out
>  '
>  
>  test_expect_success 'blame parses <end> part of -L' '
>  	git blame -L1,1 tres >out &&
> -	cat out &&
> -	test $(wc -l < out) -eq 1
> +	test_line_count = 1 out
>  '
>  
>  test_expect_success 'indent of line numbers, nine lines' '
