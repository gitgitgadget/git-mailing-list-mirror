From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] silence broken link warnings with
 revs->ignore_missing_links
Date: Mon, 1 Jun 2015 05:56:37 -0400
Message-ID: <20150601095636.GB31389@peff.net>
References: <20150601095410.GA16976@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 11:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMT7-00034Q-N9
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 11:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbbFAJ4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 05:56:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:38664 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932071AbbFAJ4j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 05:56:39 -0400
Received: (qmail 22757 invoked by uid 102); 1 Jun 2015 09:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 04:56:39 -0500
Received: (qmail 27721 invoked by uid 107); 1 Jun 2015 09:56:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:56:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 05:56:37 -0400
Content-Disposition: inline
In-Reply-To: <20150601095410.GA16976@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270387>

We set revs->ignore_missing_links to instruct the
revision-walking machinery that we know the history graph
may be incomplete. For example, we use it when walking
unreachable but recent objects; we want to add what we can,
but it's OK if the history is incomplete.

However, we still print error messages for the missing
objects, which can be confusing. This is not an error, but
just a normal situation when transitioning from a repository
last pruned by an older git (which can leave broken segments
of history) to a more recent one (where we try to preserve
whole reachable segments).

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c             |  2 +-
 revision.c                 |  2 +-
 t/t6501-freshen-objects.sh | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 2a139b6..41736d2 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -81,7 +81,7 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree(tree) < 0) {
+	if (parse_tree_gently(tree, revs->ignore_missing_links) < 0) {
 		if (revs->ignore_missing_links)
 			return;
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
diff --git a/revision.c b/revision.c
index 7ddbaa0..29e5143 100644
--- a/revision.c
+++ b/revision.c
@@ -844,7 +844,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
 
-		if (parse_commit(p) < 0)
+		if (parse_commit_gently(p, revs->ignore_missing_links) < 0)
 			return -1;
 		if (revs->show_source && !p->util)
 			p->util = commit->util;
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 157f3f9..2adf825 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -129,4 +129,19 @@ for repack in '' true; do
 	'
 done
 
+test_expect_success 'do not complain about existing broken links' '
+	cat >broken-commit <<-\EOF &&
+	tree 0000000000000000000000000000000000000001
+	parent 0000000000000000000000000000000000000002
+	author whatever <whatever@example.com> 1234 -0000
+	committer whatever <whatever@example.com> 1234 -0000
+
+	some message
+	EOF
+	commit=$(git hash-object -t commit -w broken-commit) &&
+	git gc 2>stderr &&
+	verbose git cat-file -e $commit &&
+	test_must_be_empty stderr
+'
+
 test_done
-- 
2.4.2.690.g2a79674
