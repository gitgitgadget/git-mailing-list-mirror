From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/4] Remove unnecessary call_depth parameter in merge-recursive.
Date: Sun, 14 Jan 2007 00:28:33 -0500
Message-ID: <20070114052832.GA19113@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 06:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5xv9-0006Fv-Os
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 06:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbXANF2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 00:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbXANF2i
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 00:28:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46618 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbXANF2h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 00:28:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5xv0-0004it-VA; Sun, 14 Jan 2007 00:28:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 59E3E20FBAE; Sun, 14 Jan 2007 00:28:33 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36791>

Because the output_indent always matches the call_depth value
there is no reason to pass around the call_depth to the merge
function during each recursive invocation.

This is a simple refactoring that will make the code easier to
follow later on as I start to add output verbosity controls.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-recursive.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b4acbb7..8738f09 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -70,13 +70,13 @@ struct stage_data
 static struct path_list current_file_set = {NULL, 0, 0, 1};
 static struct path_list current_directory_set = {NULL, 0, 0, 1};
 
-static int output_indent = 0;
+static int call_depth = 0;
 
 static void output(const char *fmt, ...)
 {
 	va_list args;
 	int i;
-	for (i = output_indent; i--;)
+	for (i = call_depth; i--;)
 		fputs("  ", stdout);
 	va_start(args, fmt);
 	vfprintf(stdout, fmt, args);
@@ -87,7 +87,7 @@ static void output(const char *fmt, ...)
 static void output_commit_title(struct commit *commit)
 {
 	int i;
-	for (i = output_indent; i--;)
+	for (i = call_depth; i--;)
 		fputs("  ", stdout);
 	if (commit->util)
 		printf("virtual %s\n", (char *)commit->util);
@@ -1095,7 +1095,6 @@ static int merge(struct commit *h1,
 		 struct commit *h2,
 		 const char *branch1,
 		 const char *branch2,
-		 int call_depth /* =0 */,
 		 struct commit_list *ca,
 		 struct commit **result)
 {
@@ -1129,7 +1128,7 @@ static int merge(struct commit *h1,
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
-		output_indent = call_depth + 1;
+		call_depth++;
 		/*
 		 * When the merge fails, the result contains files
 		 * with conflict markers. The cleanness flag is
@@ -1141,17 +1140,16 @@ static int merge(struct commit *h1,
 		merge(merged_common_ancestors, iter->item,
 		      "Temporary merge branch 1",
 		      "Temporary merge branch 2",
-		      call_depth + 1,
 		      NULL,
 		      &merged_common_ancestors);
-		output_indent = call_depth;
+		call_depth--;
 
 		if (!merged_common_ancestors)
 			die("merge returned no commit");
 	}
 
 	discard_cache();
-	if (call_depth == 0) {
+	if (!call_depth) {
 		read_cache();
 		index_only = 0;
 	} else
@@ -1239,7 +1237,7 @@ int main(int argc, char *argv[])
 		struct commit *ancestor = get_ref(bases[i]);
 		ca = commit_list_insert(ancestor, &ca);
 	}
-	clean = merge(h1, h2, branch1, branch2, 0, ca, &result);
+	clean = merge(h1, h2, branch1, branch2, ca, &result);
 
 	if (active_cache_changed &&
 	    (write_cache(index_fd, active_cache, active_nr) ||
-- 
1.5.0.rc1.g4494
