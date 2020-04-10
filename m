Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAF2C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F07320CC7
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJP61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:58:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:39718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726049AbgDJP61 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 11:58:27 -0400
Received: (qmail 4734 invoked by uid 109); 10 Apr 2020 15:58:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 15:58:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32376 invoked by uid 111); 10 Apr 2020 16:09:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 12:09:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 11:58:27 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge: use skip_prefix to parse config key
Message-ID: <20200410155827.GA71011@coredump.intra.peff.net>
References: <20200410151032.23198-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200410151032.23198-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 05:10:32PM +0200, Martin Ågren wrote:

> Instead of using `starts_with()`, the magic number 7, `strlen()` and a
> fair number of additions to verify the three parts of the config key
> "branch.<branch>.mergeoptions", use `skip_prefix()` to jump through them
> more explicitly.

The conversion looks correct to me and is certainly an improvement.

> We need to introduce a new variable for this (we certainly can't modify
> `k` just because we see "branch."!). With `skip_prefix()` we often use
> quite bland names like `p` or `str`. Let's do the same. If and when this
> function needs to do more prefix-skipping, we'll have a generic variable
> ready for this.

I was about to comment on this in the patch, but your explanation
preempted me. :) The logic here makes sense.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index d127d2225f..bde5f14f05 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -597,10 +597,10 @@ static void parse_branch_merge_options(char *bmo)
>  static int git_merge_config(const char *k, const char *v, void *cb)
>  {
>  	int status;
> +	const char *str;
>  
> -	if (branch && starts_with(k, "branch.") &&
> -		starts_with(k + 7, branch) &&
> -		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
> +	if (branch && skip_prefix(k, "branch.", &str) &&
> +	    skip_prefix(str, branch, &str) && !strcmp(str, ".mergeoptions")) {
>  		free(branch_mergeoptions);
>  		branch_mergeoptions = xstrdup(v);
>  		return 0;

In general, parsing subsections accurately involves looking from both
the start and the end of the string, pulling out the section and key and
leaving the rest in the middle. But I think we can get away with this
left-to-right parsing because we're only interested in matching a
_specific_ subsection name, and a specific key. So there are no cases it
will handle incorrectly.

The more general form would be:

  const char *subsection, *key;
  int subsection_len;

  if (!parse_config_key("branch", &subsection, &subsection_len, &key) &&
      subsection_len == strlen(branch) && !strncmp(subsection, branch) &&
      !strcmp(key, "mergeoptions"))
         ...

but that's a bit more awkward (it would be less so if we had a helper
function for comparing a NUL-terminated string against a ptr/len pair).

-Peff
