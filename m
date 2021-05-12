Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D480C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5574E60FD8
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbhELUgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:36:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46724 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236674AbhELSHN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 14:07:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B85601F934;
        Wed, 12 May 2021 18:05:17 +0000 (UTC)
Date:   Wed, 12 May 2021 18:05:17 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/9] perl: lazily load some common Git.pm setup code
Message-ID: <20210512180517.GA11354@dcvr>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <patch-8.9-2312346f71-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-8.9-2312346f71-20210512T132955Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> @@ -408,10 +404,12 @@ sub command_bidi_pipe {
>  	my $cwd_save = undef;
>  	if ($self) {
>  		shift;
> -		$cwd_save = cwd();
> +		require Cwd;
> +		$cwd_save = Cwd::cwd();
>  		_setup_git_cmd_env($self);

(This also applies to 7/9)

Cwd::cwd() execs /bin/pwd (at least on Perl 5.28.1 in Debian 10x).
There should be a benefit from using Cwd::getcwd() here, instead.

	strace -f -e execve perl -MCwd -E 'Cwd::cwd()

...confirms the execve is happening.

getcwd() takes 25ms vs 27ms of cwd() for me using the
"schedutil" CPU governor under Linux:

	time perl -MCwd -E 'Cwd::getcwd()'
	time perl -MCwd -E 'Cwd::cwd()'
