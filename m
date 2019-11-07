Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F192C1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfKGGCf (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:02:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:41662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725763AbfKGGCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:02:34 -0500
Received: (qmail 28914 invoked by uid 109); 7 Nov 2019 06:02:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 06:02:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32140 invoked by uid 111); 7 Nov 2019 06:05:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 01:05:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 01:02:33 -0500
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/8] t3900: demonstrate git-rebase problem with multi
 encoding
Message-ID: <20191107060233.GB6431@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <ca869cef57bcf620a7b5d0519d362dcd9a27eae6.1573094789.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca869cef57bcf620a7b5d0519d362dcd9a27eae6.1573094789.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 09:56:14AM +0700, Doan Tran Cong Danh wrote:

> We're using fixup!/squash! <subject> to mark if current commit will be
> used to be fixed up or squashed to a previous commit.
> 
> However, if we're changing i18n.commitencoding after making the
> original commit but before making the fixing up, we couldn't find the
> original commit to do the fixup/squash.
> 
> Add a test to demonstrate that problem.

OK, this makes sense to do.

I'm not sure if we need to test so many combinations, as the problem is
apparent even on some vanilla ones. But I guess this is just following
the lead of the rest of the script.

> +test_commit_autosquash_multi_encoding () {
> +	flag=$1
> +	old=$2
> +	new=$3
> +	msg=$4
> +	test_expect_failure "commit --$flag into $old from $new" '
> +		git checkout -b '$flag-$old-$new' C0 &&

These single quotes are funny; they close the test-snippet string, so
these variables are outside of any quoting (and thus subject to
whitespace splitting).

The test snippets are run as an eval, so they have access to the
variables you set above. I.e., just:

  git checkout -b $flag-$old-$new C0

would work. Or:

  git checkout -b "$flag-$old-$new" C0

if you wanted to be more careful inside the snippet.

> +		git config i18n.commitencoding '$old' &&
> +		echo '$old' >>F &&
> +		git commit -a -F "$TEST_DIRECTORY/t3900/'$msg'" &&

Likewise for all these other bits of the script.

-Peff
