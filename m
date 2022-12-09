Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C659C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 20:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLIU7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 15:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLIU7t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 15:59:49 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AB9AC6E5
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 12:59:48 -0800 (PST)
Received: (qmail 8291 invoked by uid 109); 9 Dec 2022 20:59:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Dec 2022 20:59:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28778 invoked by uid 111); 9 Dec 2022 20:59:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Dec 2022 15:59:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Dec 2022 15:59:46 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t5559-http-fetch-smart-http2 failures
Message-ID: <Y5OhwqBAq9SCuruq@coredump.intra.peff.net>
References: <Y4fUntdlc1mqwad5@pobox.com>
 <Y4kNu9iFQuKjuub1@coredump.intra.peff.net>
 <Y5KbUBC1ENOAVuTV@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5KbUBC1ENOAVuTV@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 09:20:00PM -0500, Todd Zullinger wrote:

> Sorry for the delay.  I wanted to gather some data but could
> only do it in small chunks at a time.  Hopefully that
> doesn't make this too rambling and/or disjointed.

No problem. I would be happy if all bug reports were this thorough and
clear. :)

> > Thanks for the report. I can't seem to reproduce here on my Debian
> > system, even with --stress.
> 
> One notable difference between Debian/Ubuntu and Fedora is
> that Debian/Ubuntu uses mod_http2 included with the upstream
> Apache httpd source.  Fedora is using the newer, stand-alone
> module (which is the upstream source for the http2 module).
> 
> Ubuntu 22.04.1 has httpd-2.4.52 with mod_http2-1.15.26 (per
> MOD_HTTP2_VERSION in modules/http2/h2_version.h).

Makes sense. I'm on Debian unstable, which is httpd-2.4.54 and
mod_http2-1.15.28 (the latter I pulled from "strings mod_http2.so", so
uh...it's probably right).

> Fedora 37, 36, and rawhide have httpd-httpd-2.4.54 with
> mod_http2-2.0.9.  They also have curl-7.86 in rawhide (where
> I've done the most testing), 7.85.0 in 37, and 7.82.0 in 36.

So that's the same httpd and curl version (7.86.0) I'm using, which
implies to me the problem is in the newer mod_http2 version. And...

> Interestingly, if I build the same git source rpm against
> RHEL-9 which has httpd-2.4.53 and mod_http2-1.15.19, I don't
> see any failures.

...that data point would be consistent with the theory.

> I'm tempted to do a build of mod_http2-1.x or the embedded
> mod_http2 and test with that, but I have not yet made time
> to do so.

Yeah, I suspect it would make the problem go away. In theory it may even
be possible to bisect within mod_http2, but I don't know how painful it
is to do a build+test cycle.

> With that, one of the more common errors is:
> 
>     error: RPC failed; HTTP 101 curl 92 HTTP/2 stream 1 was not closed cleanly before end of the underlying stream
> 
> others are:
> 
>     error: RPC failed; HTTP 101 curl 16 Error in the HTTP2 framing layer
>     fatal: expected flush after ref listing
> 
>     error: RPC failed; HTTP 101 curl 16 Error in the HTTP2 framing layer
> 
>     error: RPC failed; curl 16 Error in the HTTP2 framing layer 
>     fatal: expected 'packfile'

OK, that makes me pretty confident that there's nothing Git is doing
wrong here. I don't think we could stimulate a failure at that layer of
curl even if we wanted to. And those errors plus the racy nature of what
you're seeing really makes it look like there is just some race
condition or other bug in mod_http2 (possibly coupled with the mpm).

> The error.log looks the same for the failed runs I've
> collected:
> [...]
> The LogLevel might need to be adjusted to get more useful
> output there, perhaps?

Yeah, that output is not particularly enlightening. In a sense it's not
surprising, though. If there's a bug on the server side, we're not
likely to get a log line saying "sending garbage output to the client".
It's the client who sees the problem and hangs up. Turning up the log
level could help, but I'd be surprised.

> > also causes t5551 to start failing. If so, then we can blame mpm_event,
> > and not http2.
> 
> Good idea.  With that applied, I've still not seen a failure
> in t5551, not even when run via --stress for some minutes.

OK. So I think that rules out mpm_event being a problem by itself. It's
possible there's some bad interaction between mpm_event and mod_http2,
but it seems more likely there's simply a bug or race in mod_http2.

> I'm not sure whether any of this points to a bug in Git's
> http2 code at all.  It _seems_ like it's going to be
> elsewhere, in curl and/or httpd/mod_http2.  In other words,
> your 1 above.

My best guess is a bug in mod_http2. But one thing that it still _could_
be is that Git's server-side CGI interacts badly with mod_http2 somehow
(or maybe only some versions of it).

I guess some other things to try would be:

  1. Take Git out of the mix completely. If we stress-test command-line
     curl hitting our test apache, serving up static files, can we
     trigger the problem? If not, then...

  2. Try the same thing, but hit endpoints that trigger git-http-backend
     on the server side. If that fails, then we've absolved Git's client
     code, and the bug is either in mod_http2 or some bad interaction
     with Git's CGI output.

> If nothing jumps out to point to a possible issue in git,
> I'll extract a reproduction recipe from the test suite and
> file a Fedora bug.  Maybe the folks who have looked at
> similar issues in curl and httpd/mod_http2 will spot
> something.

You might try running the failing tests with GIT_TRACE_CURL set in the
environment. That should get you a pretty detailed view of what curl is
seeing, which would probably be helpful for a bug report.

-Peff
