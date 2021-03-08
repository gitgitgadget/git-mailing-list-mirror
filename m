Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31509C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D1465267
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhCHTBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:01:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:55862 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhCHTBd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:01:33 -0500
Received: (qmail 26576 invoked by uid 109); 8 Mar 2021 19:01:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 19:01:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20411 invoked by uid 111); 8 Mar 2021 19:01:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 14:01:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 14:01:32 -0500
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 1/7] symbolic-ref: don't leak shortened refname in
 check_symref()
Message-ID: <YEZ0jLppB9wOg/af@coredump.intra.peff.net>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <ff0f7c167fa5b5da2d843fa03edb70907e6af763.1615228580.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff0f7c167fa5b5da2d843fa03edb70907e6af763.1615228580.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 06:36:14PM +0000, Andrzej Hunt via GitGitGadget wrote:

> From: Andrzej Hunt <ajrhunt@google.com>
> 
> This leak has existed since:
> 9ab55daa55 (git symbolic-ref --delete $symref, 2012-10-21)
> 
> This leak was found when running t0001 with LSAN, see also LSAN output
> below:
> 
> Direct leak of 19 byte(s) in 1 object(s) allocated from:
>     #0 0x486514 in strdup /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
>     #1 0x9ab048 in xstrdup /home/ahunt/oss-fuzz/git/wrapper.c:29:14
>     #2 0x8b452f in refs_shorten_unambiguous_ref /home/ahunt/oss-fuzz/git/refs.c
>     #3 0x8b47e8 in shorten_unambiguous_ref /home/ahunt/oss-fuzz/git/refs.c:1287:9
>     #4 0x679fce in check_symref /home/ahunt/oss-fuzz/git/builtin/symbolic-ref.c:28:14
>     #5 0x679ad8 in cmd_symbolic_ref /home/ahunt/oss-fuzz/git/builtin/symbolic-ref.c:70:9
>     #6 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
>     #7 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
>     #8 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
>     #9 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
>     #10 0x69cc6e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
>     #11 0x7f98388a4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

As a general template for fixing leaks, this information seems pretty
good. You might want to give a brief reason for why it's a leak (like
you do already in the second patch). Here it just would be something
like:

  shorten_unambiguous_ref() returns an allocated string. We have to
  track it separately from the const refname.

Or whatever. It doesn't need to be a novel, but just give an overview of
what's going that makes the diff obvious.

> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index 80237f0df10f..8cf52599693a 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -24,9 +24,15 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int print)
>  			return 1;
>  	}
>  	if (print) {
> -		if (shorten)
> -			refname = shorten_unambiguous_ref(refname, 0);
> -		puts(refname);
> +		if (shorten) {
> +			const char *shortened_refname;
> +
> +			shortened_refname = shorten_unambiguous_ref(refname, 0);
> +			puts(shortened_refname);
> +			free((void *)shortened_refname);
> +		} else {
> +			puts(refname);
> +		}

If a variable is meant to take ownership of memory, our usual convention
is to not declare it as "const". And then you don't need to cast to pass
it to free().

There's also an idiom in Git's codebase when a const pointer may alias
unowned storage, or a buffer that needs to be freed. Something like:

  if (print) {
          char *to_free = NULL;
	  if (shorten)
	          refname = to_free = shorten_unambiguous_ref(refname, 0);
	  puts(refname);
	  free(to_free);
  }

That avoids duplicating the part of the code that handles the variable.
In this case it is only a single line, but IMHO it's still easier to
read, as it makes clear that we call puts() in either case.

-Peff
