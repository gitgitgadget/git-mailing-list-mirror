Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B13CC35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 14:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FFD20838
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 14:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBCOv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:51:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:51346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726224AbgBCOv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 09:51:56 -0500
Received: (qmail 2981 invoked by uid 109); 3 Feb 2020 14:51:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 14:51:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25105 invoked by uid 111); 3 Feb 2020 15:00:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 10:00:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 09:51:55 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mike McGranahan <mike@mcgwiz.com>, git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
Message-ID: <20200203145155.GA272077@coredump.intra.peff.net>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet>
 <20200201110203.GA1864964@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002012205520.46@tvgsbejvaqbjf.bet>
 <20200203085456.GD2164@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002031320180.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2002031320180.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 01:37:48PM +0100, Johannes Schindelin wrote:

> > The short of my answer is that I think the color-moved stuff might be a
> > candidate, but it's sufficiently different that I think it should be
> > decided on as a separate patch.
> 
> I actually wonder whether we should do something completely different. The
> problem with `git diff-files --color`, after all, is that `diff-files` was
> never intended to produce user-facing output, so the `--color` is somewhat
> of a contradiction here. The fact that `diff-files` is a low-level (or
> "plumbing") command means that by nature, it wants to control a lot more
> what the user-provided config can change (typically, scripts calling
> `diff-files` expect a certain format, and it would not do at all to heed
> `diff.noPrefix`, for example.
> 
> In that respect, `git add -p` using `diff-files` is kind of wrong: we
> _want_ to show the result to the user, with no processing at all (execpt
> the user-provided `diffFilter`).

Sort of. The problem is that we need two matching copies of the diff:
one to apply, and one to show the user. They don't need to be
byte-for-byte identical, but they should correlate at the level of
individual lines. And the "one to apply" can take on some user-selected
options, as long as the result can still be applied.

> So why not introduce a new option to `diff-files` and `diff-index` to ask
> it _specifically_ to heed diff UI config settings? I.e. a command-line
> option that makes it call
> 
>         git_config(git_diff_ui_config, NULL);
> 
> instead of
> 
>         git_config(git_diff_basic_config, NULL); /* no "diff" UI options */

Would you pass that option to both of the diff calls, or just the one
generating the human-readable input?

If just the human-readable one, then many options that change the line
count would be problems: diff.context, diff.interhunkcontext,
diff.orderfile, etc.

If both, then some options would be problematic for applying. Just
looking over the list, these jump out at me:

  - color.diff=always would obviously be an issue (though TBH I think
    anybody doing that is inviting a lot of breakages anyway)

  - diff.external would be a problem if it kicked in, though I think it
    would require --ext-diff to actually do anything

  - diff.submodule would generate diffs that can't be applied

-Peff
