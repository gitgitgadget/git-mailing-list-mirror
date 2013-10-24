From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] log_tree_diff: die when we fail to parse a commit
Date: Thu, 24 Oct 2013 04:52:36 -0400
Message-ID: <20131024085236.GA1346@sigill.intra.peff.net>
References: <20131024085213.GA1267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 10:52:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZGeo-0004rX-TI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 10:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931Ab3JXIwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 04:52:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:54650 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753888Ab3JXIwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 04:52:38 -0400
Received: (qmail 7402 invoked by uid 102); 24 Oct 2013 08:52:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 03:52:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 04:52:36 -0400
Content-Disposition: inline
In-Reply-To: <20131024085213.GA1267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236576>

We currently call parse_commit and then assume we can
dereference the resulting "tree" struct field. If parsing
failed, however, that field is NULL and we end up
segfaulting.

Instead of a segfault, let's print an error message and die
a little more gracefully.

Note that this should never happen in practice, but may
happen in a corrupt repository.

Signed-off-by: Jeff King <peff@peff.net>
---
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
@@ -49,6 +49,7 @@ struct commit *lookup_commit_or_die(const unsigned char *sha1, const char *ref_n
 
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
1.8.4.1.898.g8bf8a41.dirty
