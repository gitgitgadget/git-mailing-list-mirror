Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3613BC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144EC20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZIfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:35:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:51950 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726289AbgCZIfV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:35:21 -0400
Received: (qmail 1477 invoked by uid 109); 26 Mar 2020 08:35:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:35:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12392 invoked by uid 111); 26 Mar 2020 08:45:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:45:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:35:19 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy
 prereqs
Message-ID: <20200326083519.GD2200716@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 05:41:19AM +0000, Johannes Schindelin via GitGitGadget wrote:

> In preparation for fixing that, let's move all of this code into lazy
> prereqs.

OK. This looks good, even if I cannot help feel that my earlier patch
was perfectly sufficient. ;)

> Side note: it was quite tempting to use a hack that is possible because
> we do not validate what is passed to `test_lazy_prereq` (and it is
> therefore possible to "break out" of the lazy_prereq subshell:
> 
> 	test_lazy_prereq GPG '...) && GNUPGHOME=... && (...'

No, it is not tempting at all to me to do something so gross. :)

> +test_lazy_prereq GPG '
> +	gpg_version=$(gpg --version 2>&1)

One thing I observed while doing my patch is that lazy_prereq blocks do
not get run through the &&-chain linter. So this is OK, but I wonder if
we should be future-proofing with braces. I don't care _too_ much either
way, though.

> +	test $? != 127 || exit 1

I have a slight preference for "return 1" here. The "exit 1" works
because test_lazy_prereq puts us in an implicit subshell. But I think
this sets a bad example for people writing regular tests, where there is
no such subshell (and "return 1" is the only correct way to do it).

>  	case "$gpg_version" in
> -	'gpg (GnuPG) 1.0.6'*)
> +	"gpg (GnuPG) 1.0.6"*)
>  		say "Your version of gpg (1.0.6) is too buggy for testing"
> +		exit 1

Ditto here.

> @@ -25,55 +38,54 @@ then
>  		# To export ownertrust:
>  		#	gpg --homedir /tmp/gpghome --export-ownertrust \
>  		#		> lib-gpg/ownertrust
> -		mkdir ./gpghome &&
> -		chmod 0700 ./gpghome &&
> -		GNUPGHOME="$PWD/gpghome" &&
> -		export GNUPGHOME &&
> +		mkdir "$GNUPGHOME" &&
> +		chmod 0700 "$GNUPGHOME" &&

Compared to mine this keeps the mkdir in the prereq. That seems fine to
me. Other prereqs do depend on the directory existing, but they all
depend on GPG itself, so they'd be fine.

> +test_lazy_prereq GPGSM '
> +	test_have_prereq GPG &&

In mine I put the test_have_prereq outside the lazy prereq. I don't
think it really matters either way (when we later ask if GPGSM is set,
there is no difference between nobody having defined it, and having a
lazy definition that said "no").

-Peff
