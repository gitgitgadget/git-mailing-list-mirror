Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69260208C4
	for <e@80x24.org>; Sat, 12 Aug 2017 10:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdHLKCy (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 06:02:54 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:52927 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdHLKCx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 06:02:53 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 12 Aug 2017 12:02:51 +0200
  id 0000000000000012.00000000598ED24B.00001D97
Date:   Sat, 12 Aug 2017 12:02:52 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
Message-ID: <20170812100252.bhbgg5jjlom7dfl2@ruderich.org>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
 <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
 <20170811075059.nn6lru7uy6s6vpza@ruderich.org>
 <e8e7f028-6e23-368c-484f-9f069bae5dc8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8e7f028-6e23-368c-484f-9f069bae5dc8@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 10:52:51AM +0200, René Scharfe wrote:
> Am 11.08.2017 um 09:50 schrieb Simon Ruderich:
>> On Thu, Aug 10, 2017 at 10:56:40PM +0200, René Scharfe wrote:
>>> getdelim(3) returns -1 at the end of the file and if it encounters an
>>> error, but sets errno only in the latter case.  Set errno to zero before
>>> calling it to avoid misdiagnosing an out-of-memory condition due to a
>>> left-over value from some other function call.
>>
>> getdelim(3p) doesn't explicitly forbid changing the errno on EOF:
>>
>>      If no characters were read, and the end-of-file indicator for
>>      the stream is set, or if the stream is at end-of-file, the
>>      end-of-file indicator for the stream shall be set and the
>>      function shall return −1. If an error occurs, the error
>>      indicator for the stream shall be set, and the function shall
>>      return −1 and set errno to indicate the error.
>
> [snip]
>
>> I don't think that it matters in practice, but the "most" correct
>> way to handle this would be to check if feof(3) is true to check
>> for the non-errno case.
>
> Only if errors at EOF are guaranteed to be impossible.  Imagine
> getdelim being able to read to the end and then failing to get memory
> for the final NUL.  Other scenarios may be possible.

Good point. Instead of feof(3), checking ferror(3) should handle
that properly. It's guaranteed to be set by getdelim for any
error.

For example like this (as replacement for the original patch):

diff --git i/strbuf.c w/strbuf.c
index 89d22e3b0..831be21ce 100644
--- i/strbuf.c
+++ w/strbuf.c
@@ -495,7 +495,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	 * memory and retry, but that's unlikely to help for a malloc small
 	 * enough to hold a single line of input, anyway.
 	 */
-	if (errno == ENOMEM)
+	if (ferror(fp) && errno == ENOMEM)
 		die("Out of memory, getdelim failed");
 
 	/*

An edge case is if the error indicator was already set before
calling getdelim() and the errno was already set to ENOMEM. This
could be fixed by checking ferror() before calling getdelim, but
I'm not sure if that's necessary:

diff --git i/strbuf.c w/strbuf.c
index 89d22e3b0..4d394bb91 100644
--- i/strbuf.c
+++ w/strbuf.c
@@ -468,7 +468,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	ssize_t r;
 
-	if (feof(fp))
+	if (feof(fp) || ferror(fp))
 		return EOF;
 
 	strbuf_reset(sb);

Regards
Simon
-- 
+ Privatsphäre ist notwendig
+ Ich verwende GnuPG http://gnupg.org
+ Öffentlicher Schlüssel: 0x92FEFDB7E44C32F9
