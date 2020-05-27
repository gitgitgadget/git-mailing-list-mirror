Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF9DC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508ED207D3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE0XQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 19:16:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:58302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0XQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 19:16:29 -0400
Received: (qmail 24687 invoked by uid 109); 27 May 2020 23:16:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 23:16:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9323 invoked by uid 111); 27 May 2020 23:16:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 19:16:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 19:16:28 -0400
From:   Jeff King <peff@peff.net>
To:     Zach Riggle <zachriggle@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep --show-function treats GOTO labels as function names
Message-ID: <20200527231628.GC546534@coredump.intra.peff.net>
References: <CAMP9c5k=Ci8eQyOdzW7a-sssgp9g9TJ+rxAAPF3YLDCr7t6wrg@mail.gmail.com>
 <20200527224824.GA546534@coredump.intra.peff.net>
 <CAMP9c5=kRAfKqfWL4AJg1m9c-3OwG1Vv=vBaiOhsD6abjtXH=A@mail.gmail.com>
 <CAMP9c5m65hBXKgP76iUCGe79c_s5p106K6iwzJyPmm7fCsc7LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP9c5m65hBXKgP76iUCGe79c_s5p106K6iwzJyPmm7fCsc7LA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 06:04:21PM -0500, Zach Riggle wrote:

> It looks like that does the trick for "goto" labels, but there are
> also some issue on function name parsing with attributes when they are
> split onto a second line.
> 
> $ cat attr.cpp
> int main() __attribute__ ( (no_sanitize("alignment")) )
> {
>     FOO
> }
> $ git grep --no-index --show-function -e FOO attr.cpp
> attr.cpp=2=__attribute__ ( (no_sanitize("alignment")) )
> attr.cpp:4:    FOO

From your output, I assume the problematic input actually splits the
attribute onto the second line?

I agree that's not ideal. The baked-in regex we use for matching C
function lines is:

  $ git grep -nA4 cpp userdiff.c
  userdiff.c:173:PATTERNS("cpp",
  userdiff.c-174-  /* Jump targets or access declarations */
  userdiff.c-175-  "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])\n"
  userdiff.c-176-  /* functions/methods, variables, and compounds at top level */
  userdiff.c-177-  "^((::[[:space:]]*)?[A-Za-z_].*)$",

so we mistake it for a function name. I'm not sure how easy it is to do
better, though. We can add a line like:

diff --git a/userdiff.c b/userdiff.c
index 1df884ef0b..de8e1a3d72 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -173,6 +173,8 @@ PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 PATTERNS("cpp",
 	 /* Jump targets or access declarations */
 	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])\n"
+	 /* skip over attribute declarations are on their own lines */
+	 "!((::[[:space:]]*))?__attribute__\n"
 	 /* functions/methods, variables, and compounds at top level */
 	 "^((::[[:space:]]*)?[A-Za-z_].*)$",
 	 /* -- */

which works for your case, but would regress:

  __attribute__((whatever) int main()
  {
  FOO
  }

Handling both means skipping past the attribute, not counting it as a
function, and then checking for a plausible function afterwards. That's
a much trickier regex. But if you come up with something that works, I
think we'd be happy to take a patch. :)

You can also just override this regex via config for your personal use.
If you know you'd never use that style, then the problem becomes much
easier.

-Peff
