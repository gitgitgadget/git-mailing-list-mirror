Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C503C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8FB2084D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDJTuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:50:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:40090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726203AbgDJTuI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 15:50:08 -0400
Received: (qmail 7681 invoked by uid 109); 10 Apr 2020 19:50:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 19:50:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2281 invoked by uid 111); 10 Apr 2020 20:00:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 16:00:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 15:50:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] config: reject parsing of files over INT_MAX
Message-ID: <20200410195007.GF1363756@coredump.intra.peff.net>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410194211.GA1363484@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the last few commits have made it possible for the config parser
to handle config files up to the limits of size_t, the rest of the code
isn't really ready for this. In particular, we often feed the keys as
strings into printf "%s" format specifiers. And because the printf
family of functions must return an int to specify the result, they
complain. Here are two concrete examples (using glibc; we're in
uncharted territory here so results may vary):

Generate a gigantic .gitmodules file like this:

   git submodule add /some/other/repo foo
   {
           printf '[submodule "'
           perl -e 'print "a" x 2**31'
	   echo '"]path = foo'
   } >.gitmodules
   git commit -m 'huge gitmodule'

then try this:

   $ git show
   BUG: strbuf.c:397: your vsnprintf is broken (returned -1)

The problem is that we end up calling:

   strbuf_addf(&sb, "submodule.%s.ignore", submodule_name);

which relies on vsnprintf(), and that function has no way to report back
a size larger than INT_MAX.

Taking that same file, try this:

  git config --file=.gitmodules --list --name-only

On my system it produces an output with exactly 4GB of spaces. I
confirmed in a debugger that we reach the config callback with the key
intact: it's 2147483663 bytes and full of a's. But when we print it with
this call:

  printf("%s%c", key_, term);

we just get the spaces.

So given the fact that these are insane cases which we have no need to
support, the weird behavior from feeding the results to printf even if
the code is careful, and the possibility of uncareful code introducing
its own integer truncation issues, let's just declare INT_MAX as a limit
for parsing config files.

We'll enforce the limit in get_next_char(), which generalizes over all
sources (blobs, files, etc) and covers any element we're parsing
(whether section, key, value, etc). For simplicity, the limit is over
the length of the _whole_ file, so you couldn't have two 1GB values in
the same file. This should be perfectly fine, as the expected size for
config files is generally kilobytes at most.

With this patch both cases above will yield:

  fatal: bad config line 1 in file .gitmodules

That's not an amazing error message, but the parser isn't set up to
provide specific messages (it just breaks out of the parsing loop and
gives that generic error even if see a syntactic issue). And we really
wouldn't expect to see this case outside of somebody maliciously probing
the limits of the config system.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/config.c b/config.c
index 1c25c94863..8db9c77098 100644
--- a/config.c
+++ b/config.c
@@ -37,6 +37,7 @@ struct config_source {
 	enum config_error_action default_error_action;
 	int linenr;
 	int eof;
+	size_t total_len;
 	struct strbuf value;
 	struct strbuf var;
 	unsigned subsection_case_sensitive : 1;
@@ -524,6 +525,19 @@ static int get_next_char(void)
 			c = '\r';
 		}
 	}
+
+	if (c != EOF && ++cf->total_len > INT_MAX) {
+		/*
+		 * This is an absurdly long config file; refuse to parse
+		 * further in order to protect downstream code from integer
+		 * overflows. Note that we can't return an error specifically,
+		 * but we can mark EOF and put trash in the return value,
+		 * which will trigger a parse error.
+		 */
+		cf->eof = 1;
+		return 0;
+	}
+
 	if (c == '\n')
 		cf->linenr++;
 	if (c == EOF) {
@@ -1540,6 +1554,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
 	top->prev = cf;
 	top->linenr = 1;
 	top->eof = 0;
+	top->total_len = 0;
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
 	cf = top;
-- 
2.26.0.414.ge3a6455e3d
