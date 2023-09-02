Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAD3C001DB
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 23:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjIBXiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 19:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjIBXiA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 19:38:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D1911A
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 16:37:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 988A230E1D;
        Sat,  2 Sep 2023 19:37:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=RgER3AOHS/+3wrZfTsnYNP5W1Uj9eno5xcPbpC
        JXPJg=; b=aRgda1agDefo0kyH/iF+ni5XDbJyudjIHacaLoEL8J7Pwucx9Svnm7
        6amLRlVxjUkv1HHWk9lq3ECeAaHpLEiP1u9Cf44RpJ6ctpI7Kt+tgosJAsasKOrL
        FbHtV396kGCFtTmtEO28i8YGl8sZgun9AgNdmIWpX0jBrGObxFRkM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90C5730E1C;
        Sat,  2 Sep 2023 19:37:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37A2130E1B;
        Sat,  2 Sep 2023 19:37:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
In-Reply-To: <20230902221641.1399624-3-wesleys@opperschaap.net> (Wesley
        Schwengle's message of "Sat, 2 Sep 2023 18:16:40 -0400")
References: <xmqq1qfiubg5.fsf@gitster.g>
        <20230902221641.1399624-1-wesleys@opperschaap.net>
        <20230902221641.1399624-3-wesleys@opperschaap.net>
Date:   Sat, 02 Sep 2023 16:37:52 -0700
Message-ID: <xmqq4jkckuy7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC6B9196-49E9-11EE-A862-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Schwengle <wesleys@opperschaap.net> writes:

> Subject: Re: [PATCH v2 2/3] builtin/rebase.c: Emit warning when rebasing without a forkpoint

(applies to all three patches) downcase "Emit" after the <area>: prefix.

> This patch adds a warning where it will indicate that `rebase.forkpoint'
> must be set in the git configuration and/or that you can supply a
> `--fork-point' or `--no-fork-point' command line option to your `git
> rebase' invocation.
>
> When commit d1e894c6d7 (Document `rebase.forkpoint` in rebase man page,
> 2021-09-16) was submitted there was a discussion on if the forkpoint
> behaviour of `git rebase' was sane. In my experience this wasn't sane.

I already said that the above is not true, so I will not repeat myself.

> Git rebase doesn't work if you don't have an upstream branch configured

"git rebase foo" works just fine, so this statement needs a lot of
tightening.

> (or something that says `merge = refs/heads/master' in the git config).
> You would than need to use `git rebase <upstream>' to rebase. If you
> configure an upstream it would seem logical to be able to run `git
> rebase' without arguments. However doing so would trigger a different
> kind of behavior.  `git rebase <upstream>' behaves as if
> `--no-fork-point' was supplied and without it behaves as if
> `--fork-point' was supplied. This behavior can result in a loss of
> commits and can surprise users.

No, what is causing the loss in this particular case is allowing to
use the fork-point heuristics.  If you do not want it, you can
either explicitly give --no-fork-point or <upstream> (or both if you
feel that you need to absolutely be clear).  Or you can set the
configuration to "false" to disable this "auto" behaviour.

> The following reproduction path exposes
> this behavior:

I actually do not think having this example in the proposed log
message adds more value than it distracts readers from the real
point of this change.

If you rewind to lose commits from the branch you are (re)building
against, and what was rewound and discarded was part of the work you
are building, whether it is on a local branch or on a remote branch
that contains what you have already pushed, they will be discarded,
it is by design, and it is a known deficiency with the fork-point
heuristics.  How the fork-point heuristics breaks down is rather
well known and it is pretty much orthogonal to the point of this
patch, which is to make it harder to trigger by folks who are not
familiar with "git rebase" and yet try to be lazy by not specifying
the <upstream> from the command line.

By the way, while I do agree with the need to make users _aware_ of
the "auto" behaviour [*1*], I am not yet convinced that there is a
need to change the default in the future.

	Side note: It allows those who originally advocated the
	fork-point heuristics to be extra lazy and allow fork-point
	heuristics to be used when they rebuild on top of what they
	usually rebuild on (and the "usually" part is signalled by
	using "git rebase" without saying what to build on from the
	command line).  The default allows them not to worry about
	the heuristics to kick in when they explicitly say on which
	exact commit they want to rebuild on.

And when we do not know if the default will change, the new warning
message will lose value.  Many of those who see the message are
already familiar with when the forkpoint heuristics will kick in,
and those who weren't familiar with will not know what the default
change is about, without consulting the documentation.

It might be better to extend the documentation instead, which will
not distract those who are using the tool just fine already.

> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> index 4bfc779bb8..908867ae0f 100755
> --- a/t/t3431-rebase-fork-point.sh
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -113,4 +113,66 @@ test_expect_success 'rebase.forkPoint set to true and --root given' '
>  	git rebase --root
>  '
>  
> +# The use of the diff -qw is because there is some kind of whitespace character
> +# magic going on which probably has to do with the tabs. It only occurs when we
> +# check STDERR
> +test_expect_success 'rebase without rebase.forkpoint' '
> +	git init rebase-forkpoint &&
> +	cd rebase-forkpoint &&
> +	git status >/tmp/foo &&
> +	echo "commit a" > file.txt &&

Style???

> +	git add file.txt &&
> +	git commit -m "First commit" file.txt &&
> +	echo "commit b" >> file.txt &&
> +	git commit -m "Second commit" file.txt &&
> +	git switch -c foo &&
> +	echo "commit c" >> file.txt &&
> +	git commit -m "Third commit" file.txt &&
> +	git branch --set-upstream-to=main &&
> +	git switch main &&
> +	git merge foo &&
> +	git reset --hard HEAD^ &&
> +	git switch foo &&
> +	commit=$(git log -n1 --format="%h") &&
> +	git rebase >out 2>err &&
> +	test_must_be_empty out &&
> +	cat <<-\OEF > expect &&

Why does this have to be orgiinal in such a strange way?  When
everybody else uses string "EOF" as the end-of-here-doc-marker, and
if there is no downside to use the same string here, we should just
use the same "EOF" to avoid distracting readers.

> +	warning: When "git rebase" is run without specifying <upstream> on the
> +	command line, the current default is to use the fork-point
> +	heuristics. This is expected to change in a future version
> +	of Git, and you will have to explicitly give "--fork-point" from
> +	the command line if you keep using the fork-point mode.  You can
> +	run "git config rebase.forkpoint false" to adopt the new default
> +	in advance and that will also squelch the message.
> +
> +	You can replace "git config" with "git config --global" to set a default
> +	preference for all repositories. You can also pass --no-fork-point, --fork-point
> +	on the command line to override the configured default per invocation.
> +
> +	Successfully rebased and updated refs/heads/foo.
> +	OEF
> +	diff -qw expect err &&

Why not "test_cmp expect actual" like everybody else?

> +...
> +	echo "Current branch foo is up to date." > expect &&
> +	test_cmp out expect
> +'
> +
>  test_done
