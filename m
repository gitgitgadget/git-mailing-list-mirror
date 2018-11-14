Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955CB1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 12:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeKNWzP (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 17:55:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:38988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728203AbeKNWzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 17:55:15 -0500
Received: (qmail 20844 invoked by uid 109); 14 Nov 2018 12:52:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 12:52:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1583 invoked by uid 111); 14 Nov 2018 12:51:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Nov 2018 07:51:28 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2018 07:52:06 -0500
Date:   Wed, 14 Nov 2018 07:52:06 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/5] tests: do not require Git to be built when testing
 an installed Git
Message-ID: <20181114125206.GA32308@sigill.intra.peff.net>
References: <pull.73.git.gitgitgadget@gmail.com>
 <316e215e54b921330b91c763255eb25f475a64ae.1542030510.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <316e215e54b921330b91c763255eb25f475a64ae.1542030510.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 05:48:37AM -0800, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 832ede5099..1ea20dc2dc 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -51,7 +51,7 @@ export LSAN_OPTIONS
>  
>  ################################################################
>  # It appears that people try to run tests without building...
> -"$GIT_BUILD_DIR/git" >/dev/null
> +test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git" >/dev/null ||
>  if test $? != 1
>  then
>  	echo >&2 'error: you do not seem to have built git yet.'

The original runs the command independently and then checks $?. Your
replacement chains the ||. I think it works, because the only case that
is different is if running git returns 0 (in which case we currently
complain, but the new code would quietly accept this).

That should never happen, but if it does we'd probably want to complain.
And it's pretty subtle all around.  Maybe this would be a bit clearer:

  if test -n "$GIT_TEST_INSTALLED"
  then
	: assume installed git is OK
  else
	"$GIT_BUILD_DIR/git" >/dev/null
	if test $? != 1
	then
		... die ...
	fi
  fi

Though arguably we should be checking that there is a git in our path in
the first instance. So maybe:

  if test -n "$GIT_TEST_INSTALLED"
	"$GIT_TEST_INSTALLED/git" >/dev/null
  else
	"$GIT_BUILD_DIR/git" >/dev/null
  fi
  if test $? != 1 ...

-Peff
