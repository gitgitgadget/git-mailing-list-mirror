From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] builtin-push.c: Cleanup - use OPT_BIT() and remove some variables
Date: Sun, 20 Jul 2008 14:02:20 +0200
Message-ID: <200807201402.20773.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 13:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKXXL-0000e9-QY
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 13:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbYGTL4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 07:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbYGTL4K
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 07:56:10 -0400
Received: from smtp.katamail.com ([62.149.157.154]:45707 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752801AbYGTL4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 07:56:09 -0400
Received: (qmail 8058 invoked by uid 89); 20 Jul 2008 11:56:04 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host119-56-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.119)
  by smtp1-pc with SMTP; 20 Jul 2008 11:56:03 -0000
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89186>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-push.c |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 03db28c..c1ed68d 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -14,7 +14,7 @@ static const char * const push_usage[] = {
 	NULL,
 };
 
-static int thin, verbose;
+static int thin;
 static const char *receivepack;
 
 static const char **refspec;
@@ -84,7 +84,7 @@ static int do_push(const char *repo, int flags)
 		if (thin)
 			transport_set_option(transport, TRANS_OPT_THIN, "yes");
 
-		if (verbose)
+		if (flags & TRANSPORT_PUSH_VERBOSE)
 			fprintf(stderr, "Pushing to %s\n", remote->url[i]);
 		err = transport_push(transport, refspec_nr, refspec, flags);
 		err |= transport_disconnect(transport);
@@ -101,22 +101,19 @@ static int do_push(const char *repo, int flags)
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
-	int all = 0;
-	int mirror = 0;
-	int dry_run = 0;
-	int force = 0;
 	int tags = 0;
 	int rc;
 	const char *repo = NULL;	/* default repository */
 
 	struct option options[] = {
-		OPT__VERBOSE(&verbose),
+		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
-		OPT_BOOLEAN( 0 , "all", &all, "push all refs"),
-		OPT_BOOLEAN( 0 , "mirror", &mirror, "mirror all refs"),
+		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
+		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
+			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
-		OPT_BOOLEAN( 0 , "dry-run", &dry_run, "dry run"),
-		OPT_BOOLEAN('f', "force", &force, "force updates"),
+		OPT_BIT( 0 , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
+		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
@@ -125,18 +122,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, push_usage, 0);
 
-	if (force)
-		flags |= TRANSPORT_PUSH_FORCE;
-	if (dry_run)
-		flags |= TRANSPORT_PUSH_DRY_RUN;
-	if (verbose)
-		flags |= TRANSPORT_PUSH_VERBOSE;
 	if (tags)
 		add_refspec("refs/tags/*");
-	if (all)
-		flags |= TRANSPORT_PUSH_ALL;
-	if (mirror)
-		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
 	if (argc > 0) {
 		repo = argv[0];
-- 
1.5.6.3
