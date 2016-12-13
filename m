Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3652042F
	for <e@80x24.org>; Tue, 13 Dec 2016 12:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbcLMM3A (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 07:29:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:55646 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcLMM27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 07:28:59 -0500
Received: (qmail 32306 invoked by uid 109); 13 Dec 2016 12:28:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 12:28:58 +0000
Received: (qmail 14010 invoked by uid 111); 13 Dec 2016 12:29:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 07:29:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 07:28:54 -0500
Date:   Tue, 13 Dec 2016 07:28:54 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     git@vger.kernel.org, gitter.spiros@gmail.com
Subject: Re: [RFC/PATCH] Makefile: add cppcheck target
Message-ID: <20161213122854.pphyp342tstxbbqe@sigill.intra.peff.net>
References: <20161213092225.15299-1-judge.packham@gmail.com>
 <20161213121510.5o5axuwzztbxcvfd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161213121510.5o5axuwzztbxcvfd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 07:15:10AM -0500, Jeff King wrote:

> I think these last two are a good sign that we need to be feeding the
> list of source files to cppcheck. I tried your patch and it also started
> looking in t/perf/build, which are old versions of git built to serve
> the performance-testing suite.
> 
> See the way that the "tags" target is handled for a possible approach.

Maybe something like this:

diff --git a/Makefile b/Makefile
index 8b5976d88..e7684ae63 100644
--- a/Makefile
+++ b/Makefile
@@ -2638,4 +2638,6 @@ cover_db_html: cover_db
 .PHONY: cppcheck
 
 cppcheck:
-	cppcheck --force --quiet --inline-suppr $(CPPCHECK_ADD) .
+	$(FIND_SOURCE_FILES) |\
+	grep -v ^t/t |\
+	xargs cppcheck --force --quiet --inline-suppr $(CPPCHECK_ADD)

> My main complaint with any static checker is how we can handle false
> positives. [...]

Here's what that generates on my machine, with annotations:

[builtin/am.c:766]: (error) Resource leak: in

  Correct.

[builtin/notes.c:260]: (error) Memory pointed to by 'buf' is freed twice.
[builtin/notes.c:264]: (error) Memory pointed to by 'buf' is freed twice.

  Nope. It appears not to understand that die() does not return.

[builtin/rev-list.c:391]: (error) Uninitialized variable: reaches
[builtin/rev-list.c:391]: (error) Uninitialized variable: all

  These are "int foo = foo" (which is ugly, and maybe we can get rid of
  if compilers have gotten smart enough to figure it out).

[compat/nedmalloc/malloc.c.h:4646]: (error) Memory leak: mem

  Hard to tell, but I think this is wrong and is confused by pointer
  arithmetic on the malloc chunks.

[compat/regex/regcomp.c:3086]: (error) Memory leak: sbcset

  Nope, this return is hit only when sbcset is NULL. The tool is
  presumably confused by a conditional hidden inside a macro.

[compat/regex/regcomp.c:3634]: (error) Memory leak: sbcset
[compat/regex/regcomp.c:3086]: (error) Memory leak: mbcset
[compat/regex/regcomp.c:3634]: (error) Memory leak: mbcset

  I didn't look at these, but presumably similar.

[compat/regex/regcomp.c:2802]: (error) Uninitialized variable: table_size
[compat/regex/regcomp.c:2805]: (error) Uninitialized variable: table_size

  Not sure, but it looks like this function declares another inline
  function inside its scope, and that confuses the tool.

[compat/regex/regcomp.c:532]: (error) Memory leak: fastmap

  Nope. Tool seems confused by hiding free() in a macro.

[contrib/examples/builtin-fetch--tool.c:420]: (error) Uninitialized variable: lrr_count
[contrib/examples/builtin-fetch--tool.c:427]: (error) Uninitialized variable: lrr_list

  More "int foo = foo". Might be worth omitting contrib/examples (or
  possibly contrib/ entirely) from the check.

[t/helper/test-hashmap.c:125]: (error) Memory leak: entries
[t/helper/test-hashmap.c:125]: (error) Memory leak: hashes

  Correct (but unimportant).

So I think it is capable of finding real problems, but I think we'd need
some way of squelching false positives, preferably in a way that carries
forward as the code changes (so not just saying "foo.c:1234 is a false
positive", which will break when it becomes "foo.c:1235").

-Peff
