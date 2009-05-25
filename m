From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] fetch: report ref storage DF errors more accurately
Date: Mon, 25 May 2009 06:40:54 -0400
Message-ID: <20090525104054.GA26682@coredump.intra.peff.net>
References: <20090429080650.GA25227@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 12:41:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Xc9-0004kU-Ek
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 12:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbZEYKk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 06:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbZEYKk4
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 06:40:56 -0400
Received: from peff.net ([208.65.91.99]:43993 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594AbZEYKkz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 06:40:55 -0400
Received: (qmail 3777 invoked by uid 107); 25 May 2009 10:40:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 06:40:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 06:40:54 -0400
Content-Disposition: inline
In-Reply-To: <20090429080650.GA25227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119917>

When we fail to store a fetched ref, we recommend that the
user try running "git prune" to remove up any old refs that
have been deleted by the remote, which would clear up any DF
conflicts. However, ref storage might fail for other
reasons (e.g., permissions problems) in which case the
advice is useless and misleading.

This patch detects when there is an actual DF situation and
only issues the advice when one is found.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a followup to Ingo's bug report here:

  http://thread.gmane.org/gmane.comp.version-control.git/117751

 builtin-fetch.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 77acabf..1eec64e 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -167,6 +167,9 @@ static struct ref *get_ref_map(struct transport *transport,
 	return ref_map;
 }
 
+#define STORE_REF_ERROR_OTHER 1
+#define STORE_REF_ERROR_DF_CONFLICT 2
+
 static int s_update_ref(const char *action,
 			struct ref *ref,
 			int check_old)
@@ -181,9 +184,11 @@ static int s_update_ref(const char *action,
 	lock = lock_any_ref_for_update(ref->name,
 				       check_old ? ref->old_sha1 : NULL, 0);
 	if (!lock)
-		return 2;
+		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
+					  STORE_REF_ERROR_OTHER;
 	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
-		return 2;
+		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
+					  STORE_REF_ERROR_OTHER;
 	return 0;
 }
 
@@ -386,7 +391,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	}
 	free(url);
 	fclose(fp);
-	if (rc & 2)
+	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
 		      "branches", remote_name);
-- 
1.6.3.1.250.g01b8b.dirty
