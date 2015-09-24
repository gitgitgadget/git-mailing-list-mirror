From: Jeff King <peff@peff.net>
Subject: [PATCH 56/68] use alloc_ref rather than hand-allocating "struct ref"
Date: Thu, 24 Sep 2015 17:08:09 -0400
Message-ID: <20150924210809.GA30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDki-00028o-TE
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbbIXVIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:08:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:36026 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754400AbbIXVIM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:08:12 -0400
Received: (qmail 12133 invoked by uid 102); 24 Sep 2015 21:08:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:08:12 -0500
Received: (qmail 29510 invoked by uid 107); 24 Sep 2015 21:08:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:08:09 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278600>

This saves us some manual computation, and eliminates a call
to strcpy.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 3 +--
 remote-curl.c   | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 841880e..ed84963 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -639,8 +639,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				continue;
 
 			if (rm->peer_ref) {
-				ref = xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
-				strcpy(ref->name, rm->peer_ref->name);
+				ref = alloc_ref(rm->peer_ref->name);
 				hashcpy(ref->old_sha1, rm->peer_ref->old_sha1);
 				hashcpy(ref->new_sha1, rm->old_sha1);
 				ref->force = rm->peer_ref->force;
diff --git a/remote-curl.c b/remote-curl.c
index 71fbbb6..cc7a8a6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -168,10 +168,7 @@ static struct ref *parse_info_refs(struct discovery *heads)
 				    url.buf);
 			data[i] = 0;
 			ref_name = mid + 1;
-			ref = xmalloc(sizeof(struct ref) +
-				      strlen(ref_name) + 1);
-			memset(ref, 0, sizeof(struct ref));
-			strcpy(ref->name, ref_name);
+			ref = alloc_ref(ref_name);
 			get_sha1_hex(start, ref->old_sha1);
 			if (!refs)
 				refs = ref;
-- 
2.6.0.rc3.454.g204ad51
