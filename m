Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C421F403
	for <e@80x24.org>; Wed, 13 Jun 2018 11:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935500AbeFMLeA (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 07:34:00 -0400
Received: from mail187-21.suw11.mandrillapp.com ([198.2.187.21]:40477 "EHLO
        mail187-21.suw11.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935492AbeFMLd5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jun 2018 07:33:57 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 07:33:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=B73T0J9Ofl6qijovtILTdt29Op0uyiJ55svkiS8pu+U=;
 b=MR8piP2JFd8iZ1E1gC9CizVKSQcd2D3mf+hDn5QAeho0fTnB+ec4eK+SHPTOTj6EQsOUn4rBIEma
   zckY79qxI8WKZhxwipm/WxYJ+8fU0Gd+A/7J0Ac//5Pex1Nweg4YNNvYWhmoLoM1dAk1p54j5fd2
   ytG+IZsjwanTt7epwms=
Received: from pmta01.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail187-21.suw11.mandrillapp.com id h440ia174i4t for <git@vger.kernel.org>; Wed, 13 Jun 2018 11:18:56 +0000 (envelope-from <bounce-md_31050260.5b20fda0.v1-0a9ac1e832f34b98b324c37bd93e30f1@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528888736; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=B73T0J9Ofl6qijovtILTdt29Op0uyiJ55svkiS8pu+U=; 
 b=bXpmAwIN9ajSkCFOGaG3wUXz7QgdhPuC/6gA7yBe2UhBY/xyA0Hv0rcZoBbd4Unl57oiJZ
 9S+Eyb8NgQ9eD3fYsnSlkVEwBwkjqkQtYWxxFSMwedUCnDaFIrAkYIiAojykTMj0OEpJ2Btd
 ygHeG9ljvZKFjSiQkzSUGZ5dLtm7s=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH] fetch-pack: test explicitly that --all can fetch tag references pointing to non-commits
Received: from [87.98.221.171] by mandrillapp.com id 0a9ac1e832f34b98b324c37bd93e30f1; Wed, 13 Jun 2018 11:18:56 +0000
X-Mailer: git-send-email 2.18.0.rc1.253.gf85a566b11.dirty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>, Kirill Smelkov <kirr@nexedi.com>
Message-Id: <20180613111840.1427-1-kirr@nexedi.com>
In-Reply-To: <20180612185413.GA21856@deco.navytux.spb.ru>
References: <20180612185413.GA21856@deco.navytux.spb.ru>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.0a9ac1e832f34b98b324c37bd93e30f1
X-Mandrill-User: md_31050260
Date:   Wed, 13 Jun 2018 11:18:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fetch-pack --all became broken with respect to unusual tags in
5f0fc64513 (fetch-pack: eliminate spurious error messages, 2012-09-09),
and was fixed only recently in e9502c0a7f (fetch-pack: don't try to fetch
peel values with --all, 2018-06-11). However the test added in
e9502c0a7f does not explicitly cover all funky cases.

In order to be sure fetching funky tags will never break, let's
explicitly test all relevant cases with 4 tag objects pointing to 1) a
blob, 2) a tree, 3) a commit, and 4) another tag objects. The referenced
tag objects themselves are referenced from under regular refs/tags/*
namespace. Before e9502c0a7f `fetch-pack --all` was failing e.g. this way:

        .../git/t/trash directory.t5500-fetch-pack/fetchall$ git ls-remote ..
        440858748ae905d48259d4fb67a12a7aa1520cf7        HEAD
        ...
        bc4e9e1fa80662b449805b1ac29fc9b1e4c49187        refs/tags/tag-to-blob                   # <-- NOTE
        038f48ad0beaffbea71d186a05084b79e3870cbf        refs/tags/tag-to-blob^{}
        520db1f5e1afeaa12b1a8d73ce82db72ca036ee1        refs/tags/tag-to-tree                   # <-- NOTE
        7395c100223b7cd760f58ccfa0d3f3d2dd539bb6        refs/tags/tag-to-tree^{}

        .../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch-pack --all ..
        fatal: A git upload-pack: not our ref 038f48ad0beaffbea71d186a05084b79e3870cbf
        fatal: The remote end hung up unexpectedly

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 t/t5500-fetch-pack.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f20bb59d22..b560d90c7b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -528,6 +528,34 @@ test_expect_success 'test --all with tag to non-tip' '
 	)
 '
 
+test_expect_success 'test --all wrt tag to non-commits' '
+	blob=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
+	git tag -a -m "tag -> blob" tag-to-blob $blob &&
+ \
+	tree=$(printf "100644 blob $blob\tfile" | git mktree) &&
+	git tag -a -m "tag -> tree" tag-to-tree $tree &&
+ \
+	tree2=$(printf "100644 blob $blob\tfile2" | git mktree) &&
+	commit=$(git commit-tree -m "hello commit" $tree) &&
+	git tag -a -m "tag -> commit" tag-to-commit $commit &&
+ \
+	blob2=$(echo "hello blob2" | git hash-object -t blob -w --stdin) &&
+	tag=$(printf "object $blob2\ntype blob\ntag tag-to-blob2\n\
+tagger author A U Thor <author@example.com> 0 +0000\n\nhello tag" | git mktag) &&
+	git tag -a -m "tag -> tag" tag-to-tag $tag &&
+ \
+	mkdir fetchall &&
+	(
+		cd fetchall &&
+		git init &&
+		git fetch-pack --all .. &&
+		git cat-file blob $blob >/dev/null &&
+		git cat-file tree $tree >/dev/null &&
+		git cat-file commit $commit >/dev/null &&
+		git cat-file tag $tag >/dev/null
+	)
+'
+
 test_expect_success 'shallow fetch with tags does not break the repository' '
 	mkdir repo1 &&
 	(
-- 
2.18.0.rc1.253.gf85a566b11.dirty
