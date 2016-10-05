Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102B61F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbcJEQhO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 5 Oct 2016 12:37:14 -0400
Received: from p3plsmtp15-02-2.prod.phx3.secureserver.net ([173.201.193.36]:54022
        "EHLO p3plwbeout15-02.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751304AbcJEQhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:37:13 -0400
Received: from localhost ([173.201.193.12])
        by p3plwbeout15-02.prod.phx3.secureserver.net with bizsmtp
        id rsdC1t0020GWrr901sdCVk; Wed, 05 Oct 2016 09:37:12 -0700
X-SID:  rsdC1t0020GWrr901
Received: (qmail 6823 invoked by uid 99); 5 Oct 2016 16:37:12 -0000
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: 128.143.170.15
User-Agent: Workspace Webmail 6.5.1
Message-Id: <20161005093711.dc30d64f61e5ec441c34ffd4f788e58e.4f463e82c1.wbe@email15.godaddy.com>
From:   <writeonce@midipix.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     musl@lists.openwall.com, git@vger.kernel.org,
        "Jeff King" <peff@peff.net>
Subject: RE: [musl] Re: Regression: git no longer works with musl libc's regex impl
Date:   Wed, 05 Oct 2016 09:37:11 -0700
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

> 
> 
> -------- Original Message --------
> Subject: RE: [musl] Re: Regression: git no longer works with musl libc's
> regex impl
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date: Wed, October 05, 2016 3:49 am
> To: writeonce@midipix.org
> Cc: musl@lists.openwall.com, git@vger.kernel.org, Jeff King
> <peff@peff.net>
> 
> Hi writeonce,
> 
> On Tue, 4 Oct 2016, writeonce@midipix.org wrote:
> 
> > < On Tue, 4 Oct 2016, Rich Felker wrote:
> > < 
> > < > On Tue, Oct 04, 2016 at 11:27:22AM -0400, Jeff King wrote:
> > < > > On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:
> > < > > 
> > < > > > 1. is nonzero mod page size, it just works; the remainder of the
> > < > > > last page reads as zero bytes when mmapped.
> > < > > 
> > < > > Is that a portable assumption?
> > < > 
> > < > Yes.
> > < 
> > < No, it is not. You quote POSIX, but the matter of the fact is that we
> > < use a subset of POSIX in order to be able to keep things running on
> > < Windows.
> > 
> > As far as I can tell (and as the attached program may help demonstrate),
> > the above assumption has been valid on all versions of Windows since at
> > least Windows 2000.
> 
> And since W2K is already past its end of life, it would be safe for
> practical considerations.
> 
> However, I have to add two comments to that:
> 
> - it is *not* guaranteed. The behavior is undefined, even if you see
>  consistent behavior so far. Future Windows versions might break that
>  assumption freely, though.
> 

That is of course the official language, and generally speaking a good
rule of thumb. However... there is enough information to suggest that
when it comes to mapping of file-backed sections, the NT kernel
developers will choose to keep things the way they are. In brief, here's
why:

Given a "gray zone" that spans from EOF to end-of-page, there are in
essence three possible behaviors:

[1] bytes in the gray zone are accessible and are all zero's. This is
the current behavior.
[2] bytes in the gray zone are not accessible; trying to read past EOF
would result in a segfault.
[3] bytes in the gray zone are accessible but might contain random data
or junk.

Assessment:

[1] backward-compatible, POSIX-compliant, single code path for both
WIN32 and LXW.
[2] requires changing memory access granularity from 4096 bytes to a
single byte, and is therefore extremely costly.
[3] introduces a whole new class of security vulnerabilities, and will
thus be a lot of fun to watch:-)

All in all taken, then, I'd argue that relying on the current behavior
is very reasonable. If you, too, find the above assessment valid, and
since you mentioned that you were a Microsoft employee, it would be
great if you could make a good-faith effort to have the current behavior
added to the Driver Documentation and thus guaranteed.

PS. this isn't to say that the regex extension should or should not be
used, only that a decision on the matter should not be based on the
undocumentedness of current behavior.

midipix

> - some implementations of the REG_STARTEND feature have the nice property
>  that they can read past NUL characters. Granted, not all of them do
>  (AFAIU one example is FreeBSD itself, the first platform to sport
>  REG_STARTEND), but we at least reap the benefit whenever using a regex
>  that *can* read past NUL characters.
> 
> > In this context, one thing to remember is that the page-size for the mod
> > operation is 4096, whereas the POSIX page-size (for the purpose of mmap
> > and mremap) is 65536.
> 
> Indeed. A colleague of mine spotted the segfault when diffing a file that
> was *exactly* 4,096 bytes.
> 
> > Note also that in the case of file-backed mapped sections, using
> > kernel32.dll or msvcrt.dll or cygwin/newlib or midipix/musl is of little
> > significance, specifically since all invoke ZwCreateSection and
> > ZwMapViewOfSection under the hood.
> 
> Right. It's all backed by the very same kernel functions.
> 
> Ciao,
> Johannes

