Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D861F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 21:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389771AbeKVHoH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 02:44:07 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:48770 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732609AbeKVHoH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Nov 2018 02:44:07 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=thomas.baccab.home.arpa); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1gPZUJ-00055p-GX; Wed, 21 Nov 2018 21:52:43 +0100
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v1 1/2] log -G: Ignore binary files
Date:   Wed, 21 Nov 2018 21:52:27 +0100
Message-Id: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
In-Reply-To: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1542834487;c6541f0a;
X-HE-SMSGID: 1gPZUJ-00055p-GX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -G <regex> option of log looks for the differences whose patch text
contains added/removed lines that match regex.

The concept of differences only makes sense for text files, therefore
we need to ignore binary files when searching with -G <regex> as well.

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 Documentation/gitdiffcore.txt |  2 +-
 diffcore-pickaxe.c            |  5 +++++
 t/t4209-log-pickaxe.sh        | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

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
index 69fc55ea1e..8c2558b07d 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -144,6 +144,11 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 		textconv_two = get_textconv(o->repo->index, p->two);
 	}
 
+	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
+	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
+	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
+		return 0;
+
 	/*
 	 * If we have an unmodified pair, we know that the count will be the
 	 * same and don't even have to load the blobs. Unless textconv is in
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 844df760f7..42cc8afd8b 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -106,4 +106,26 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
+test_expect_success 'log -G ignores binary files' '
+	rm -rf .git &&
+	git init &&
+	printf "a\0b" >data.bin &&
+	git add data.bin &&
+	git commit -m "message" &&
+	git log -G a >result &&
+	test_must_be_empty result
+'
+
+test_expect_success 'log -G looks into binary files with textconv filter' '
+	rm -rf .git &&
+	git init &&
+	echo "* diff=bin" > .gitattributes &&
+	printf "a\0b" >data.bin &&
+	git add data.bin &&
+	git commit -m "message" &&
+	git -c diff.bin.textconv=cat log -G a >actual &&
+	git log >expected &&
+	test_cmp actual expected
+'
+
 test_done
-- 
2.19.0.271.gfe8321ec05.dirty

