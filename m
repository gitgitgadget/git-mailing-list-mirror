Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFC1C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 10:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059906109F
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 10:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhDOKKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 06:10:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:53248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhDOKKF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 06:10:05 -0400
Received: (qmail 10414 invoked by uid 109); 15 Apr 2021 10:09:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 10:09:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14902 invoked by uid 111); 15 Apr 2021 10:09:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 06:09:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 06:09:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/3] usage.c: don't copy/paste the same comment three
 times
Message-ID: <YHgQ5kjqQKb1zZpu@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
 <patch-1.3-2e4665b625b-20210413T090603Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.3-2e4665b625b-20210413T090603Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 11:08:19AM +0200, Ævar Arnfjörð Bjarmason wrote:

> In ee4512ed481 (trace2: create new combined trace facility,
> 2019-02-22) we started with two copies of this comment,
> 0ee10fd1296 (usage: add trace2 entry upon warning(), 2020-11-23) added
> a third. Let's instead add an earlier comment that applies to all
> these mostly-the-same functions.

I'm sometimes wary of this aggregating comments like this, because
somebody who is just reading the third function may not think to look
further up to find the comment.

But this comment in particular does not seem dangerous if somebody
misses it (unlike comments that are warning people about bad things
happening).

> + */
>  static NORETURN void die_builtin(const char *err, va_list params)
>  {
> -	/*
> -	 * We call this trace2 function first and expect it to va_copy 'params'
> -	 * before using it (because an 'ap' can only be walked once).
> -	 */
>  	trace2_cmd_error_va(err, params);
>  
>  	vreportf("fatal: ", err, params);

TBH, I am not sure it adds all that much value in the first place. It is
only telling the reader that the code is not broken. But I kind of
wonder if it should simply be doing the defensive thing anyway:

  va_list cp;
  va_copy(cp, params);
  trace2_cmd_error_va(err, params);
  va_end(cp);

We are relying on a subtle contract with the trace2 code, and there is
no compile-time check that it will be upheld (and indeed, on many
platforms we might not even notice if it isn't, depending on how va_list
is implemented). Looking at the trace2 code, we do not even enforce this
centrally. It is up to each target to remember to va_copy()!

Anyway, that is somewhat outside the scope of your series (though I
would not be sad to see this comment go away entirely in favor of the
more defensive code above).

-Peff
