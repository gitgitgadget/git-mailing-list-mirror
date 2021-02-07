Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A78C433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D5064DE7
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBGSiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:38:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:52926 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhBGSiU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:38:20 -0500
Received: (qmail 15944 invoked by uid 109); 7 Feb 2021 18:37:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Feb 2021 18:37:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17224 invoked by uid 111); 7 Feb 2021 18:37:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 07 Feb 2021 13:37:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 7 Feb 2021 13:37:38 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>,
        git@vger.kernel.org
Subject: Re: default editor
Message-ID: <YCAzcs1e08Qnk2wa@coredump.intra.peff.net>
References: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
 <YCAk8Zx8KvZhaJMx@camp.crustytoothpaste.net>
 <xmqqlfbz927i.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfbz927i.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 07, 2021 at 10:12:33AM -0800, Junio C Hamano wrote:

> > I don't think the return value is the problem.  Both Unix and Windows
> > return 0 on success and nonzero on error, and Git will interpret
> > editor return codes that way.
> 
> When git spawns an editor, it is asking the editor to give the text
> file that has been edited by the end user into a shape that the end
> user is happy with.  A non-zero exit is a way for the end user to
> tell the editor (and hence git) that, even though the user has ended
> the editor session, the resulting contents is not satisfactory and
> not to be used.
> 
> If the 'ed' in question behaves the same as traditional UNIX 'ed' (I
> am guessing so, as even this is on Windows, Cygwin was mentioned),
> you can start making changes and attempt to quit without saving by
> typing 'q<RET>' twice (the first one will be greeted with '?'
> meaning "are you sure you want to quit without saving", and the
> second one lets you quit).  'ed' will signal the calling environment
> that the editor session was aborted by exiting with a non-zero
> status.

There are lots of ways to make ed exit non-zero. Any invalid command
during the session will do. E.g.:

       $ echo bar >foo
       $ ed foo
 ed -> 4
 me -> l
 ed -> bar$
 me -> 2l
 ed -> ?
 me -> q
       $ echo $?
       1

The "2l" was bogus (there is no line 2). It seems likely that an
interactive user might make at least one invalid command while editing.
Some versions (like GNU ed) have a "-l" option to loosen the exit code.

-Peff
