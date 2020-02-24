Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B5EC3567B
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 06:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C4720714
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 06:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgBXGDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:03:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:52426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725895AbgBXGDv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 01:03:51 -0500
Received: (qmail 5533 invoked by uid 109); 24 Feb 2020 06:03:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 06:03:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7445 invoked by uid 111); 24 Feb 2020 06:12:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2020 01:12:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Feb 2020 01:03:50 -0500
From:   Jeff King <peff@peff.net>
To:     Rasmus Jonsson <wasmus@zom.bi>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [GSoC][PATCH 1/1] t1050: clean up checks for file existence
Message-ID: <20200224060350.GA1015967@coredump.intra.peff.net>
References: <20200222071335.27292-1-wasmus@zom.bi>
 <20200222071335.27292-2-wasmus@zom.bi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222071335.27292-2-wasmus@zom.bi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 22, 2020 at 08:13:35AM +0100, Rasmus Jonsson wrote:

> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index d3b2adb28b..667fc2a745 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -53,7 +53,8 @@ test_expect_success 'add a large file or two' '
>  	for p in .git/objects/pack/pack-*.pack
>  	do
>  		count=$(( $count + 1 ))
> -		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
> +		if test_path_is_file "$p" && idx=${p%.pack}.idx &&
> +		   test_path_is_file "$idx"
>  		then
>  			continue
>  		fi

I was confused at first why these tests use "continue", since it seems
like these conditions would be errors that could cause a test failure
(and if they're not, we probably wouldn't want to use test_path_is_file,
since it's purpose is to complain noisily).

But the part that didn't quite make it into the diff context is
something like this:

  for p in ...
    if test -f ...
    then
      continue
    fi
    bad=t
  done &&
  test -z "$bad"

I think this could be written more clearly as:

  for p in ...
    test -f ... || return 1
  done

We explicitly run the test snippets in a shell function to allow this
kind of early return.

That's orthogonal to your patch, but it might be worth doing on top, or
as a preparatory patch.

But there's one more interesting bit. The loose-object loop from the
next hunk does this:

  for l in ...
    test -f "$l" || continue
    bad=t
  done &&
  test -z "$bad"

In other words, it's checking the opposite case: the test fails if the
file _does_ exist. And so it seems like using test_path_is_file would be
the wrong thing there (it would complain noisily in the success case,
and not at all in the failure case).

I suspect this could be written more clearly by looking at the output of
`git count-objects`, or perhaps just:

  {
    # ignore exit code; will fail when the glob matches nothing
    find objects/??/ -type f >loose-objects
    test_must_be_empty loose-objects
  }

either of which would solve the "match a loose object with any length"
problem that Junio brought up.

-Peff
