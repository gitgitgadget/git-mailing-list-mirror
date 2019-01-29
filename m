Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5781E1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 13:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfA2NAe (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 08:00:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:52954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725730AbfA2NAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 08:00:34 -0500
Received: (qmail 26012 invoked by uid 109); 29 Jan 2019 13:00:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 13:00:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6199 invoked by uid 111); 29 Jan 2019 13:00:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 08:00:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 08:00:32 -0500
Date:   Tue, 29 Jan 2019 08:00:32 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/3] Add tests for describe with --work-tree
Message-ID: <20190129130031.GA22211@sigill.intra.peff.net>
References: <20190129051859.12830-1-koraktor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129051859.12830-1-koraktor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 06:18:57AM +0100, Sebastian Staudt wrote:

> The dirty ones are already passing, but just because describe is comparing
> with the wrong working tree.
> 
> Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> ---
>  t/t6120-describe.sh | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index d639d94696..c863c4f600 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -145,14 +145,38 @@ check_describe A-* HEAD
>  
>  check_describe "A-*[0-9a-f]" --dirty
>  
> +test_expect_success 'describe --dirty with --work-tree' "

This should be marked as test_expect_failure, I think, because it does
not yet pass (and then flipped s/failure/success/ in the next patch).

> +	(
> +		cd '$TEST_DIRECTORY' &&
> +		git --git-dir '$TRASH_DIRECTORY/.git' --work-tree '$TRASH_DIRECTORY' describe --dirty >'$TRASH_DIRECTORY/out'
> +	) &&

The quoting you've done here is unusual for our test suite, and not
quite as robust. You've put the whole test snippet into double-quotes,
which means that $TRASH_DIRECTORY, etc, will be expanded before we eval
the code.

By putting single-quotes around $TRASH_DIRECTORY, that makes it work
when the path contains a space. But it would fail if somebody's
filesystem path contains a single-quote.

The usual style is to put the whole snippet into single-quotes, and then
double-quote as appropriate within it. Like:

  test_expect_failure 'describe --dirty with --work-tree' '
	(
		cd "$TEST_DIRECTORY" &&
		git --git-dir "$TRASH_DIRECTORY/.git" ...etc

Those variables will be expanded when test_expect_failure eval's the
snippet.

> +	grep 'A-\d\+-g[0-9a-f]\+' '$TRASH_DIRECTORY/out'

Using "\d" isn't portable.

This regex is pretty broad. What are we checking here? If I understand
the previous discussion, we just care that it doesn't have "dirty" in
it, right? I don't think this regex does that, because it doesn't anchor
the end of string.

If that's indeed what we're checking, then an easier check is perhaps:

  ! grep dirty ...

As a side note, you can also shorten your references to "out" by
referring to it from the trash directory itself. I.e.:

  (
	cd "$TEST_DIRECTORY" &&
	git --git-dir="$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" \
	  describe --dirty
  ) >out &&
  ! grep dirty out

Same thing, but IMHO a little easier to read.

>  check_describe "A-*[0-9a-f]-dirty" --dirty
>  
> +test_expect_success 'describe --dirty with --work-tree' "
> [...]

Same comments apply to the other blocks you added.

Other than those mechanical things, though, what the tests are actually
trying to do seems quite reasonable to me.

-Peff
