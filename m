Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297F2201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934589AbdBVXmT (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:42:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:60326 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934217AbdBVXl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 18:41:56 -0500
Received: (qmail 808 invoked by uid 109); 22 Feb 2017 23:34:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 23:34:39 +0000
Received: (qmail 25165 invoked by uid 111); 22 Feb 2017 23:34:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 18:34:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 18:34:37 -0500
Date:   Wed, 22 Feb 2017 18:34:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] http: restrict auth methods to what the server advertises
Message-ID: <20170222233436.l5c3ya53cl7y5x7z@sigill.intra.peff.net>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, we tell curl to use CURLAUTH_ANY, which does not
limit its set of auth methods. However, this results in an
extra round-trip to the server when authentication is
required. After we've fed the credential to curl, it wants
to probe the server to find its list of available methods
before sending an Authorization header.

We can shortcut this by limiting our http_auth_methods by
what the server told us it supports. In some cases (such as
when the server only supports Basic), that lets curl skip
the extra probe request.

The end result should look the same to the user, but you can
use GIT_TRACE_CURL to verify the sequence of requests:

  GIT_TRACE_CURL=1 \
  git ls-remote https://example.com/repo.git \
  2>&1 >/dev/null |
  egrep '(Send|Recv) header: (GET|HTTP|Auth)'

Before this patch, hitting a Basic-only server like
github.com results in:

  Send header: GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  Recv header: HTTP/1.1 401 Authorization Required
  Send header: GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  Recv header: HTTP/1.1 401 Authorization Required
  Send header: GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  Send header: Authorization: Basic <redacted>
  Recv header: HTTP/1.1 200 OK

And after:

  Send header: GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  Recv header: HTTP/1.1 401 Authorization Required
  Send header: GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  Send header: Authorization: Basic <redacted>
  Recv header: HTTP/1.1 200 OK

The possible downsides are:

  - This only helps for a Basic-only server; for a server
    with multiple auth options, curl may still send a probe
    request to see which ones are available (IOW, there's no
    way to say "don't probe, I already know what the server
    will say").

  - The http_auth_methods variable is global, so this will
    apply to all further requests. That's acceptable for
    Git's usage of curl, though, which also treats the
    credentials as global. I.e., in any given program
    invocation we hit only one conceptual server (we may be
    redirected at the outset, but in that case that's whose
    auth_avail field we'd see).

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index 90a1c0f11..a05609766 100644
--- a/http.c
+++ b/http.c
@@ -1347,6 +1347,8 @@ static int handle_curl_result(struct slot_results *results)
 		} else {
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+			if (results->auth_avail)
+				http_auth_methods &= results->auth_avail;
 #endif
 			return HTTP_REAUTH;
 		}
-- 
2.12.0.rc2.597.g959f68882

