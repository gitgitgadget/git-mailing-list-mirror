From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] bisect: use argv_array API
Date: Tue, 13 Sep 2011 17:58:14 -0400
Message-ID: <20110913215814.GE24490@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 23:58:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3azt-0001ma-EG
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 23:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928Ab1IMV6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 17:58:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51536
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834Ab1IMV6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 17:58:17 -0400
Received: (qmail 2056 invoked by uid 107); 13 Sep 2011 21:59:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 17:59:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 17:58:14 -0400
Content-Disposition: inline
In-Reply-To: <20110913215026.GA26743@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181312>

Now that the argv_array API exists, we can save some lines
of code.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c |   48 +++++++++++-------------------------------------
 1 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/bisect.c b/bisect.c
index dd7e8ed..ef92871 100644
--- a/bisect.c
+++ b/bisect.c
@@ -10,18 +10,13 @@
 #include "log-tree.h"
 #include "bisect.h"
 #include "sha1-array.h"
+#include "argv-array.h"
 
 static struct sha1_array good_revs;
 static struct sha1_array skipped_revs;
 
 static const unsigned char *current_bad_sha1;
 
-struct argv_array {
-	const char **argv;
-	int argv_nr;
-	int argv_alloc;
-};
-
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 
@@ -404,21 +399,6 @@ struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
-static void argv_array_push(struct argv_array *array, const char *string)
-{
-	ALLOC_GROW(array->argv, array->argv_nr + 1, array->argv_alloc);
-	array->argv[array->argv_nr++] = string;
-}
-
-static void argv_array_push_sha1(struct argv_array *array,
-				 const unsigned char *sha1,
-				 const char *format)
-{
-	struct strbuf buf = STRBUF_INIT;
-	strbuf_addf(&buf, format, sha1_to_hex(sha1));
-	argv_array_push(array, strbuf_detach(&buf, NULL));
-}
-
 static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
@@ -448,16 +428,10 @@ static void read_bisect_paths(struct argv_array *array)
 		die_errno("Could not open file '%s'", filename);
 
 	while (strbuf_getline(&str, fp, '\n') != EOF) {
-		char *quoted;
-		int res;
-
 		strbuf_trim(&str);
-		quoted = strbuf_detach(&str, NULL);
-		res = sq_dequote_to_argv(quoted, &array->argv,
-					 &array->argv_nr, &array->argv_alloc);
-		if (res)
+		if (sq_dequote_to_argv_array(str.buf, array))
 			die("Badly quoted content in file '%s': %s",
-			    filename, quoted);
+			    filename, str.buf);
 	}
 
 	strbuf_release(&str);
@@ -622,7 +596,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
 {
-	struct argv_array rev_argv = { NULL, 0, 0 };
+	struct argv_array rev_argv = ARGV_ARRAY_INIT;
 	int i;
 
 	init_revisions(revs, prefix);
@@ -630,17 +604,17 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
-	argv_array_push(&rev_argv, xstrdup("bisect_rev_setup"));
-	argv_array_push_sha1(&rev_argv, current_bad_sha1, bad_format);
+	argv_array_push(&rev_argv, "bisect_rev_setup");
+	argv_array_pushf(&rev_argv, bad_format, sha1_to_hex(current_bad_sha1));
 	for (i = 0; i < good_revs.nr; i++)
-		argv_array_push_sha1(&rev_argv, good_revs.sha1[i],
-				     good_format);
-	argv_array_push(&rev_argv, xstrdup("--"));
+		argv_array_pushf(&rev_argv, good_format,
+				 sha1_to_hex(good_revs.sha1[i]));
+	argv_array_push(&rev_argv, "--");
 	if (read_paths)
 		read_bisect_paths(&rev_argv);
-	argv_array_push(&rev_argv, NULL);
 
-	setup_revisions(rev_argv.argv_nr, rev_argv.argv, revs, NULL);
+	setup_revisions(rev_argv.argc, rev_argv.argv, revs, NULL);
+	/* XXX leak rev_argv, as "revs" may still be pointing to it */
 }
 
 static void bisect_common(struct rev_info *revs)
-- 
1.7.7.rc1.2.gb2409
