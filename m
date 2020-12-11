Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F2C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B566F23F34
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437401AbgLKJXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:23:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60601 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405591AbgLKJXl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:23:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE59610EA78;
        Fri, 11 Dec 2020 04:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=WC/eZpyKHKpcOZoActrfMv7Hxqg=; b=ClXTCYHvcOvqyltRj+01
        rE59nZD+dY60k91Le9keh2b8dDczKV0sgrx4WiGG9N8ZF6eCRYD/9QFzdEfuqeQt
        +r76OLpsIM/vFUA7v7anUnB0OkSq3CuRaVjnBC15PBMoHgTusQQQ3CF3dGIme3ue
        zP0Zs3DwpyyJ7Am/jSihVx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=cLJuqT59bA/SJcGZJw2arRRLn2ZcKgr8vpfqggAE9qR8r3
        qWKCGGQ4PO5WdBTFhlSXMgsFwSfi359ybnPyooVVT2dhXXVPU+Rl6S7HwlAHeVaQ
        q2Tcpi71ay8u4ojPQ44KaV6kN4pejqj26AymChRgTd1BWA4WcpAVg5PzA+wWs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA00E10EA77;
        Fri, 11 Dec 2020 04:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FC3C10EA76;
        Fri, 11 Dec 2020 04:22:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 3/3] pull: display default warning only when non-ff
Date:   Thu, 10 Dec 2020 23:16:25 -0800
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
        <20201210100538.696787-4-felipe.contreras@gmail.com>
Message-ID: <xmqqzh2kitn9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7185FC2E-3B92-11EB-82CD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's no need to display the annoying warning on every pull... only
> the ones that are not fast-forward.

Yes!  And thanks to the previous two steps, the change to the code
is quite obvious.  I don't have to give any further comment on the
part that changes code---it is well done, period.

> This requires the tests to pick another base, so the merge is not
> fast-forward. And in the cases where --ff-only is specified add
> test_must_fail (since now they are non-fast-forward).

I am not sure what this means.  

Existing tests pull histories that may or may not be descendants of
the HEAD.  If we do not change the pair of commits involved in the
tests, i.e. if we do not apply many s/c0/c2/ replacement I see in
the patch, some of these tests would change their behaviour with
respect to their advice output (but not the outcome).  The ones that
pulled fast-forward would stop showing the warning, and that is a
good effect of this change.  We want to see that in the update to
the tests, no?

The ones that pulled non-fast-forward history would still show the
warning as they used to, and that is also what we want to see after
this change.  Which means we want the tests to keep doing what they
do, while adjusting what we expect out of the tested commands to the
world that is made better with the code change in this patch.  I do
not think we need to add new tests to demonstrate the new behaviour,
as they (i.e. when the test pulls fast-forwardable history, with
various combinations of options and configuration) seem to be pretty
well covered already.

In other words, the changes the paragraph says that the commit made
to the tests sound quite backwards.

The actual changes to some of the tests do look sensible, testing
both sides of the coin.  I've looked at the changes to the tests,
but cannot convince me that we are not making irrelevant changes
to the tests, or losing coverage needlessly because of s/c0/c2/
(i.e. turning tests that used to check fast-forward situations
into tests that check non-ff situations).

> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 6774e9d86f..6b4adab8b1 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -28,7 +28,7 @@ test_expect_success 'setup' '
>  '
>  
>  test_expect_success 'pull.rebase not set' '
> -	git reset --hard c0 &&
> +	git reset --hard c2 &&
>  	git -c color.advice=always pull . c1 2>err &&
>  	test_decode_color <err >decoded &&
>  	test_i18ngrep "<YELLOW>hint: " decoded &&

This is not "keeping what the original test does and adjusting the
expectation, to demonstrate how behaviour changed"; instead, we make
sure that the message we originally gave and we intend to keep
giving is shown in non-ff situation by choosing the current commit
that won't allow a ff merge.  This is OK if we did not lose test
coverage---as long as we test that we no longer give the message in
ff situation somewhere else, And that happens later, I think.

> @@ -36,54 +36,60 @@ test_expect_success 'pull.rebase not set' '
>  
>  '
>  
> -test_expect_success 'pull.rebase not set and pull.ff=true' '
> +test_expect_success 'pull.rebase not set (fast-forward)' '
>  	git reset --hard c0 &&
> +	git pull . c1 2>err &&
> +	test_i18ngrep ! "Pulling without specifying how to reconcile" err
> +'

This is the new test to check the other side of the coin.  It sees
how the original test to merge c1 into c0 would behave with the new
code.  We make sure we do not give the advice because it is
irrelevant in this situation.

So the above two are good, even though the way this patch updates
tests is probably a bit more error prone than necessary.

Since we have checked how the new code behave for fast-forward with
this new test, the remainder of the entire test script can be
modified to test only non-ff situation without losing test coverage?

I am not sure if that is the case.

> +test_expect_success 'pull.rebase not set and pull.ff=true' '
> +	git reset --hard c2 &&
>  	test_config pull.ff true &&
>  	git pull . c1 2>err &&
>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '

We are merely allowing fast-forward merges without unnecessary merge
commits, but we are faced to merge c1 into c2, which is not ff.  The
command goes ahead and merges anyway, but why shouldn't we be seeing
the message?  I am puzzled.

>  test_expect_success 'pull.rebase not set and pull.ff=false' '
> -	git reset --hard c0 &&
> +	git reset --hard c2 &&
>  	test_config pull.ff false &&
>  	git pull . c1 2>err &&
>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>  
>  test_expect_success 'pull.rebase not set and pull.ff=only' '
> -	git reset --hard c0 &&
> +	git reset --hard c2 &&
>  	test_config pull.ff only &&
> -	git pull . c1 2>err &&
> +	test_must_fail git pull . c1 2>err &&
>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '

This used to test that fast-forwarding the HEAD from c0 to c2 would
be done successfully without issuing the message.  Shouldn't that
still be true in the improved "do not complain on fast-forward" code?

We seem to be losing test coverage by checking how pull.ff=only prevents
the command from working in a non-ff merge.

I'd stop my review on the tests here, but I generally think s/c0/c2/
done in this patch is a wrong thing to do.  We are changing the
condition under which the messages is given (we are narrowing it to
avoid giving it when it is irrelevant), without changing the final
outcome (even though we changed the condition to give the message,
we didn't change what the final outcome of the pull command would
be), so I'd strongly prefer testing the same set of scenarios and
update the expectation to an improved reality.

>  test_expect_success 'pull.rebase not set and --rebase given' '
> -	git reset --hard c0 &&
> +	git reset --hard c2 &&
>  	git pull --rebase . c1 2>err &&
>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>  
>  test_expect_success 'pull.rebase not set and --no-rebase given' '
> -	git reset --hard c0 &&
> +	git reset --hard c2 &&
>  	git pull --no-rebase . c1 2>err &&
>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>  
>  test_expect_success 'pull.rebase not set and --ff given' '
> -	git reset --hard c0 &&
> +	git reset --hard c2 &&
>  	git pull --ff . c1 2>err &&
>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>  
>  test_expect_success 'pull.rebase not set and --no-ff given' '
> -	git reset --hard c0 &&
> +	git reset --hard c2 &&
>  	git pull --no-ff . c1 2>err &&
>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>  
>  test_expect_success 'pull.rebase not set and --ff-only given' '
> -	git reset --hard c0 &&
> -	git pull --ff-only . c1 2>err &&
> +	git reset --hard c2 &&
> +	test_must_fail git pull --ff-only . c1 2>err &&
>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
