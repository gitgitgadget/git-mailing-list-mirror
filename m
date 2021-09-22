Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB78C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B0960F3A
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhIVWPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:15:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:53074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238256AbhIVWPf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:15:35 -0400
Received: (qmail 12560 invoked by uid 109); 22 Sep 2021 22:14:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 22:14:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19680 invoked by uid 111); 22 Sep 2021 22:14:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 18:14:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 18:14:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH v2] http: match headers case-insensitively when redacting
Message-ID: <YUuqrNXdgUR5thl5@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <xmqq8rzo770h.fsf@gitster.g>
 <YUuNXOb5blV7iN6P@coredump.intra.peff.net>
 <xmqqk0j85o6c.fsf@gitster.g>
 <YUudqYmzy9N3e0Bk@coredump.intra.peff.net>
 <xmqqbl4k5lsu.fsf@gitster.g>
 <YUuqKeXRYuXjXy1+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUuqKeXRYuXjXy1+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 06:11:54PM -0400, Jeff King wrote:

> Well, I did it anyway. :) Here's the updated patch. I think it explains
> things more clearly by showing the example output from our discussion
> (and reframes the text around it to explain it more). I'll send a
> range-diff in a moment.

Here's the range-diff. I split it out because the commit message is
already so long and full of sample diffs and output that I thought it
would get hard to tell what was range-diff and what was actual diff. :)

1:  faa6e6d28e ! 1:  ea064beb32 http: match headers case-insensitively when redacting
    @@ Commit message
           Authorization: Basic ...
     
         After breaking it into lines, we match each header using skip_prefix().
    -    This is case-insensitive, even though HTTP headers are case-insensitive.
    +    This is case-sensitive, even though HTTP headers are case-insensitive.
         This has worked reliably in the past because these headers are generated
         by curl itself, which is predictable in what it sends.
     
    @@ Commit message
             (the overall operation works fine; we just don't see the header in
             the trace).
     
    -    On top of that, we also need the test change that this patch _does_ do:
    -    grepping the trace file case-insensitively. Otherwise the test continues
    -    to pass even over HTTP/2, because it sees _both_ forms of the header
    -    (redacted and unredacted), as we upgrade from HTTP/1.1 to HTTP/2. So our
    -    double grep:
    +    Furthermore, even with the changes above, this test still does not
    +    detect the current failure, because we see _both_ HTTP/1.1 and HTTP/2
    +    requests, which confuse it. Quoting only the interesting bits from the
    +    resulting trace file, we first see:
    +
    +      => Send header: GET /auth/smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
    +      => Send header: Connection: Upgrade, HTTP2-Settings
    +      => Send header: Upgrade: h2c
    +      => Send header: HTTP2-Settings: AAMAAABkAAQCAAAAAAIAAAAA
    +
    +      <= Recv header: HTTP/1.1 401 Unauthorized
    +      <= Recv header: Date: Wed, 22 Sep 2021 20:03:32 GMT
    +      <= Recv header: Server: Apache/2.4.49 (Debian)
    +      <= Recv header: WWW-Authenticate: Basic realm="git-auth"
    +
    +    So the client asks for HTTP/2, but Apache does not do the upgrade for
    +    the 401 response. Then the client repeats with credentials:
    +
    +      => Send header: GET /auth/smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
    +      => Send header: Authorization: Basic <redacted>
    +      => Send header: Connection: Upgrade, HTTP2-Settings
    +      => Send header: Upgrade: h2c
    +      => Send header: HTTP2-Settings: AAMAAABkAAQCAAAAAAIAAAAA
    +
    +      <= Recv header: HTTP/1.1 101 Switching Protocols
    +      <= Recv header: Upgrade: h2c
    +      <= Recv header: Connection: Upgrade
    +      <= Recv header: HTTP/2 200
    +      <= Recv header: content-type: application/x-git-upload-pack-advertisement
    +
    +    So the client does properly redact there, because we're speaking
    +    HTTP/1.1, and the server indicates it can do the upgrade. And then the
    +    client will make further requests using HTTP/2:
    +
    +      => Send header: POST /auth/smart/repo.git/git-upload-pack HTTP/2
    +      => Send header: authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==
    +      => Send header: content-type: application/x-git-upload-pack-request
    +
    +    And there we can see that the credential is _not_ redacted. This part of
    +    the test is what gets confused:
     
                 # Ensure that there is no "Basic" followed by a base64 string, but that
                 # the auth details are redacted
                 ! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
                 grep "Authorization: Basic <redacted>" trace
     
    -    gets confused. It sees the "<redacted>" one from the pre-upgrade
    -    HTTP/1.1 request, but fails to see the unredacted HTTP/2 one, because it
    -    does not match the lower-case "authorization". Even without the rest of
    -    the test changes, we can still make this test more robust by matching
    -    case-insensitively. That will future-proof the test for a day when
    -    HTTP/2 is finally enabled by default, and doesn't hurt in the meantime.
    +    The first grep does not match the un-redacted HTTP/2 header, because
    +    it insists on an uppercase "A". And the second one does find the
    +    HTTP/1.1 header. So as far as the test is concerned, everything is OK,
    +    but it failed to notice the un-redacted lines.
    +
    +    We can make this test (and the other related ones) more robust by adding
    +    "-i" to grep case-insensitively. This isn't really doing anything for
    +    now, since we're not actually speaking HTTP/2, but it future-proofs the
    +    tests for a day when we do (either we add explicit HTTP/2 test support,
    +    or it's eventually enabled by default by our Apache+curl test setup).
    +    And it doesn't hurt in the meantime for the tests to be more careful.
    +
    +    The change to use "grep -i", coupled with the changes to use HTTP/2
    +    shown above, causes the test to fail with the current code, and pass
    +    after this patch is applied.
     
         And finally, there's one other way to demonstrate the issue (and how I
         actually found it originally). Looking at GIT_TRACE_CURL output against
