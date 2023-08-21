Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E11EE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjHUVBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjHUVBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:01:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A35D9
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:00:59 -0700 (PDT)
Received: (qmail 17728 invoked by uid 109); 21 Aug 2023 21:00:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 21:00:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19503 invoked by uid 111); 21 Aug 2023 21:01:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 17:01:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 17:00:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] diff: the -w option breaks --exit-code for --raw
 and other output modes
Message-ID: <20230821210058.GD1800481@coredump.intra.peff.net>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
 <20230818235932.3253552-6-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818235932.3253552-6-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2023 at 04:59:32PM -0700, Junio C Hamano wrote:

> The output from "--raw", "--name-status", and "--name-only" modes in
> "git diff" does depend on and does not reflect how certain different
> contents are considered equal, unlike "--patch" and "--stat" output
> modes do, when used with options like "-w" (another way of thinking
> about it is that it is not like we recompute the hash of the blob
> after removing all whitespaces to show "git diff --raw -w" output).
> 
> But that is not an excuse for "git diff --exit-code --raw" to fail
> to report differences with its exit status, when used with options
> like "-w".  Make sure the command exits with 1 when these options
> report paths that are different.

I think s/with options like/without options like/ in the final
paragraph?

I like this approach much better than the earlier round. It brings the
output and exit code of "--raw", etc, into harmony. I am open to the
argument that if you ask for "--raw -w", we should start doing
content-level comparisons (since otherwise the "-w" is somewhat
useless). But even if we went that route, it should affect both the
output and the exit code. So this patch would be a prerequisite anyway.

And I say "I am open to" and not "I think it is a good idea" above,
because I suspect there are many lurking corner cases. The hash output
you mentioned is one. But also, what "--raw --patch -w" does right now
is sensible (show the raw output, but also show the whitespace-ignoring
patch), and would be impossible if "-w" affected "--raw".

> diff --git a/diff.c b/diff.c
> index da965ff688..78f4e7518f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4744,6 +4744,10 @@ void diff_setup_done(struct diff_options *options)
>  	else
>  		options->prefix_length = 0;
>  
> +	/*
> +	 * --name-only, --name-status, --checkdiff, and -s
> +	 * turn other output format off.
> +	 */
>  	if (options->output_format & (DIFF_FORMAT_NAME |
>  				      DIFF_FORMAT_NAME_STATUS |
>  				      DIFF_FORMAT_CHECKDIFF |

OK, this hunk is just documenting the current state, not changing
anything.

> @@ -6072,6 +6076,8 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
>  		fprintf(opt->file, "%s", diff_line_prefix(opt));
>  		write_name_quoted(name_a, opt->file, opt->line_termination);
>  	}
> +
> +	opt->found_changes = 1;
>  }

This seems deceptively simple. :) The key here is that flush_one_pair()
is called only for the formats that are otherwise broken (because they
are not looking at the content). I think this is a good spot to put the
fix, as any similar formats would hopefully get added to the conditional
in diff_flush() that puts us here.

Alternatively, we could put it in the caller, like so:

diff --git a/diff.c b/diff.c
index 78f4e7518f..e7281e75eb 100644
--- a/diff.c
+++ b/diff.c
@@ -6528,6 +6528,7 @@ void diff_flush(struct diff_options *options)
 			if (check_pair_status(p))
 				flush_one_pair(p, options);
 		}
+		options->found_changes = !!q->nr;
 		separator++;
 	}
 

which matches the diffstat technique (I almost thought we could share
the code, but for the diffstat we are counting what ends up in the
diffstat struct; it does not clean out the original diff_queue when it
sees a noop pair).

I don't see a real reason to prefer one over the other.

> -for opts in --patch --quiet -s --stat --shortstat --dirstat=lines
> +for opt_res in --patch --quiet -s --stat --shortstat --dirstat=lines \
> +	       --raw! --name-only! --name-status!
>  do
> +	opts=${opt_res%!} expect_failure=
> +	test "$opts" = "$opt_res" ||
> +		expect_failure="test_expect_code 1"

Cute "!" convention. :)

-Peff
