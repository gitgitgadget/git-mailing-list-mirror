Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27C51F424
	for <e@80x24.org>; Mon, 16 Apr 2018 09:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754509AbeDPJjy (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 05:39:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34995 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754175AbeDPJju (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Apr 2018 05:39:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 102E621C0D;
        Mon, 16 Apr 2018 05:39:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 16 Apr 2018 05:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=YVfL9NCT6u6ydm8A7hl8G4GEgx08zdFdSVzhuMA7oUY=; b=glzuBldW
        b3xhAQM4eXVMDtoIYeD6DQH8NAgFcF/sZtzTlz76dIZhWqR4ldlxMRnp9SCOw8HZ
        Y3PraetQZAimWHgQ8XxWz23mytP4tYJ4sqYs9GQP3PZI5yaxWLsYn0pQ0MbvO/fe
        to0OWUFCpowXRtKAVpi9hyZxfpaFXIYB8i/ZSypGwZiUzf2YutOLIpngIM7qfyGh
        h6EUmH/rDd5vmo5PUmkynmaO488GJ6MxZoUE7MBmWsRzQZuUHx+6naC5jS4tOUdc
        oSsKekF2S5WyrxAXqjTGLkSvpaeT2bHJ6ZDNY64RWpz2NInknCbXlv1YYYJLTXw4
        w/AdTQWdQ9qvpQ==
X-ME-Sender: <xms:Zm_UWvHHNVP2rJLzMilpk_LAzVlso4wQERoAwtKil_x1LEUZ2--VEA>
Received: from bod.fritz.box (p5482623f.dip0.t-ipconnect.de [84.130.98.63])
        by mail.messagingengine.com (Postfix) with ESMTPA id 86413E49AD;
        Mon, 16 Apr 2018 05:39:49 -0400 (EDT)
Received: by bod.fritz.box (Postfix, from userid 1000)
        id 430647C05C7; Mon, 16 Apr 2018 11:39:48 +0200 (CEST)
From:   Michael Vogt <mvo@ubuntu.com>
To:     git@vger.kernel.org, sbeller@google.com, avarab@gmail.com
Cc:     Michael Vogt <mvo@ubuntu.com>
Subject: [PATCH] show: add --follow-symlinks option for <rev>:<path>
Date:   Mon, 16 Apr 2018 11:36:25 +0200
Message-Id: <20180416093625.15752-2-mvo@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180416093625.15752-1-mvo@ubuntu.com>
References: <87fu3yg6od.fsf@evledraar.gmail.com>
 <20180416093625.15752-1-mvo@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --follow-symlinks option that'll resolve symlinks to their
targets when the target is of the form <rev>:<path>.

Without it, git will show the path of the link itself if the symlink
is the leaf node of <path>, or otherwise an error if some component
of <path> is a symlink to another location in the repository. With
the new --follow-symlinks option both will be resolved to their
target, and its content shown instead.

Signed-off-by: Michael Vogt <mvo@ubuntu.com>
---
 Documentation/git-show.txt |  7 +++++++
 builtin/log.c              |  6 +++++-
 revision.c                 |  2 ++
 revision.h                 |  1 +
 t/t1800-git-show.sh        | 41 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100755 t/t1800-git-show.sh

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index e73ef5401..e2634b27e 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -39,6 +39,13 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
+--follow-symlinks::
+	Follow symlinks inside the repository when requesting objects
+	in extended revision syntax of the form tree-ish:path-in-tree.
+	It will resolve any symlinks in <path-in-tree> and shows the
+	content	of the link if the symlink is the leaf node of
+	<path-in-tree>.
+
 include::pretty-options.txt[]
 
 
diff --git a/builtin/log.c b/builtin/log.c
index 94ee177d5..7d815b8ea 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -142,7 +142,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0, mailmap = 0;
+	int quiet = 0, source = 0, mailmap = 0, follow_symlinks = 0;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
@@ -162,6 +162,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
 			     N_("Process line range n,m in file, counting from 1"),
 			     log_line_range_callback),
+		OPT_BOOL(0, "follow-symlinks", &follow_symlinks,
+			 N_("follow in-tree symlinks (used when showing file content)")),
 		OPT_END()
 	};
 
@@ -176,6 +178,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 
 	if (quiet)
 		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
+	if (follow_symlinks)
+		rev->follow_symlinks = 1;
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	/* Any arguments at this point are not recognized */
diff --git a/revision.c b/revision.c
index b42c836d7..4ab22313f 100644
--- a/revision.c
+++ b/revision.c
@@ -1678,6 +1678,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags |= GET_OID_COMMITTISH;
+	if (revs && revs->follow_symlinks)
+		get_sha1_flags |= GET_OID_FOLLOW_SYMLINKS;
 
 	if (get_oid_with_context(arg, get_sha1_flags, &oid, &oc))
 		return revs->ignore_missing ? 0 : -1;
diff --git a/revision.h b/revision.h
index b8c47b98e..060f1038a 100644
--- a/revision.h
+++ b/revision.h
@@ -122,6 +122,7 @@ struct rev_info {
 			first_parent_only:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
+			follow_symlinks:1,
 
 			/* for internal use only */
 			exclude_promisor_objects:1;
diff --git a/t/t1800-git-show.sh b/t/t1800-git-show.sh
new file mode 100755
index 000000000..7a02438ec
--- /dev/null
+++ b/t/t1800-git-show.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='Test git show works'
+
+. ./test-lib.sh
+
+test_expect_success 'verify git show HEAD:foo works' '
+	test_commit A &&
+	git show HEAD:A.t >actual &&
+	echo A >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success SYMLINKS 'verify git show HEAD:symlink shows symlink points to foo' '
+	ln -s A.t A.link &&
+	git add A.link &&
+	git commit -m"Added symlink to A.t" &&
+	git show HEAD:A.link >actual &&
+	printf "%s" A.t >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success SYMLINKS 'verify git show --follow-symlinks HEAD:symlink shows foo' '
+	git show --follow-symlinks HEAD:A.link >actual &&
+	echo A >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success SYMLINKS 'verify git show --follow-symlinks HEAD:symlink works with subdirs' '
+	mkdir dir &&
+	ln -s dir symlink-to-dir &&
+	test_commit dir/B &&
+	git add dir symlink-to-dir &&
+	git commit -m "add dir and symlink-to-dir" &&
+	test_must_fail git show HEAD:symlink-to-dir/B.t >actual &&
+	git show --follow-symlinks HEAD:symlink-to-dir/B.t >actual &&
+	echo dir/B >expected &&
+	test_cmp expected actual
+'
+
+test_done
-- 
2.17.0

