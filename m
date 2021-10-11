Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99CEC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4786058D
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhJKQJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:09:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:36996 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhJKQJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 12:09:37 -0400
Received: (qmail 29085 invoked by uid 109); 11 Oct 2021 16:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Oct 2021 16:07:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19429 invoked by uid 111); 11 Oct 2021 16:07:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 12:07:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 12:07:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] archive: add test testing MIME for created archive
 through compression filter
Message-ID: <YWRhR9IXZfU93Uok@coredump.intra.peff.net>
References: <20211011112712.475306-1-bagasdotme@gmail.com>
 <xmqqlf2zd0d4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlf2zd0d4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 08:53:11AM -0700, Junio C Hamano wrote:

> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > +test_expect_success GZIP,BZIP2,XZ 'git archive with gzip, bzip2, and xz filters creates compressed tar archive with proper MIME type' '
> > +	git config tar.tar.bz2.command "bzip2 -c" &&
> > +	git config tar.tar.xz.command "xz -c" &&
> > +	git archive --output HEAD.tar.gz --prefix=src/ HEAD &&
> 
> I think a lot more portable and robust way to test the feature is to
> configure git config tar.tar.test.command (or come up with a name for
> a suffix to be used in the test), point it at a script created in this
> test script and run git archive with output filename that would trigger
> the command.  Then, arrange the test to notice if the "test" script was
> called with expected command line arguments and standard input.
> 
> That way, you do not need to rely on prereqs and you do not have to
> resort to un-portable use of the "file" command.  After all, you are
> *not* testing if "bzip2 -c" the user happens to have on their $PATH
> produces output their "find" recognises as bzip2 compressed.

That would work. Or perhaps using something portable like "tr" to
do a nonsense conversion, and verifying that we can get convert back to
the original. Like say, the tests added to t5000 by 767cf4579f (archive:
implement configurable tar filters, 2011-06-21).

I don't think the newly proposed test is adding anything beyond that
(except checking the system "bzip2" command, but as you say, that is not
useful to us, nor portable).

-Peff
