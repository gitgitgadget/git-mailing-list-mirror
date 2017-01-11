Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA6E205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 14:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967105AbdAKOC2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 09:02:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:37985 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967099AbdAKOC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 09:02:28 -0500
Received: (qmail 863 invoked by uid 109); 11 Jan 2017 14:02:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 14:02:27 +0000
Received: (qmail 22107 invoked by uid 111); 11 Jan 2017 14:03:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 09:03:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2017 09:02:23 -0500
Date:   Wed, 11 Jan 2017 09:02:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] vreport: sanitize ASCII control chars
Message-ID: <20170111140223.7irjqrtz77kaa5r7@sigill.intra.peff.net>
References: <20170111140138.5p647xuqpqrej63b@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170111140138.5p647xuqpqrej63b@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our error() and die() calls may report messages with
arbitrary data (e.g., filenames or even data from a remote
server). Let's make it harder to cause confusion with
mischievous filenames. E.g., try:

  git rev-parse "$(printf "\rfatal: this argument is too sneaky")" --

or

  git rev-parse "$(printf "\x1b[5mblinky\x1b[0m")" --

Let's block all ASCII control characters, with the exception
of TAB and LF. We use both in our own messages (and we are
necessarily sanitizing the complete output of snprintf here,
as we do not have access to the individual varargs). And TAB
and LF are unlikely to cause confusion (you could put
"\nfatal: sneaky\n" in your filename, but it would at least
not _cover up_ the message leading to it, unlike "\r").

We'll replace the characters with a "?", which is similar to
how "ls" behaves. It might be nice to do something less
lossy, like converting them to "\x" hex codes. But replacing
with a single character makes it easy to do in-place and
without worrying about length limitations. This feature
should kick in rarely enough that the "?" marks are almost
never seen.

We'll leave high-bit characters as-is, as they are likely to
be UTF-8 (though there may be some Unicode mischief you
could cause, which may require further patches).

Signed-off-by: Jeff King <peff@peff.net>
---
 usage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/usage.c b/usage.c
index b1cbe6799..ad6d2910f 100644
--- a/usage.c
+++ b/usage.c
@@ -12,7 +12,13 @@ void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	FILE *fh = error_handle ? error_handle : stderr;
+	char *p;
+
 	vsnprintf(msg, sizeof(msg), err, params);
+	for (p = msg; *p; p++) {
+		if (iscntrl(*p) && *p != '\t' && *p != '\n')
+			*p = '?';
+	}
 	fprintf(fh, "%s%s\n", prefix, msg);
 }
 
-- 
2.11.0.627.gfa6151259
