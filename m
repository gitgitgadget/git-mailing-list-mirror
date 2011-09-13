From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] checkout: use argv_array API
Date: Tue, 13 Sep 2011 17:58:19 -0400
Message-ID: <20110913215819.GF24490@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 23:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3azt-0001ma-V3
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 23:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931Ab1IMV6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 17:58:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51541
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834Ab1IMV6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 17:58:21 -0400
Received: (qmail 2066 invoked by uid 107); 13 Sep 2011 21:59:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 17:59:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 17:58:19 -0400
Content-Disposition: inline
In-Reply-To: <20110913215026.GA26743@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181314>

We were using a similar ad-hoc rev_list_args structure, but
this saves some code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c |   27 ++++++++-------------------
 1 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 28cdc51..bb056e4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -19,6 +19,7 @@
 #include "ll-merge.h"
 #include "resolve-undo.h"
 #include "submodule.h"
+#include "argv-array.h"
 
 static const char * const checkout_usage[] = {
 	"git checkout [options] <branch>",
@@ -588,24 +589,12 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		report_tracking(new);
 }
 
-struct rev_list_args {
-	int argc;
-	int alloc;
-	const char **argv;
-};
-
-static void add_one_rev_list_arg(struct rev_list_args *args, const char *s)
-{
-	ALLOC_GROW(args->argv, args->argc + 1, args->alloc);
-	args->argv[args->argc++] = s;
-}
-
 static int add_one_ref_to_rev_list_arg(const char *refname,
 				       const unsigned char *sha1,
 				       int flags,
 				       void *cb_data)
 {
-	add_one_rev_list_arg(cb_data, refname);
+	argv_array_push(cb_data, refname);
 	return 0;
 }
 
@@ -684,15 +673,14 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
  */
 static void orphaned_commit_warning(struct commit *commit)
 {
-	struct rev_list_args args = { 0, 0, NULL };
+	struct argv_array args = ARGV_ARRAY_INIT;
 	struct rev_info revs;
 
-	add_one_rev_list_arg(&args, "(internal)");
-	add_one_rev_list_arg(&args, sha1_to_hex(commit->object.sha1));
-	add_one_rev_list_arg(&args, "--not");
+	argv_array_push(&args, "(internal)");
+	argv_array_push(&args, sha1_to_hex(commit->object.sha1));
+	argv_array_push(&args, "--not");
 	for_each_ref(add_one_ref_to_rev_list_arg, &args);
-	add_one_rev_list_arg(&args, "--");
-	add_one_rev_list_arg(&args, NULL);
+	argv_array_push(&args, "--");
 
 	init_revisions(&revs, NULL);
 	if (setup_revisions(args.argc - 1, args.argv, &revs, NULL) != 1)
@@ -704,6 +692,7 @@ static void orphaned_commit_warning(struct commit *commit)
 	else
 		describe_detached_head(_("Previous HEAD position was"), commit);
 
+	argv_array_clear(&args);
 	clear_commit_marks(commit, -1);
 	for_each_ref(clear_commit_marks_from_one_ref, NULL);
 }
-- 
1.7.7.rc1.2.gb2409
