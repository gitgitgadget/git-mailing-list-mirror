Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A025A1F4F8
	for <e@80x24.org>; Fri, 30 Sep 2016 07:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751006AbcI3HrO (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 03:47:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50378 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbcI3HrM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 03:47:12 -0400
Received: (qmail 23214 invoked by uid 109); 30 Sep 2016 07:47:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 07:47:10 +0000
Received: (qmail 8757 invoked by uid 111); 30 Sep 2016 07:47:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 03:47:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 03:47:08 -0400
Date:   Fri, 30 Sep 2016 03:47:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
Message-ID: <20160930074708.pthqg4ttl5rtpy3i@sigill.intra.peff.net>
References: <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
 <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
 <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 04:13:38PM -0700, Junio C Hamano wrote:

> There are very early ones in the program startup sequence in the
> following functions, but I do not think of a reason why our new and
> early call to prepare_packed_git() might be problematic, given that
> all of them require us to have an access to the repository (i.e.
> this change cannot introduce a regression where a command used to
> work outside a repository but barf when prepare_packed_git() is
> called early):
> 
>  - builtin/describe.c
>  - builtin/rev-list.c
>  - builtin/rev-parse.c
> 
> I thought that the one in diff.c might be problematic when the "git
> diff" command is run outside a repository with the "--no-index"
> option, but it appears that init_default_abbrev() seems to be OK
> when run outside a repository.

Actually, "diff --no-index" is currently buggy in this regard. In the
followup series to jk/setup-sequence-update (which I mentioned but
haven't posted yet), I teach get_object_dir() not to blindly default to
".git", and found that "diff --no-index" is perfectly happy to look in
".git/objects" for find_unique_abbrev(), even when we know there's no
repository (or it has an unknown vintage).

I fixed it there by just using the default abbrev value for out-of-repo
diffs, and skip calling find_unique_abbrev() at all. That would here,
too.

But if we add object-store initialization at other times, it's a
potential conflict. IMHO this should stay inside find_unique_abbrev(),
where we know we already must look at the object store.

-Peff
