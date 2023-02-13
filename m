Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0E9C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 20:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjBMUTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjBMUTb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 15:19:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E9C7
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 12:19:30 -0800 (PST)
Received: (qmail 21819 invoked by uid 109); 13 Feb 2023 20:19:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Feb 2023 20:19:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25261 invoked by uid 111); 13 Feb 2023 20:18:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Feb 2023 15:18:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Feb 2023 15:18:28 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
Message-ID: <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 02:38:08PM +0800, 孟子易 wrote:

> System: Mac Os (Ventura 13.2)
> Language: Chinese simplified
> Preconditions:
> # git checkout -b 测试-加-增加-加-增加
> # git symbolic-ref --short HEAD
> Wrong Echo (Current Echo):
> 测试-�
> Correct Echo:
> // I Don't know, may be "测试-加" ?

Hmm, I can't reproduce here on Linux:

  $ git init
  $ git commit --allow-empty -m foo
  $ git checkout -b 测试-加-增加-加-增加
  $ git symbolic-ref --short HEAD
  测试-加-增加-加-增加

I wonder if it is related to using macOS. The refs are stored as
individual files in the filesystem, and HFS+ will do some unicode
normalization. So I get:

  $ ls .git/refs/heads/ | xxd
  00000000: 6d61 696e 0ae6 b58b e8af 952d e58a a02d  main.......-...-
  00000010: e5a2 9ee5 8aa0 2de5 8aa0 2de5 a29e e58a  ......-...-.....
  00000020: a00a          

Are your on-disk bytes different?

My instinct was that this might be related to the shortening code
treating the names as bytes, rather than characters. But looking at
shorten_unambiguous_ref(), it is really operating at the level of path
components, and should never split a partial string.

Another possibility: the shortening is done by applying our usual
ref-resolving rules one by one via scanf(). There's an assumption in the
code that the resulting string can never be longer than the input:

	/* buffer for scanf result, at most refname must fit */
	short_name = xstrdup(refname);

	...
        for (i = nr_rules - 1; i > 0 ; --i) {
		...
                if (1 != sscanf(refname, scanf_fmts[i], short_name))
                        continue;

Is it possible that this assumption is violated based on some particular
combination of unicode normalization and locale? That seems unlikely to
me, but it wouldn't be the first time I've been surprised by subtle
unicode implications.

Is it possible for you to run Git in a debugger and check the
intermediate steps happening in refs_shorten_unambiguous_ref()?

-Peff
