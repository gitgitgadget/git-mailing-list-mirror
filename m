Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AFFC4742C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63110208B3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgKLBcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:55450 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgKKXHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:07:00 -0500
Received: (qmail 15401 invoked by uid 109); 11 Nov 2020 23:07:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Nov 2020 23:07:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23278 invoked by uid 111); 11 Nov 2020 23:07:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Nov 2020 18:07:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Nov 2020 18:06:59 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 1/4] t1400: avoid touching refs on filesystem
Message-ID: <20201111230659.GA632312@coredump.intra.peff.net>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605077740.git.ps@pks.im>
 <e66b1bcc62139f62866dc9f25856eaebfe107056.1605077740.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e66b1bcc62139f62866dc9f25856eaebfe107056.1605077740.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 07:58:38AM +0100, Patrick Steinhardt wrote:

> The testcase t1400 exercises the git-update-ref(1) utility. To do so,
> many tests directly read and write references via the filesystem,
> assuming that we always use loose and/or packed references. While this
> is true now, it'll change with the introduction of the reftable backend.
> 
> Convert those tests to use git-update-ref(1) and git-show-ref(1) where
> possible. As some tests exercise behaviour with broken references and
> neither of those tools actually allows writing or reading broken
> references, this commit doesn't adjust all tests.

Do you want to mention the switch away from using HEAD in some tests
here?

> +# Some of the tests delete HEAD, which causes us to not treat the current
> +# working directory as a Git repository anymore. To avoid using any potential
> +# parent repository to be discovered, we need to set up the ceiling directories.
> +GIT_CEILING_DIRECTORIES="$PWD/.."
> +export GIT_CEILING_DIRECTORIES

Do we still need this, now that we're not deleting HEAD? I think we do
still delete a branch via HEAD, but that should leave an unborn branch,
which is still a valid repo.

>  test_expect_success "deleting current branch adds message to HEAD's log" '
> -	test_when_finished "rm -f .git/$m" &&
> +	test_when_finished "git update-ref -d $m" &&
>  	git update-ref $m $A &&
>  	git symbolic-ref HEAD $m &&
>  	git update-ref -m delete-$m -d $m &&
> -	test_path_is_missing .git/$m &&
> +	test_must_fail git show-ref --verify -q $m &&
>  	grep "delete-$m$" .git/logs/HEAD
>  '

E.g., these ones should leave a valid repo (and must remain HEAD,
because it's special for reflogging).

> -cp -f .git/HEAD .git/HEAD.orig
>  test_expect_success 'delete symref without dereference' '
> -	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
> -	git update-ref --no-deref -d HEAD &&
> -	test_path_is_missing .git/HEAD
> +	git symbolic-ref SYMREF $m &&
> +	git update-ref --no-deref -d SYMREF &&
> +	test_must_fail git show-ref --verify -q SYMREF
>  '

And now this one is safe. Good.

I wonder, though...is it still testing the same thing as the original?
This is not related to the use of SYMREF vs HEAD, but wouldn't show-ref
similarly fail if we had deleted $m, but left SYMREF in place (i.e., if
--no-deref didn't actually do anything)?

Perhaps this would be better:

  # confirm that the pointed-to ref is still there
  git show-ref --verify $m &&
  # but our symref is not
  test_must_fail git show-ref --verify SYMREF &&
  test_must_fail git symbolic-ref SYMREF

>  test_expect_success 'delete symref without dereference when the referred ref is packed' '
> -	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
>  	echo foo >foo.c &&
>  	git add foo.c &&
>  	git commit -m foo &&
> +	git symbolic-ref SYMREF $m &&
>  	git pack-refs --all &&
> -	git update-ref --no-deref -d HEAD &&
> -	test_path_is_missing .git/HEAD
> +	git update-ref --no-deref -d SYMREF &&
> +	test_must_fail git show-ref --verify -q SYMREF
>  '

Likewise here.

-Peff
