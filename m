From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] use parse_commit_or_die instead of segfaulting
Date: Tue, 8 Oct 2013 09:57:16 -0400
Message-ID: <20131008135716.GC7650@sigill.intra.peff.net>
References: <20131008134843.GA7530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 09 18:37:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTwle-0001zL-0g
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 18:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab3JIQhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 12:37:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:46332 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754774Ab3JIQhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 12:37:16 -0400
Received: (qmail 22588 invoked by uid 102); 8 Oct 2013 13:57:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Oct 2013 08:57:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Oct 2013 09:57:16 -0400
Content-Disposition: inline
In-Reply-To: <20131008134843.GA7530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235825>

Some unchecked calls to parse_commit should obviously die on
error, because their next step is to start looking at the
parsed fields, which will cause a segfault. These are
obvious candidates for parse_commit_or_die, which will be a
strict improvement in behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c    | 4 ++--
 builtin/fast-export.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0f57397..34a2e43 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -789,7 +789,7 @@ static int switch_branches(const struct checkout_opts *opts,
 		new->commit = old.commit;
 		if (!new->commit)
 			die(_("You are on a branch yet to be born"));
-		parse_commit(new->commit);
+		parse_commit_or_die(new->commit);
 	}
 
 	ret = merge_working_tree(opts, &old, new, &writeout_error);
@@ -952,7 +952,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		/* not a commit */
 		*source_tree = parse_tree_indirect(rev);
 	} else {
-		parse_commit(new->commit);
+		parse_commit_or_die(new->commit);
 		*source_tree = new->commit->tree;
 	}
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 78250ea..ea63052 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -287,7 +287,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 
 	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
 
-	parse_commit(commit);
+	parse_commit_or_die(commit);
 	author = strstr(commit->buffer, "\nauthor ");
 	if (!author)
 		die ("Could not find author in commit %s",
@@ -308,7 +308,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	if (commit->parents &&
 	    get_object_mark(&commit->parents->item->object) != 0 &&
 	    !full_tree) {
-		parse_commit(commit->parents->item);
+		parse_commit_or_die(commit->parents->item);
 		diff_tree_sha1(commit->parents->item->tree->object.sha1,
 			       commit->tree->object.sha1, "", &rev->diffopt);
 	}
-- 
1.8.4.1.4.gf327177
