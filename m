Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E199201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 02:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933664AbdKPCBA (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 21:01:00 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:44236 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932458AbdKPCAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 21:00:53 -0500
Received: by mail-io0-f194.google.com with SMTP id w127so3647006iow.11
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 18:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TP4crpaCI/YLD3vHHsxAICue1GQ6qdhCNZBp9MwUnQc=;
        b=YvB01HWhn1kbp/nDCoRlNOa4HIoUgM0qPiYdaD/lGYeV66aTzn0VEyXumY5yA46nXY
         y2dqz5m6bBREFMtikGuI7PigkwG+SulY2MyR75DnykJgsI7QUcjokZaBB6z4HTq3mnpl
         oOK3DBzmVMzokm/ziWXMGIKf0Yc+jF1j84z5SZ6JxrSLbr1YL92k65KsZ8r/jcR+FXqE
         9/EM6XwIQ+tnnScHrzR1ZdQx+HJeA99Q+hA1t1XQB5hQ2zoz5ShReS1Or0+jH2H8kYoT
         VNRKpBI0d1sOM97CefoVfJe4F/mWKJs/TyKVTNQoaP4uSj4vhq+NG7odtrc82qAgB/0Y
         2DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TP4crpaCI/YLD3vHHsxAICue1GQ6qdhCNZBp9MwUnQc=;
        b=k74M0Cv22Xn7lE7dDMXDYlFoTquFVLsZb5kw2DnbTlkjLx2cnhEdKzqBIIt5IGqWV0
         lYVY8h75VAjLuohuVrCO1Ahrk2fPwLrb4jChonmQ18sbW3Fl6wGV4n7c+lsEnU/6B/Py
         3WrMH2XWGVLAOrN0j+aoUTi+F50SiXL0O2URjS+vFyqjB6cllU2uJ1Qva+iSmKX6TiGy
         OIvaMMFAsFe/eTbUEpw0x80kROENCBx0ANUop0am6yVnY/vyIzyaxMsknVOjBise6VeX
         d5Lea7CdeXI12wEbD7zHyuC3fvkOSuKo+5jIiKyKcnVNBTGZemiN7tWPJcRRlSPz5kVf
         CVEg==
X-Gm-Message-State: AJaThX4zz0ORnSjoaHzd1VPPYL8u1pIVsWWN7r9wLxEZ6E+JNHlkeg19
        /f+gT/Z6JAsDgA0XvQaT/m4Uc9JiDbw=
X-Google-Smtp-Source: AGs4zMbMd/+k6APQn0Py2JI7GLnpcSvUQFtr+4ksnPKH+zobFyR3E05DXE1gNe8k3IBsrz9b8k8Cqg==
X-Received: by 10.107.6.169 with SMTP id f41mr57197ioi.173.1510797652085;
        Wed, 15 Nov 2017 18:00:52 -0800 (PST)
Received: from localhost ([2620:0:100e:422:34c9:3de6:9af7:a340])
        by smtp.gmail.com with ESMTPSA id p68sm187344itc.26.2017.11.15.18.00.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 18:00:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 3/7] revision.h: introduce blob/tree walking in order of the commits
Date:   Wed, 15 Nov 2017 18:00:35 -0800
Message-Id: <20171116020039.17810-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171116020039.17810-1-sbeller@google.com>
References: <20171116020039.17810-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functionality to list tree objects in the order they were seen
while traversing the commits will be used in one of the next commits,
where we teach `git describe` to describe not only commits, but blobs, too.

The change in list-objects.c is rather minimal as we'll be re-using
the infrastructure put in place of the revision walking machinery. For
example one could expect that add_pending_tree is not called, but rather
commit->tree is directly passed to the tree traversal function. This
however requires a lot more code than just emptying the queue containing
trees after each commit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/rev-list-options.txt |  5 +++
 list-objects.c                     |  8 ++++
 revision.c                         |  2 +
 revision.h                         |  3 +-
 t/t6100-rev-list-in-order.sh       | 77 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100755 t/t6100-rev-list-in-order.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 13501e1556..9066e0c777 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -686,6 +686,11 @@ ifdef::git-rev-list[]
 	all object IDs which I need to download if I have the commit
 	object _bar_ but not _foo_''.
 
+--in-commit-order::
+	Print tree and blob ids in order of the commits. The tree
+	and blob ids are printed after they are first referenced
+	by a commit.
+
 --objects-edge::
 	Similar to `--objects`, but also print the IDs of excluded
 	commits prefixed with a ``-'' character.  This is used by
diff --git a/list-objects.c b/list-objects.c
index 7c2ce9c4bd..4caa6fcb77 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -239,6 +239,14 @@ void traverse_commit_list(struct rev_info *revs,
 		if (commit->tree)
 			add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
+
+		if (revs->tree_blobs_in_commit_order)
+			/*
+			 * NEEDSWORK: Adding the tree and then flushing it here
+			 * needs a reallocation for each commit. Can we pass the
+			 * tree directory without allocation churn?
+			 */
+			traverse_trees_and_blobs(revs, &csp, show_object, data);
 	}
 	traverse_trees_and_blobs(revs, &csp, show_object, data);
 
diff --git a/revision.c b/revision.c
index d167223e69..9329d4ebbf 100644
--- a/revision.c
+++ b/revision.c
@@ -1845,6 +1845,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->dense = 0;
 	} else if (!strcmp(arg, "--show-all")) {
 		revs->show_all = 1;
+	} else if (!strcmp(arg, "--in-commit-order")) {
+		revs->tree_blobs_in_commit_order = 1;
 	} else if (!strcmp(arg, "--remove-empty")) {
 		revs->remove_empty_trees = 1;
 	} else if (!strcmp(arg, "--merges")) {
diff --git a/revision.h b/revision.h
index 54761200ad..86985d68aa 100644
--- a/revision.h
+++ b/revision.h
@@ -121,7 +121,8 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
-			line_level_traverse:1;
+			line_level_traverse:1,
+			tree_blobs_in_commit_order:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
new file mode 100755
index 0000000000..b2bb0a7f61
--- /dev/null
+++ b/t/t6100-rev-list-in-order.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+
+test_description='rev-list testing in-commit-order'
+
+. ./test-lib.sh
+
+test_expect_success 'setup a commit history with trees, blobs' '
+	for x in one two three four
+	do
+		echo $x >$x &&
+		git add $x &&
+		git commit -m "add file $x" ||
+		return 1
+	done &&
+	for x in four three
+	do
+		git rm $x &&
+		git commit -m "remove $x" ||
+		return 1
+	done
+'
+
+test_expect_success 'rev-list --in-commit-order' '
+	git rev-list --in-commit-order --objects HEAD >actual.raw &&
+	cut -c 1-40 >actual <actual.raw &&
+
+	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
+		HEAD^{commit}
+		HEAD^{tree}
+		HEAD^{tree}:one
+		HEAD^{tree}:two
+		HEAD~1^{commit}
+		HEAD~1^{tree}
+		HEAD~1^{tree}:three
+		HEAD~2^{commit}
+		HEAD~2^{tree}
+		HEAD~2^{tree}:four
+		HEAD~3^{commit}
+		# HEAD~3^{tree} skipped, same as HEAD~1^{tree}
+		HEAD~4^{commit}
+		# HEAD~4^{tree} skipped, same as HEAD^{tree}
+		HEAD~5^{commit}
+		HEAD~5^{tree}
+	EOF
+	grep -v "#" >expect <expect.raw &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list lists blobs and trees after commits' '
+	git rev-list --objects HEAD >actual.raw &&
+	cut -c 1-40 >actual <actual.raw &&
+
+	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
+		HEAD^{commit}
+		HEAD~1^{commit}
+		HEAD~2^{commit}
+		HEAD~3^{commit}
+		HEAD~4^{commit}
+		HEAD~5^{commit}
+		HEAD^{tree}
+		HEAD^{tree}:one
+		HEAD^{tree}:two
+		HEAD~1^{tree}
+		HEAD~1^{tree}:three
+		HEAD~2^{tree}
+		HEAD~2^{tree}:four
+		# HEAD~3^{tree} skipped, same as HEAD~1^{tree}
+		# HEAD~4^{tree} skipped, same as HEAD^{tree}
+		HEAD~5^{tree}
+	EOF
+	grep -v "#" >expect <expect.raw &&
+
+	test_cmp expect actual
+'
+
+test_done
-- 
2.15.0.128.gcadd42da22

