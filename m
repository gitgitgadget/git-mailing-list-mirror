Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956361F454
	for <e@80x24.org>; Thu,  7 Nov 2019 08:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKGIDI (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 03:03:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:41806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726800AbfKGIDI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 03:03:08 -0500
Received: (qmail 29936 invoked by uid 109); 7 Nov 2019 08:03:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 08:03:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 358 invoked by uid 111); 7 Nov 2019 08:06:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 03:06:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 03:03:07 -0500
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 8/8] sequencer: reencode commit message for am/rebase
 --show-current-patch
Message-ID: <20191107080307.GB11245@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <36796e2b679cd8b2d341058e775db401f9abcef7.1573094789.git.congdanhqx@gmail.com>
 <20191107063223.GF6431@sigill.intra.peff.net>
 <20191107074858.GC8096@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107074858.GC8096@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 02:48:58PM +0700, Danh Doan wrote:

> > # and if we resolve and commit, presumably we'd get a broken commit,
> > # with iso8859-1 and no encoding header
> > echo resolved >file
> > git add file
> > GIT_EDITOR=: git rebase --continue
> > -- 8< --
> > 
> > But somehow it all seems to work. The resulting commit has real utf8 in
> > it. I'm not sure if we pull it from the original commit via "commit -c",
> 
> Yes, somehow it worked. But, without this patch, git also warns:
> 
>     % GIT_EDITOR=: git rebase --continue
>     Warning: commit message did not conform to UTF-8.
>     You may want to amend it after fixing the message, or set the config
>     variable i18n.commitencoding to the encoding your project uses.
> 
> Checking with strace (on glibc, musl strace can't trace execve):
> 
> > [pid 12848] execve("/home/danh/workspace/git/git", ["/home/danh/workspace/git/git", "commit", "-n", "-F", ".git/rebase-merge/message", "-e", "--allow-empty"], 0x558fb02e8240 /* 51 vars */) = 0
> 
> Turn out, it's because of: commit.c::verify_utf8
> 
>     /*
>      * This verifies that the buffer is in proper utf8 format.
>      *
>      * If it isn't, it assumes any non-utf8 characters are Latin1,
>      * and does the conversion.
>      */
>     static int verify_utf8(struct strbuf *buf)
> 
> Hence, your test is just pure luck (because it's in latin1).

Ah, thanks for resolving that mystery. Is it worth turning the scenario
above into a test?

-Peff
