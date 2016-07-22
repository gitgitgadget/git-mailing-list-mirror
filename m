Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60476203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbcGVRoN (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:44:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751621AbcGVRoM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:44:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 78A412DAD5;
	Fri, 22 Jul 2016 13:44:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tQgUt3rrWtRsIT5Ye7WmAx2BSy8=; b=sCckLa
	NHltOu9A3zv1MWP6iCi9UzBcaQMYBRfXCKfrvu0I4cGxjonweFlUc3bxt+BZP29H
	JP+6b8Gr23rS0AXUS5kOME+nPPSRKmwmawGoj6Z8qZpTzHMNRkQrYguZ+T7XqEwY
	IlzhSE7csSVbsmMuf5xQta8G8yJlNzYGEsCOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T6SrtWDPOYovtgOMFjr3jJDgIXr8TXr9
	e1kBDwIaxgP5PzD7KR5bu6JYqthHfYq6YPHwYouCSU9MnMYDzeextDJaf6xRI9lO
	y8x08Ki+GjMfVzLjw5yGhfC6jISlXzBKBNKT7UYyejSaX7gwBcNRMW2zEshAi/GD
	I3yIO/qi3tc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E8D42DAD4;
	Fri, 22 Jul 2016 13:44:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D52A82DAD3;
	Fri, 22 Jul 2016 13:44:10 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] diff: do not reuse worktree files that need "clean" conversion
References: <1469134747-26785-1-git-send-email-larsxschneider@gmail.com>
	<20160721213740.GB4604@sigill.intra.peff.net>
	<20160722152753.GA6859@sigill.intra.peff.net>
Date:	Fri, 22 Jul 2016 10:44:08 -0700
In-Reply-To: <20160722152753.GA6859@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Jul 2016 11:27:53 -0400")
Message-ID: <xmqq60rxbmaf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5B616FA-5033-11E6-8050-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: diff: do not reuse worktree files that need "clean" conversion
>
> When accessing a blob for a diff, we may try to reuse file
> contents in the working tree, under the theory that it is
> faster to mmap those file contents than it would be to
> extract the content from the object database.
>
> When we have to filter those contents, though, that
> assumption does not hold. Even for our internal conversions
> like CRLF, we have to allocate and fill a new buffer anyway.
> But much worse, for external clean filters we have to exec
> an arbitrary script, and we have no idea how expensive it
> may be to run.
>
> So let's skip this optimization when conversion into git's
> "clean" form is required. This applies whenever the
> "want_file" flag is false. When it's true, the caller
> actually wants the smudged worktree contents, which the
> reused file by definition already has (in fact, this is a
> key optimization going the other direction, since reusing
> the worktree file there lets us skip smudge filters).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  diff.c                |  7 +++++++
>  t/t0021-conversion.sh | 11 +++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index 7d03419..b43d3dd 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2683,6 +2683,13 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
>  	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1))
>  		return 0;
>  
> +	/*
> +	 * Similarly, if we'd have to convert the file contents anyway, that
> +	 * makes the optimization not worthwhile.
> +	 */
> +	if (!want_file && would_convert_to_git(name))
> +		return 0;

The would_convert_to_git() function is not a free operation.  It
needs to prime the attribute stack, so it needs to open/read/parse a
few files ($GIT_DIR/info/attributes and .gitattributes at least, and
more if your directory hierarchy is deep) on the filesystem.  The
cost is amortized across paths, but we do not even enable the
optimization if we have to pay the cost of reading the index
ourselves.

I suspect that we may be better off disabling this optimization if
we need to always call the helper.

>  	len = strlen(name);
>  	pos = cache_name_pos(name, len);
>  	if (pos < 0)
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 7bac2bc..e799e59 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -268,4 +268,15 @@ test_expect_success 'disable filter with empty override' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_success 'diff does not reuse worktree files that need cleaning' '
> +	test_config filter.counter.clean "echo . >>count; sed s/^/clean:/" &&
> +	echo "file filter=counter" >.gitattributes &&
> +	test_commit one file &&
> +	test_commit two file &&
> +
> +	>count &&
> +	git diff-tree -p HEAD &&
> +	test_line_count = 0 count
> +'
> +
>  test_done
