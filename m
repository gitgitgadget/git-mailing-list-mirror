Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65DF1F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfHZBoG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58276 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfHZBoG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BB85E6073E;
        Mon, 26 Aug 2019 01:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783844;
        bh=0aUrkkGgDyIzNnei0WzMtIoehV5rHqX1zjnet1bL7Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jYNTV9F/4s3OrpnpRees482ziHUtPMrIYcTc1r1RKsl+2/P/bGdGoVMLGA3mXb9Br
         PPpbJ4KT2bYjpzJEEuaFwCpvJ59IfP/6wQVxtXfp0IKvuvIevknXwiixIy/ZAey+Iq
         oJQff355xgtxPapsI+hk5+O3dX0OhadwoLKvMlhT9BGAqQXRHmfaP4afUE/o8giPoA
         oETTpLR8MW05kIZMXGZvpCkl/IO/rQsOKk7zqljAJCKRqYuPI0BsymJq6tnH3fq/lM
         nQpxHW7fP7QqQwhImhSDZWv7brYYGdwLnxWNALHHVZF2ySI19otQ/Rvp+vtmqBtbSu
         UZTAm7Xq3jOEZntGhPMdhuoCJNkOM8+Fd7FnCrhHpDlp1KE6Jn9qrT9jqVtoFdpM41
         ToiP45SyoT1aH+5R0fN8yDgKHTE7pdnJXzXQKCT07hojzAQXAlwB0y05vAqphOLhzP
         L8k/h8KKL7vSnwPxG0+TsZkgXk+nTuYATkSQAlizYhGEXe1jOlS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 03/14] t3301: abstract away SHA-1-specific constants
Date:   Mon, 26 Aug 2019 01:43:33 +0000
Message-Id: <20190826014344.16008-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.  Move some invocations of test_commit around so
that we can compute the object IDs for these commits.

Compute several object IDs in the tests instead of using hard-coded
values so that the test works with any hash algorithm.  Since the actual
values are sorted by the object ID of the object being annotated, sort
the expected values accordingly as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3301-notes.sh | 140 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 90 insertions(+), 50 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 704bbc6541..d3fa298c6a 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -66,8 +66,9 @@ test_expect_success 'show notes entry with %N' '
 '
 
 test_expect_success 'create reflog entry' '
+	ref=$(git rev-parse --short refs/notes/commits) &&
 	cat <<-EOF >expect &&
-		a1d8fa6 refs/notes/commits@{0}: notes: Notes added by '\''git notes add'\''
+		$ref refs/notes/commits@{0}: notes: Notes added by '\''git notes add'\''
 	EOF
 	git reflog show refs/notes/commits >actual &&
 	test_cmp expect actual
@@ -134,8 +135,9 @@ test_expect_success 'can overwrite existing note with "git notes add -f"' '
 '
 
 test_expect_success 'show notes' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 7a4ca6ee52a974a66cbaa78e33214535dff1d691
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:14:13 2005 -0700
 
@@ -152,8 +154,9 @@ test_expect_success 'show notes' '
 test_expect_success 'show multi-line notes' '
 	test_commit 3rd &&
 	MSG="b3${LF}c3c3c3c3${LF}d3d3d3" git notes add &&
+	commit=$(git rev-parse HEAD) &&
 	cat >expect-multiline <<-EOF &&
-		commit d07d62e5208f22eb5695e7eb47667dc8b9860290
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:15:13 2005 -0700
 
@@ -174,8 +177,9 @@ test_expect_success 'show -F notes' '
 	test_commit 4th &&
 	echo "xyzzy" >note5 &&
 	git notes add -F note5 &&
+	commit=$(git rev-parse HEAD) &&
 	cat >expect-F <<-EOF &&
-		commit 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:16:13 2005 -0700
 
@@ -198,10 +202,13 @@ test_expect_success 'Re-adding -F notes without -f fails' '
 '
 
 test_expect_success 'git log --pretty=raw does not show notes' '
+	commit=$(git rev-parse HEAD) &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	parent=$(git rev-parse HEAD^) &&
 	cat >expect <<-EOF &&
-		commit 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
-		tree 05ac65288c4c4b3b709a020ae94b2ece2f2201ae
-		parent d07d62e5208f22eb5695e7eb47667dc8b9860290
+		commit $commit
+		tree $tree
+		parent $parent
 		author A U Thor <author@example.com> 1112912173 -0700
 		committer C O Mitter <committer@example.com> 1112912173 -0700
 
@@ -291,8 +298,9 @@ test_expect_success 'git log --no-notes resets ref list' '
 test_expect_success 'show -m notes' '
 	test_commit 5th &&
 	git notes add -m spam -m "foo${LF}bar${LF}baz" &&
+	commit=$(git rev-parse HEAD) &&
 	cat >expect-m <<-EOF &&
-		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
@@ -313,8 +321,9 @@ test_expect_success 'show -m notes' '
 
 test_expect_success 'remove note with add -f -F /dev/null' '
 	git notes add -f -F /dev/null &&
+	commit=$(git rev-parse HEAD) &&
 	cat >expect-rm-F <<-EOF &&
-		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
@@ -356,14 +365,16 @@ test_expect_success 'create note with combination of -m and -F' '
 test_expect_success 'remove note with "git notes remove"' '
 	git notes remove HEAD^ &&
 	git notes remove &&
+	commit=$(git rev-parse HEAD) &&
+	parent=$(git rev-parse HEAD^) &&
 	cat >expect-rm-remove <<-EOF &&
-		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
 		${indent}5th
 
-		commit 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
+		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:16:13 2005 -0700
 
@@ -459,9 +470,11 @@ test_expect_success 'removing with --stdin --ignore-missing' '
 '
 
 test_expect_success 'list notes with "git notes list"' '
-	cat >expect <<-EOF &&
-		c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 7a4ca6ee52a974a66cbaa78e33214535dff1d691
-		c18dc024e14f08d18d14eea0d747ff692d66d6a3 d07d62e5208f22eb5695e7eb47667dc8b9860290
+	commit_2=$(git rev-parse 2nd) &&
+	commit_3=$(git rev-parse 3rd) &&
+	sort -t" " -k2 >expect <<-EOF &&
+		$(git rev-parse refs/notes/commits:$commit_2) $commit_2
+		$(git rev-parse refs/notes/commits:$commit_3) $commit_3
 	EOF
 	git notes list >actual &&
 	test_cmp expect actual
@@ -474,7 +487,7 @@ test_expect_success 'list notes with "git notes"' '
 
 test_expect_success 'list specific note with "git notes list <object>"' '
 	cat >expect <<-EOF &&
-		c18dc024e14f08d18d14eea0d747ff692d66d6a3
+		$(git rev-parse refs/notes/commits:$commit_3)
 	EOF
 	git notes list HEAD^^ >actual &&
 	test_cmp expect actual
@@ -498,10 +511,11 @@ test_expect_success 'append to existing note with "git notes append"' '
 '
 
 test_expect_success '"git notes list" does not expand to "git notes list HEAD"' '
-	cat >expect_list <<-EOF &&
-		c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 7a4ca6ee52a974a66cbaa78e33214535dff1d691
-		4b6ad22357cc8a1296720574b8d2fbc22fab0671 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
-		c18dc024e14f08d18d14eea0d747ff692d66d6a3 d07d62e5208f22eb5695e7eb47667dc8b9860290
+	commit_5=$(git rev-parse 5th) &&
+	sort -t" " -k2 >expect_list <<-EOF &&
+		$(git rev-parse refs/notes/commits:$commit_2) $commit_2
+		$(git rev-parse refs/notes/commits:$commit_3) $commit_3
+		$(git rev-parse refs/notes/commits:$commit_5) $commit_5
 	EOF
 	git notes list >actual &&
 	test_cmp expect_list actual
@@ -531,8 +545,9 @@ test_expect_success 'appending empty string to non-existing note does not create
 test_expect_success 'create other note on a different notes ref (setup)' '
 	test_commit 6th &&
 	GIT_NOTES_REF="refs/notes/other" git notes add -m "other note" &&
+	commit=$(git rev-parse HEAD) &&
 	cat >expect-not-other <<-EOF &&
-		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
@@ -569,8 +584,10 @@ test_expect_success 'Do not show note when core.notesRef is overridden' '
 '
 
 test_expect_success 'Show all notes when notes.displayRef=refs/notes/*' '
+	commit=$(git rev-parse HEAD) &&
+	parent=$(git rev-parse HEAD^) &&
 	cat >expect-both <<-EOF &&
-		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
@@ -582,7 +599,7 @@ test_expect_success 'Show all notes when notes.displayRef=refs/notes/*' '
 		Notes (other):
 		${indent}other note
 
-		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
@@ -616,8 +633,9 @@ test_expect_success 'notes.displayRef can be given more than once' '
 '
 
 test_expect_success 'notes.displayRef respects order' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect-both-reversed <<-EOF &&
-		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
@@ -642,14 +660,16 @@ test_expect_success 'GIT_NOTES_DISPLAY_REF works' '
 '
 
 test_expect_success 'GIT_NOTES_DISPLAY_REF overrides config' '
+	commit=$(git rev-parse HEAD) &&
+	parent=$(git rev-parse HEAD^) &&
 	cat >expect-none <<-EOF &&
-		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
 		${indent}6th
 
-		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
@@ -666,8 +686,9 @@ test_expect_success '--show-notes=* adds to GIT_NOTES_DISPLAY_REF' '
 '
 
 test_expect_success '--no-standard-notes' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect-commits <<-EOF &&
-		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
@@ -712,8 +733,10 @@ test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 '
 
 test_expect_success 'create note from other note with "git notes add -C"' '
+	test_commit 7th &&
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit fb01e0ca8c33b6cc0c6451dde747f97df567cb5c
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:19:13 2005 -0700
 
@@ -722,7 +745,6 @@ test_expect_success 'create note from other note with "git notes add -C"' '
 		Notes:
 		${indent}order test
 	EOF
-	test_commit 7th &&
 	git notes add -C $(git notes list HEAD^) &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
@@ -744,8 +766,9 @@ test_expect_success 'create note from non-blob with "git notes add -C" fails' '
 '
 
 test_expect_success 'create note from blob with "git notes add -C" reuses blob id' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 9a4c31c7f722b5d517e92c64e932dd751e1413bf
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:20:13 2005 -0700
 
@@ -762,8 +785,10 @@ test_expect_success 'create note from blob with "git notes add -C" reuses blob i
 '
 
 test_expect_success 'create note from other note with "git notes add -c"' '
+	test_commit 9th &&
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 2e0db4bc649e174d667a1cde19e725cf897a5bd2
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:21:13 2005 -0700
 
@@ -772,7 +797,6 @@ test_expect_success 'create note from other note with "git notes add -c"' '
 		Notes:
 		${indent}yet another note
 	EOF
-	test_commit 9th &&
 	MSG="yet another note" git notes add -c $(git notes list HEAD^^) &&
 	git log -1 >actual &&
 	test_cmp expect actual
@@ -785,8 +809,9 @@ test_expect_success 'create note from non-existing note with "git notes add -c"
 '
 
 test_expect_success 'append to note from other note with "git notes append -C"' '
+	commit=$(git rev-parse HEAD^) &&
 	cat >expect <<-EOF &&
-		commit 2e0db4bc649e174d667a1cde19e725cf897a5bd2
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:21:13 2005 -0700
 
@@ -803,8 +828,9 @@ test_expect_success 'append to note from other note with "git notes append -C"'
 '
 
 test_expect_success 'create note from other note with "git notes append -c"' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 7c3b87ab368f81e11b1ea87b2ab99a71ccd25406
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:22:13 2005 -0700
 
@@ -819,8 +845,9 @@ test_expect_success 'create note from other note with "git notes append -c"' '
 '
 
 test_expect_success 'append to note from other note with "git notes append -c"' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 7c3b87ab368f81e11b1ea87b2ab99a71ccd25406
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:22:13 2005 -0700
 
@@ -837,8 +864,10 @@ test_expect_success 'append to note from other note with "git notes append -c"'
 '
 
 test_expect_success 'copy note with "git notes copy"' '
+	test_commit 11th &&
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit a446fff8777efdc6eb8f4b7c8a5ff699484df0d5
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:23:13 2005 -0700
 
@@ -849,7 +878,6 @@ test_expect_success 'copy note with "git notes copy"' '
 		${indent}
 		${indent}yet another note
 	EOF
-	test_commit 11th &&
 	git notes copy HEAD^ HEAD &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
@@ -864,8 +892,9 @@ test_expect_success 'prevent overwrite with "git notes copy"' '
 '
 
 test_expect_success 'allow overwrite with "git notes copy -f"' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit a446fff8777efdc6eb8f4b7c8a5ff699484df0d5
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:23:13 2005 -0700
 
@@ -889,8 +918,10 @@ test_expect_success 'cannot copy note from object without notes' '
 '
 
 test_expect_success 'git notes copy --stdin' '
+	commit=$(git rev-parse HEAD) &&
+	parent=$(git rev-parse HEAD^) &&
 	cat >expect <<-EOF &&
-		commit e871aa61182b1d95d0a6fb75445d891722863b6b
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:25:13 2005 -0700
 
@@ -901,7 +932,7 @@ test_expect_success 'git notes copy --stdin' '
 		${indent}
 		${indent}yet another note
 
-		commit 65e263ded02ae4e8839bc151095113737579dc12
+		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:24:13 2005 -0700
 
@@ -922,21 +953,23 @@ test_expect_success 'git notes copy --stdin' '
 '
 
 test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
+	test_commit 14th &&
+	test_commit 15th &&
+	commit=$(git rev-parse HEAD) &&
+	parent=$(git rev-parse HEAD^) &&
 	cat >expect <<-EOF &&
-		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
 		${indent}15th
 
-		commit 07c85d77059393ed0154b8c96906547a59dfcddd
+		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:26:13 2005 -0700
 
 		${indent}14th
 	EOF
-	test_commit 14th &&
-	test_commit 15th &&
 	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^) &&
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
@@ -945,8 +978,10 @@ test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
 '
 
 test_expect_success 'git notes copy --for-rewrite (enabled)' '
+	commit=$(git rev-parse HEAD) &&
+	parent=$(git rev-parse HEAD^) &&
 	cat >expect <<-EOF &&
-		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
@@ -957,7 +992,7 @@ test_expect_success 'git notes copy --for-rewrite (enabled)' '
 		${indent}
 		${indent}yet another note
 
-		commit 07c85d77059393ed0154b8c96906547a59dfcddd
+		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:26:13 2005 -0700
 
@@ -986,8 +1021,9 @@ test_expect_success 'git notes copy --for-rewrite (disabled)' '
 '
 
 test_expect_success 'git notes copy --for-rewrite (overwrite)' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
@@ -1015,8 +1051,9 @@ test_expect_success 'git notes copy --for-rewrite (ignore)' '
 '
 
 test_expect_success 'git notes copy --for-rewrite (append)' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
@@ -1037,8 +1074,9 @@ test_expect_success 'git notes copy --for-rewrite (append)' '
 '
 
 test_expect_success 'git notes copy --for-rewrite (append two to one)' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
@@ -1075,8 +1113,9 @@ test_expect_success 'git notes copy --for-rewrite (append empty)' '
 '
 
 test_expect_success 'GIT_NOTES_REWRITE_MODE works' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
@@ -1095,8 +1134,9 @@ test_expect_success 'GIT_NOTES_REWRITE_MODE works' '
 '
 
 test_expect_success 'GIT_NOTES_REWRITE_REF works' '
+	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		commit $commit
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
