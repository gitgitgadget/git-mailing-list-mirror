Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9C8205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 14:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759902AbdAKOID (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 09:08:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:37988 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756247AbdAKOIC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 09:08:02 -0500
Received: (qmail 1148 invoked by uid 109); 11 Jan 2017 14:08:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 14:08:01 +0000
Received: (qmail 22157 invoked by uid 111); 11 Jan 2017 14:08:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 09:08:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2017 09:07:58 -0500
Date:   Wed, 11 Jan 2017 09:07:58 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 3/2] vreportf: add prefix to each line
Message-ID: <20170111140758.yyfsc3r3spqpi6es@sigill.intra.peff.net>
References: <20170111140138.5p647xuqpqrej63b@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170111140138.5p647xuqpqrej63b@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 09:01:38AM -0500, Jeff King wrote:

>   [1/2]: Revert "vreportf: avoid intermediate buffer"
>   [2/2]: vreport: sanitize ASCII control chars

We've talked before about repeating the "error:" header for multi-line
messages. The reversion in patch 1 makes this easy to play with, so I
did. I kind of hate it. But here it is, for your viewing pleasure.

-- >8 --
Subject: vreportf: add prefix to each line

Some error and warning messages are multi-line, but we put
the prefix only on the first line. This means that either
the subsequent lines don't have any indication that they're
connected to the original error, or the caller has to make
multiple calls to error() or warning(). And that's not even
possible for die().

Instead, let's put the prefix at the start of each line,
just as advise() does.

Note that this patch doesn't update the tests yet, so it
causes tons of failures. This is just to see what it might
look like.

It's actually kind of ugly.  For instance, a failing test in
t3600 now produces:

   error: the following files have staged content different from both the
   error: file and the HEAD:
   error:     bar.txt
   error:     foo.txt
   error: (use -f to force removal)

which seems a bit aggressive.  It also screws up messages
which indent with tabs (the prefix eats up some of the
tabstop, making the indentation smaller). And the result is
a little harder if you need to cut-and-paste the file lines
(if your terminal lets you triple-click to select a whole
line, now you have this "error:" cruft on the front).

It may be possible to address some of that by using some
other kind of continuation marker (instead of just repeating
the prefix), and expanding initial tabs.

Signed-off-by: Jeff King <peff@peff.net>
---
 usage.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/usage.c b/usage.c
index ad6d2910f..8a1f6ff4e 100644
--- a/usage.c
+++ b/usage.c
@@ -8,18 +8,30 @@
 
 static FILE *error_handle;
 
+static void show_line(FILE *fh, const char *prefix, const char *line, int len)
+{
+	fprintf(fh, "%s%.*s\n", prefix, len, line);
+}
+
 void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	FILE *fh = error_handle ? error_handle : stderr;
+	const char *base;
 	char *p;
 
 	vsnprintf(msg, sizeof(msg), err, params);
+
+	base = msg;
 	for (p = msg; *p; p++) {
-		if (iscntrl(*p) && *p != '\t' && *p != '\n')
+		if (*p == '\n') {
+			show_line(fh, prefix, base, p - base);
+			base = p + 1;
+		} else if (iscntrl(*p) && *p != '\t')
 			*p = '?';
 	}
-	fprintf(fh, "%s%s\n", prefix, msg);
+
+	show_line(fh, prefix, base, p - base);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
-- 
2.11.0.627.gfa6151259

