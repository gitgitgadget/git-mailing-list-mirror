Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747401F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeCTKL0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 06:11:26 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:60429 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeCTKLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 06:11:25 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yEEeeoX3nwheayEEkepmVh; Tue, 20 Mar 2018 10:11:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521540683;
        bh=zdApyYF8QZg8EPmXqphX046wqhQEXKNsCDIMh57s6fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=KOKGLo8I3KXn7rlVk9E7megOwCrry/FJHG1WmBn183P50jxzdZu8U23jebWpgSHQm
         7QuHggQo4pM/wr6GngrK/enkQ+EdXwc3o6WzXds7cI0BnttXe+ZKr+9cLudLs42yMh
         GfXbwW04x42Q+xVtici+g0tuKLbbIOyJvwMoz4F4=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=lbhvvuAQ99ReslbqRIUA:9
 a=IbXPrWutsH4lV3aq:21 a=M9ltfJvlFyWV1q3L:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] rebase --recreate-merges --keep-empty: don't prune empty commits
Date:   Tue, 20 Mar 2018 10:11:14 +0000
Message-Id: <20180320101114.17663-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320101114.17663-1-phillip.wood@talktalk.net>
References: <20180320101114.17663-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHjGM9PXMvt0Zpkvw4ILfYdpifDRqVfh9eJ34ioryoaU32pleOR9giKsRhw7lHGQSKlBXlfUmQbQjiyBxXyGaohhHAjrUh0KcvmseAE4O3Gctzc+gnj0
 bLw95vsGCL6Gn8JxnYMB7rVFVSObjN3S1A7CejDAh8kG1u79U08j9J4Msj6aFhJ9Vzmp/08GbymUkFjNO9BA/BuiDCQ3SWiLo4dM0AOa2K5JTegHKC0nk3JV
 /Ci2KglLPU/W50y6uCGAqKZAsB5GNS3MeefFkKMrxC18lOJ3gQHHl6tuh9iLpYAM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are empty commits on the left hand side of $upstream...HEAD
then the empty commits on the right hand side that we want to keep are
pruned because they are marked as cherry-picks. Fix this by keeping
the commits that are empty or are not marked as cherry-picks.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                       | 30 ++++++++++++++++--------------
 t/t3421-rebase-topology-linear.sh |  4 ++--
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d8cc63dbe4..da87c390ed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2975,14 +2975,15 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	 */
 	while ((commit = get_revision(revs))) {
 		struct commit_list *to_merge;
-		int is_octopus;
+		int is_octopus, is_empty;
 		const char *p1, *p2;
 		struct object_id *oid;
 
 		tail = &commit_list_insert(commit, tail)->next;
 		oidset_insert(&interesting, &commit->object.oid);
 
-		if ((commit->object.flags & PATCHSAME))
+		is_empty = is_original_commit_empty(commit);
+		if (!is_empty && (commit->object.flags & PATCHSAME))
 			continue;
 
 		strbuf_reset(&oneline);
@@ -2992,7 +2993,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		if (!to_merge) {
 			/* non-merge commit: easy case */
 			strbuf_reset(&buf);
-			if (!keep_empty && is_original_commit_empty(commit))
+			if (!keep_empty && is_empty)
 				strbuf_addf(&buf, "%c ", comment_line_char);
 			strbuf_addf(&buf, "%s %s %s", cmd_pick,
 				    oid_to_hex(&commit->object.oid),
@@ -3172,12 +3173,9 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 	init_revisions(&revs, NULL);
 	revs.verbose_header = 1;
-	if (recreate_merges)
-		revs.cherry_mark = 1;
-	else {
+	if (!recreate_merges)
 		revs.max_parents = 1;
-		revs.cherry_pick = 1;
-	}
+	revs.cherry_mark = 1;
 	revs.limited = 1;
 	revs.reverse = 1;
 	revs.right_only = 1;
@@ -3205,14 +3203,18 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 		return make_script_with_merges(&pp, &revs, out, flags);
 
 	while ((commit = get_revision(&revs))) {
+		int is_empty  = is_original_commit_empty(commit);
+
 		strbuf_reset(&buf);
-		if (!keep_empty && is_original_commit_empty(commit))
+		if (!keep_empty && is_empty)
 			strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, "%s %s ", insn,
-			    oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&pp, commit, &buf);
-		strbuf_addch(&buf, '\n');
-		fputs(buf.buf, out);
+		if (is_empty || !(commit->object.flags & PATCHSAME)) {
+			strbuf_addf(&buf, "%s %s ", insn,
+				    oid_to_hex(&commit->object.oid));
+			pretty_print_commit(&pp, commit, &buf);
+			strbuf_addch(&buf, '\n');
+			fputs(buf.buf, out);
+		}
 	}
 	strbuf_release(&buf);
 	return 0;
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index cb7f176f1d..7384010075 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -215,9 +215,9 @@ test_run_rebase () {
 }
 test_run_rebase success ''
 test_run_rebase failure -m
-test_run_rebase failure -i
+test_run_rebase success -i
 test_run_rebase failure -p
-test_run_rebase failure --recreate-merges
+test_run_rebase success --recreate-merges
 
 #       m
 #      /
-- 
2.16.2

