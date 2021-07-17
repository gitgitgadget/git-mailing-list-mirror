Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8F2C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CA96115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhGQRuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 13:50:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:52854 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhGQRuS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 13:50:18 -0400
Received: (qmail 24420 invoked by uid 109); 17 Jul 2021 17:47:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jul 2021 17:47:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19748 invoked by uid 111); 17 Jul 2021 17:47:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Jul 2021 13:47:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Jul 2021 13:47:20 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, Luca Weiss <luca@z3ntu.xyz>,
        Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
Message-ID: <YPMXqLESKApq2uPI@coredump.intra.peff.net>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
 <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
 <8678772b-dd5d-9188-8b63-98d05cedb323@gmail.com>
 <AB048897-F70A-4388-B2A6-56BFEA40B303@z3ntu.xyz>
 <16229b1d-e4a6-7a8d-8ea0-ae7c3f13075d@gmail.com>
 <YPHe/W7+Oh63NpB0@coredump.intra.peff.net>
 <xmqq8s26q9ot.fsf@gitster.g>
 <YPH1qKMPOqhCzp4Y@coredump.intra.peff.net>
 <693954a7-af64-67c5-41b9-b648a9fe3ef2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <693954a7-af64-67c5-41b9-b648a9fe3ef2@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 17, 2021 at 02:40:55PM +0100, Phillip Wood wrote:

> > which would cover that case. But Phillip mentioned that our own
> > fmt_merge_msg() does not include a newline.
> 
> I mentioned that we remove the newline that is added by fmt_merge_msg(), not
> that there is no newline added by fmt_merge_msg() - maybe I wasn't clear
> enough. In builtin/merge.c:prepare_merge_message() we do
> 
> 	fmt_merge_msg(merge_names, merge_msg, &opts);
> 	if (merge_msg->len)
> 		strbuf_setlen(merge_msg, merge_msg->len - 1);

Of maybe I didn't read carefully enough. :)

Either way, thanks for clarifying. Doing something like:

  cat >.git/hooks/commit-msg <<\EOF
  #!/bin/sh
  xxd "$1"
  EOF
  chmod +x .git/hooks/commit-msg

  git merge --no-edit ...

shows off the problem; the hook sees that intermediate state.

Likewise if we do:

  git merge -m "foo" ...

which similarly suppresses the editor. There are actually two
interesting cases here:

  - if merge.log is not set, then we'd see "foo" with no newline

  - if it is set, we'll get a newline after "foo", but with no newline
    after the log data

Likewise for:

  printf foo >no-newline
  git merge -F no-newline ...

So I think we'd probably want to see a 3-patch series:

  1. Make interpret-trailers handle input missing the final newline.
     This isn't strictly necessary after patches 2 and 3, but it makes
     sense to be more robust with unexpected input.

  2. Drop the newline-stripping from prepare_merge_message(). The
     examples above show some ways we could cover this in the tests.
     This will help --no-edit case, but also using merge.log with "-m"
     or "-F".

  3. Teach prepare_to_commit() to add the extra newline before letting
     hooks see the message. This should probably be done only when
     cleanup_mode != COMMIT_MSG_CLEANUP_NONE.

Luca, do you want to try revising your series in that direction?

-Peff
