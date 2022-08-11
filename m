Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11613C19F2D
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 08:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiHKIij (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbiHKIii (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 04:38:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C979684
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 01:38:37 -0700 (PDT)
Received: (qmail 8577 invoked by uid 109); 11 Aug 2022 08:38:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Aug 2022 08:38:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19873 invoked by uid 111); 11 Aug 2022 08:38:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Aug 2022 04:38:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Aug 2022 04:38:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v4] rev-list: support human-readable output for
 `--disk-usage`
Message-ID: <YvTACxGqVPBa+IDx@coredump.intra.peff.net>
References: <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
 <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com>
 <xmqqlerwm28n.fsf@gitster.g>
 <YvQhHOkjZatIqlFr@coredump.intra.peff.net>
 <xmqqy1vvgxv5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1vvgxv5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 10:20:14PM -0700, Junio C Hamano wrote:

> I still do not see the point of changing it to print to a strbuf and
> puts() the result, though.  It does not make the code shorter, more
> efficient, or more readable.  Once "if (we are producing humanize
> format)" condition is hit, both of its branches can either be (1)
> responsible to print the number to the standard output stream, using
> whatever implementation, or (2) responsible to print the number to a
> strbuf, so that somebody outside the if statement will be
> respohnsible for printing that string to the standard output stream.

I was not the original reviewer who suggested that change, but FWIW, I
think the argument for cases like these is something like this. Between:

  if (some_cond) {
    foo(do_some_prep());
  } else {
    foo(do_some_other_prep());
  }

and:

  if (some_cond) {
    x = do_some_prep();
  } else {
    x = do_some_other_prep();
  }
  foo(x);

the latter makes it more clear that foo() is called on both sides of the
conditional. In this case the "foo" is not exactly the same: on one it
is printing a strbuf, and on the other it is a printf that
direct-formats. But the principle is the same, if you want to make it
clear that both sides will result in printing something.

As you note, it loses the possibility for one side of the conditional to
do its "foo" in a more efficient way, but I don't think that's very
important for this particular call site.

> The patch chooses (2), which is more complex, for no good reason.  A
> good thing about (1) is that the non-human codepath can STAY to be
> the same as before, which is one fewer chance to introduce
> unnecessary bugs.

True.

Again, I don't care much either way. But I am not quite on the "I do not
see the point at all" side.

-Peff
