Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7DE1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 20:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfBKUUC (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 15:20:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:40418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727530AbfBKUUC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 15:20:02 -0500
Received: (qmail 7191 invoked by uid 109); 11 Feb 2019 20:20:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Feb 2019 20:20:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17066 invoked by uid 111); 11 Feb 2019 20:20:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 15:20:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 15:20:00 -0500
Date:   Mon, 11 Feb 2019 15:20:00 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 1/8] tests: define GIT_TEST_PROTOCOL_VERSION
Message-ID: <20190211201959.GA9072@sigill.intra.peff.net>
References: <cover.1549411880.git.jonathantanmy@google.com>
 <6e0c6aa9a71d4192591ed406735684cd15a0e3b9.1549411880.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e0c6aa9a71d4192591ed406735684cd15a0e3b9.1549411880.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 04:21:15PM -0800, Jonathan Tan wrote:

> Define a GIT_TEST_PROTOCOL_VERSION environment variable meant to be used
> from tests. When set, this ensures protocol.version is at least the
> given value, allowing the entire test suite to be run as if this
> configuration is in place for all repositories.
> 
> As of this patch, all tests pass whether GIT_TEST_PROTOCOL_VERSION is
> unset, set to 0, or set to 1. Some tests fail when
> GIT_TEST_PROTOCOL_VERSION is set to 2, but this will be dealt with in
> subsequent patches.

Makes sense. The "at least" part made me scratch my head at first, but
your explanation in response to Ævar made sense.

Two minor nits:

> diff --git a/protocol.c b/protocol.c
> index 5664bd7a05..c7a735bfa2 100644
> --- a/protocol.c
> +++ b/protocol.c
> @@ -42,6 +42,10 @@ static const char *format_protocol_version(enum protocol_version version)
>  enum protocol_version get_protocol_version_config(void)
>  {
>  	const char *value;
> +	enum protocol_version retval = protocol_v0;
> +	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
> +	const char *git_test_v = getenv(git_test_k);

We've discussed recently how the return value from getenv() isn't
stable. It looks like we could assign it much closer to the point-of-use
here (which still isn't 100% foolproof, but I think is something we
could encourage as a general pattern, and mostly works due to our
ring-buffer technique).

I.e., right before this conditional:

> +
> +	if (git_test_v && strlen(git_test_v)) {

It's more idiomatic in our code base to check for a non-empty string as:

  if (git_test_v && *git_test_v)

though obviously that's pretty minor.

-Peff
