Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFCC433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 21:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C6164E2E
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 21:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhB1VOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 16:14:49 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33158 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhB1VOs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 16:14:48 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B59531F9FD;
        Sun, 28 Feb 2021 21:14:07 +0000 (UTC)
Date:   Sun, 28 Feb 2021 21:14:07 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 09/10] svn tests: refactor away a "set -e" in test body
Message-ID: <20210228211407.GA3214@dcvr>
References: <20200223125102.6697-1-benno@bmevers.de>
 <20210228195414.21372-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210228195414.21372-10-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Refactor a test added in 83c9433e67 (git-svn: support for git-svn
> propset, 2014-12-07) to avoid using "set -e" in the test body. This
> would have broken in combination with a subsequent change to make
> "test_expect_success" return 1 to catch such cases.
> 
> While I'm at it rewrite the test to conform to a modern style in our
> tests, using the "test_when_finished" function for the "rm -rf", and
> avoiding repeated "mkdir" in favor of "mkdir -p".

Thank you for working on these (and sorry for making a mess all
those years ago!).

I had it in my mind that "mkdir -p" wasn't portable, but systems
without it probably haven't been relevant since pre-git times.

> --- a/t/t9148-git-svn-propset.sh
> +++ b/t/t9148-git-svn-propset.sh
> @@ -7,19 +7,22 @@ test_description='git svn propset tests'
>  
>  . ./lib-git-svn.sh
>  
> -foo_subdir2="subdir/subdir2/foo_subdir2"
> +test_expect_success 'setup propset via import' '
> +	test_when_finished "rm -rf import" &&
>  
> -set -e
> -mkdir import &&
> -(set -e ; cd import
> -	mkdir subdir
> -	mkdir subdir/subdir2
> -	touch foo 		# for 'add props top level'
> -	touch subdir/foo_subdir # for 'add props relative'
> -	touch "$foo_subdir2"	# for 'add props subdir'
> -	svn_cmd import -m 'import for git svn' . "$svnrepo" >/dev/null
> -)
> -rm -rf import
> +	foo_subdir2="subdir/subdir2/foo_subdir2" &&
> +	mkdir -p import/subdir/subdir2 &&
> +	(
> +		cd import &&
> +		# for "add props top level"
> +		touch foo &&
> +		# for "add props relative"
> +		touch subdir/foo_subdir &&
> +		# for "add props subdir"
> +		touch "$foo_subdir2" &&
> +		svn_cmd import -m "import for git svn" . "$svnrepo"

I've noticed '>' could be used instead of touch, but that's
probably better as another patch :>
