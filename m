Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD95C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505EA6112F
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbhIVUK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:10:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:52888 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237391AbhIVUKl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:10:41 -0400
Received: (qmail 10982 invoked by uid 109); 22 Sep 2021 20:09:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 20:09:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17810 invoked by uid 111); 22 Sep 2021 20:09:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 16:09:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 16:09:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUuNXOb5blV7iN6P@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <xmqq8rzo770h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rzo770h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 12:19:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > 	# Ensure that there is no "Basic" followed by a base64 string, but that
> > 	# the auth details are redacted
> > 	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
> > 	grep "Authorization: Basic <redacted>" trace
> >
> > gets confused. It sees the "<redacted>" one from the pre-upgrade
> > HTTP/1.1 request, but fails to see the unredacted HTTP/2 one, because it
> > does not match the lower-case "authorization".
> 
> Neither pattern of the above two will not match the HTTP/2 one, so
> the first one would report "there is no leakage of Auth with a
> caplital letter"; the second one may see only one pre-upgrade Auth
> with a capital letter, but as long as it does find one, it should be
> happy, no?
> 
> I am a bit puzzled how the test gets confused.

The first one matches nothing, because the HTTP/2 one which fails to
redact has a lower-case "A". The second one _does_ match, because we do
issue an HTTP/1.1 request in addition to the HTTP/2 one. We have to in
order to probe the server to say "this is HTTP/1.1, but by the way, we
support HTTP/2".

I am a little surprised that we get as far as sending auth info via
HTTP/1.1, since the initial probe that results in a 401 (causing us to
send the auth) could in theory let us know the server speaks HTTP/2. But
in practice it doesn't.  It looks like the server does not do the
upgrade for a 401 (perhaps that's true for any non-success code, I don't
know).

You can see it in action if you use the test changes I mentioned earlier
_without_ my patch applied (so neither the "grep -i" fix, nor the actual
code change). And then do:

  ./t5551-http-fetch-smart.sh --run=1-17 --debug
  egrep 'Send header:|Recv header:' trash*/trace

I get (with some extraneous headers omitted):

  => Send header: GET /auth/smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
  => Send header: Connection: Upgrade, HTTP2-Settings
  => Send header: Upgrade: h2c
  => Send header: HTTP2-Settings: AAMAAABkAAQCAAAAAAIAAAAA

  <= Recv header: HTTP/1.1 401 Unauthorized
  <= Recv header: Date: Wed, 22 Sep 2021 20:03:32 GMT
  <= Recv header: Server: Apache/2.4.49 (Debian)
  <= Recv header: WWW-Authenticate: Basic realm="git-auth"

  => Send header: GET /auth/smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
  => Send header: Authorization: Basic <redacted>
  => Send header: Connection: Upgrade, HTTP2-Settings
  => Send header: Upgrade: h2c
  => Send header: HTTP2-Settings: AAMAAABkAAQCAAAAAAIAAAAA

  <= Recv header: HTTP/1.1 101 Switching Protocols
  <= Recv header: Upgrade: h2c
  <= Recv header: Connection: Upgrade
  <= Recv header: HTTP/2 200
  <= Recv header: content-type: application/x-git-upload-pack-advertisement

  => Send header: POST /auth/smart/repo.git/git-upload-pack HTTP/2
  => Send header: authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==
  => Send header: content-type: application/x-git-upload-pack-request

  <= Recv header: HTTP/2 200
  <= Recv header: content-type: application/x-git-upload-pack-result
  [...and so on...]

So you can see both the redacted and unredacted lines in that output.
I'm happy to include that in the commit message if it helps; I avoided
it earlier because it was already getting quite long. ;)

-Peff
