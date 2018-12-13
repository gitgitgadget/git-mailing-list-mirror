Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D32F20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 08:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeLMII1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 03:08:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:40348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726781AbeLMII1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 03:08:27 -0500
Received: (qmail 24071 invoked by uid 109); 13 Dec 2018 08:08:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Dec 2018 08:08:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22475 invoked by uid 111); 13 Dec 2018 08:07:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Dec 2018 03:07:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2018 03:08:25 -0500
Date:   Thu, 13 Dec 2018 03:08:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] run-command: report exec failure
Message-ID: <20181213080825.GB12132@sigill.intra.peff.net>
References: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1812111327460.43@tvgsbejvaqbjf.bet>
 <xmqqsgz4jkgl.fsf@gitster-ct.c.googlers.com>
 <xmqqbm5qioca.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbm5qioca.fsf_-_@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 03:36:53AM +0900, Junio C Hamano wrote:

> In 321fd823 ("run-command: mark path lookup errors with ENOENT",
> 2018-10-24), we rewrote the logic to execute a command by looking
> in the directories on $PATH; as a side effect, a request to run a
> command that is not found on $PATH is noticed even before a child
> process is forked to execute it.
> 
> We however stopped to report an exec failure in such a case by
> mistake.  Add a logic to report the error unless silent-exec-failure
> is requested, to match the original code.
> 
> Reported-by: John Passaro <john.a.passaro@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks, this looks good to me.

>  test_expect_success 'start_command reports ENOENT (slash)' '
> -	test-tool run-command start-command-ENOENT ./does-not-exist
> +	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
> +	test_i18ngrep "\./does-not-exist" err
>  '

I thought at first you could use "grep" here, since we know that the
name of the file would appear untranslated. But I think the way
GETTEXT_POISON works, it actually eats the whole string, including
placeholders (which IMHO is a failing of GETTEXT_POISON, since no real
translation would do that, but not worth caring too much about).

-Peff
