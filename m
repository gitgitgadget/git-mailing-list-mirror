Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF20B1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbcHCXIF (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:08:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:54439 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932995AbcHCXID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:08:03 -0400
Received: (qmail 22808 invoked by uid 102); 3 Aug 2016 23:00:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:00:26 -0400
Received: (qmail 8006 invoked by uid 107); 3 Aug 2016 23:00:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:00:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 19:00:23 -0400
Date:	Wed, 3 Aug 2016 19:00:23 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: [PATCH 4/7] trace: cosmetic fixes for error messages
Message-ID: <20160803230022.drw4kcwgheeqn3xr@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The error messages for the trace code are often multi-line;
the first line gets a nice "warning:", but the rest are
left-aligned. Let's give them an indentation to make sure
they stand out as a unit.

While we're here, let's also downcase the first letter of
each error (our usual style), and break up a long line of
advice (since we're already using multiple lines, one more
doesn't hurt).

We also replace "What does 'foo' for GIT_TRACE mean?". While
cute, it's probably a good idea to give more context, and
follow our usual styles. So it's now "unknown trace value
for 'GIT_TRACE': foo".

Signed-off-by: Jeff King <peff@peff.net>
---
I went with an indent the size of "warning: ", because that string does
not actually get translated (it seems like it probably should, though).

I think it would be nicer to still to print:

 warning: first line
 warning: second line

etc. We do that for "advice:", but not the rest of the vreportf
functions. It might be nice to do that, but we'd have to go back to
printing into a buffer (since we can't break up the incoming format
string that we feed to fprintf).

 trace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/trace.c b/trace.c
index 6a77e4d..4d68eb5 100644
--- a/trace.c
+++ b/trace.c
@@ -61,8 +61,8 @@ static int get_trace_fd(struct trace_key *key)
 	else if (is_absolute_path(trace)) {
 		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
 		if (fd == -1) {
-			warning("Could not open '%s' for tracing: %s\n"
-				"Defaulting to tracing on stderr...",
+			warning("could not open '%s' for tracing: %s\n"
+				"         Defaulting to tracing on stderr...",
 				trace, strerror(errno));
 			key->fd = STDERR_FILENO;
 		} else {
@@ -70,11 +70,11 @@ static int get_trace_fd(struct trace_key *key)
 			key->need_close = 1;
 		}
 	} else {
-		warning("What does '%s' for %s mean?\n"
-			"If you want to trace into a file, then please set "
-			"%s to an absolute pathname (starting with /).\n"
-			"Defaulting to tracing on stderr...",
-			trace, key->key, key->key);
+		warning("unknown trace value for '%s': %s\n"
+			"         If you want to trace into a file, then please set %s\n"
+			"         to an absolute pathname (starting with /)\n"
+			"         Defaulting to tracing on stderr...",
+			key->key, trace, key->key);
 		key->fd = STDERR_FILENO;
 	}
 
@@ -93,7 +93,7 @@ void trace_disable(struct trace_key *key)
 	key->need_close = 0;
 }
 
-static const char err_msg[] = "Could not trace into fd given by "
+static const char err_msg[] = "could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
 static int prepare_trace_line(const char *file, int line,
-- 
2.9.2.670.g42e63de

