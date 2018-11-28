Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA06F1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 11:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeK1Wef (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 17:34:35 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:49564 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727673AbeK1Wef (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 17:34:35 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=thomas.baccab.home.arpa); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1gRy5h-0006XF-TE; Wed, 28 Nov 2018 12:33:13 +0100
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        avarab@gmail.com, Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v2] log -G: Ignore binary files
Date:   Wed, 28 Nov 2018 12:32:57 +0100
Message-Id: <c4eac0b0ff0812e5aa8b081e603fc8bdd042ddeb.1543403143.git.thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
In-Reply-To: <1535679074.141165.1542834055343@ox.hosteurope.de>
References: <1535679074.141165.1542834055343@ox.hosteurope.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1543404795;77392d3f;
X-HE-SMSGID: 1gRy5h-0006XF-TE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -G<regex> option of log looks for the differences whose patch text
contains added/removed lines that match regex.

As the concept of patch text only makes sense for text files, we need to
ignore binary files when searching with -G <regex> as well.

The -S<block of text> option of log looks for differences that changes
the number of occurrences of the specified block of text (i.e.
addition/deletion) in a file. As we want to keep the current behaviour,
add a test to ensure it.

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---

Changes since v1:
- Merged both patches into one
- Adapted commit messages
- Added missing support for -a flag with tests
- Placed new code into correct location to be able to reuse an existing
  optimization
- Uses help-suggested -Ga writing without spaces
- Uses orphan branches instead of cannonball cleanup with rm -rf
- Changed search text to make it clear that it is not about the \0 boundary

 Documentation/gitdiffcore.txt |  2 +-
 diffcore-pickaxe.c            |  6 ++++++
 t/t4209-log-pickaxe.sh        | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index c0a60f3158..059ddd3431 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -242,7 +242,7 @@ textual diff has an added or a deleted line that matches the given
 regular expression.  This means that it will detect in-file (or what
 rename-detection considers the same file) moves, which is noise.  The
 implementation runs diff twice and greps, and this can be quite
-expensive.
+expensive.  Binary files without textconv filter are ignored.
 
 When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
 that match their respective criterion are kept in the output.  When
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 69fc55ea1e..4cea086f80 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -154,6 +154,12 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	if (textconv_one == textconv_two && diff_unmodified_pair(p))
 		return 0;
 
+	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
+	    !o->flags.text &&
+	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
+	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
+		return 0;
+
 	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 844df760f7..5c3e2a16b2 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -106,4 +106,44 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
+test_expect_success 'log -G ignores binary files' '
+	git checkout --orphan orphan1 &&
+	printf "a\0a" >data.bin &&
+	git add data.bin &&
+	git commit -m "message" &&
+	git log -Ga >result &&
+	test_must_be_empty result
+'
+
+test_expect_success 'log -G looks into binary files with -a' '
+	git checkout --orphan orphan2 &&
+	printf "a\0a" >data.bin &&
+	git add data.bin &&
+	git commit -m "message" &&
+	git log -a -Ga >actual &&
+	git log >expected &&
+	test_cmp actual expected
+'
+
+test_expect_success 'log -G looks into binary files with textconv filter' '
+	git checkout --orphan orphan3 &&
+	echo "* diff=bin" > .gitattributes &&
+	printf "a\0a" >data.bin &&
+	git add data.bin &&
+	git commit -m "message" &&
+	git -c diff.bin.textconv=cat log -Ga >actual &&
+	git log >expected &&
+	test_cmp actual expected
+'
+
+test_expect_success 'log -S looks into binary files' '
+	git checkout --orphan orphan4 &&
+	printf "a\0a" >data.bin &&
+	git add data.bin &&
+	git commit -m "message" &&
+	git log -Sa >actual &&
+	git log >expected &&
+	test_cmp actual expected
+'
+
 test_done
-- 
2.19.0.271.gfe8321ec05.dirty

