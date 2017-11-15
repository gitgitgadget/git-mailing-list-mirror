Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C60C202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 00:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756466AbdKOAbK (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 19:31:10 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:39787 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755601AbdKOAaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 19:30:55 -0500
Received: by mail-it0-f67.google.com with SMTP id y15so15876139ita.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nPso/LlRRz2QdgIK1wsRJb6+fc/6hThBOFjz4WG6Fus=;
        b=E06M9G/me0jhxHsu4ho5JVIeRrvrXK1jGAbgRhWRGTArC/Dtjs232do/nXbadyCHYA
         kQDI+V2vhCgYU3XNfdcHJZH2r9xYK3CcD/LJhwwsK9/Mzpi8A/j9+cSZMRDT9mzUZznj
         uLZgM3d8W838/dVvsnHznlRwseD7qeuPco5FBpp6Jv1PdfNZu88rRzyR5QgZ62mAizk9
         lK9lqIeQCuY48sfX0KOp3lHPfXredQbqkWSzqEt1HQXMGYM+NSt7EYYk7jFTH7r3BTOV
         lS/szwQHo0uWWSpFMjZhajKtbgwUtT6VyQ7JsRPICG1333Qkdi9GXXWFpsv5relOUk5x
         U3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nPso/LlRRz2QdgIK1wsRJb6+fc/6hThBOFjz4WG6Fus=;
        b=bmYdvzNSw9Y4dhHBD04VUAMY8y5aFlpfWh2dDIKY3y0oouq+cdGWhZZP+v4bOsvsVm
         DhpBF0YG7rUeKreHQj6KYgdyAKOjgsjk0umvZNFoZ52POS5MniSeuq5x8hXwMnqQQTDJ
         wYRac30ryiFfQo7tU73ThlQbdzbA8yb16SR5y5RJPYlLN/NGwWS+iktayInzYSbiKqan
         eMdKVkesngk6LbNc6D3Aw7ZtwlkcFIubGsbRO3rEpGHXLyZowzrjBjinoZqYcTDJYty+
         nWIbaDpNuNl9LRodYrH8gNyVC4GsfxtGYdG9LdmAODaVdF8PsZQoqD/ESH7ObAglEeTo
         yRrQ==
X-Gm-Message-State: AJaThX576BoUgukoSTbyn0A4CX6K7yZGriK44ZpTdIuBzy1oDAcaBsIN
        pNcgNKrcC/kjki6UUxfs7PVYn1X4IAA=
X-Google-Smtp-Source: AGs4zMbgvNJ2l1JQ8egCN8efZI9YGuR7sbVx9xPL0tET4ro4WWesZbs8MfTJk+llxeWNYad0iy4EVQ==
X-Received: by 10.36.141.65 with SMTP id w62mr18507024itd.152.1510705854570;
        Tue, 14 Nov 2017 16:30:54 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c9fb:9110:c737:8943])
        by smtp.gmail.com with ESMTPSA id q191sm8322014itb.1.2017.11.14.16.30.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 16:30:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/7] revision.h: introduce blob/tree walking in order of the commits
Date:   Tue, 14 Nov 2017 16:30:39 -0800
Message-Id: <20171115003043.24080-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171115003043.24080-1-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
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
 list-objects.c                     |  2 +
 revision.c                         |  2 +
 revision.h                         |  3 +-
 t/t6100-rev-list-in-order.sh       | 77 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 1 deletion(-)
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
index 7c2ce9c4bd..07a92f35fe 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -239,6 +239,8 @@ void traverse_commit_list(struct rev_info *revs,
 		if (commit->tree)
 			add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
+		if (revs->tree_blobs_in_commit_order)
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

