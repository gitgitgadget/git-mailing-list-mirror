Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D822018E
	for <e@80x24.org>; Fri,  5 Aug 2016 07:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbcHEH5X (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 03:57:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:55142 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759530AbcHEH4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 03:56:12 -0400
Received: (qmail 10286 invoked by uid 102); 5 Aug 2016 07:56:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 03:56:05 -0400
Received: (qmail 23995 invoked by uid 107); 5 Aug 2016 07:56:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 03:56:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 03:56:00 -0400
Date:	Fri, 5 Aug 2016 03:56:00 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 3/7] trace: use warning() for printing trace errors
Message-ID: <20160805075600.dzt4hfvcdgruo2ef@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
 <20160803225826.hlr273h4cy2hcfyk@sigill.intra.peff.net>
 <xmqqk2fw1d41.fsf@gitster.mtv.corp.google.com>
 <20160804212157.cn7ecyxcbyf4okd7@sigill.intra.peff.net>
 <xmqqy44cz0k6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy44cz0k6.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 02:28:09PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I wondered if that would then let us drop set_warn_routine(), but it
> > looks like there are other warning() calls it cares about. So that would
> > invalidate the last paragraph here, though I still think converting the
> > trace errors to warning() is a reasonable thing to do.
> 
> Yes.  That is why tonight's pushout will have this series in 'jch'
> (that is a point on a linear history between 'master' and 'pu') and
> tentatively ejects cc/apply-am topic out of 'pu', expecting it to be
> rerolled.

Here's a replacement patch 3. Same code, but it clarifies the
warn_routine situation in the commit message.

-- >8 --
Subject: [PATCH] trace: use warning() for printing trace errors

Right now we just fprintf() straight to stderr, which can
make the output hard to distinguish. It would be helpful to
give it one of our usual prefixes like "error:", "warning:",
etc.

It doesn't make sense to use error() here, as the trace code
is "optional" debugging code. If something goes wrong, we
should warn the user, but saying "error" implies the actual
git operation had a problem. So warning() is the only sane
choice.

Note that this does end up calling warn_routine() to do the
formatting. This is probably a good thing, since they are
clearly trying to hook messages before they make it to
stderr. However, it also means that in theory somebody who
tries to trace from their warn_routine() could cause a loop.
This seems rather unlikely in practice (we've never even
overridden the default warn_builtin routine before, and
recent discussions to do so would just install a noop
routine).

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/trace.c b/trace.c
index bdbe149..6a77e4d 100644
--- a/trace.c
+++ b/trace.c
@@ -61,9 +61,8 @@ static int get_trace_fd(struct trace_key *key)
 	else if (is_absolute_path(trace)) {
 		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
 		if (fd == -1) {
-			fprintf(stderr,
-				"Could not open '%s' for tracing: %s\n"
-				"Defaulting to tracing on stderr...\n",
+			warning("Could not open '%s' for tracing: %s\n"
+				"Defaulting to tracing on stderr...",
 				trace, strerror(errno));
 			key->fd = STDERR_FILENO;
 		} else {
@@ -71,10 +70,10 @@ static int get_trace_fd(struct trace_key *key)
 			key->need_close = 1;
 		}
 	} else {
-		fprintf(stderr, "What does '%s' for %s mean?\n"
+		warning("What does '%s' for %s mean?\n"
 			"If you want to trace into a file, then please set "
 			"%s to an absolute pathname (starting with /).\n"
-			"Defaulting to tracing on stderr...\n",
+			"Defaulting to tracing on stderr...",
 			trace, key->key, key->key);
 		key->fd = STDERR_FILENO;
 	}
@@ -135,7 +134,7 @@ static int prepare_trace_line(const char *file, int line,
 static void trace_write(struct trace_key *key, const void *buf, unsigned len)
 {
 	if (write_in_full(get_trace_fd(key), buf, len) < 0)
-		fprintf(stderr, "%s: write error (%s)\n", err_msg, strerror(errno));
+		warning("%s: write error (%s)", err_msg, strerror(errno));
 }
 
 void trace_verbatim(struct trace_key *key, const void *buf, unsigned len)
-- 
2.9.2.707.g48ee8b7

