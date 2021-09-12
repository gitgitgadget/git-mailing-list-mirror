Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E6EC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 21:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2626103D
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 21:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbhILVlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 17:41:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:45642 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236532AbhILVlO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 17:41:14 -0400
Received: (qmail 16909 invoked by uid 109); 12 Sep 2021 21:39:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 12 Sep 2021 21:39:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2462 invoked by uid 111); 12 Sep 2021 21:39:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 12 Sep 2021 17:39:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 12 Sep 2021 17:39:57 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>, Jakub Wilk <jwilk@jwilk.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag -h fatal error with global tag.sort config
Message-ID: <YT5zrWVlplgE/PWJ@coredump.intra.peff.net>
References: <0daf6907-b472-a756-1240-4c78f8f4d37e@gmail.com>
 <20210912132757.GC76263@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210912132757.GC76263@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 03:27:57PM +0200, SZEDER Gábor wrote:

> Interesting.  It bisects to 47bd3d0c14 (ref-filter: don't look for
> objects when outside of a repository, 2018-11-14), which, based on the
> error message, kind of makes sense, because 'git tag' uses the general
> ref-filter sorting facility.  Now, even if 'git tag -h' is executed in
> a repository, since 99caeed05d (Let 'git <command> -h' show usage
> without a git dir, 2009-11-09) run_builtin() special-cases the '-h'
> option and does not call setup_git_directory(), so cmd_tag() and
> everything invoked from within will mistakenly think that there is no
> repository.  And cmd_tag() parses the config before parsing the
> options (of course, otherwise command line options couldn't override
> the config), so it hits this die() before parse_options would get a
> change to act on the '-h' option.
> 
> Now, 'git branch' uses the same ref-filter sorting, but the equivalent
> 'git -c branch.sort=creatordate branch -h' command does show the usage
> as expected.  The relevant difference between cmd_branch() and
> cmd_tag() is that the former special-cases the '-h' option as well
> just before it would call git_config().  Doing the same in cmd_tag()
> like in the patch below seems to fix this issue, but I'm not sure that
> this is the right fix.
> 
> 
>   ---  >8  ---
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 065b6bf093..31b8cc4600 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -485,6 +485,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  
>  	setup_ref_filter_porcelain_msg();
>  
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(git_tag_usage, options);
> +
>  	git_config(git_tag_config, sorting_tail);
>  
>  	memset(&opt, 0, sizeof(opt));

I think part of the problem is that git_tag_config() is pretty eager to
parse the ref format. You can similarly see:

  $ git -c tag.sort=foobar tag -h
  fatal: unknown field name: foobar

If git_tag_config() just kept strings, and then we later fed them to
a parser (when we knew they were needed), that would be an appropriate
time to bail.

We do something similar with verify_ref_format(); it is just a string
until we know we are ready to use it. But here, the format that is being
used for sorting gets fed early to parse_ref_sorting(). I guess it is a
bit more complicated, because it is generating a linked list. But maybe
it could generate a list of to-be-parsed entries, with a function like
verify_sort_format() to validate them.

-Peff
