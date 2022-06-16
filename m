Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F5FC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 04:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349153AbiFPExU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiFPExS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 00:53:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004A237D6
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 21:53:16 -0700 (PDT)
Received: (qmail 12405 invoked by uid 109); 16 Jun 2022 04:53:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jun 2022 04:53:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 16 Jun 2022 00:53:15 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 11/11] bug_fl(): add missing `va_end()` call
Message-ID: <Yqq3O5hykBecoVKQ@coredump.intra.peff.net>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
 <d674aefa78bdb6d255e40af2f308abf8a87a593a.1655336146.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d674aefa78bdb6d255e40af2f308abf8a87a593a.1655336146.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 11:35:45PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> According to the manual:
> 
> 	Each invocation of va_copy() must be matched by a corresponding
> 	invocation of va_end() in the  same function.
> 
> Note: There is another instance of `va_copy()` in `usage.c` that is
> missing a `va_end()` call, in `BUG_vfl()`. It does not matter there,
> though, because that function either `exit()`s or `abort()`s, anyway.
> 
> Reported by Coverity.

This was introduced by the recent 0cc05b044f (usage.c: add a non-fatal
bug() function to go with BUG(), 2022-06-02). But there's a much worse
bug in the same function. The code introduced by that patch does:

  va_list ap, cp;
  [...]
  va_copy(cp, ap);
  va_start(ap, fmt);

So "cp" is copied from "ap" before we have actually initialized "ap".
It's surprising that this works at all. The two lines should be flipped.

IMHO, since we're in the actual varargs function itself, it would be
simpler to just bracket each use with start/end, rather than copying,
like:

diff --git a/usage.c b/usage.c
index 79900d0287..56e29d6cd6 100644
--- a/usage.c
+++ b/usage.c
@@ -334,15 +334,17 @@ NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 int bug_called_must_BUG;
 void bug_fl(const char *file, int line, const char *fmt, ...)
 {
-	va_list ap, cp;
+	va_list ap;
 
 	bug_called_must_BUG = 1;
 
-	va_copy(cp, ap);
 	va_start(ap, fmt);
 	BUG_vfl_common(file, line, fmt, ap);
 	va_end(ap);
-	trace2_cmd_error_va(fmt, cp);
+
+	va_start(ap, fmt);
+	trace2_cmd_error_va(fmt, ap);
+	va_end(ap);
 }
 
 #ifdef SUPPRESS_ANNOTATED_LEAKS

but I am happy with any solution that is correct. :)

-Peff
