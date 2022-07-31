Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5702EC19F28
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 00:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiGaASv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 20:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGaASu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 20:18:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A9A12774
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 17:18:49 -0700 (PDT)
Received: (qmail 28078 invoked by uid 109); 31 Jul 2022 00:18:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 31 Jul 2022 00:18:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7858 invoked by uid 111); 31 Jul 2022 00:18:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jul 2022 20:18:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jul 2022 20:18:48 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
Message-ID: <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 30, 2022 at 01:21:50PM -0700, Linus Torvalds wrote:

> Again - this is such a low-level plumbing thing that maybe nobody
> cares, but it just struck me as a bad idea to have these kinds of
> maintenance commands that can be used to just mess up your repository.
> And if you have a bare repo, this really does look like the command
> that *should* be used to change HEAD, since it's not about "git
> checkout"

I think it is probably worth addressing. I'm sure it has bitten me
before[0], and the HEAD logic from afe5d3d516 (symbolic ref: refuse
non-ref targets in HEAD, 2009-01-29) was a cowardly attempt to fix the
most egregious cases without breaking anything.

> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index e547a08d6c..5354cfb4f1 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -71,6 +71,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  		if (!strcmp(argv[0], "HEAD") &&
>  		    !starts_with(argv[1], "refs/"))
>  			die("Refusing to point HEAD outside of refs/");
> +		if (check_refname_format(argv[1], 0) < 0)
> +			die("Refusing to set '%s' to invalid ref '%s'", argv[0], argv[1]);

This forbids syntactically-invalid refnames, which is good.

Since you don't pass REFNAME_ALLOW_ONELEVEL, it also forbids nonsense
names like "nowhere". But that also breaks some probably-stupid cases
that are currently possible, like:

  git symbolic-ref refs/heads/foo FETCH_HEAD

I'm not really sure why anybody would want to do that, but it does work
currently. I'm tempted to say that the symref-reading code should
actually complain about following something outside of "refs/", but that
carries an even higher possibility of breaking somebody. But it seems
like we should be consistent between what we allow to be read, and what
we allow to be written.

At any rate, with the code as you have it above, I think the "make sure
HEAD starts with refs/" code is now redundant.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 9723c2827c..b194c1b09b 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -723,9 +723,9 @@ test_expect_success 'deleting a symref' '
>  '
>  
>  test_expect_success 'deleting a dangling symref' '
> -	git symbolic-ref refs/heads/dangling-symref nowhere &&
> +	git symbolic-ref refs/heads/dangling-symref refs/heads/nowhere &&
>  	test_path_is_file .git/refs/heads/dangling-symref &&
> -	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
> +	echo "Deleted branch dangling-symref (was refs/heads/nowhere)." >expect &&

This is a sensible change. With ALLOW_ONELEVEL, it wouldn't be
necessary, but I think it is representing a more plausible real-world
scenario.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 6e66352558..427b06442d 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -2114,7 +2114,7 @@ test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
>  
>  test_expect_success 'log diagnoses bogus HEAD symref' '
>  	git init empty &&
> -	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
> +	echo "ref: refs/heads/invalid.lock" > empty/.git/HEAD &&
>  	test_must_fail git -C empty log 2>stderr &&
>  	test_i18ngrep broken stderr &&
>  	test_must_fail git -C empty log --default totally-bogus 2>stderr &&

After this change, I think this would need to be marked with a REFFILES
prereq similar to the test right before it.

-Peff

[0] Curiously there was a very similar patch to yours posted a while
    ago:

      https://lore.kernel.org/git/4FDE3D7D.4090502@elegosoft.com/

    There was some discussion and a followup:

      https://lore.kernel.org/git/1342440781-18816-1-git-send-email-mschub@elegosoft.com/

    but nothing seems to have been applied. I don't see any arguments
    against it there; I think the author simply didn't push it forward
    enough.

    There's also some bits in the sub-thread about limiting HEAD to
    "refs/heads/", which we couldn't quite do at the time. That might be
    worth revisiting, but definitely shouldn't hold up your patch.
