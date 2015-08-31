From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] fast-import: switch crash-report date to iso8601
Date: Mon, 31 Aug 2015 16:47:16 -0400
Message-ID: <20150831204716.GA10338@sigill.intra.peff.net>
References: <20150831204444.GA4385@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:47:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVzA-0007SN-BD
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbbHaUrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:47:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:52658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752033AbbHaUrT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:47:19 -0400
Received: (qmail 26024 invoked by uid 102); 31 Aug 2015 20:47:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 15:47:19 -0500
Received: (qmail 27053 invoked by uid 107); 31 Aug 2015 20:47:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 16:47:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2015 16:47:16 -0400
Content-Disposition: inline
In-Reply-To: <20150831204444.GA4385@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276939>

When fast-import emits a crash report, it does so in the
user's local timezone. But because we omit the timezone
completely for DATE_LOCAL, a reader of the report does not
immediately know which time zone was used. Let's switch this
to ISO8601 instead, which includes the time zone.

This does mean we will show the time in UTC, but that's not
a big deal. A crash report like this will either be looked
at immediately (in which case nobody even looks at the
timestamp), or it will be passed along to a developer to
debug, in which case the original timezone is less likely to
be of interest.

Signed-off-by: Jeff King <peff@peff.net>
---
After patch 2/2, we could make this iso8601-local. But frankly, I have a
hard time believing anybody really cares about this format.

 fast-import.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 6c7c3c9..adcbfc6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -424,7 +424,7 @@ static void write_crash_report(const char *err)
 	fprintf(rpt, "fast-import crash report:\n");
 	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
 	fprintf(rpt, "    parent process     : %"PRIuMAX"\n", (uintmax_t) getppid());
-	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_MODE(LOCAL)));
+	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_MODE(ISO8601)));
 	fputc('\n', rpt);
 
 	fputs("fatal: ", rpt);
-- 
2.5.1.739.g7891f6b
