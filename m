From: Jeff King <peff@peff.net>
Subject: [PATCH] log_tree_diff: die when we fail to parse a commit
Date: Sun, 6 Oct 2013 00:48:57 -0400
Message-ID: <20131006044856.GA12301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 06 06:49:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSgHR-00079U-5k
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 06:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab3JFEtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 00:49:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:44505 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751047Ab3JFEs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 00:48:59 -0400
Received: (qmail 18217 invoked by uid 102); 6 Oct 2013 04:48:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 Oct 2013 23:48:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Oct 2013 00:48:57 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235735>

We currently call parse_commit and then assume we can
dereference the resulting "tree" struct field. If parsing
failed, however, that field is NULL and we end up
segfaulting.

Instead of a segfault, let's print an error message and die
a little more gracefully.

Note that this should never happen in practice, but may
happen in a corrupt repository (or when accessing objects
not connected to the reachable history, whose parents may be
subject to pruning).

Signed-off-by: Jeff King <peff@peff.net>
---
Not a huge deal, since we are terminating the program either way. There
are other places in the code with a bare parse_commit that could
probably use the same treatment. I didn't investigate them, but they
could easily build on the parse_commit_or_die here if somebody wants to
follow up.

 commit.c   | 7 +++++++
 commit.h   | 1 +
 log-tree.c | 6 +++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index de16a3c..51a9bbc 100644
--- a/commit.c
+++ b/commit.c
@@ -341,6 +341,13 @@ int parse_commit(struct commit *item)
 	return ret;
 }
 
+void parse_commit_or_die(struct commit *item)
+{
+	if (parse_commit(item))
+		die("unable to parse commit %s",
+		    item ? sha1_to_hex(item->object.sha1) : "(null)");
+}
+
 int find_commit_subject(const char *commit_buffer, const char **subject)
 {
 	const char *eol;
diff --git a/commit.h b/commit.h
index bd841f4..934af88 100644
--- a/commit.h
+++ b/commit.h
@@ -49,6 +49,7 @@ int parse_commit(struct commit *item);
 
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
 int parse_commit(struct commit *item);
+void parse_commit_or_die(struct commit *item);
 
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
diff --git a/log-tree.c b/log-tree.c
index 8534d91..e958d07 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -734,7 +734,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	if (!opt->diff && !DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS))
 		return 0;
 
-	parse_commit(commit);
+	parse_commit_or_die(commit);
 	sha1 = commit->tree->object.sha1;
 
 	/* Root commit? */
@@ -759,7 +759,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			 * parent, showing summary diff of the others
 			 * we merged _in_.
 			 */
-			parse_commit(parents->item);
+			parse_commit_or_die(parents->item);
 			diff_tree_sha1(parents->item->tree->object.sha1,
 				       sha1, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
@@ -774,7 +774,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	for (;;) {
 		struct commit *parent = parents->item;
 
-		parse_commit(parent);
+		parse_commit_or_die(parent);
 		diff_tree_sha1(parent->tree->object.sha1,
 			       sha1, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
-- 
1.8.4.1.4.gf327177
