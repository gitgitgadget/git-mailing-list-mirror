Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C39C20248
	for <e@80x24.org>; Fri, 29 Mar 2019 13:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfC2NqG (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 09:46:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:40388 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729644AbfC2NqG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 09:46:06 -0400
Received: (qmail 22560 invoked by uid 109); 29 Mar 2019 13:46:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Mar 2019 13:46:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19470 invoked by uid 111); 29 Mar 2019 13:46:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 29 Mar 2019 09:46:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2019 09:46:04 -0400
Date:   Fri, 29 Mar 2019 09:46:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] sha1-file: test the error behavior of alt_odb_usable()
Message-ID: <20190329134603.GB21802@sigill.intra.peff.net>
References: <20181204132716.19208-2-avarab@gmail.com>
 <20190328200456.29240-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328200456.29240-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 28, 2019 at 09:04:56PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Add a test for the error() case in alt_odb_usable() where an alternate
> directory doesn't exist. This behavior has been the same since
> 26125f6b9b ("detect broken alternates.", 2006-02-22), but if that
> error() was turned into die() the entire test suite would still pass.
>
> Perhaps we should die() in that case, but let's start by adding a test
> here to assert the long-standing existing behavior.

I think if anything we might go the other direction, and downgrade the
error() to a warning() or even omit it entirely. It's not an error to
have a missing or transient alternate. Unless of course it has objects
you need, but then those generate their own errors.

I actually think in an ideal world we wouldn't say anything at all about
alternates which aren't present, don't appear to contain objects, etc,
on their own. And then when we hit an error because an object is
missing, only _then_ diagnose and say "hey, you have this alternate but
it doesn't have anything in it. Maybe that's an error?". Doing that
diagnosis in the error path helps in two ways:

  - we don't have to worry about it being slow

  - we can be a bit more loose about things that _might_ be an issue.
    E.g., it's not an error to point to an alternate directory that has
    no files in it. It might be a misconfiguration, or it might just not
    have any objects right now. It's hard to justify complaining about
    it in _every_ git command that loads alternates. But after hitting a
    fatal error due to a missing object, it seems like a convenient
    thing to mention to the user.

I suspect that implementing it that way might be a pain, though. Even if
we had a convenient diagnose_missing_object() one-liner, there are
probably dozens of separate places it would need to be called from.

> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> index 895f46bb91..d2964c57b7 100755
> --- a/t/t5613-info-alternate.sh
> +++ b/t/t5613-info-alternate.sh
> @@ -136,4 +136,11 @@ test_expect_success CASE_INSENSITIVE_FS 'dup finding can be case-insensitive' '
>  	test_cmp expect actual.alternates
>  '
>  
> +test_expect_success 'print "error" on non-existing alternate' '
> +	git init --bare I &&
> +	echo DOES_NOT_EXIST >I/objects/info/alternates &&
> +	git -C I fsck 2>stderr &&
> +	test_i18ngrep "does not exist; check" stderr
> +'

All that said, I don't really have an objection against this patch,
since it's just testing the current behavior. Anybody who wants to
change it would find it pretty easy to tweak this test, too.

-Peff
