Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482CC1F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 08:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbcI0IgQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 04:36:16 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:51339 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbcI0IgN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 04:36:13 -0400
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u8R8X9mN028966
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2016 08:33:09 GMT
Received: from lenuta.oracle.com (dhcp-ukc1-twvpn-3-vpnpool-10-175-228-237.vpn.oracle.com [10.175.228.237])
        by userv0022.oracle.com (8.14.4/8.13.8) with ESMTP id u8R8X4OI014972;
        Tue, 27 Sep 2016 08:33:05 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH v5] revision: new rev^-n shorthand for rev^n..rev
Date:   Tue, 27 Sep 2016 10:32:49 +0200
Message-Id: <20160927083249.31869-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.10.0.rc0.1.g07c9292
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git log rev^..rev" is commonly used to show all work done on and merged
from a side branch. This patch introduces a shorthand "rev^-" for this
and additionally allows "rev^-$n" to mean "reachable from rev, excluding
what is reachable from the nth parent of rev". For example, for a
two-parent merge, you can use rev^-2 to get the set of commits which were
made to the main branch while the topic branch was prepared.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

---
[v2: Use ^- instead of % as suggested by Junio Hamano and use some
 common helper functions for parsing.]

[v3: Use 'struct object_id' instead of 'char[20]' and add some tests as
 suggested by Matthieu Moy; fix missing '-' in Documentation/revisions.txt
 as suggested by Ramsay Jones; misc changelog + documentation fixes as
 suggested by Philip Oakley.]

[v4: Documentation fixes and parsing rework suggested by Junio Hamano
 and add some more tests.]

[v5: count parents before showing anything, misc testing changes, and
 changelog shortening as suggested by Junio Hamano, parent counting
 changes suggested by Jeff King.]
---
 Documentation/revisions.txt  | 17 +++++++-
 builtin/rev-parse.c          | 54 +++++++++++++++++++------
 revision.c                   | 34 ++++++++++++++--
 t/t6101-rev-parse-parents.sh | 94 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+), 19 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 4bed5b1..ba11b9c 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -283,7 +283,7 @@ empty range that is both reachable and unreachable from HEAD.
 
 Other <rev>{caret} Parent Shorthand Notations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Two other shorthands exist, particularly useful for merge commits,
+Three other shorthands exist, particularly useful for merge commits,
 for naming a set that is formed by a commit and its parent commits.
 
 The 'r1{caret}@' notation means all parents of 'r1'.
@@ -291,8 +291,15 @@ The 'r1{caret}@' notation means all parents of 'r1'.
 The 'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.
 By itself, this notation denotes the single commit 'r1'.
 
+The '<rev>{caret}-{<n>}' notation includes '<rev>' but excludes the <n>th
+parent (i.e. a shorthand for '<rev>{caret}<n>..<rev>'), with '<n>' = 1 if
+not given. This is typically useful for merge commits where you
+can just pass '<commit>{caret}-' to get all the commits in the branch
+that was merged in merge commit '<commit>' (including '<commit>'
+itself).
+
 While '<rev>{caret}<n>' was about specifying a single commit parent, these
-two notations consider all its parents. For example you can say
+three notations also consider its parents. For example you can say
 'HEAD{caret}2{caret}@', however you cannot say 'HEAD{caret}@{caret}2'.
 
 Revision Range Summary
@@ -326,6 +333,10 @@ Revision Range Summary
   as giving commit '<rev>' and then all its parents prefixed with
   '{caret}' to exclude them (and their ancestors).
 
+'<rev>{caret}-{<n>}', e.g. 'HEAD{caret}-, HEAD{caret}-2'::
+	Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
+	given.
+
 Here are a handful of examples using the Loeliger illustration above,
 with each step in the notation's expansion and selection carefully
 spelt out:
@@ -339,6 +350,8 @@ spelt out:
    C                            I J F C
    B..C   = ^B C                C
    B...C  = B ^F C              G H D E B C
+   B^-    = B^..B
+	  = ^B^1 B              E I J F B
    C^@    = C^1
 	  = F                   I J F
    B^@    = B^1 B^2 B^3
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 76cf05e..4da1f1d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -298,14 +298,30 @@ static int try_parent_shorthands(const char *arg)
 	unsigned char sha1[20];
 	struct commit *commit;
 	struct commit_list *parents;
-	int parents_only;
-
-	if ((dotdot = strstr(arg, "^!")))
-		parents_only = 0;
-	else if ((dotdot = strstr(arg, "^@")))
-		parents_only = 1;
-
-	if (!dotdot || dotdot[2])
+	int parent_number;
+	int include_rev = 0;
+	int include_parents = 0;
+	int exclude_parent = 0;
+
+	if ((dotdot = strstr(arg, "^!"))) {
+		include_rev = 1;
+		if (dotdot[2])
+			return 0;
+	} else if ((dotdot = strstr(arg, "^@"))) {
+		include_parents = 1;
+		if (dotdot[2])
+			return 0;
+	} else if ((dotdot = strstr(arg, "^-"))) {
+		include_rev = 1;
+		exclude_parent = 1;
+
+		if (dotdot[2]) {
+			char *end;
+			exclude_parent = strtoul(dotdot + 2, &end, 10);
+			if (*end != '\0' || !exclude_parent)
+				return 0;
+		}
+	} else
 		return 0;
 
 	*dotdot = 0;
@@ -314,12 +330,24 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 	}
 
-	if (!parents_only)
-		show_rev(NORMAL, sha1, arg);
 	commit = lookup_commit_reference(sha1);
-	for (parents = commit->parents; parents; parents = parents->next)
-		show_rev(parents_only ? NORMAL : REVERSED,
-				parents->item->object.oid.hash, arg);
+	if (exclude_parent &&
+	    exclude_parent > commit_list_count(commit->parents)) {
+		*dotdot = '^';
+		return 0;
+	}
+
+	if (include_rev)
+		show_rev(NORMAL, sha1, arg);
+	for (parents = commit->parents, parent_number = 1;
+	     parents;
+	     parents = parents->next, parent_number++) {
+		if (exclude_parent && parent_number != exclude_parent)
+			continue;
+
+		show_rev(include_parents ? NORMAL : REVERSED,
+			 parents->item->object.oid.hash, arg);
+	}
 
 	*dotdot = '^';
 	return 1;
diff --git a/revision.c b/revision.c
index 969b3d1..b37dbec 100644
--- a/revision.c
+++ b/revision.c
@@ -1289,12 +1289,14 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 	}
 }
 
-static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
+static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
+			    int exclude_parent)
 {
 	unsigned char sha1[20];
 	struct object *it;
 	struct commit *commit;
 	struct commit_list *parents;
+	int parent_number;
 	const char *arg = arg_;
 
 	if (*arg == '^') {
@@ -1316,7 +1318,15 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
 	if (it->type != OBJ_COMMIT)
 		return 0;
 	commit = (struct commit *)it;
-	for (parents = commit->parents; parents; parents = parents->next) {
+	if (exclude_parent &&
+	    exclude_parent > commit_list_count(commit->parents))
+		return 0;
+	for (parents = commit->parents, parent_number = 1;
+	     parents;
+	     parents = parents->next, parent_number++) {
+		if (exclude_parent && parent_number != exclude_parent)
+			continue;
+
 		it = &parents->item->object;
 		it->flags |= flags;
 		add_rev_cmdline(revs, it, arg_, REV_CMD_PARENTS_ONLY, flags);
@@ -1519,17 +1529,33 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		}
 		*dotdot = '.';
 	}
+
 	dotdot = strstr(arg, "^@");
 	if (dotdot && !dotdot[2]) {
 		*dotdot = 0;
-		if (add_parents_only(revs, arg, flags))
+		if (add_parents_only(revs, arg, flags, 0))
 			return 0;
 		*dotdot = '^';
 	}
 	dotdot = strstr(arg, "^!");
 	if (dotdot && !dotdot[2]) {
 		*dotdot = 0;
-		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM)))
+		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), 0))
+			*dotdot = '^';
+	}
+	dotdot = strstr(arg, "^-");
+	if (dotdot) {
+		int exclude_parent = 1;
+
+		if (dotdot[2]) {
+			char *end;
+			exclude_parent = strtoul(dotdot + 2, &end, 10);
+			if (*end != '\0' || !exclude_parent)
+				return -1;
+		}
+
+		*dotdot = 0;
+		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), exclude_parent))
 			*dotdot = '^';
 	}
 
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 1c6952d..64a9850 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -102,4 +102,98 @@ test_expect_success 'short SHA-1 works' '
 	test_cmp_rev_output start "git rev-parse ${start%?}"
 '
 
+# rev^- tests; we can use a simpler setup for these
+
+test_expect_success 'setup for rev^- tests' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+
+	# Merge in a branch for testing rev^-
+	git checkout -b branch &&
+	git checkout HEAD^^ &&
+	git merge -m merge --no-edit --no-ff branch &&
+	git checkout -b merge
+'
+
+# The merged branch has 2 commits + the merge
+test_expect_success 'rev-list --count merge^- = merge^..merge' '
+	git rev-list --count merge^..merge >expect &&
+	echo 3 >actual &&
+	test_cmp expect actual
+'
+
+# All rev^- rev-parse tests
+
+test_expect_success 'rev-parse merge^- = merge^..merge' '
+	git rev-parse merge^..merge >expect &&
+	git rev-parse merge^- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-parse merge^-1 = merge^..merge' '
+	git rev-parse merge^1..merge >expect &&
+	git rev-parse merge^-1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-parse merge^-2 = merge^2..merge' '
+	git rev-parse merge^2..merge >expect &&
+	git rev-parse merge^-2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-parse merge^-0 (invalid parent)' '
+	test_must_fail git rev-parse merge^-0
+'
+
+test_expect_success 'rev-parse merge^-3 (invalid parent)' '
+	test_must_fail git rev-parse merge^-3
+'
+
+test_expect_success 'rev-parse merge^-^ (garbage after ^-)' '
+	test_must_fail git rev-parse merge^-^
+'
+
+test_expect_success 'rev-parse merge^-1x (garbage after ^-1)' '
+	test_must_fail git rev-parse merge^-1x
+'
+
+# All rev^- rev-list tests (should be mostly the same as rev-parse; the reason
+# for the duplication is that rev-parse and rev-list use different parsers).
+
+test_expect_success 'rev-list merge^- = merge^..merge' '
+	git rev-list merge^..merge >expect &&
+	git rev-list merge^- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list merge^-1 = merge^1..merge' '
+	git rev-list merge^1..merge >expect &&
+	git rev-list merge^-1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list merge^-2 = merge^2..merge' '
+	git rev-list merge^2..merge >expect &&
+	git rev-list merge^-2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list merge^-0 (invalid parent)' '
+	test_must_fail git rev-list merge^-0
+'
+
+test_expect_success 'rev-list merge^-3 (invalid parent)' '
+	test_must_fail git rev-list merge^-3
+'
+
+test_expect_success 'rev-list merge^-^ (garbage after ^-)' '
+	test_must_fail git rev-list merge^-^
+'
+
+test_expect_success 'rev-list merge^-1x (garbage after ^-1)' '
+	test_must_fail git rev-list merge^-1x
+'
+
 test_done
-- 
2.10.0.rc0.1.g07c9292

