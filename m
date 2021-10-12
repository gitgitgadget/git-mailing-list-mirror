Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0EEC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5464F60D43
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhJLVOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:14:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:38054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233110AbhJLVO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 17:14:29 -0400
Received: (qmail 1683 invoked by uid 109); 12 Oct 2021 21:12:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 21:12:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17591 invoked by uid 111); 12 Oct 2021 21:12:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 17:12:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 17:12:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>, Alex Waite <alex@waite.eu>,
        git@vger.kernel.org
Subject: [PATCH] urlmatch: add underscore to URL_HOST_CHARS
Message-ID: <YWX6OkJANJGN0RnT@coredump.intra.peff.net>
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
 <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
 <YWX13C7xsLcu+jZA@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWX13C7xsLcu+jZA@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 04:53:48PM -0400, Jeff King wrote:

> > because earlier we define URL_HOST_CHARS without underscore:
> > 
> >   #define URL_HOST_CHARS URL_ALPHADIGIT ".-[:]" /* IPv6 literals need [:] */
> > 
> > I'm not sure why, given that this otherwise seems to match according to
> > the rfc. This code comes from 3402a8dc48 (config: add helper to
> > normalize and match URLs, 2013-07-31), but there's no mention of
> > underscore there. Possibly it came from earlier rules (rfc1738, for
> > example, has a stricter grammar that allows only alphabit and dashes).
> 
> Sorry, I meant to cc the author of 3402a8dc48, which I've now done. It's
> been a while, but maybe he remembers something (I couldn't find anything
> digging in the archive, either).

Absent any other input, I'd propose the patch below.

-- >8 --
Subject: urlmatch: add underscore to URL_HOST_CHARS

When parsing a URL to normalize it, we allow hostnames to contain only
dot (".") or dash ("-"), plus brackets and colons for IPv6 literals.
This matches the old URL standard in RFC 1738, which says:

  host           = hostname | hostnumber
  hostname       = *[ domainlabel "." ] toplabel
  domainlabel    = alphadigit | alphadigit *[ alphadigit | "-" ] alphadigit

But this was later updated by RFC 3986, which is more liberal:

  host        = IP-literal / IPv4address / reg-name
  reg-name    = *( unreserved / pct-encoded / sub-delims )
  unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"

While names with underscore in them are not common and possibly violate
some DNS rules, they do work in practice, and we will happily contact
them over http://, git://, or ssh://. It seems odd to ignore them for
purposes of URL matching, especially when the URL RFC seems to allow
them.

There shouldn't be any downside here. It's not a syntactically
significant character in a URL, so we won't be confused about parsing;
we'd have simply rejected such a URL previously (the test here checks
the url code directly, but the obvious user-visible effect would be
failing to match credential.http://foo_bar.example.com.helper, or
similar config in http.<url>.*).

Arguably we'd want to allow tilde ("~") here, too. There's likewise
probably no downside, but I didn't add it simply because it seems like
an even less likely character to appear in a hostname.

Reported-by: Alex Waite <alex@waite.eu>
Signed-off-by: Jeff King <peff@peff.net>
---
I'm on the fence regarding "~". I didn't actually test that things like
curl even allow it (I did for underscore by creating a throwaway DNS
name).

 t/t0110-urlmatch-normalization.sh | 2 +-
 urlmatch.c                        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0110-urlmatch-normalization.sh b/t/t0110-urlmatch-normalization.sh
index f99529d838..4dc9fecf72 100755
--- a/t/t0110-urlmatch-normalization.sh
+++ b/t/t0110-urlmatch-normalization.sh
@@ -47,7 +47,7 @@ test_expect_success 'url authority' '
 	test-tool urlmatch-normalization "scheme://@host" &&
 	test-tool urlmatch-normalization "scheme://%00@host" &&
 	! test-tool urlmatch-normalization "scheme://%%@host" &&
-	! test-tool urlmatch-normalization "scheme://host_" &&
+	test-tool urlmatch-normalization "scheme://host_" &&
 	test-tool urlmatch-normalization "scheme://user:pass@host/" &&
 	test-tool urlmatch-normalization "scheme://@host/" &&
 	test-tool urlmatch-normalization "scheme://host/" &&
diff --git a/urlmatch.c b/urlmatch.c
index 33a2ccd306..03ad3f30a9 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -5,7 +5,7 @@
 #define URL_DIGIT "0123456789"
 #define URL_ALPHADIGIT URL_ALPHA URL_DIGIT
 #define URL_SCHEME_CHARS URL_ALPHADIGIT "+.-"
-#define URL_HOST_CHARS URL_ALPHADIGIT ".-[:]" /* IPv6 literals need [:] */
+#define URL_HOST_CHARS URL_ALPHADIGIT ".-_[:]" /* IPv6 literals need [:] */
 #define URL_UNSAFE_CHARS " <>\"%{}|\\^`" /* plus 0x00-0x1F,0x7F-0xFF */
 #define URL_GEN_RESERVED ":/?#[]@"
 #define URL_SUB_RESERVED "!$&'()*+,;="
-- 
2.33.0.1387.g4e339dd0af

