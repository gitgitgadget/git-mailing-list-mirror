Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7634320986
	for <e@80x24.org>; Tue,  4 Oct 2016 15:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbcJDPku (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 11:40:50 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55424 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbcJDPkt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 11:40:49 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1brRpl-0002BL-00; Tue, 04 Oct 2016 15:40:45 +0000
Date:   Tue, 4 Oct 2016 11:40:45 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, musl@lists.openwall.com
Subject: Re: Regression: git no longer works with musl libc's regex impl
Message-ID: <20161004154045.GT19318@brightrain.aerifal.cx>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 11:27:22AM -0400, Jeff King wrote:
> On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:
> 
> > This commit broke support for using git with musl libc:
> > 
> > https://github.com/git/git/commit/2f8952250a84313b74f96abb7b035874854cf202
> 
> Yep. The idea is that you would compile git with NO_REGEX=1, and it
> would use the included compat routines.

This is really obnoxious to have to do manually. Why can't it simply
be auto-detected based on non-definition of REG_STARDEND?

> Is there something in particular you want to get out of using musl's
> regex that is not supported in the compat library?

It's always nice not to link extra implementations of the same thing.
This comes up all the time with gratuitous gnulib replacement
functions too.

> > Rather than depending on non-portable GNU regex extensions, there is a
> > simple portable fix for the issue this code was added to work around:
> > When a text file is being mmapped for use with string functions which
> > depend on null termination, if the file size:
> > 
> > 1. is nonzero mod page size, it just works; the remainder of the last
> >    page reads as zero bytes when mmapped.
> 
> Is that a portable assumption?

Yes. Per POSIX:

"The system shall always zero-fill any partial page at the end of an
object. Further, the system shall never write out any modified
portions of the last page of an object which are beyond its end.
References within the address range starting at pa and continuing for
len bytes to whole pages following the end of an object shall result
in delivery of a SIGBUS signal."

Source: http://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html

The same or similar text appears at least back to SUSv2; I did not
look further back.

> > 2. if an exact multiple of the page size, then instead of directly
> >    mmapping the file, first mmap a mapping 1 byte (thus 1 page) larger
> >    with MAP_ANON, then use MAP_FIXED to map the file over top of all
> >    but the last page. Now the mmapped buffer can safely be used as a C
> >    string.
> 
> I'm not sure whether all of our compat layers for mmap would be happy
> with that (e.g., see compat/win32mmap.c).

The nice thing about this approach is that if the MAP_FIXED fails due
to a broken system you can just read() into the anonymous memory.

> So it seems like any mmap-related solutions would have to be
> conditional, too. And then regexec_buf() would have to become something
> like:
> 
>   int regexec_buf(...)
>   {
>   #if defined(REG_STARTEND)
> 	... set up match ...
> 	return regexec(..., REG_STARTEND);
>   #elif defined(MMAP_ALWAYS_HAS_NUL)
> 	/*
> 	 * We assume that every buffer we see is always NUL-terminated
> 	 * eventually, either because it comes from xmallocz() or our
> 	 * mmap layer always ensures an extra NUL.
> 	 */
> 	 return regexec(...);
>   #else
>   #error "Nope, you need either NO_REGEX or USE_MMAP_NUL"
>   #endif
>   }
> 
> The assumption in the middle case feels pretty hacky, though. It fails

I agree. I would prefer just falling back to read() after MAP_ANON if
the MAP_FIXED fails. This would work for all systems.

> if we get a buffer from somewhere besides those two sources. It fails if
> somebody calls regexec_buf() on a subset of a string.
> 
> It also doesn't handle matching past embedded NULs in the string. That's
> not something we're relying on yet, but it would be nice to support
> consistently in the long run.

This is going to be even more non-portable and
implementation-specific. There's not even a good spec for how embedded
nuls should be treated in regex.

> If there's a compelling reason, it might be worth making that tradeoff.
> But I am not sure what the compelling reason is to use musl's regex
> (aside from the obvious of "less code in the resulting executable").

The compelling reason is just being portable by default rather than
requiring manual overrides to use a replacement library with weird
extensions for something that could have been done portably to begin
with.

Rich
