Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF683C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 18:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D528F207DD
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 18:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgFRSPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:15:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:36406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbgFRSPe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 14:15:34 -0400
Received: (qmail 20826 invoked by uid 109); 18 Jun 2020 18:15:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Jun 2020 18:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17732 invoked by uid 111); 18 Jun 2020 18:15:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Jun 2020 14:15:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Jun 2020 14:15:33 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] lib-submodule-update: use callbacks in
 test_submodule_switch_common()
Message-ID: <20200618181533.GA633383@coredump.intra.peff.net>
References: <cover.1591897173.git.liu.denton@gmail.com>
 <cover.1592470068.git.liu.denton@gmail.com>
 <35d07117e637edf5f9a148a50da6b2294ec0f87f.1592470068.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35d07117e637edf5f9a148a50da6b2294ec0f87f.1592470068.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 04:49:14AM -0400, Denton Liu wrote:

> Instead of invoking $command as one monolithic helper function, break it
> up into three parts:
> 
> 	1. $command which is always a git command.
> 	2. $before which is a callback function that runs just prior to
> 	   $command.
> 	3. $after which is a callback function that runs just after
> 	   $command.

Thanks for reworking it in this way. I do think it's less confusing than
the original.

> If the command requires a filename argument, specify it as `\$arg` since
> that variable will be set and the whole $command string will be eval'd.
> Unfortunately, there is no way to get rid of the eval as some of the
> commands that are passed (such as the `git pull` tests) require that no
> additional arguments are passed so we must have some mechanism for the
> caller to specify whether or not it wants the filename argument.

We didn't need that "\$arg" thing before because we were passing whole
functions (which then decided to pass the arg or not). Can we just keep
doing that (using functions)?

That puts the onus on callers who want to ignore the arg to wrap any
commands in a function, but saves ones who _do_ want to use the arg from
having to do anything. So it's a tradeoff, but I think an extra function
wrapper is less magical than the "\$arg" eval (plus from skimming the
diff, I think most callers do use it).

So for example, this:

> +test_submodule_switch_func "apply --3way diff" "create_diff"

becomes:

  apply_diff () {
          git apply --3way diff
  }
  test_submodule_switch_func apply_diff create_diff

Obviously that requires dropping the implicit "git" from $command (but
I'd argue that makes things less magical, too).

> @@ -326,7 +336,10 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t add_sub1 origin/add_sub1 &&
> -			$command add_sub1 &&
> +			arg=add_sub1 &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&

This block gets repeated a lot, and I wondered if a helper function
could make it better. But:

  1. We'd have to pass in a bunch of variables (or consider them as
     magic globals).

  2. Some callers want test_must_fail and other's don't.

So I think it would be something like:

  do_command () {
    $before "$1" &&
    "$2" $command "$1" &&
    $after "$1"
  }

  ...
  do_command add_sub1 &&
  ...

There's definitely still some magic there, but at least it's all
contained within the one script. I could go either way on it.

-Peff
