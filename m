From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] checkout: allow ignoring unmerged paths when checking
 out of the index
Date: Fri, 29 Aug 2008 14:42:33 -0700
Message-ID: <7v7i9z4hx2.fsf@gitster.siamese.dyndns.org>
References: <7vbpzb4i1h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 23:43:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZBks-0007Ja-Qh
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 23:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbYH2Vmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 17:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbYH2Vmi
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 17:42:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710AbYH2Vmh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 17:42:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F7EF6DFC4;
	Fri, 29 Aug 2008 17:42:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 69A3C6DFC3; Fri, 29 Aug 2008 17:42:35 -0400 (EDT)
In-Reply-To: <7vbpzb4i1h.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Aug 2008 14:39:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65A098E4-7613-11DD-A894-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94332>

Earlier we made "git checkout $pathspec" to atomically refuse the
operation, if $pathspec matched any path with unmerged stages.

This patch allows:

    $ git checkout -f a b c

to ignore, instead of erroring out on, such unmerged paths.  The fix to
prevent checkout of an unmerged path from random stages is still there.

Signed-off-by: Junio C Hamano <junio@twinsun.com>
---
 builtin-checkout.c |   41 +++++++++++++++++++++++------------------
 t/t7201-co.sh      |   23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9b33f3a..49c43d9 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -20,6 +20,17 @@ static const char * const checkout_usage[] = {
 	NULL,
 };
 
+struct checkout_opts {
+	int quiet;
+	int merge;
+	int force;
+	int writeout_error;
+
+	const char *new_branch;
+	int new_branch_log;
+	enum branch_track track;
+};
+
 static int post_checkout_hook(struct commit *old, struct commit *new,
 			      int changed)
 {
@@ -85,7 +96,8 @@ static int skip_same_name(struct cache_entry *ce, int pos)
 }
 
 
-static int checkout_paths(struct tree *source_tree, const char **pathspec)
+static int checkout_paths(struct tree *source_tree, const char **pathspec,
+			  struct checkout_opts *opts)
 {
 	int pos;
 	struct checkout state;
@@ -121,8 +133,12 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec)
 		struct cache_entry *ce = active_cache[pos];
 		if (pathspec_match(pathspec, NULL, ce->name, 0) &&
 		    ce_stage(ce)) {
-			errs = 1;
-			error("path '%s' is unmerged", ce->name);
+			if (!opts->force) {
+				errs = 1;
+				error("path '%s' is unmerged", ce->name);
+			} else {
+				warning("path '%s' is unmerged", ce->name);
+			}
 			pos = skip_same_name(ce, pos) - 1;
 			continue;
 		}
@@ -178,17 +194,6 @@ static void describe_detached_head(char *msg, struct commit *commit)
 	strbuf_release(&sb);
 }
 
-struct checkout_opts {
-	int quiet;
-	int merge;
-	int force;
-	int writeout_error;
-
-	const char *new_branch;
-	int new_branch_log;
-	enum branch_track track;
-};
-
 static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 {
 	struct unpack_trees_options opts;
@@ -569,15 +574,15 @@ no_reference:
 			die("invalid path specification");
 
 		/* Checkout paths */
-		if (opts.new_branch || opts.force || opts.merge) {
+		if (opts.new_branch || opts.merge) {
 			if (argc == 1) {
-				die("git checkout: updating paths is incompatible with switching branches/forcing\nDid you intend to checkout '%s' which can not be resolved as commit?", argv[0]);
+				die("git checkout: updating paths is incompatible with switching branches.\nDid you intend to checkout '%s' which can not be resolved as commit?", argv[0]);
 			} else {
-				die("git checkout: updating paths is incompatible with switching branches/forcing");
+				die("git checkout: updating paths is incompatible with switching branches.");
 			}
 		}
 
-		return checkout_paths(source_tree, pathspec);
+		return checkout_paths(source_tree, pathspec, &opts);
 	}
 
 	if (new.name && !new.commit) {
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 303cf62..bbf86cb 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -391,5 +391,28 @@ test_expect_success 'checkout an unmerged path should fail' '
 	test_cmp sample file
 '
 
+test_expect_success 'checkout with an unmerged path can ignore' '
+	rm -f .git/index &&
+	O=$(echo original | git hash-object -w --stdin) &&
+	A=$(echo ourside | git hash-object -w --stdin) &&
+	B=$(echo theirside | git hash-object -w --stdin) &&
+	(
+		echo "100644 $A 0	fild" &&
+		echo "100644 $O 1	file" &&
+		echo "100644 $A 2	file" &&
+		echo "100644 $B 3	file" &&
+		echo "100644 $A 0	filf"
+	) | git update-index --index-info &&
+	echo "none of the above" >sample &&
+	echo ourside >expect &&
+	cat sample >fild &&
+	cat sample >file &&
+	cat sample >filf &&
+	git checkout -f fild file filf &&
+	test_cmp expect fild &&
+	test_cmp expect filf &&
+	test_cmp sample file
+'
+
 test_done
 
-- 
1.6.0.1.90.g27a6e
