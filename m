Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517C4C35666
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 12:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB03206E0
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 12:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgBWM56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 07:57:58 -0500
Received: from hermes.apache.org ([207.244.88.153]:62089 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726592AbgBWM55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 07:57:57 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 07:57:57 EST
Received: (qmail 33520 invoked by uid 99); 23 Feb 2020 12:51:17 -0000
Received: from Unknown (HELO mailrelay1-lw-us.apache.org) (10.10.3.159)
    by apache.org (qpsmtpd/0.29) with ESMTP; Sun, 23 Feb 2020 12:51:17 +0000
Received: from serre.fritz.box (p54A2654B.dip0.t-ipconnect.de [84.162.101.75])
        by mailrelay1-lw-us.apache.org (ASF Mail Server at mailrelay1-lw-us.apache.org) with ESMTPA id 7E2842234;
        Sun, 23 Feb 2020 12:51:16 +0000 (UTC)
From:   Benno Evers <benno@bmevers.de>
To:     git@vger.kernel.org
Cc:     spearce@spearce.org, Benno Evers <benno@bmevers.de>
Subject: [PATCH] describe: dont abort too early when searching tags
Date:   Sun, 23 Feb 2020 13:51:02 +0100
Message-Id: <20200223125102.6697-1-benno@bmevers.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When searching the commit graph for tag candidates, `git-describe`
will stop as soon as there is only one active branch left and
it already found an annotated tag as a candidate.

This works well as long as all branches eventually connect back
to a common root, but if the tags are found across branches
with no common ancestor

                  B
                  o----.
                        \
          o-----o---o----x
          A

it can happen that the search on one branch terminates prematurely
because a tag was found on another, independent branch. This scenario
isn't quite as obscure as it sounds, since cloning with a limited
depth often introduces many independent "dead ends" into the commit
graph.

The help text of `git-describe` states pretty clearly that when
describing a commit D, the number appended to the emitted tag X should
correspond to the number of commits found by `git log X..D`.

Thus, this commit modifies the stopping condition to only abort
the search when only one branch is left to search *and* all current
best candidates are descendants from that branch.

Signed-off-by: Benno Evers <benno@bmevers.de>
---
We originally found this issue in one of our internal CI jobs,
which relied on `git-describe` to assign filenames to the generated
artifacts.
---
 builtin/describe.c  | 22 +++++++++++++++----
 t/t6120-describe.sh | 53 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b6df81d8d0..420f4c6401 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -376,11 +376,25 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 			if (!(c->object.flags & t->flag_within))
 				t->depth++;
 		}
+		/* Stop if last remaining path already covered by best candidate(s) */
 		if (annotated_cnt && !list) {
-			if (debug)
-				fprintf(stderr, _("finished search at %s\n"),
-					oid_to_hex(&c->object.oid));
-			break;
+			int best_depth = INT_MAX;
+			unsigned best_within = 0;
+			for (cur_match = 0; cur_match < match_cnt; cur_match++) {
+				struct possible_tag *t = &all_matches[cur_match];
+				if (t->depth < best_depth) {
+					best_depth = t->depth;
+					best_within = t->flag_within;
+				} else if (t->depth == best_depth) {
+					best_within |= t->flag_within;
+				}
+			}
+			if ((c->object.flags & best_within) == best_within) {
+				if (debug)
+					fprintf(stderr, _("finished search at %s\n"),
+						oid_to_hex(&c->object.oid));
+				break;
+			}
 		}
 		while (parents) {
 			struct commit *p = parents->item;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 09c50f3f04..d8cc08258e 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -479,4 +479,55 @@ test_expect_success 'name-rev covers all conditions while looking at parents' '
 	)
 '
 
-test_done
+#               B
+#               o
+#                \
+#  o-----o---o----x
+#        A
+#
+test_expect_success 'describe commits with disjoint bases' '
+	git init disjoint1 &&
+	(
+		cd disjoint1 &&
+
+		echo o >> file && git add file && git commit -m o &&
+		echo A >> file && git add file && git commit -m A &&
+		git tag A -a -m A &&
+		echo o >> file && git add file && git commit -m o &&
+
+		git checkout --orphan branch && rm file &&
+		echo B > file2 && git add file2 && git commit -m B &&
+		git tag B -a -m B &&
+		git merge --no-ff --allow-unrelated-histories master -m x &&
+
+		check_describe "A-3-*" HEAD
+	)
+'
+
+#           B
+#   o---o---o------------.
+#                         \
+#                  o---o---x
+#                  A
+#
+test_expect_success 'describe commits with disjoint bases 2' '
+	git init disjoint2 &&
+	(
+		cd disjoint2 &&
+
+		echo A >> file && git add file && GIT_COMMITTER_DATE="2020-01-01 18:00" git commit -m A &&
+		git tag A -a -m A &&
+		echo o >> file && git add file && GIT_COMMITTER_DATE="2020-01-01 18:01" git commit -m o &&
+
+		git checkout --orphan branch &&
+		echo o >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:00" git commit -m o &&
+		echo o >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:01" git commit -m o &&
+		echo B >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:02" git commit -m B &&
+		git tag B -a -m B &&
+		git merge --no-ff --allow-unrelated-histories master -m x &&
+
+		check_describe "B-3-*" HEAD
+	)
+'
+
+test_done
\ No newline at end of file
-- 
2.20.1

