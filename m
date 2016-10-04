Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8485E20986
	for <e@80x24.org>; Tue,  4 Oct 2016 14:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbcJDOKe (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 10:10:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:52031 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbcJDOKd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 10:10:33 -0400
Received: (qmail 23214 invoked by uid 109); 4 Oct 2016 14:10:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 14:10:32 +0000
Received: (qmail 5218 invoked by uid 111); 4 Oct 2016 14:10:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 10:10:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 10:10:30 -0400
Date:   Tue, 4 Oct 2016 10:10:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 18/18] alternates: use fspathcmp to detect duplicates
Message-ID: <20161004141029.medczy5vusmam23h@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203626.styj2vwcmgwnpx4v@sigill.intra.peff.net>
 <CA+P7+xqhuYmp-H=b-SrNdZjN5urWGHPuNkWbeVgCBF1UuhQZKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqhuYmp-H=b-SrNdZjN5urWGHPuNkWbeVgCBF1UuhQZKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 11:51:59PM -0700, Jacob Keller wrote:

> On Mon, Oct 3, 2016 at 1:36 PM, Jeff King <peff@peff.net> wrote:
> > On a case-insensitive filesystem, we should realize that
> > "a/objects" and "A/objects" are the same path. We already
> > use fspathcmp() to check against the main object directory,
> > but until recently we couldn't use it for comparing against
> > other alternates (because their paths were not
> > NUL-terminated strings). But now we can, so let's do so.
> >
> 
> Yep, makes sense.
> 
> > Note that we also need to adjust count-objects to load the
> > config, so that it can see the setting of core.ignorecase
> > (this is required by the test, but is also a general bugfix
> > for users of count-objects).
> 
> Also makes sense.

BTW, I tested this on a vfat loopback device, but I was surprised to see
that quite a few other tests failed on that device.

At least one of the problems is that symlinks are not supported, but
lib-httpd.sh wants to use them for its Apache setup. I guess people on
Windows just don't run the httpd tests at all, which is not too
surprising.

Likewise, credential-cache fails because it cannot create a Unix socket
(and the flag for that is in the build, not a run-time filesystem
check).

Some of the other failures seemed to be due to lack of an executable bit
on the filesystem. I'm not sure if we could or should do better run-time
detection of that sort of thing. I think some of the checks are tied to
the build, and that's generally good enough in practice because people
don't use vfat on their Linux machines. So tracking down each of them
may just be pedantic make-work that nobody cares about.

I did wonder if there was another good filesystem to use for
case-insensitive experiments on Linux. At the time I didn't think there
was good support for making HFS+ filesystems, but it looks Debian cares
mkfs.hfs. That's probably a better choice for such experiments.

-Peff
