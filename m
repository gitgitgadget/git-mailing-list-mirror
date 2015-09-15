From: Jeff King <peff@peff.net>
Subject: [PATCH 49/67] http-push: use an argv_array for setup_revisions
Date: Tue, 15 Sep 2015 12:02:51 -0400
Message-ID: <20150915160251.GW29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:03:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsh9-0002t9-8P
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbbIOQCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:02:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:59429 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753357AbbIOQCy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:02:54 -0400
Received: (qmail 13800 invoked by uid 102); 15 Sep 2015 16:02:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:02:53 -0500
Received: (qmail 7740 invoked by uid 107); 15 Sep 2015 16:03:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:03:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:02:51 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277953>

This drops the magic number for the fixed-size argv arrays,
so we do not have to wonder if we are overflowing it. We can
also drop some confusing sha1_to_hex memory allocation
(which seems to predate the ring of buffers allowing
multiple calls), and get rid of an unchecked sprintf call.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/http-push.c b/http-push.c
index e501c28..43a9036 100644
--- a/http-push.c
+++ b/http-push.c
@@ -10,6 +10,7 @@
 #include "remote.h"
 #include "list-objects.h"
 #include "sigchain.h"
+#include "argv-array.h"
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
@@ -1856,9 +1857,7 @@ int main(int argc, char **argv)
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char old_hex[60], *new_hex;
-		const char *commit_argv[5];
-		int commit_argc;
-		char *new_sha1_hex, *old_sha1_hex;
+		struct argv_array commit_argv = ARGV_ARRAY_INIT;
 
 		if (!ref->peer_ref)
 			continue;
@@ -1937,27 +1936,15 @@ int main(int argc, char **argv)
 		}
 
 		/* Set up revision info for this refspec */
-		commit_argc = 3;
-		new_sha1_hex = xstrdup(sha1_to_hex(ref->new_sha1));
-		old_sha1_hex = NULL;
-		commit_argv[1] = "--objects";
-		commit_argv[2] = new_sha1_hex;
-		if (!push_all && !is_null_sha1(ref->old_sha1)) {
-			old_sha1_hex = xmalloc(42);
-			sprintf(old_sha1_hex, "^%s",
-				sha1_to_hex(ref->old_sha1));
-			commit_argv[3] = old_sha1_hex;
-			commit_argc++;
-		}
-		commit_argv[commit_argc] = NULL;
+		argv_array_push(&commit_argv, ""); /* ignored */
+		argv_array_push(&commit_argv, "--objects");
+		argv_array_push(&commit_argv, sha1_to_hex(ref->new_sha1));
+		if (!push_all && !is_null_sha1(ref->old_sha1))
+			argv_array_pushf(&commit_argv, "^%s",
+					 sha1_to_hex(ref->old_sha1));
 		init_revisions(&revs, setup_git_directory());
-		setup_revisions(commit_argc, commit_argv, &revs, NULL);
+		setup_revisions(commit_argv.argc, commit_argv.argv, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
-		free(new_sha1_hex);
-		if (old_sha1_hex) {
-			free(old_sha1_hex);
-			commit_argv[1] = NULL;
-		}
 
 		/* Generate a list of objects that need to be pushed */
 		pushing = 0;
@@ -1986,6 +1973,7 @@ int main(int argc, char **argv)
 			printf("%s %s\n", !rc ? "ok" : "error", ref->name);
 		unlock_remote(ref_lock);
 		check_locks();
+		argv_array_clear(&commit_argv);
 	}
 
 	/* Update remote server info if appropriate */
-- 
2.6.0.rc2.408.ga2926b9
