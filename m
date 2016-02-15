From: Jeff King <peff@peff.net>
Subject: [PATCH 03/18] harden REALLOC_ARRAY and xcalloc against size_t
 overflow
Date: Mon, 15 Feb 2016 16:50:30 -0500
Message-ID: <20160215215030.GC10287@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 22:50:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVR2S-00087C-QO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbcBOVud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:50:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:42471 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751478AbcBOVuc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:50:32 -0500
Received: (qmail 2434 invoked by uid 102); 15 Feb 2016 21:50:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:50:32 -0500
Received: (qmail 12353 invoked by uid 107); 15 Feb 2016 21:50:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:50:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:50:30 -0500
Content-Disposition: inline
In-Reply-To: <20160215214516.GA4015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286257>

REALLOC_ARRAY inherently involves a multiplication which can
overflow size_t, resulting in a much smaller buffer than we
think we've allocated. We can easily harden it by using
st_mult() to check for overflow.  Likewise, we can add
ALLOC_ARRAY to do the same thing for xmalloc calls.

xcalloc() should already be fine, because it takes the two
factors separately, assuming the system calloc actually
checks for overflow. However, before we even hit the system
calloc(), we do our memory_limit_check, which involves a
multiplication. Let's check for overflow ourselves so that
this limit cannot be bypassed.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 3 ++-
 wrapper.c         | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 0c65033..55c073d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -779,7 +779,8 @@ extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
 extern char *xgetcwd(void);
 extern FILE *fopen_for_writing(const char *path);
 
-#define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), (alloc) * sizeof(*(x)))
+#define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult((alloc), sizeof(*(x))))
+#define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult((alloc), sizeof(*(x))))
 
 static inline char *xstrdup_or_null(const char *str)
 {
diff --git a/wrapper.c b/wrapper.c
index 29a45d2..9afc1a0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -152,6 +152,9 @@ void *xcalloc(size_t nmemb, size_t size)
 {
 	void *ret;
 
+	if (unsigned_mult_overflows(nmemb, size))
+		die("data too large to fit into virtual memory space");
+
 	memory_limit_check(size * nmemb, 0);
 	ret = calloc(nmemb, size);
 	if (!ret && (!nmemb || !size))
-- 
2.7.1.572.gf718037
