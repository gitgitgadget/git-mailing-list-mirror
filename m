Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36ACC1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbeGXL4D (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 07:56:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:57296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388318AbeGXL4C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 07:56:02 -0400
Received: (qmail 10873 invoked by uid 109); 24 Jul 2018 10:50:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 10:50:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26397 invoked by uid 111); 24 Jul 2018 10:50:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 06:50:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 06:50:10 -0400
Date:   Tue, 24 Jul 2018 06:50:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] reencode_string: use st_add/st_mult helpers
Message-ID: <20180724105009.GA17165@sigill.intra.peff.net>
References: <20180724104852.GA14638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724104852.GA14638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When converting a string with iconv, if the output buffer
isn't big enough, we grow it. But our growth is done without
any concern for integer overflow. So when we add:

  outalloc = sofar + insz * 2 + 32;

we may end up wrapping outalloc (which is a size_t), and
allocating a too-small buffer. We then manipulate it
further:

  outsz = outalloc - sofar - 1;

and feed outsz back to iconv. If outalloc is wrapped and
smaller than sofar, we'll end up with a small allocation but
feed a very large outsz to iconv, which could result in it
overflowing the buffer.

Can we use this to construct an attack wherein the victim
clones a repository with a very large commit object with an
encoding header, and running "git log" reencodes it into
utf8, causing an overflow?

An attack of this sort is likely impossible in practice.
"sofar" is how many output bytes we've written total, and
"insz" is the number of input bytes remaining. Imagine our
input doubles in size as we output it (which is easy to do
by converting latin1 to utf8, for example), and that we
start with N input bytes. Our initial output buffer also
starts at N bytes, so after the first call we'd have N/2
input bytes remaining (insz), and have written N bytes
(sofar). That means our next allocation will be
(N + N/2 * 2 + 32) bytes, or (2N + 32).

We can therefore overflow a 32-bit size_t with a commit
message that's just under 2^31 bytes, assuming it consists
mostly of "doubling" sequences (e.g., latin1 0xe1 which
becomes utf8 0xc3 0xa1).

But we'll never make it that far with such a message. We'll
be spending 2^31 bytes on the original string. And our
initial output buffer will also be 2^31 bytes. Which is not
going to succeed on a system with a 32-bit size_t, since
there will be other things using the address space, too. The
initial malloc will fail.

If we imagine instead that we can triple the size when
converting, then our second allocation becomes
(N + 2/3N * 2 + 32), or (7/3N + 32). That still requires two
allocations of 3/7 of our address space (6/7 of the total)
to succeed.

If we imagine we can quadruple, it becomes (5/2N + 32); we
need to be able to allocate 4/5 of the address space to
succeed.

This might start to get plausible. But is it possible to get
a 4-to-1 increase in size? Probably if you're converting to
some obscure encoding. But since git defaults to utf8 for
its output, that's the likely destination encoding for an
attack. And while there are 4-character utf8 sequences, it's
unlikely that you'd be able find a single-byte source
sequence in any encoding.

So this is certainly buggy code which should be fixed, but
it is probably not a useful attack vector.

Signed-off-by: Jeff King <peff@peff.net>
---
 utf8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index d55e20c641..a2fd24c70a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -477,7 +477,7 @@ char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, int *outs
 	iconv_ibp cp;
 
 	outsz = insz;
-	outalloc = outsz + 1; /* for terminating NUL */
+	outalloc = st_add(outsz, 1); /* for terminating NUL */
 	out = xmalloc(outalloc);
 	outpos = out;
 	cp = (iconv_ibp)in;
@@ -497,7 +497,7 @@ char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, int *outs
 			 * converting the rest.
 			 */
 			sofar = outpos - out;
-			outalloc = sofar + insz * 2 + 32;
+			outalloc = st_add3(sofar, st_mult(insz, 2), 32);
 			out = xrealloc(out, outalloc);
 			outpos = out + sofar;
 			outsz = outalloc - sofar - 1;
-- 
2.18.0.542.g2bf2fc4f7e

