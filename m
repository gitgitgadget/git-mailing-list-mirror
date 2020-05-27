Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E655C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E506B20DD4
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgE0HXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 03:23:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:57116 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgE0HXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 03:23:20 -0400
Received: (qmail 20410 invoked by uid 109); 27 May 2020 07:23:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 07:23:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1534 invoked by uid 111); 27 May 2020 07:23:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 03:23:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 03:23:18 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 0/4] Selectively show only blamed limes
Message-ID: <20200527072318.GA4006199@coredump.intra.peff.net>
References: <20200525215751.1735-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525215751.1735-1-philipoakley@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 25, 2020 at 10:57:47PM +0100, Philip Oakley wrote:

> While `git blame` is able to select interesting line regions of a
> file, it's not easy to just display blame lines since a recent date,
> especially for large files.

I'm not convinced this is a useful thing to do in general. Lines don't
always stand on their own, and you'd lack context for deciphering them.
So a real example from "git blame -b --since=1.year.ago Makefile", for
example (pardon the long lines):

  3a94cb31d52 (Johannes Schindelin        2019-07-29 13:08:16 -0700 2734)              -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \

but in context it looks like:

              (Junio C Hamano             2019-05-19 16:46:42 +0900 2730) bin-wrappers/%: wrap-for-bin.sh
              (Junio C Hamano             2019-05-19 16:46:42 +0900 2731)         @mkdir -p bin-wrappers
              (Junio C Hamano             2019-05-19 16:46:42 +0900 2732)         $(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
              (Junio C Hamano             2019-05-19 16:46:42 +0900 2733)              -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
  3a94cb31d52 (Johannes Schindelin        2019-07-29 13:08:16 -0700 2734)              -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
              (Junio C Hamano             2019-05-19 16:46:42 +0900 2735)         chmod +x $@

Of course there are cases where it might be useful. But you can already
do:

  git blame --since=1.year.ago Makefile | grep -v ^^

I'm not totally opposed to the feature. I'm just really struggling to
see how it would be generally useful. For special cases where you're
just counting up lines, you'd be more likely to post-process the result
anyway, at which point --line-porcelain is often easier to work with.

> Philip Oakley (4):
>   doc: blame: show the boundary commit '^' caret mark

This doc fix seems worthwhile on its own, though.

>   blame: add option to show only blamed commits `--blame-only`
>   blame: do not show boundary commits, only those blamed

If we do go this direction, these really ought to be a single commit.

>   blame: test the -b option, use blank oid for boundary commits.

This one might be worth doing independently, too.

-Peff
