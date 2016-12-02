Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047E81FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 21:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932390AbcLBVqc (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 16:46:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:50883 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbcLBVqa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 16:46:30 -0500
Received: (qmail 9328 invoked by uid 109); 2 Dec 2016 21:45:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 21:45:31 +0000
Received: (qmail 15708 invoked by uid 111); 2 Dec 2016 21:46:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 16:46:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2016 16:45:29 -0500
Date:   Fri, 2 Dec 2016 16:45:29 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161202214529.mjekdaixrdoyroxq@sigill.intra.peff.net>
References: <20161201191603.GB54082@google.com>
 <20161201205444.GG54082@google.com>
 <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net>
 <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
 <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net>
 <20161202183622.GB117792@google.com>
 <CA+P7+xpoO=ieRyQb8r8Xz12nN10f53LKeVMgAO8XPdSwvG7fuA@mail.gmail.com>
 <20161202184944.GC117792@google.com>
 <CA+P7+xoi_UNSv-dKVFWf7T4o3uBtGa0wR6=nnYX+kjzLAmw6ug@mail.gmail.com>
 <CAGZ79kYPpc0=NAJaNPW+8faszOPAkq=b3m-EopY5A8oFwh+9=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYPpc0=NAJaNPW+8faszOPAkq=b3m-EopY5A8oFwh+9=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 11:28:49AM -0800, Stefan Beller wrote:

> I just reviewed 2 libc implementations (glibc and an Android libc) and
> both of them
> do not use chdir internally, but use readlink and compose the path 'manually'
> c.f. http://osxr.org:8080/glibc/source/stdlib/canonicalize.c?v=glibc-2.13

Interesting. It might be worth updating our implementation. The original
comes all the way from 54f4b8745 (Library code for user-relative paths,
take three., 2005-11-17). That references a suggestion which I think
comes from:

  http://public-inbox.org/git/Pine.LNX.4.64.0510181728490.3369@g5.osdl.org/

where it's claimed to be simpler and more efficient (which sounds
plausible to me).  But back then it was _just_ git-daemon doing a
canonicalization, and nobody cared about things like thread safety.

Looking at the glibc implementation, it's really not that bad. We
_could_ even rely on the system realpath() and just provide our own
fallback for systems without it, but I think ours might be a little more
featureful (at the very least, it handles arbitrary-sized paths via
strbufs).

-Peff
