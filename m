From: Jeff King <peff@peff.net>
Subject: [PATCH 59/67] prefer memcpy to strcpy
Date: Tue, 15 Sep 2015 12:11:48 -0400
Message-ID: <20150915161147.GG29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:12:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbspn-0005iV-6h
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbbIOQLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:11:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:59462 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753481AbbIOQLu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:11:50 -0400
Received: (qmail 14495 invoked by uid 102); 15 Sep 2015 16:11:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:11:50 -0500
Received: (qmail 7941 invoked by uid 107); 15 Sep 2015 16:11:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:11:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:11:48 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277964>

When we already know the length of a string (e.g., because
we just malloc'd to fit it), it's nicer to use memcpy than
strcpy, as it makes it more obvious that we are not going to
overflow the buffer (because the size we pass matches the
size in the allocation).

This also eliminates calls to strcpy, which make auditing
the code base harder.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/nedmalloc/nedmalloc.c | 5 +++--
 fast-import.c                | 5 +++--
 revision.c                   | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index 609ebba..a0a16eb 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -957,8 +957,9 @@ char *strdup(const char *s1)
 {
 	char *s2 = 0;
 	if (s1) {
-		s2 = malloc(strlen(s1) + 1);
-		strcpy(s2, s1);
+		size_t len = strlen(s1) + 1;
+		s2 = malloc(len);
+		memcpy(s2, s1, len);
 	}
 	return s2;
 }
diff --git a/fast-import.c b/fast-import.c
index 895c6b4..cf6d8bc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -644,8 +644,9 @@ static void *pool_calloc(size_t count, size_t size)
 
 static char *pool_strdup(const char *s)
 {
-	char *r = pool_alloc(strlen(s) + 1);
-	strcpy(r, s);
+	size_t len = strlen(s) + 1;
+	char *r = pool_alloc(len);
+	memcpy(r, s, len);
 	return r;
 }
 
diff --git a/revision.c b/revision.c
index af2a18e..2236463 100644
--- a/revision.c
+++ b/revision.c
@@ -38,7 +38,7 @@ char *path_name(const struct name_path *path, const char *name)
 	}
 	n = xmalloc(len);
 	m = n + len - (nlen + 1);
-	strcpy(m, name);
+	memcpy(m, name, nlen + 1);
 	for (p = path; p; p = p->up) {
 		if (p->elem_len) {
 			m -= p->elem_len + 1;
-- 
2.6.0.rc2.408.ga2926b9
