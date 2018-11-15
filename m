Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169281F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 04:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeKOOkY (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 09:40:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:40102 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726689AbeKOOkY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 09:40:24 -0500
Received: (qmail 18162 invoked by uid 109); 15 Nov 2018 04:34:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 04:34:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12158 invoked by uid 111); 15 Nov 2018 04:33:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Nov 2018 23:33:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2018 23:34:09 -0500
Date:   Wed, 14 Nov 2018 23:34:09 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?R2HDq2w=?= Lhez <gael.lhez@gmail.com>
Subject: Re: [PATCH v2 1/1] bundle: cleanup lock files on error
Message-ID: <20181115043409.GA3419@sigill.intra.peff.net>
References: <pull.79.git.gitgitgadget@gmail.com>
 <pull.79.v2.git.gitgitgadget@gmail.com>
 <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
 <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
 <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 02:08:48PM -0800, Stefan Beller wrote:

> On Wed, Nov 14, 2018 at 1:43 PM Martin Ågren <martin.agren@gmail.com> wrote:
> >
> > On Wed, 14 Nov 2018 at 16:26, Gaël Lhez via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > However, the `.lock` file was still open and on Windows that means
> > > that it could not be deleted properly. This patch fixes that issue.
> >
> > Hmmm, doesn't the tempfile machinery remove the lock file when we die?
> 
> On Windows this seems not to be the case. (Open files cannot be deleted
> as the open file is not kept by inode or similar but by the file path there?)
> 
> Rewording your concern: Could the tempfile machinery be taught to
> work properly on Windows, e.g. by first closing all files and then deleting
> them afterwards?

It already tries to do so. See delete_tempfile(), or more likely in the
die() case, the remove_tempfiles() handler which is called at exit.

Are we sure this is still a problem?

I looked at the test to see if it would pass, but it is not even
checking anything about lockfiles! It just checks that we exit 1 by
returning up the callstack instead of calling die(). And of course it
would not have a problem under Linux either way. But if I run something
similar under strace, I see:

  $ strace ./git bundle create foobar.bundle HEAD..HEAD
  [...]
  openat(AT_FDCWD, "/home/peff/compile/git/foobar.bundle.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) = 3
  [...]
  close(3)                                = 0
  unlink("/home/peff/compile/git/foobar.bundle.lock") = 0
  exit_group(128)                         = ?

which seems right.

-Peff
