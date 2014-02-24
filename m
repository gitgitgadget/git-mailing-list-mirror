From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] date: check date overflow against time_t
Date: Mon, 24 Feb 2014 02:39:45 -0500
Message-ID: <20140224073945.GC9969@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 08:40:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHq95-0005x3-FV
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 08:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbaBXHjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 02:39:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:55859 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751762AbaBXHjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 02:39:47 -0500
Received: (qmail 14448 invoked by uid 102); 24 Feb 2014 07:39:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 01:39:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 02:39:45 -0500
Content-Disposition: inline
In-Reply-To: <20140224073348.GA20221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242568>

When we check whether a timestamp has overflowed, we check
only against ULONG_MAX, meaning that strtoul has overflowed.
However, we also feed these timestamps to system functions
like gmtime, which expect a time_t. On many systems, time_t
is actually smaller than "unsigned long" (e.g., because it
is signed), and we would overflow when using these
functions.  We don't know the actual size or signedness of
time_t, but we can easily check for truncation with a simple
assignment.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |  1 +
 date.c  | 17 +++++++++++++++++
 fsck.c  |  2 +-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index dc040fb..e405598 100644
--- a/cache.h
+++ b/cache.h
@@ -959,6 +959,7 @@ void datestamp(char *buf, int bufsize);
 unsigned long approxidate_careful(const char *, int *);
 unsigned long approxidate_relative(const char *date, const struct timeval *now);
 enum date_mode parse_date_format(const char *format);
+int date_overflows(unsigned long date);
 
 #define IDENT_STRICT	       1
 #define IDENT_NO_DATE	       2
diff --git a/date.c b/date.c
index 83b4166..90b28f7 100644
--- a/date.c
+++ b/date.c
@@ -1113,3 +1113,20 @@ unsigned long approxidate_careful(const char *date, int *error_ret)
 	gettimeofday(&tv, NULL);
 	return approxidate_str(date, &tv, error_ret);
 }
+
+int date_overflows(unsigned long t)
+{
+	time_t sys;
+
+	/* If we overflowed our unsigned long, that's bad... */
+	if (t == ULONG_MAX)
+		return 1;
+
+	/*
+	 * ...but we also are going to feed the result to system
+	 * functions that expect time_t, which is often "signed long".
+	 * Make sure that we fit into time_t, as well.
+	 */
+	sys = t;
+	return t != sys || (t < 1) != (sys < 1);
+}
diff --git a/fsck.c b/fsck.c
index 760e072..64bf279 100644
--- a/fsck.c
+++ b/fsck.c
@@ -266,7 +266,7 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
 	(*ident)++;
 	if (**ident == '0' && (*ident)[1] != ' ')
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - zero-padded date");
-	if (strtoul(*ident, &end, 10) == ULONG_MAX)
+	if (date_overflows(strtoul(*ident, &end, 10)))
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - date causes integer overflow");
 	if (end == *ident || *end != ' ')
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad date");
-- 
1.8.5.2.500.g8060133
