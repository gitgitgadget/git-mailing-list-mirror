From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 1/2] combine-diff: Honour --full-index.
Date: Mon, 27 Feb 2006 12:52:50 +0000
Message-ID: <20060227125250.25144.28246.stgit@metalzone.distorted.org.uk>
References: <20060227124815.25144.83101.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Mon Feb 27 13:53:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDhsE-00076V-Jk
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 13:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWB0Mww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 07:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWB0Mww
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 07:52:52 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:13400 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751091AbWB0Mwv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 07:52:51 -0500
Received: (qmail 25576 invoked from network); 27 Feb 2006 12:52:50 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?yZudMMouV9PWpVJicx9Of0qRVofSgIvn?@127.0.0.1)
  by localhost with SMTP; 27 Feb 2006 12:52:50 -0000
To: git@vger.kernel.org
In-Reply-To: <20060227124815.25144.83101.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16841>

From: Mark Wooding <mdw@distorted.org.uk>

For some reason, combined diffs don't honour the --full-index flag when
emitting patches.  Fix this.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 combine-diff.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index d812600..984103e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -621,7 +621,8 @@ static void reuse_combine_diff(struct sl
 }
 
 static int show_patch_diff(struct combine_diff_path *elem, int num_parent,
-			   int dense, const char *header)
+			   int dense, const char *header,
+			   struct diff_options *opt)
 {
 	unsigned long size, cnt, lno;
 	char *result, *cp, *ep;
@@ -631,6 +632,7 @@ static int show_patch_diff(struct combin
 	char ourtmp_buf[TMPPATHLEN];
 	char *ourtmp = ourtmp_buf;
 	int working_tree_file = !memcmp(elem->sha1, null_sha1, 20);
+	int abbrev = opt->full_index ? 40 : DEFAULT_ABBREV;
 
 	/* Read the result of merge first */
 	if (!working_tree_file) {
@@ -735,10 +737,10 @@ static int show_patch_diff(struct combin
 		printf("index ");
 		for (i = 0; i < num_parent; i++) {
 			abb = find_unique_abbrev(elem->parent[i].sha1,
-						 DEFAULT_ABBREV);
+						 abbrev);
 			printf("%s%s", i ? "," : "", abb);
 		}
-		abb = find_unique_abbrev(elem->sha1, DEFAULT_ABBREV);
+		abb = find_unique_abbrev(elem->sha1, abbrev);
 		printf("..%s\n", abb);
 
 		if (mode_differs) {
@@ -862,7 +864,7 @@ int show_combined_diff(struct combine_di
 
 	default:
 	case DIFF_FORMAT_PATCH:
-		return show_patch_diff(p, num_parent, dense, header);
+		return show_patch_diff(p, num_parent, dense, header, opt);
 	}
 }
 
