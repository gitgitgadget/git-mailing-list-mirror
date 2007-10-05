From: Pierre Habouzit <madcoder@debian.org>
Subject: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 5 Oct 2007 10:11:59 +0200
Message-ID: <20071005085522.32EFF1E16E@madism.org>
References: <20071005082026.GE19879@artemis.corp>
Cc: git@vger.kernel.org, Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:55:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idiy4-0001sb-M8
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXJEIzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbXJEIzY
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:55:24 -0400
Received: from pan.madism.org ([88.191.52.104]:60321 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002AbXJEIzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:55:23 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A92B022CEF;
	Fri,  5 Oct 2007 10:55:22 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 32EFF1E16E; Fri,  5 Oct 2007 10:55:22 +0200 (CEST)
In-Reply-To: <20071005082026.GE19879@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60056>

* crlf_to_git and ident_to_git:

  Don't grow the buffer if there is enough space in the first place.
  As a side effect, when the editing is done "in place", we don't grow, so
  the buffer pointer doesn't changes, and `src' isn't invalidated anymore.

  Thanks to Bernt Hansen for the bug report.

* apply_filter:

  Fix memory leak due to fake in-place editing that didn't collected the
  old buffer when the filter succeeds. Also a cosmetic fix.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

This patch is on top of master, and supersedes both patch I sent before.
Following dscho's remark, I only grow the buffer if they aren't big enough
in the first place, which ensures that buffers are not touched if edited in
place.

 convert.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 0d5e909..aa95834 100644
--- a/convert.c
+++ b/convert.c
@@ -110,7 +110,9 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
-	strbuf_grow(buf, len);
+	/* only grow if not in place */
+	if (strbuf_avail(buf) + buf->len < len)
+		strbuf_grow(buf, len - buf->len);
 	dst = buf->buf;
 	if (action == CRLF_GUESS) {
 		/*
@@ -281,20 +283,19 @@ static int apply_filter(const char *path, const char *src, size_t len,
 		ret = 0;
 	}
 	if (close(pipe_feed[0])) {
-		ret = error("read from external filter %s failed", cmd);
+		error("read from external filter %s failed", cmd);
 		ret = 0;
 	}
 	status = finish_command(&child_process);
 	if (status) {
-		ret = error("external filter %s failed %d", cmd, -status);
+		error("external filter %s failed %d", cmd, -status);
 		ret = 0;
 	}
 
 	if (ret) {
-		*dst = nbuf;
-	} else {
-		strbuf_release(&nbuf);
+		strbuf_swap(dst, &nbuf);
 	}
+	strbuf_release(&nbuf);
 	return ret;
 }
 
@@ -422,7 +423,9 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 	if (!ident || !count_ident(src, len))
 		return 0;
 
-	strbuf_grow(buf, len);
+	/* only grow if not in place */
+	if (strbuf_avail(buf) + buf->len < len)
+		strbuf_grow(buf, len - buf->len);
 	dst = buf->buf;
 	for (;;) {
 		dollar = memchr(src, '$', len);
-- 
1.5.3.4.207.gb504-dirty
