Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9652027C
	for <e@80x24.org>; Wed, 31 May 2017 02:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbdEaC6H (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 22:58:07 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:38522
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751030AbdEaC6G (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 May 2017 22:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496199484;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Q3q5BzOeswCHN9COqeDlsNKPtKvQEgDY8/waEto3U7E=;
        b=O2zbgIOA279k2Gu6QB4dbUnrarOUaRNy5bqWl4fd6TdbL+J7gARgxPtkgJmz1FbL
        b0XICp78hclG75VUy2s4FBWmfHoEK81qVmzhcjlDa+6/XoTwncit86hzcfExfiNdsV3
        53pJZRvqnQJIWIhscNYc/PGQlJHfz9nuRI7sN0W0=
From:   Tyler Brazier <tyler@tylerbrazier.com>
To:     git@vger.kernel.org
Message-ID: <0102015c5c7054ac-5ec72a28-ff81-42b8-8224-26a588cef485-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c5166284d-d8dd6534-a8d5-452d-af14-d827934ef593-000000@eu-west-1.amazonses.com>
References: <0102015c5166284d-d8dd6534-a8d5-452d-af14-d827934ef593-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] pull: ff --rebase --autostash works in dirty repo
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 May 2017 02:58:04 +0000
X-SES-Outgoing: 2017.05.31-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git pull --rebase --autostash` in a dirty repository resulted in a
fast-forward, nothing was being autostashed and the pull failed. This
was due to a shortcut to avoid running rebase when we can fast-forward,
but autostash is ignored on that codepath.

Now we will only take the shortcut if autostash is not in effect.
Based on a few tests against the git.git repo, the shortcut does not
seem to give us significant performance benefits, on Linux at least.
Regardless, it is more important to be correct than to be fast.
---
 builtin/pull.c  | 25 ++++++++++++++-----------
 t/t5520-pull.sh | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index dd1a4a94e41e..42f0560252e0 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -772,6 +772,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
+	int autostash;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -800,8 +801,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_rebase && opt_autostash != -1)
 		die(_("--[no-]autostash option is only valid with --rebase."));
 
+	autostash = config_autostash;
 	if (opt_rebase) {
-		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -862,16 +863,18 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		die(_("Cannot rebase onto multiple branches."));
 
 	if (opt_rebase) {
-		struct commit_list *list = NULL;
-		struct commit *merge_head, *head;
-
-		head = lookup_commit_reference(orig_head.hash);
-		commit_list_insert(head, &list);
-		merge_head = lookup_commit_reference(merge_heads.oid[0].hash);
-		if (is_descendant_of(merge_head, list)) {
-			/* we can fast-forward this without invoking rebase */
-			opt_ff = "--ff-only";
-			return run_merge();
+		if (!autostash) {
+			struct commit_list *list = NULL;
+			struct commit *merge_head, *head;
+
+			head = lookup_commit_reference(orig_head.hash);
+			commit_list_insert(head, &list);
+			merge_head = lookup_commit_reference(merge_heads.oid[0].hash);
+			if (is_descendant_of(merge_head, list)) {
+				/* we can fast-forward this without invoking rebase */
+				opt_ff = "--ff-only";
+				return run_merge();
+			}
 		}
 		return run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
 	} else {
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 17f4d0fe4e72..f15f7a332960 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -272,6 +272,24 @@ test_expect_success '--rebase fast forward' '
 	test_cmp reflog.expected reflog.fuzzy
 '
 
+test_expect_success '--rebase --autostash fast forward' '
+	test_when_finished "
+		git reset --hard
+		git checkout to-rebase
+		git branch -D to-rebase-ff
+		git branch -D behind" &&
+	git branch behind &&
+	git checkout -b to-rebase-ff &&
+	echo another modification >>file &&
+	git add file &&
+	git commit -m mod &&
+
+	git checkout behind &&
+	echo dirty >file &&
+	git pull --rebase --autostash . to-rebase-ff &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse to-rebase-ff)"
+'
+
 test_expect_success '--rebase with conflicts shows advice' '
 	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
 	git checkout -b seq &&

--
https://github.com/git/git/pull/365
