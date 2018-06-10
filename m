Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E721F403
	for <e@80x24.org>; Sun, 10 Jun 2018 14:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeFJOr7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 10:47:59 -0400
Received: from mail134-31.atl141.mandrillapp.com ([198.2.134.31]:22166 "EHLO
        mail134-31.atl141.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750744AbeFJOr6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 10:47:58 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2018 10:47:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=QMIhDadM1hixdA7U9ZjEDaITN1w4t0GY4P/EvTfTES0=;
 b=NJui9yAmLCIAI+g2TDZf8FqN7D2r/yg+zU4a/mJzeAbEYeyW0sXFNncUtnqW17cejL8GDAzOyj4q
   y9cXiuB2CYxSEjMWa0fM3hhIFiLBV6sA/mRtYgxtC5Ez8tpBmQryOFWCUlC0TjLDlMUuG6BElybK
   PpHvTsCQ8k++uytSAqU=
Received: from pmta03.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail134-31.atl141.mandrillapp.com id h3kt1s1sau87 for <git@vger.kernel.org>; Sun, 10 Jun 2018 14:32:57 +0000 (envelope-from <bounce-md_31050260.5b1d3699.v1-4f874078a7ca408fb4a023aeb7bcbe8e@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528641177; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=QMIhDadM1hixdA7U9ZjEDaITN1w4t0GY4P/EvTfTES0=; 
 b=a1d9YKrEg28rL4/Q10E/KvCCsttqqP++EvUNrPy7Kene5xHxPSbHDHnu8+bZYHVJNwTuCE
 0Hy9IWlTEQEyQDEIoHzCNNdjRrEDRMNnOALvGoMaj8kgUBxOTLtEPYCZlfXr/tuIOrA4x92C
 iO6rqnyMHvp6nTU9Ilk+X2iX3seYk=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH] fetch-pack: demonstrate --all breakage when remote have tags to non-commit objects
Received: from [87.98.221.171] by mandrillapp.com id 4f874078a7ca408fb4a023aeb7bcbe8e; Sun, 10 Jun 2018 14:32:57 +0000
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a.dirty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>, Kirill Smelkov <kirr@nexedi.com>
Message-Id: <20180610143231.7131-1-kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.4f874078a7ca408fb4a023aeb7bcbe8e
X-Mandrill-User: md_31050260
Date:   Sun, 10 Jun 2018 14:32:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added test shows remote with two tag objects pointing to a blob and a
tree. The tag objects themselves are referenced from under regular
refs/tags/* namespace. If test_expect_failure is changed to
test_expect_success the test fails:

	Initialized empty Git repository in /home/kirr/src/tools/git/git/t/trash directory.t5500-fetch-pack/fetchall/.git/
	fatal: git upload-pack: not our ref 038f48ad0beaffbea71d186a05084b79e3870cbf
	fatal: The remote end hung up unexpectedly
	not ok 56 - test --all wrt tag to non-commits
	#
	#               blob_sha1=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
	#               git tag -a -m "tag -> blob" tag-to-blob $blob_sha1 &&
	#               tree_sha1=$(echo -e "100644 blob $blob_sha1\tfile" | git mktree) &&
	#               git tag -a -m "tag -> tree" tag-to-tree $tree_sha1 &&
	#               mkdir fetchall &&
	#               (
	#                       cd fetchall &&
	#                       git init &&
	#                       git fetch-pack --all .. &&
	#                       git cat-file blob $blob_sha1 >/dev/null &&
	#                       git cat-file tree $tree_sha1 >/dev/null
	#               )

and manual investigation from under "trash directory.t5500-fetch-pack/fetchall/" shows:

	.../git/t/trash directory.t5500-fetch-pack/fetchall$ git ls-remote ..
	440858748ae905d48259d4fb67a12a7aa1520cf7        HEAD
	f85e353c1b377970afbb804118d9135948598eea        refs/heads/A
	440858748ae905d48259d4fb67a12a7aa1520cf7        refs/heads/B
	7f3cb539fbce926dd99233cfc9b6966f1d69747e        refs/heads/C
	b3401427a9637a35f6a203d635e5677e76ad409d        refs/heads/D
	4928b093c801d36be5cdb3ed3ab572fa0d4c93bf        refs/heads/E
	c1375be492d3716839043d7f7e9a593f8e80c668        refs/heads/F
	f85e353c1b377970afbb804118d9135948598eea        refs/tags/A
	440858748ae905d48259d4fb67a12a7aa1520cf7        refs/tags/B
	7f3cb539fbce926dd99233cfc9b6966f1d69747e        refs/tags/C
	b3401427a9637a35f6a203d635e5677e76ad409d        refs/tags/D
	4928b093c801d36be5cdb3ed3ab572fa0d4c93bf        refs/tags/E
	c1375be492d3716839043d7f7e9a593f8e80c668        refs/tags/F
	27f494dfb7e67d2f9cd2282404adf1d97581aa34        refs/tags/OLDTAG
	10e1d7b51cacf2f0478498681177f0e6f1e8392d        refs/tags/TAGA1
	f85e353c1b377970afbb804118d9135948598eea        refs/tags/TAGA1^{}
	f85e353c1b377970afbb804118d9135948598eea        refs/tags/TAGA2
	a540a4ddd2b16a9fe66e9539d5ec103c68052eaa        refs/tags/TAGB1
	9ca64d8fd8038b086badca1d11ccd8bbcfdeace1        refs/tags/TAGB1^{}
	9ca64d8fd8038b086badca1d11ccd8bbcfdeace1        refs/tags/TAGB2
	bc4e9e1fa80662b449805b1ac29fc9b1e4c49187        refs/tags/tag-to-blob			# <-- NOTE
	038f48ad0beaffbea71d186a05084b79e3870cbf        refs/tags/tag-to-blob^{}
	520db1f5e1afeaa12b1a8d73ce82db72ca036ee1        refs/tags/tag-to-tree			# <-- NOTE
	7395c100223b7cd760f58ccfa0d3f3d2dd539bb6        refs/tags/tag-to-tree^{}

	.../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch-pack --all ..
	fatal: A git upload-pack: not our ref 038f48ad0beaffbea71d186a05084b79e3870cbf
	fatal: The remote end hung up unexpectedly

however the remote has all referenced objects and is generally ok:

	.../git/t/trash directory.t5500-fetch-pack/fetchall$ cd ..

	.../git/t/trash directory.t5500-fetch-pack$ git show tag-to-blob
	tag tag-to-blob
	Tagger: C O Mitter <committer@example.com>
	Date:   Thu Apr 7 16:36:13 2005 -0700

	tag -> blob
	hello blob

	.../git/t/trash directory.t5500-fetch-pack$ git show tag-to-tree
	tag tag-to-tree
	Tagger: C O Mitter <committer@example.com>
	Date:   Thu Apr 7 16:36:13 2005 -0700

	tag -> tree

	tree tag-to-tree

	file

	.../git/t/trash directory.t5500-fetch-pack$ git fsck
	Checking object directories: 100% (256/256), done.

For the reference, porcelain fetch 'refs/*:refs/origin/*' works:

	.../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch .. 'refs/*:refs/origin/*'
	remote: Enumerating objects: 259, done.
	remote: Counting objects: 100% (259/259), done.
	remote: Compressing objects: 100% (89/89), done.
	remote: Total 259 (delta 1), reused 0 (delta 0)
	Receiving objects: 100% (259/259), 21.64 KiB | 1.97 MiB/s, done.
	Resolving deltas: 100% (1/1), done.
	From ..
	 * [new branch]      A           -> refs/origin/heads/A
	 * [new branch]      B           -> refs/origin/heads/B
	 * [new branch]      C           -> refs/origin/heads/C
	 * [new branch]      D           -> refs/origin/heads/D
	 * [new branch]      E           -> refs/origin/heads/E
	 * [new branch]      F           -> refs/origin/heads/F
	 * [new tag]         A           -> refs/origin/tags/A
	 * [new tag]         B           -> refs/origin/tags/B
	 * [new tag]         C           -> refs/origin/tags/C
	 * [new tag]         D           -> refs/origin/tags/D
	 * [new tag]         E           -> refs/origin/tags/E
	 * [new tag]         F           -> refs/origin/tags/F
	 * [new tag]         OLDTAG      -> refs/origin/tags/OLDTAG
	 * [new tag]         TAGA1       -> refs/origin/tags/TAGA1
	 * [new tag]         TAGA2       -> refs/origin/tags/TAGA2
	 * [new tag]         TAGB1       -> refs/origin/tags/TAGB1
	 * [new tag]         TAGB2       -> refs/origin/tags/TAGB2
	 * [new tag]         tag-to-blob -> refs/origin/tags/tag-to-blob
	 * [new tag]         tag-to-tree -> refs/origin/tags/tag-to-tree
	 * [new tag]         A           -> A
	 * [new tag]         B           -> B
	 * [new tag]         C           -> C
	 * [new tag]         D           -> D
	 * [new tag]         E           -> E
	 * [new tag]         F           -> F
	 * [new tag]         OLDTAG      -> OLDTAG
	 * [new tag]         TAGA1       -> TAGA1
	 * [new tag]         TAGA2       -> TAGA2
	 * [new tag]         TAGB1       -> TAGB1
	 * [new tag]         TAGB2       -> TAGB2
	 * [new tag]         tag-to-blob -> tag-to-blob				# <-- NOTE
	 * [new tag]         tag-to-tree -> tag-to-tree				# <-- NOTE

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 t/t5500-fetch-pack.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d4f435155f..000f338172 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -518,6 +518,21 @@ test_expect_success 'test --all, --depth, and explicit tag' '
 	) >out-adt 2>error-adt
 '
 
+test_expect_failure 'test --all wrt tag to non-commits' '
+	blob_sha1=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
+	git tag -a -m "tag -> blob" tag-to-blob $blob_sha1 &&
+	tree_sha1=$(echo -e "100644 blob $blob_sha1\tfile" | git mktree) &&
+	git tag -a -m "tag -> tree" tag-to-tree $tree_sha1 &&
+	mkdir fetchall &&
+	(
+		cd fetchall &&
+		git init &&
+		git fetch-pack --all .. &&
+		git cat-file blob $blob_sha1 >/dev/null &&
+		git cat-file tree $tree_sha1 >/dev/null
+	)
+'
+
 test_expect_success 'shallow fetch with tags does not break the repository' '
 	mkdir repo1 &&
 	(
-- 
2.18.0.rc1.242.g61856ae69a.dirty
