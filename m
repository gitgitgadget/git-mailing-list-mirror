From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] git-compat-util: add xstrdup_or_null helper
Date: Mon, 12 Jan 2015 20:57:37 -0500
Message-ID: <20150113015736.GA18986@peff.net>
References: <20150113015427.GA5497@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:57:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAqjm-0004x5-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 02:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbbAMB5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 20:57:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:33593 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751952AbbAMB5h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 20:57:37 -0500
Received: (qmail 19181 invoked by uid 102); 13 Jan 2015 01:57:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 19:57:37 -0600
Received: (qmail 22670 invoked by uid 107); 13 Jan 2015 01:57:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 20:57:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 20:57:37 -0500
Content-Disposition: inline
In-Reply-To: <20150113015427.GA5497@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262316>

It's a common idiom to duplicate a string if it is non-NULL,
or pass a literal NULL through. This is already a one-liner
in C, but you do have to repeat the name of the string
twice. So if there's a function call, you must write:

  const char *x = some_fun(...);
  return x ? xstrdup(x) : NULL;

instead of (with this patch) just:

  return xstrdup_or_null(some_fun(...));

Signed-off-by: Jeff King <peff@peff.net>
---
This example is the heart of the readability question to me. It is nice
to avoid the temporary, which makes the code more direct. But it also
sticks some_fun(...) inside another function, which is a little harder
to read.

 git-compat-util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index dcecd85..8157eb2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -675,6 +675,11 @@ extern char *xgetcwd(void);
 
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), (alloc) * sizeof(*(x)))
 
+static inline char *xstrdup_or_null(const char *str)
+{
+	return str ? xstrdup(str) : NULL;
+}
+
 static inline size_t xsize_t(off_t len)
 {
 	if (len > (size_t) len)
-- 
2.2.1.425.g441bb3c
