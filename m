From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] branch: show upstream branch when double verbose
Date: Tue, 7 Apr 2009 03:16:56 -0400
Message-ID: <20090407071656.GE2924@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 09:19:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5ah-0005ba-3p
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbZDGHRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754875AbZDGHRN
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:17:13 -0400
Received: from peff.net ([208.65.91.99]:42613 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbZDGHRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:17:12 -0400
Received: (qmail 464 invoked by uid 107); 7 Apr 2009 07:16:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 03:16:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 03:16:56 -0400
Content-Disposition: inline
In-Reply-To: <20090407070254.GA2870@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115914>

This information is easily accessible when we are
calculating the relationship. The only reason not to print
it all the time is that it consumes a fair bit of screen
space, and may not be of interest to the user.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is very RFC. Should this information be part of the regular
"-v"? Should it be part of "git branch" with regular verbosity?

Should the format be different? I wonder if

  master 1234abcd [origin/master: ahead 5, behind 6] whatever

will be interpreted as "origin/master is ahead 5, behind 6" when it is
really the reverse. Maybe "[ahead 5, behind 6 from origin/master]" would
be better?

 Documentation/git-branch.txt |    4 +++-
 builtin-branch.c             |   23 +++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 31ba7f2..ba3dea6 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -100,7 +100,9 @@ OPTIONS
 
 -v::
 --verbose::
-	Show sha1 and commit subject line for each head.
+	Show sha1 and commit subject line for each head, along with
+	relationship to upstream branch (if any). If given twice, print
+	the name of the upstream branch, as well.
 
 --abbrev=<length>::
 	Alter the sha1's minimum display length in the output listing.
diff --git a/builtin-branch.c b/builtin-branch.c
index ca81d72..3275821 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -301,19 +301,30 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
 
-static void fill_tracking_info(struct strbuf *stat, const char *branch_name)
+static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
+		int show_upstream_ref)
 {
 	int ours, theirs;
 	struct branch *branch = branch_get(branch_name);
 
-	if (!stat_tracking_info(branch, &ours, &theirs) || (!ours && !theirs))
+	if (!stat_tracking_info(branch, &ours, &theirs)) {
+		if (branch && branch->merge && branch->merge[0]->dst &&
+		    show_upstream_ref)
+			strbuf_addf(stat, "[%s] ",
+			    shorten_unambiguous_ref(branch->merge[0]->dst));
 		return;
+	}
+
+	strbuf_addch(stat, '[');
+	if (show_upstream_ref)
+		strbuf_addf(stat, "%s: ",
+			shorten_unambiguous_ref(branch->merge[0]->dst));
 	if (!ours)
-		strbuf_addf(stat, "[behind %d] ", theirs);
+		strbuf_addf(stat, "behind %d] ", theirs);
 	else if (!theirs)
-		strbuf_addf(stat, "[ahead %d] ", ours);
+		strbuf_addf(stat, "ahead %d] ", ours);
 	else
-		strbuf_addf(stat, "[ahead %d, behind %d] ", ours, theirs);
+		strbuf_addf(stat, "ahead %d, behind %d] ", ours, theirs);
 }
 
 static int matches_merge_filter(struct commit *commit)
@@ -379,7 +390,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		}
 
 		if (item->kind == REF_LOCAL_BRANCH)
-			fill_tracking_info(&stat, item->name);
+			fill_tracking_info(&stat, item->name, verbose > 1);
 
 		strbuf_addf(&out, " %s %s%s",
 			find_unique_abbrev(item->commit->object.sha1, abbrev),
-- 
1.6.2.2.450.gd6aa9.dirty
