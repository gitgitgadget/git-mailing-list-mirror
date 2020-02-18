Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D1C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B3A2070B
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRU7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:59:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:47232 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726352AbgBRU7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:59:07 -0500
Received: (qmail 20289 invoked by uid 109); 18 Feb 2020 20:59:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 20:59:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22422 invoked by uid 111); 18 Feb 2020 21:08:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 16:08:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 15:59:06 -0500
From:   Jeff King <peff@peff.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] push: introduce --push-option-if-able
Message-ID: <20200218205906.GB22630@coredump.intra.peff.net>
References: <20200218200913.128519-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218200913.128519-1-sir@cmpwn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 03:09:14PM -0500, Drew DeVault wrote:

> This introduces a --push-option-if-able, and along with it updates
> send-pack, transport, push, etc to track the list of push options
> specified via this flag. These options will be used if the remote
> supports push options, but will not cause the push operation to
> terminate if the remote does not support push options.
> 
> This is desirable in the following scenario: you frequently use two git
> hosts, A and B, of which only B supports push options. If you wish to
> set a push option globally (via git config push.pushOptions), any
> attempts to push to host A will fail, requiring you to explicitly
> override it at the command line. This renders the push.pushOption
> config value basically useless for a lot of users.

Unsurprisingly, this approach makes sense to me. :)

The implementation looks like the right direction, but I noticed a few
things I think are worth addressing:

>  Documentation/config/push.txt      |  6 +++++
>  Documentation/git-push.txt         | 14 +++++++++++-
>  Documentation/git-receive-pack.txt | 10 +++++++++
>  Documentation/githooks.txt         |  3 ++-
>  builtin/push.c                     | 35 +++++++++++++++++++++++++-----
>  send-pack.c                        |  9 ++++++--
>  send-pack.h                        |  2 +-
>  submodule.c                        | 11 +++++++++-
>  submodule.h                        |  1 +
>  transport-helper.c                 |  3 +++
>  transport.c                        |  2 ++
>  transport.h                        |  5 +++++

We'd probably want some test coverage of the new command-line and config
options. Looks like t/t5545-push-options.sh would be a good place to add
it, and you should be able to emulate some of the existing tests there.

> @@ -224,6 +225,17 @@ already exists on the remote side.
>  	line, the values of configuration variable `push.pushOption`
>  	are used instead.
>  
> +--push-option-if-able=<option>::
> +	Identical to --push-option, but does not terminate the push if the
> +	remote does not support push options. This is useful, for example,
> +	if you wish to globally enable a push option for use on a specific
> +	git host, but also occasionally push to hosts which do not have
> +	push options enabled. If you were to use --push-option instead,
> +	pushing to the latter would cause the push to be aborted.
> +	When no `--push-option-if-able=<option>` is given from the command
> +	line, the values of configuration variable `push.pushOptionIfAble`
> +	are used instead.

The discussion of the rationale looks good here.

How do the two command-line lists (and their config counterparts)
interact? E.g., if I do:

  git push --push-option-if-able=foo

we know that overrides push.pushOptionIfAble config. Does it / should it
override push.pushOption? Likewise, a blank config option resets the
list. Would:

  [push]
  pushOptionIfAble = foo
  pushOption =

send "foo" or not?

IMHO we should consider it from the user's point of view as a single
list of push options, some of which are annotated with "if able" and
some not (and the answer would be "yes" to both of my questions).

And then the implementation could reflect that by using a single list.
I think that simplifies things by not having to pass around both lists.
You should be able to use string_list's util field to store the flag
(either allocate and point to a struct for each option, or just cast 0/1
to a void pointer).

> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
> index 25702ed730..992ef5784f 100644
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -109,6 +109,16 @@ the following environment variables:
>  This hook is called before any refname is updated and before any
>  fast-forward checks are performed.
>  
> +The number of push options given on the command line of
> +`git push --push-option=...` can be read from the environment
> +variable `GIT_PUSH_OPTION_COUNT`, and the options themselves are
> +found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
> +If it is negotiated to not use the push options phase, the
> +environment variables will not be set. If the client selects
> +to use push options, but doesn't transmit any, the count variable
> +will be set to zero, `GIT_PUSH_OPTION_COUNT=0`. In order for to receive push
> +options, `receive.advertisePushOptions` must be enabled on the server.

I think this documentation change made more sense as a separate patch
(since the server side is not affected either way by the "if able"
feature).

It still has the "for to" typo (or am I misreading it?).

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 3dccab5375..48103116fd 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -283,7 +283,8 @@ found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
>  If it is negotiated to not use the push options phase, the
>  environment variables will not be set. If the client selects
>  to use push options, but doesn't transmit any, the count variable
> -will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
> +will be set to zero, `GIT_PUSH_OPTION_COUNT=0`. In order for to receive push
> +options, `receive.advertisePushOptions` must be enabled on the server.

Likewise here (including the typo ;) ).

-Peff
