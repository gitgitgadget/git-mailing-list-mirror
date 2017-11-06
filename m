Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38D4202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 10:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbdKFKbe (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 05:31:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:47438 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751054AbdKFKbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 05:31:33 -0500
Received: (qmail 19616 invoked by uid 109); 6 Nov 2017 10:31:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Nov 2017 10:31:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19648 invoked by uid 111); 6 Nov 2017 10:31:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Nov 2017 05:31:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Nov 2017 05:31:26 -0500
Date:   Mon, 6 Nov 2017 05:31:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Cc:     git@vger.kernel.org
Subject: Re: git grep -P fatal: pcre_exec failed with error code -8
Message-ID: <20171106103125.fwtrxv6zycrbihcv@sigill.intra.peff.net>
References: <635a9bd4-2aa9-4415-2756-b82370c55798@aegee.org>
 <20171105021623.yi46w2awwy7p3q6e@sigill.intra.peff.net>
 <4e2bc579-429f-9927-4502-5929e5235740@aegee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e2bc579-429f-9927-4502-5929e5235740@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 05, 2017 at 10:41:17AM +0100, Дилян Палаузов wrote:

> I understand that the PCRE's stack can get exhausted for some files, but in
> such cases, git grep shall proceed with the other files, and print at the
> end/stderr for which files the pattern was not applied.  Such behaviour
> would be more usefull than the current one.

Yes, I had a similar thought. It does feel a little funny for us to
basically treat an error as "no match" for non-interactive use, but then
the current behavior works out to be more or less the same (we return an
error code which most shell scripts would interpret as failure).

IOW, I think something like this is probably the right direction:

diff --git a/grep.c b/grep.c
index ce6a48e634..2c152e5908 100644
--- a/grep.c
+++ b/grep.c
@@ -427,7 +427,7 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 	}
 
 	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
-		die("pcre_exec failed with error code %d", ret);
+		warning("pcre_exec failed with error code %d", ret);
 	if (ret > 0) {
 		ret = 0;
 		match->rm_so = ovector[0];

but possibly:

  1. It would be nice to report the filename that we couldn't match on.
     But we don't know it at this level of the code (and it might not be
     a file at all that we are matching). So probably we'd want to pass
     the error much further up the call stack. This is tricky as there
     are multiple regex libraries we can use, and the return value gets
     normalized to 1/0 for hit/not-hit long before we get as far as
     something that knows the filename.

     We might need to do something invasive like adding an extra
     parameter to hold the error message, and passing it through the
     whole stack.

  2. We should still try to exit with an exit code other than "1" to
     indicate we hit an error besides "no lines were found".

  3. Other regex libraries might need similar treatment. Probably
     pcre2match() needs it. It doesn't look like regexec() can ever
     return an error besides REG_NOMATCH.

-Peff
