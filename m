Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7BCC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 03:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjDRDlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 23:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRDkp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 23:40:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9A23581
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 20:40:44 -0700 (PDT)
Received: (qmail 32100 invoked by uid 109); 18 Apr 2023 03:40:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 03:40:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30250 invoked by uid 111); 18 Apr 2023 03:40:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Apr 2023 23:40:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Apr 2023 23:40:43 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
Message-ID: <20230418034043.GB60552@coredump.intra.peff.net>
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
 <20230416054735.3386065-1-newren@gmail.com>
 <20230417073827.GA39931@coredump.intra.peff.net>
 <CABPp-BHW8Xi+=+GG4Z+-cf1a365eO6AzBifRjB+3600G5yyY9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHW8Xi+=+GG4Z+-cf1a365eO6AzBifRjB+3600G5yyY9A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 06:56:42PM -0700, Elijah Newren wrote:

> > The error message is a bit verbose, but it starts with:
> >
> >   connect.c: In function ‘git_tcp_connect_sock’:
> >   connect.c:801:32: error: ‘DEFAULT_GIT_PORT’ undeclared (first use in this function)
> >   801 |         const char *port = STR(DEFAULT_GIT_PORT);
> >       |                                ^~~~~~~~~~~~~~~~
> >
> > which seems OK in practice.
> 
> Seems pretty good to me.

The rest of it is less nice:
  connect.c: In function ‘git_tcp_connect_sock’:
  connect.c:801:32: error: ‘DEFAULT_GIT_PORT’ undeclared (first use in this function)
    801 |         const char *port = STR(DEFAULT_GIT_PORT);
        |                                ^~~~~~~~~~~~~~~~
  git-compat-util.h:93:31: note: in definition of macro ‘BUILD_ASSERT_OR_ZERO’
     93 |         (sizeof(char [1 - 2*!(cond)]) - 1)
        |                               ^~~~
  connect.c:801:28: note: in expansion of macro ‘STR’
    801 |         const char *port = STR(DEFAULT_GIT_PORT);
        |                            ^~~
  connect.c:801:32: note: each undeclared identifier is reported only once for each function it appears in
    801 |         const char *port = STR(DEFAULT_GIT_PORT);
        |                                ^~~~~~~~~~~~~~~~
  git-compat-util.h:93:31: note: in definition of macro ‘BUILD_ASSERT_OR_ZERO’
     93 |         (sizeof(char [1 - 2*!(cond)]) - 1)
        |                               ^~~~
  connect.c:801:28: note: in expansion of macro ‘STR’
    801 |         const char *port = STR(DEFAULT_GIT_PORT);
        |                            ^~~

but that's kind of the nature of BUILD_ASSERT (it's even worse if the
code compiles but the assertion is false, since the first thing is that
funky sizeof() line). I guess it's the best we can do. The point is that
these aren't supposed to happen very often.

-Peff
