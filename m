Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA3C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DEDB20780
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgKJVfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:35:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:53540 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJVfp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:35:45 -0500
Received: (qmail 9472 invoked by uid 109); 10 Nov 2020 21:35:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 21:35:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6047 invoked by uid 111); 10 Nov 2020 21:35:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 16:35:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 16:35:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Demi M. Obenour" <athena@invisiblethingslab.com>,
        Git <git@vger.kernel.org>
Subject: Re: check_refname_format allows refs with components that begin with
 -, even though `git tag` does not
Message-ID: <20201110213544.GA3263091@coredump.intra.peff.net>
References: <c926193b-a328-7562-6d4b-1ab2765c8cca@invisiblethingslab.com>
 <xmqqd00l6kj0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd00l6kj0.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 12:09:55PM -0800, Junio C Hamano wrote:

> > The best idea I had for a fix is to print names beginning with `-`
> > using the fully-qualified form, such as "refs/tags/-a".  Also, `--`
> > is used as a delimiter in many commands, and can’t be escaped,
> > so disallowing it might be a good idea.
> 
> I do not think there is anything to fix.
> 
> Command line parsers of some commands may have to learn how to
> disambiguate such a strangely named tags and branches, though.  Some
> commands do not know --end-of-options convention, for example.

I think there is at least one thing to fix: rev-parse never learned
about --end-of-options. It also seems to have some weirdness around
"--".

Here's a series which fixes it.

  [1/3]: rev-parse: don't accept options after dashdash
  [2/3]: rev-parse: put all options under the "-" check
  [3/3]: rev-parse: handle --end-of-options

 Documentation/git-rev-parse.txt |   8 ++-
 builtin/rev-parse.c             | 100 ++++++++++++++++++--------------
 t/t1503-rev-parse-verify.sh     |  13 +++++
 t/t1506-rev-parse-diagnosis.sh  |  25 ++++++++
 4 files changed, 99 insertions(+), 47 deletions(-)

-Peff
