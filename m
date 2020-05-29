Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8C4C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 06:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA3920721
	for <git@archiver.kernel.org>; Fri, 29 May 2020 06:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgE2GNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 02:13:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:59708 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2GNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 02:13:48 -0400
Received: (qmail 1781 invoked by uid 109); 29 May 2020 06:13:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2020 06:13:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21188 invoked by uid 111); 29 May 2020 06:13:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2020 02:13:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 May 2020 02:13:46 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: add new --date-format=raw-permissive
 format
Message-ID: <20200529061346.GB1294228@coredump.intra.peff.net>
References: <pull.795.git.git.1590693313099.gitgitgadget@gmail.com>
 <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 08:40:37PM +0000, Elijah Newren via GitGitGadget wrote:

>      * Instead of just allowing such timezones outright, did it behind a
>        --date-format=raw-permissive as suggested by Jonathan

Thanks, I like the safety this gives us against importer bugs. It does
mean that people doing "export | filter | import" may have to manually
loosen it, but it should be rare enough that this isn't a big burden
(and if they're rewriting anyway, maybe it gives them a chance to decide
how to fix it up).

>  fast-import.c          | 15 ++++++++++++---
>  t/t9300-fast-import.sh | 30 ++++++++++++++++++++++++++++++

Would we need a documentation update for "raw-permissive", too?

> @@ -1929,7 +1931,8 @@ static int validate_raw_date(const char *src, struct strbuf *result)
>  		return -1;
>  
>  	num = strtoul(src + 1, &endp, 10);
> -	if (errno || endp == src + 1 || *endp || 1400 < num)
> +	out_of_range_timezone = strict && (1400 < num);
> +	if (errno || endp == src + 1 || *endp || out_of_range_timezone)
>  		return -1;

It's a little funny to do computations on the result of a function
before we've checked whether it produced an error. But since the result
is just an integer, I don't think we'd do anything unexpected (we might
just throw away the value, though I imagine an optimizing compiler might
evaluate it lazily anyway).

> @@ -1963,7 +1966,11 @@ static char *parse_ident(const char *buf)
>  
>  	switch (whenspec) {
>  	case WHENSPEC_RAW:
> -		if (validate_raw_date(ltgt, &ident) < 0)
> +		if (validate_raw_date(ltgt, &ident, 1) < 0)
> +			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
> +		break;
> +	case WHENSPEC_RAW_PERMISSIVE:
> +		if (validate_raw_date(ltgt, &ident, 0) < 0)
>  			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
>  		break;

This looks simple enough. We have the bogus date in a buffer at that
point, and we stuff that string literally into the commit (or tag)
object. If we ever get more clever about storing the timestamp
internally as an integer, we may need to get more clever. But your new
test should alert us if that becomes the case.

> +test_expect_success 'B: accept invalid timezone with raw-permissive' '
> +	cat >input <<-INPUT_END &&
> +	commit refs/heads/invalid-timezone
> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
> +	data <<COMMIT
> +	empty commit
> +	COMMIT
> +	INPUT_END
> +
> +	test_when_finished "git update-ref -d refs/heads/invalid-timezone
> +		git gc
> +		git prune" &&

We check the exit code of when_finished commands, so this should be
&&-chained as usual. And possibly indented like:

  test_when_finished "
    git update-ref -d refs/heads/invalid-timezone &&
    git gc &&
    git prune
  " &&

but I see this all is copying another nearby test. So I'm OK with
keeping it consistent for now and cleaning up the whole thing later.
Though if you want to do that step now, I have no objection. :)

I also also suspect this "gc" is not useful these days. For a small
input like this, fast-import will write loose objects, since d9545c7f46
(fast-import: implement unpack limit, 2016-04-25).

TBH, I think it would be easier to understand as:

  ...
  git init invalid-timezone &&
  git -C invalid-timezone fast-import <input &&
  git -C invalid-timezone cat-file -p master >out &&
  ...

and don't bother with the when_finished at all. Then you don't have to
wonder whether the cleanup was sufficient, and it's fewer processes
to boot (we'll leave the sub-repo cruft sitting around, but a single "rm
-rf" at the end of the test script will wipe them all out).

-Peff
