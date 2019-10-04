Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350391F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 21:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfJDVab (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 17:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDVab (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 17:30:31 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E82215EA;
        Fri,  4 Oct 2019 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570224630;
        bh=BZ8D3ASkRBLiAl1fEalEQcByzgh8ZyMWZRFDcK/FGTw=;
        h=From:To:Cc:Subject:Date:From;
        b=GOE1S2Cg/0DiHxOloVe8Oss0fDVAASzm77Bz/TbLIkYgC0DqbTB0TED1AnQgB41dM
         7/jCWcGpQ1dt0aE1mbNRQhZ4+Dyfc22XiPFlaUh22BKM0rn9hBYKO5OFYMWg7qBO/V
         MzzHzYymW/b3rWYS9F/Rbejr08i0GwhPnqYIj/to=
From:   Stephen Boyd <sboyd@kernel.org>
To:     git@vger.kernel.org
Cc:     Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        Junio C Hamano <gitster@pobox.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] userdiff: Fix some corner cases in dts regex
Date:   Fri,  4 Oct 2019 14:30:29 -0700
Message-Id: <20191004213029.145027-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While reviewing some dts diffs recently I noticed that the hunk header
logic was failing to find the containing node. This is because the regex
doesn't consider properties that may span multiple lines, i.e.

	property = <something>,
		   <something_else>;

and it got hung up on comments inside nodes that look like the root node
because they start with '/*'. Add tests for these cases and update the
regex to find them. Maybe detecting the root node is too complicated but
forcing it to be a backslash with any amount of whitespace up to an open
bracket seemed OK. I tried to detect that a comment is in-between the
two parts but I wasn't happy so I just dropped it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 t/t4018/dts-nodes-multiline-prop | 12 ++++++++++++
 t/t4018/dts-root                 |  2 +-
 t/t4018/dts-root-comment         |  8 ++++++++
 userdiff.c                       |  3 ++-
 4 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 t/t4018/dts-nodes-multiline-prop
 create mode 100644 t/t4018/dts-root-comment

diff --git a/t/t4018/dts-nodes-multiline-prop b/t/t4018/dts-nodes-multiline-prop
new file mode 100644
index 000000000000..f7b655935429
--- /dev/null
+++ b/t/t4018/dts-nodes-multiline-prop
@@ -0,0 +1,12 @@
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 {
+			multilineprop = <3>,
+					<4>;
+
+
+
+			ChangeMe = <0xffeedd00>;
+		};
+	};
+};
diff --git a/t/t4018/dts-root b/t/t4018/dts-root
index 2ef9e6ffaa2c..4353b8220c91 100644
--- a/t/t4018/dts-root
+++ b/t/t4018/dts-root
@@ -1,4 +1,4 @@
-/RIGHT { /* Technically just supposed to be a slash */
+/ { RIGHT /* Technically just supposed to be a slash and brace */
 	#size-cells = <1>;
 
 	ChangeMe = <0xffeedd00>;
diff --git a/t/t4018/dts-root-comment b/t/t4018/dts-root-comment
new file mode 100644
index 000000000000..333a625c7007
--- /dev/null
+++ b/t/t4018/dts-root-comment
@@ -0,0 +1,8 @@
+/ { RIGHT /* Technically just supposed to be a slash and brace */
+	#size-cells = <1>;
+
+	/* This comment should be ignored */
+
+	some-property = <40+2>;
+	ChangeMe = <0xffeedd00>;
+};
diff --git a/userdiff.c b/userdiff.c
index 86e3244e15dd..651b56caec56 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -25,8 +25,9 @@ IPATTERN("ada",
 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
 PATTERNS("dts",
 	 "!;\n"
+	 "!.*=.*\n"
 	 /* lines beginning with a word optionally preceded by '&' or the root */
-	 "^[ \t]*((/|&?[a-zA-Z_]).*)",
+	 "^[ \t]*((/[ \t]*\\{|&?[a-zA-Z_]).*)",
 	 /* -- */
 	 /* Property names and math operators */
 	 "[a-zA-Z0-9,._+?#-]+"
-- 
Sent by a computer through tubes

