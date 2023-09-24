Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D335FCE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 04:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIXDuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 23:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXDub (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 23:50:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB61109
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 20:50:24 -0700 (PDT)
Received: (qmail 17374 invoked by uid 109); 24 Sep 2023 03:50:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 24 Sep 2023 03:50:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32729 invoked by uid 111); 24 Sep 2023 03:50:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 23:50:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 23:50:22 -0400
From:   Jeff King <peff@peff.net>
To:     David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
Cc:     git@vger.kernel.org
Subject: Re: Issues with git clone over HTTP/2 and closed connections
Message-ID: <20230924035022.GA1503477@coredump.intra.peff.net>
References: <bb757ebd66b5ac4c81d62b01d5cff2f75250090d@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb757ebd66b5ac4c81d62b01d5cff2f75250090d@hardeman.nu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2023 at 12:58:09PM +0000, David Härdeman wrote:

> By running "GIT_CURL_VERBOSE=1 git clone https://example.com/myrepo.git", I noticed that:
> 
>   a) HTTP/2 was being used; and
>   b) just before the error the server returned a GOAWAY [1]:
>      "== Info: received GOAWAY, error=0, last_stream=1999"
> 
> On the client side I'm using Debian Unstable (libcurl 8.3.0, git
> 2.40.1), and the server is running Debian Stable (nginx 1.22.1-9).
> 
> nginx will, by default, close HTTP/2 connections after
> "http2_max_requests", (default: 1000, i.e. 1999 streams, note that the
> error message above says last_stream=1999) and it seems that it is
> using GOAWAY to do so, which seems to confuse git/libcurl.
> 
> And sure enough, after running "git config --global http.version
> HTTP/1.1" on the client and trying again, the "git clone" was
> successful (I'm guessing I could/should also bump http2_max_requests
> on the server).

Thanks for a detailed report. Your analysis all makes sense to me.

> From what I understand, git should close the connection, try to open a
> new one and resume the clone operation before erroring out (because
> the GOAWAY message could mean anything).
> 
> Is this a known bug and is it something that would need to be fixed in
> libcurl or in git?

I don't think we've heard of such a problem before with Git. I don't
know enough about GOAWAY to comment on the correct behavior, but this is
almost certainly a curl issue, not a Git one. All of the connection
handling, reuse, etc, is happening invisibly at the curl layer.

It's probably worth poking around libcurl's issue tracker. This seems
like it might be related:

  https://github.com/curl/curl/issues/11859

And one final comment: 2000 is a lot of requests for one clone. That
plus the error you are seeing from Git makes me think you're using the
"dumb" http protocol (i.e., your webserver is not set up to run the
server side of Git's smart protocol, so it is just serving files
blindly).

I don't know if using it is intentional or not. But the smart protocol
is much more efficient, and in general I would expect it to have fewer
corner cases (none of the major forges allow dumb-http at all).

You can find more details on setting it up in "git help http-backend".

If you do want to keep using the dumb protocol, consider running "git
gc" on the server side repository. 2000 requests implies you have many
loose objects, which could be served much more efficiently as a single
pack.

-Peff
