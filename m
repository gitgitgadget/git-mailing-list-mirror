From: Jeff King <peff@peff.net>
Subject: [PATCH 2/9] git-compat-util: add fallbacks for unlocked stdio
Date: Thu, 16 Apr 2015 04:48:45 -0400
Message-ID: <20150416084844.GB17938@peff.net>
References: <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 10:48:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YifTh-0000YC-UV
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 10:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbbDPIsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 04:48:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:46091 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933487AbbDPIsr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 04:48:47 -0400
Received: (qmail 21549 invoked by uid 102); 16 Apr 2015 08:48:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 03:48:47 -0500
Received: (qmail 23416 invoked by uid 107); 16 Apr 2015 08:49:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:49:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 04:48:45 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267263>

POSIX.1-2001 specifies some functions for optimizing the
locking out of tight getc() loops. Not all systems are
POSIX, though, and even not all POSIX systems are required
to implement these functions. We can check for the
feature-test macro to see if they are available, and if not,
provide a noop implementation.

There's no Makefile knob here, because we should just detect
this automatically. If there are very bizarre systems, we
may need to add one, but it's not clear yet in which
direction:

  1. If a system defines _POSIX_THREAD_SAFE_FUNCTIONS but
     these functions are missing or broken, we would want a
     knob to manually turn them off.

  2. If a system has these functions but does not define
     _POSIX_THREAD_SAFE_FUNCTIONS, we would want a knob to
     manually turn them on.

We can add such a knob when we find a real-world system that
matches this.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index bc8fc8c..685a0a4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -883,4 +883,10 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 # define SHELL_PATH "/bin/sh"
 #endif
 
+#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
+#define flockfile(fh)
+#define funlockfile(fh)
+#define getc_unlocked(fh) getc(fh)
+#endif
+
 #endif
-- 
2.4.0.rc2.384.g7297a4a
