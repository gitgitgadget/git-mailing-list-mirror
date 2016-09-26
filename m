Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF23207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 20:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938928AbcIZUxR (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 16:53:17 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:33497 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750754AbcIZUxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 16:53:16 -0400
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u8QKoAju024204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2016 20:50:10 GMT
Received: from lenuta.oracle.com (dhcp-ukc1-twvpn-2-vpnpool-10-175-218-147.vpn.oracle.com [10.175.218.147])
        by userv0022.oracle.com (8.14.4/8.13.8) with ESMTP id u8QKo5Ae020188;
        Mon, 26 Sep 2016 20:50:06 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [RFC PATCH v4] revision: new rev^-n shorthand for rev^n..rev
Date:   Mon, 26 Sep 2016 22:49:59 +0200
Message-Id: <20160926204959.26007-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.10.0.rc0.1.g07c9292
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I often use rev^..rev to get all the commits in the branch that was merged
in by the merge commit 'rev' (including the merge itself). To save typing
(or copy-pasting, if the rev is long -- like a full SHA-1 or branch name)
we can make rev^- a shorthand for that.

The existing syntax rev^! seems like it should do the same thing, but it
doesn't really do the right thing for merge commits (it doesn't include
the commits from side branches).

As a natural generalisation, we also accept rev^-n where n excludes the
nth parent of rev. For example, for a two-parent merge, you can use rev^-2
to get the set of commits which were made to the main branch while the
topic branch was prepared.

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
---
 Documentation/revisions.txt     | 17 +++++++-
 builtin/rev-parse.c             | 47 +++++++++++++++------
 revision.c                      | 32 +++++++++++++--
 t/t6070-rev-parent-exclusion.sh | 90 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+), 18 deletions(-)
 create mode 100755 t/t6070-rev-parent-exclusion.sh

diff --git Documentation/revisions.txt Documentation/revisions.txt
index 4bed5b1..ba11b9c 100644
--- Documentation/revisions.txt
+++ Documentation/revisions.txt
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
diff --git builtin/rev-parse.c builtin/rev-parse.c
index 76cf05e..2c3da19 100644
--- builtin/rev-parse.c
+++ builtin/rev-parse.c
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
@@ -314,14 +330,21 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 	}
 
-	if (!parents_only)
+	if (include_rev)
 		show_rev(NORMAL, sha1, arg);
 	commit = lookup_commit_reference(sha1);
-	for (parents = commit->parents; parents; parents = parents->next)
-		show_rev(parents_only ? NORMAL : REVERSED,
-				parents->item->object.oid.hash, arg);
+	for (parent_number = 1, parents = commit->parents;
+	     parents; parents = parents->next, parent_number++) {
+		if (exclude_parent && parent_number != exclude_parent)
+			continue;
+
+		show_rev(include_parents ? NORMAL : REVERSED,
+			 parents->item->object.oid.hash, arg);
+	}
 
 	*dotdot = '^';
+	if (exclude_parent >= parent_number)
+		return 0;
 	return 1;
 }
 
diff --git revision.c revision.c
index 969b3d1..9ae95bf 100644
--- revision.c
+++ revision.c
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
@@ -1316,12 +1318,18 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
 	if (it->type != OBJ_COMMIT)
 		return 0;
 	commit = (struct commit *)it;
-	for (parents = commit->parents; parents; parents = parents->next) {
+	for (parent_number = 1, parents = commit->parents;
+	     parents; parents = parents->next, parent_number++) {
+		if (exclude_parent && parent_number != exclude_parent)
+			continue;
+
 		it = &parents->item->object;
 		it->flags |= flags;
 		add_rev_cmdline(revs, it, arg_, REV_CMD_PARENTS_ONLY, flags);
 		add_pending_object(revs, it, arg);
 	}
+	if (exclude_parent >= parent_number)
+		return 0;
 	return 1;
 }
 
@@ -1519,17 +1527,33 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
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
 
diff --git t/t6070-rev-parent-exclusion.sh t/t6070-rev-parent-exclusion.sh
new file mode 100755
index 0000000..e6e5a8d
--- /dev/null
+++ t/t6070-rev-parent-exclusion.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+test_description='rev-list/rev-parse rev^- parsing'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+
+	# Merge in a branch for testing ^-
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
+# All rev-parse tests
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
+test_expect_success 'rev-parse merge^-0' '
+	test_must_fail git rev-parse merge^-0
+'
+
+test_expect_success 'rev-parse merge^-3' '
+	test_must_fail git rev-parse merge^-3
+'
+
+test_expect_success 'rev-parse merge^-^' '
+	test_must_fail git rev-parse merge^-^
+'
+
+# All rev-list tests (should be mostly the same as rev-parse)
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
+test_expect_success 'rev-list merge^-0' '
+	test_must_fail git rev-list merge^-0
+'
+
+test_expect_success 'rev-list merge^-3' '
+	test_must_fail git rev-list merge^-3
+'
+
+test_expect_success 'rev-list merge^-^' '
+	test_must_fail git rev-list merge^-^
+'
+
+test_done
-- 
2.10.0.rc0.1.g07c9292

