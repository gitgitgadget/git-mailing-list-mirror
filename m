Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC7CDB474
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 18:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjJKSSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjJKSSB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 14:18:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE86DD
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:17:34 -0700 (PDT)
Received: (qmail 18238 invoked by uid 109); 11 Oct 2023 18:17:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 18:17:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7568 invoked by uid 111); 11 Oct 2023 18:17:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 14:17:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 14:17:33 -0400
From:   Jeff King <peff@peff.net>
To:     Adam Johnson <me@adamj.eu>
Cc:     git@vger.kernel.org
Subject: Re: Bug: 'git stash --staged' crashes with binary files
Message-ID: <20231011181733.GA514244@coredump.intra.peff.net>
References: <CAMyDDM3DFyru6zph4qqf_QoaOeezvYkT7SmwinCfJNnFsnuRjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMyDDM3DFyru6zph4qqf_QoaOeezvYkT7SmwinCfJNnFsnuRjQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2023 at 10:26:13PM +0100, Adam Johnson wrote:

> Stage a binary file and run 'git stash --staged'. The stash is created but
> the command fails to remove changes from the index:
> 
> $ echo -n "\0" >file
> 
> $ git add file
> 
> $ git stash --staged
> Saved working directory and index state WIP on main: e7911b6 Whatever
> error: cannot apply binary patch to 'file' without full index line
> error: file: patch does not apply
> Cannot remove worktree changes
> 
> $ git status
> ...
> Changes to be committed:
>         new file:   file
> 
> The "remove from the index" step seems not to be binary-compatible.

This seems like a bug. It looks like stash does pass "--binary" in some
cases, but not all. So it's probably a matter of finding the right
invocation and adding it.

> The below patch adds a reproducing test.

I think finding the bug and writing the test is probably 75% of the
work. :)

> diff --git t/t3903-stash.sh t/t3903-stash.sh
> index 376cc8f4ab..5e3ea64f38 100755
> --- t/t3903-stash.sh
> +++ t/t3903-stash.sh
> @@ -392,6 +392,13 @@ setup_stash()
>      git stash pop &&
>      test bar,bar4 = $(cat file),$(cat file2)
>  '
> +test_expect_success 'stash --staged with binary file' '
> +    echo -n "\0" >file &&

Unfortunately "echo -n" isn't portable. But you can use:

  printf "\0" >file

instead.

> +    git add file &&
> +    git stash --staged &&
> +    git stash pop &&
> +    test "\0" = $(cat file)
> +'

I doubt this "test" will work, as the shell won't interpolate that into
a NUL (and anyway, I think having NULs in shell variables isn't
portable). You could perhaps do:

  printf "\0" >expect &&
  test_cmp expect file

-Peff
