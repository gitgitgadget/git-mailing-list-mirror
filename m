From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] error: save and restore errno
Date: Tue, 18 Nov 2014 20:37:10 -0500
Message-ID: <20141119013710.GA2135@peff.net>
References: <20141119013532.GA861@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sahlberg@google.com, jrnieder@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:37:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquCt-0001Mu-2x
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbaKSBhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:37:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:42051 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754398AbaKSBhM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:37:12 -0500
Received: (qmail 9666 invoked by uid 102); 19 Nov 2014 01:37:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 19:37:12 -0600
Received: (qmail 25405 invoked by uid 107); 19 Nov 2014 01:37:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 20:37:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 20:37:10 -0500
Content-Disposition: inline
In-Reply-To: <20141119013532.GA861@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's common to use error() to return from a function, like:

	if (open(...) < 0)
		return error("open failed");

Unfortunately this may clobber the errno from the open()
call. So we often end up with code like this:

        if (open(...) < 0) {
		int saved_errno = errno;
		error("open failed");
		errno = saved_errno;
		return -1;
	}

which is less nice. Let's teach error() to save and restore
errno in each call, so that the original errno is preserved.
This is slightly less efficient for callers which do not
care, but error code paths are generally not performance
critical anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
It's pretty minor to just handle errno in the callers, but I feel like
I've wanted this at least a dozen times, and it seems like it cannot
possibly hurt (i.e., I imagine there are callers where we _should_ be
doing the errno dance but have not realized it).

 usage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/usage.c b/usage.c
index ed14645..ee44d57 100644
--- a/usage.c
+++ b/usage.c
@@ -142,10 +142,13 @@ void NORETURN die_errno(const char *fmt, ...)
 int error(const char *err, ...)
 {
 	va_list params;
+	int saved_errno = errno;
 
 	va_start(params, err);
 	error_routine(err, params);
 	va_end(params);
+
+	errno = saved_errno;
 	return -1;
 }
 
-- 
2.1.2.596.g7379948
