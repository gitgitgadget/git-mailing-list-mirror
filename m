From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/12] checkout --ours/--theirs
Date: Fri, 29 Aug 2008 17:42:42 -0700
Message-ID: <1220056963-2352-12-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
 <1220056963-2352-3-git-send-email-gitster@pobox.com>
 <1220056963-2352-4-git-send-email-gitster@pobox.com>
 <1220056963-2352-5-git-send-email-gitster@pobox.com>
 <1220056963-2352-6-git-send-email-gitster@pobox.com>
 <1220056963-2352-7-git-send-email-gitster@pobox.com>
 <1220056963-2352-8-git-send-email-gitster@pobox.com>
 <1220056963-2352-9-git-send-email-gitster@pobox.com>
 <1220056963-2352-10-git-send-email-gitster@pobox.com>
 <1220056963-2352-11-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZw-00076v-CH
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbYH3AnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYH3AnV
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:43:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbYH3AnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:43:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 56A946DC1A
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5DA236DC19 for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:15
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-11-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A23BDE80-762C-11DD-B458-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94350>

This lets you to check out 'our' (or 'their') version of an
unmerged path out of the index while resolving conflicts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |   47 ++++++++++++++++++++++++++++++++++++++++++-----
 t/t7201-co.sh      |   25 +++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 49c43d9..bdfdb65 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -24,6 +24,7 @@ struct checkout_opts {
 	int quiet;
 	int merge;
 	int force;
+	int writeout_stage;
 	int writeout_error;
 
 	const char *new_branch;
@@ -95,6 +96,32 @@ static int skip_same_name(struct cache_entry *ce, int pos)
 	return pos;
 }
 
+static int check_stage(int stage, struct cache_entry *ce, int pos)
+{
+	while (pos < active_nr &&
+	       !strcmp(active_cache[pos]->name, ce->name)) {
+		if (ce_stage(active_cache[pos]) == stage)
+			return 0;
+		pos++;
+	}
+	return error("path '%s' does not have %s version",
+		     ce->name,
+		     (stage == 2) ? "our" : "their");
+}
+
+static int checkout_stage(int stage, struct cache_entry *ce, int pos,
+			  struct checkout *state)
+{
+	while (pos < active_nr &&
+	       !strcmp(active_cache[pos]->name, ce->name)) {
+		if (ce_stage(active_cache[pos]) == stage)
+			return checkout_entry(active_cache[pos], state, NULL);
+		pos++;
+	}
+	return error("path '%s' does not have %s version",
+		     ce->name,
+		     (stage == 2) ? "our" : "their");
+}
 
 static int checkout_paths(struct tree *source_tree, const char **pathspec,
 			  struct checkout_opts *opts)
@@ -106,6 +133,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	int flag;
 	struct commit *head;
 	int errs = 0;
+	int stage = opts->writeout_stage;
 
 	int newfd;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
@@ -131,13 +159,16 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	/* Any unmerged paths? */
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
-		if (pathspec_match(pathspec, NULL, ce->name, 0) &&
-		    ce_stage(ce)) {
-			if (!opts->force) {
+		if (pathspec_match(pathspec, NULL, ce->name, 0)) {
+			if (!ce_stage(ce))
+				continue;
+			if (stage) {
+				errs |= check_stage(stage, ce, pos);
+			} else if (opts->force) {
+				warning("path '%s' is unmerged", ce->name);
+			} else {
 				errs = 1;
 				error("path '%s' is unmerged", ce->name);
-			} else {
-				warning("path '%s' is unmerged", ce->name);
 			}
 			pos = skip_same_name(ce, pos) - 1;
 			continue;
@@ -154,6 +185,8 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 		struct cache_entry *ce = active_cache[pos];
 		if (pathspec_match(pathspec, NULL, ce->name, 0)) {
 			if (ce_stage(ce)) {
+				if (stage)
+					errs |= checkout_stage(stage, ce, pos, &state);
 				pos = skip_same_name(ce, pos) - 1;
 				continue;
 			}
@@ -458,6 +491,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
+		OPT_SET_INT('2', "ours", &opts.writeout_stage, "stage",
+			    2),
+		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",
+			    3),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
 		OPT_END(),
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b7274eb..85c792c 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -414,4 +414,29 @@ test_expect_success 'checkout with an unmerged path can be ignored' '
 	test_cmp sample file
 '
 
+test_expect_success 'checkout unmerged stage' '
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
+	git checkout --ours . &&
+	test_cmp expect fild &&
+	test_cmp expect filf &&
+	test_cmp expect file &&
+	git checkout --theirs file &&
+	test ztheirside = "z$(cat file)"
+'
+
 test_done
-- 
1.6.0.1.149.ga4c44
