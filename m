Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A72F1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933231AbdCaNwC (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:52:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57686 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933000AbdCaNvk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:51:40 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue004
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0M0v6Z-1bzdHe2xSh-00v7K7; Fri, 31
 Mar 2017 15:51:33 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH v3 2/4] name-rev: favor describing with tags and use committer date to tiebreak
Date:   Fri, 31 Mar 2017 15:51:22 +0200
Message-Id: <aa0bac0a16647c74283fb392046409da094d2e41.1490967948.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.739.gfc3eb97820
In-Reply-To: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1490967948.git.git@grubix.eu>
References: <cover.1490967948.git.git@grubix.eu>
X-Provags-ID: V03:K0:nVPBuAP0SjMtxizzZ1aQbR/gPsff0UlywriJYID8M160qVyXQWj
 9TAWaL+pzKiU9O7LsUJbnEKvdU5FgFXJN+kbVAOcbhB8JU1a3qkNqkApk1D6C+mqc+atsK8
 o2Yl1ONkNjMdxu8dwhZ5S6HtEI9n30m216fzheAkH9QMk3OOm0/yD0EagZ86Cw7ffFYLiC7
 GVpR2k/F5+OTMmjerjEbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zo9KoglaQKc=:4Wt0zUXY6DXT5X4UK/yH7B
 22pdct5yKekozaHSAG1M7UG+gM2oWg8Zce1X6aAmoozBxvsVQiFT+0BzlNV/lPYicM1d4Grjf
 W0XeQf37hrRsey7F23Dh2lLVEiIzyBb3u6OZCJCT1STVPOeWNksqrEQ7Kpd2lOt55G1RTrW9a
 198GS9LXpOMv2t6bfql1gGqJ1ow0TnkGJy7QJU8+dNzBIC0Djts1T6gCVRgE3T/HrJRrDM/+D
 9m9ap1AjeLUjmuQ/Kfq9POHfxb2U+vpkxobFWoxsUQry0j6K+z10yiY0nWlo7Ii8LchzGt4Ek
 YmaGXugmQ7TfcYpz+at23ofD7B7Gum6nVN/Pbr/AOZv1BFmwui2g6bvk9BbYzjIQA7CH7EpTh
 OPG1tJGD6ThJOY95Bb6rAj0JGO0dlMUu3nqs5Hiew77f6vlZ7wudtzIapw1tFfWbTVyz2Aq9y
 ZRbNxXntMkNWY01TE1lhrRc1mh4ulTTT4ea3uz8/3dMi3HnnM5FUToOYZ+Li6704wkb6pqB2/
 oaO2Ssxl+DbS8h5hlx38xmCo0lbSypp3kfnej9tapdd3OSA0YyqlVvz54Iz+xKzpxzcpED97/
 q2BJCmodcG7oxmLUmd7aEqxU7aVb5XongtBYrQB/s0NxY4ZdHWC05Tfn6L3aCOTpqmeUOWzcu
 vyzXLjA/OMF4lCbc9x1dnuEli6p+n4uCzgBa4QtnK+75g3kSfbPxFACt3EmwGJAq/dhs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

"git name-rev" assigned a phony "far in the future" date to tips of
refs that are not pointing at tag objects, and favored names based
on a ref with the oldest date.  This made it almost impossible for
an unannotated tags and branches to be counted as a viable base,
which was especially problematic when the command is run with the
"--tags" option.  If an unannotated tag that points at an ancient
commit and an annotated tag that points at a much newer commit
reaches the commit that is being named, the old unannotated tag was
ignored.

Update the "taggerdate" field of the rev-name structure, which is
initialized from the tip of ref, to have the committer date if the
object at the tip of ref is a commit, not a tag, so that we can
optionally take it into account when doing "is this name better?"
comparison logic.

When "name-rev" is run without the "--tags" option, the general
expectation is still to name the commit based on a tag if possible,
but use non-tag refs as fallback, and tiebreak among these non-tag
refs by favoring names with shorter hops from the tip.  The use of a
phony "far in the future" date in the original code was an effective
way to ensure this expectation is held: a non-tag tip gets the same
"far in the future" timestamp, giving precedence to tags, and among
non-tag tips, names with shorter hops are preferred over longer
hops, without taking the "taggerdate" into account.  As we are
taking over the "taggerdate" field to store the committer date for
tips with commits:

 (1) keep the original logic when comparing names based on two refs
     both of which are from refs/tags/;

 (2) favoring a name based on a ref in refs/tags/ hierarchy over
     a ref outside the hierarchy;

 (3) between two names based on a ref both outside refs/tags/, give
     precedence to a name with shorter hops and use "taggerdate"
     only to tie-break.

A change to t4202 is a natural consequence.  The test creates a
commit on a branch "side" and points at it with an unannotated tag
"refs/tags/side-2".  The original code couldn't decide which one to
favor at all, and gave a name based on a branch (simply because
refs/heads/side sorts earlier than refs/tags/side-2).  Because the
updated logic is taught to favor refs in refs/tags/ hierarchy, the
the test is updated to expect to see tags/side-2 instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am sure others can add better heurisitics in is_better_name()
   for comparing names based on non-tag refs, and I do not mind
   people disagreeing with the logic that this patch happens to
   implement.  This is done primarily to illustrate the value of
   using a separate helper function is_better_name() instead of
   open-coding the selection logic in name_rev() function.
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/name-rev.c | 53 ++++++++++++++++++++++++++++++++++++++++++++---------
 t/t4202-log.sh     |  2 +-
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 7890f826ce..bf7ed015ae 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -13,6 +13,7 @@ typedef struct rev_name {
 	unsigned long taggerdate;
 	int generation;
 	int distance;
+	int from_tag;
 } rev_name;
 
 static long cutoff = LONG_MAX;
@@ -24,16 +25,43 @@ static int is_better_name(struct rev_name *name,
 			  const char *tip_name,
 			  unsigned long taggerdate,
 			  int generation,
-			  int distance)
+			  int distance,
+			  int from_tag)
 {
-	return (name->taggerdate > taggerdate ||
-		(name->taggerdate == taggerdate &&
-		 name->distance > distance));
+	/*
+	 * When comparing names based on tags, prefer names
+	 * based on the older tag, even if it is farther away.
+	 */
+	if (from_tag && name->from_tag)
+		return (name->taggerdate > taggerdate ||
+			(name->taggerdate == taggerdate &&
+			 name->distance > distance));
+
+	/*
+	 * We know that at least one of them is a non-tag at this point.
+	 * favor a tag over a non-tag.
+	 */
+	if (name->from_tag != from_tag)
+		return from_tag;
+
+	/*
+	 * We are now looking at two non-tags.  Tiebreak to favor
+	 * shorter hops.
+	 */
+	if (name->distance != distance)
+		return name->distance > distance;
+
+	/* ... or tiebreak to favor older date */
+	if (name->taggerdate != taggerdate)
+		return name->taggerdate > taggerdate;
+
+	/* keep the current one if we cannot decide */
+	return 0;
 }
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, unsigned long taggerdate,
-		int generation, int distance,
+		int generation, int distance, int from_tag,
 		int deref)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
@@ -57,12 +85,13 @@ static void name_rev(struct commit *commit,
 		commit->util = name;
 		goto copy_data;
 	} else if (is_better_name(name, tip_name, taggerdate,
-				  generation, distance)) {
+				  generation, distance, from_tag)) {
 copy_data:
 		name->tip_name = tip_name;
 		name->taggerdate = taggerdate;
 		name->generation = generation;
 		name->distance = distance;
+		name->from_tag = from_tag;
 	} else
 		return;
 
@@ -82,10 +111,12 @@ static void name_rev(struct commit *commit,
 						   parent_number);
 
 			name_rev(parents->item, new_name, taggerdate, 0,
-				distance + MERGE_TRAVERSAL_WEIGHT, 0);
+				 distance + MERGE_TRAVERSAL_WEIGHT,
+				 from_tag, 0);
 		} else {
 			name_rev(parents->item, tip_name, taggerdate,
-				generation + 1, distance + 1, 0);
+				 generation + 1, distance + 1,
+				 from_tag, 0);
 		}
 	}
 }
@@ -216,9 +247,13 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
+		int from_tag = starts_with(path, "refs/tags/");
 
+		if (taggerdate == ULONG_MAX)
+			taggerdate = ((struct commit *)o)->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), taggerdate, 0, 0, deref);
+		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
+			 from_tag, deref);
 	}
 	return 0;
 }
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index f577990716..4afd8135cd 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -399,7 +399,7 @@ cat > expect <<\EOF
 | |
 | |     Merge branch 'side'
 | |
-| * commit side
+| * commit tags/side-2
 | | Author: A U Thor <author@example.com>
 | |
 | |     side-2
-- 
2.12.2.739.gfc3eb97820

