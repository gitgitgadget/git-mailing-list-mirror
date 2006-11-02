X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: [PATCH] git-pickaxe: look for files relative to current path
Date: Thu, 2 Nov 2006 02:22:49 -0500
Message-ID: <20061102072249.GA15220@coredump.intra.peff.net>
References: <45496432.80503@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 07:23:05 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45496432.80503@shadowen.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30690>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfWuf-0004AC-I3 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 08:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752706AbWKBHWw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 02:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbWKBHWw
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 02:22:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:61071
 "HELO peff.net") by vger.kernel.org with SMTP id S1752706AbWKBHWv (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 02:22:51 -0500
Received: (qmail 23780 invoked from network); 2 Nov 2006 02:21:59 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 2 Nov 2006 02:21:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Nov
 2006 02:22:49 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


Signed-off-by: Jeff King <peff@peff.net>
---
Andy Whitcroft writes:
> We seem to have a difference in the handling of relative filenames
> within a repository between git blame and git pickaxe.  Specifically git
> pickaxe seems to always require names as if it were run in the top of
> the project:

This simple patch seems to fix it (but is not extensively tested).

 builtin-pickaxe.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin-pickaxe.c b/builtin-pickaxe.c
index c9405e9..3e76258 100644
--- a/builtin-pickaxe.c
+++ b/builtin-pickaxe.c
@@ -1413,6 +1413,13 @@ static void sanity_check_refcnt(struct s
 	}
 }
 
+static const char *add_prefix(const char *prefix, const char *path)
+{
+	if (!prefix || !prefix[0])
+		return path;
+	return prefix_path(prefix, strlen(prefix), path);
+}
+
 static int has_path_in_work_tree(const char *path)
 {
 	struct stat st;
@@ -1548,7 +1555,7 @@ int cmd_pickaxe(int argc, const char **a
 		/* (1) */
 		if (argc <= i)
 			usage(pickaxe_usage);
-		path = argv[i];
+		path = add_prefix(prefix, argv[i]);
 		if (i + 1 == argc - 1) {
 			if (unk != 1)
 				usage(pickaxe_usage);
@@ -1566,13 +1573,13 @@ int cmd_pickaxe(int argc, const char **a
 		if (seen_dashdash) {
 			if (seen_dashdash + 1 != argc - 1)
 				usage(pickaxe_usage);
-			path = argv[seen_dashdash + 1];
+			path = add_prefix(prefix, argv[seen_dashdash + 1]);
 			for (j = i; j < seen_dashdash; j++)
 				argv[unk++] = argv[j];
 		}
 		else {
 			/* (3) */
-			path = argv[i];
+			path = add_prefix(prefix, argv[i]);
 			if (i + 1 == argc - 1) {
 				final_commit_name = argv[i + 1];
 
@@ -1580,7 +1587,7 @@ int cmd_pickaxe(int argc, const char **a
 				 * old-style
 				 */
 				if (unk == 1 && !has_path_in_work_tree(path)) {
-					path = argv[i + 1];
+					path = add_prefix(prefix, argv[i + 1]);
 					final_commit_name = argv[i];
 				}
 			}
-- 
