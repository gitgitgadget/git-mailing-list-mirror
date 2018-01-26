Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DDE51F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeAZTno (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:43:44 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:43864
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751824AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=zE+x3PsTit2wZUkfjMiZxE1BIcsJyhid1gquDkYpPRU=;
        b=G2ZUmEhHU9YQ0Ey1kBN2ZQLU+C1PiorRYcTFa7u+X6GOMS+DwsTLVtbvlVcoFQm1
        7lvT35zhB6MU/4or+HpmiUtx4gMSt0H9y5OaqTArdDX76oWQJ95ChF5q25bNwxFtgkH
        IBSzhkzrnl0y6MxLzCW2ydFgPj/IUME7Uxe/aZpo=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b5d-2a898107-6989-411d-b7c5-f349e897873e-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 23/24] cat-file: tests for new atoms added
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add some tests for new formatting atoms from ref-filter.
Some of new atoms are supported automatically,
some of them are expanded into empty string
(because they are useless for some types of objects),
some of them could be supported later in other patches.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 t/t1006-cat-file.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index b19f332694620..e72fcaf0e02c5 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -20,6 +20,19 @@ maybe_remove_timestamp () {
     fi
 }
 
+test_atom () {
+    name=$1
+    sha1=$2
+    atoms=$3
+    expected=$4
+
+    test_expect_success "$name" '
+	echo "$expected" >expect &&
+	echo $sha1 | git cat-file --batch-check="$atoms" >actual &&
+	test_cmp expect actual
+    '
+}
+
 run_tests () {
     type=$1
     sha1=$2
@@ -119,6 +132,13 @@ $content"
 	maybe_remove_timestamp "$(cat actual.full)" $no_ts >actual &&
 	test_cmp expect actual
     '
+
+    for atom in refname parent body trailers upstream push symref flag
+    do
+	test_atom "Check %($atom) gives empty output" "$sha1" "%($atom)" ""
+    done
+
+    test_atom "Check %(HEAD) gives only one space as output" "$sha1" '%(HEAD)' ' '
 }
 
 hello_content="Hello World"
@@ -140,6 +160,12 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 	test_cmp expect actual
 '
 
+shortname=`echo $hello_sha1 | sed 's/^.\{0\}\(.\{7\}\).*/\1/'`
+test_atom 'Check format option %(objectname:short) works' "$hello_sha1" '%(objectname:short)' "$shortname"
+
+test_atom 'Check format option %(align) is not broken' \
+    "$hello_sha1" "%(align:8)%(objecttype)%(end)%(objectname)" "blob    $hello_sha1"
+
 tree_sha1=$(git write-tree)
 tree_size=33
 tree_pretty_content="100644 blob $hello_sha1	hello"
@@ -157,6 +183,17 @@ $commit_message"
 
 run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_content" 1
 
+test_atom "Check format option %(if) is not broken" "$commit_sha1" \
+    "%(if)%(author)%(then)%(objectname)%(end)" "$commit_sha1"
+test_atom "Check %(tree) works for commit" "$commit_sha1" "%(tree)" "$tree_sha1"
+test_atom "Check %(numparent) works for commit" "$commit_sha1" "%(numparent)" "0"
+test_atom "Check %(authorname) works for commit" "$commit_sha1" "%(authorname)" "$GIT_AUTHOR_NAME"
+test_atom "Check %(authoremail) works for commit" "$commit_sha1" "%(authoremail)" "<$GIT_AUTHOR_EMAIL>"
+test_atom "Check %(committername) works for commit" "$commit_sha1" "%(committername)" "$GIT_COMMITTER_NAME"
+test_atom "Check %(committeremail) works for commit" "$commit_sha1" "%(committeremail)" "<$GIT_COMMITTER_EMAIL>"
+test_atom "Check %(subject) works for commit" "$commit_sha1" "%(subject)" "$commit_message"
+test_atom "Check %(contents) works for commit" "$commit_sha1" "%(contents)" "$commit_message"
+
 tag_header_without_timestamp="object $hello_sha1
 type blob
 tag hellotag
@@ -171,6 +208,17 @@ tag_size=$(strlen "$tag_content")
 
 run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
 
+test_atom "Check %(object) works for tag" "$tag_sha1" "%(object)" "$hello_sha1"
+test_atom "Check %(type) works for tag" "$tag_sha1" "%(type)" "blob"
+test_atom "Check %(tag) works for tag" "$tag_sha1" "%(tag)" "hellotag"
+test_atom "Check %(taggername) works for tag" "$tag_sha1" "%(taggername)" "$GIT_COMMITTER_NAME"
+test_atom "Check %(taggeremail) works for tag" "$tag_sha1" "%(taggeremail)" "<$GIT_COMMITTER_EMAIL>"
+test_atom "Check %(subject) works for tag" "$tag_sha1" "%(subject)" "$tag_description"
+test_atom "Check %(contents) works for tag" "$tag_sha1" "%(contents)" "$tag_description"
+
+test_atom "Check %(color) gives no additional output" "$sha1" \
+    "%(objectname) %(color:green) %(objecttype)" "$sha1  $type"
+
 test_expect_success \
     "Reach a blob from a tag pointing to it" \
     "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""

--
https://github.com/git/git/pull/452
