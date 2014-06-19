From: Jeff King <peff@peff.net>
Subject: [PATCH v2 09/10] walker_fetch: fix minor memory leak
Date: Thu, 19 Jun 2014 17:29:48 -0400
Message-ID: <20140619212948.GI28474@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxju6-0003vA-BV
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965742AbaFSV3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:29:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:47804 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964833AbaFSV3u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:29:50 -0400
Received: (qmail 17248 invoked by uid 102); 19 Jun 2014 21:29:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:29:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:29:48 -0400
Content-Disposition: inline
In-Reply-To: <20140619211659.GA32412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252192>

We sometimes allocate "msg" on the heap, but will fail to
free it if we hit the failure code path. We can instead keep
a separate variable that is safe to be freed no matter how
we get to the failure code path.

While we're here, we can also do two readability
improvements:

  1. Use xstrfmt instead of a manual malloc/sprintf

  2. Due to the "maybe we allocate msg, maybe we don't"
     strategy, the logic for deciding which message to show
     was split into two parts. Since the deallocation is now
     pushed onto a separate variable, this is no longer a
     concern, and we can keep all of the logic in the same
     place.

Signed-off-by: Jeff King <peff@peff.net>
---
 walker.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/walker.c b/walker.c
index 1dd86b8..0148264 100644
--- a/walker.c
+++ b/walker.c
@@ -253,7 +253,8 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 {
 	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
 	unsigned char *sha1 = xmalloc(targets * 20);
-	char *msg;
+	const char *msg;
+	char *to_free = NULL;
 	int ret;
 	int i;
 
@@ -285,21 +286,19 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	if (loop(walker))
 		goto unlock_and_fail;
 
-	if (write_ref_log_details) {
-		msg = xmalloc(strlen(write_ref_log_details) + 12);
-		sprintf(msg, "fetch from %s", write_ref_log_details);
-	} else {
-		msg = NULL;
-	}
+	if (write_ref_log_details)
+		msg = to_free = xstrfmt("fetch from %s", write_ref_log_details);
+	else
+		msg = "fetch (unknown)";
 	for (i = 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
 			continue;
-		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
+		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg);
 		lock[i] = NULL;
 		if (ret)
 			goto unlock_and_fail;
 	}
-	free(msg);
+	free(to_free);
 
 	return 0;
 
@@ -307,6 +306,7 @@ unlock_and_fail:
 	for (i = 0; i < targets; i++)
 		if (lock[i])
 			unlock_ref(lock[i]);
+	free(to_free);
 
 	return -1;
 }
-- 
2.0.0.566.gfe3e6b2
