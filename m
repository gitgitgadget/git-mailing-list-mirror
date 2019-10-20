Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146A61F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 18:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfJTSwb (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 14:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfJTSwb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 14:52:31 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916F321928;
        Sun, 20 Oct 2019 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571597550;
        bh=Ez4ENTvYs0AfI3YbAmEvULnW7Y+h0pBneEkV67koPdw=;
        h=From:To:Cc:Subject:Date:From;
        b=H6QFWknoDst1WPX3HbWPMkx2TIwKh9iK2+6LZfTVfh5nvDDKzPPB0VoR1nesxJkYV
         Ld6tuyKJJfjdM0V0LPtnWcigKx+rdspuKzjV47JkWC/lYGov25Sm9RwiJqJS35cT6M
         S138DqsZSaYQtZ+Rw8ZMIe4D0gu+LqkstW25XMl0=
From:   Stephen Boyd <sboyd@kernel.org>
To:     git@vger.kernel.org
Cc:     Adrian Johnson <ajohnson@redneon.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3] userdiff: Fix some corner cases in dts regex
Date:   Sun, 20 Oct 2019 11:52:30 -0700
Message-Id: <20191020185230.212875-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
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

Changes from v2:
 * Updated test to be really multiline.

Changes from v1:
 * Added a new boolean property unit test
 * Updated the regex to simplify multi-line property skipping
 * Added some space to multieline prop test between cells in
   first property

 t/t4018/dts-nodes-boolean-prop   |  9 +++++++++
 t/t4018/dts-nodes-multiline-prop | 13 +++++++++++++
 t/t4018/dts-root                 |  2 +-
 t/t4018/dts-root-comment         |  8 ++++++++
 userdiff.c                       |  3 ++-
 5 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 t/t4018/dts-nodes-boolean-prop
 create mode 100644 t/t4018/dts-nodes-multiline-prop
 create mode 100644 t/t4018/dts-root-comment

diff --git a/t/t4018/dts-nodes-boolean-prop b/t/t4018/dts-nodes-boolean-prop
new file mode 100644
index 000000000000..afc6b5b404e4
--- /dev/null
+++ b/t/t4018/dts-nodes-boolean-prop
@@ -0,0 +1,9 @@
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 {
+			boolean-prop1;
+
+			ChangeMe;
+		};
+	};
+};
diff --git a/t/t4018/dts-nodes-multiline-prop b/t/t4018/dts-nodes-multiline-prop
new file mode 100644
index 000000000000..072d58b69dc2
--- /dev/null
+++ b/t/t4018/dts-nodes-multiline-prop
@@ -0,0 +1,13 @@
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 {
+			multilineprop = <3>,
+					<4>,
+					<5>,
+					<6>,
+					<7>;
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
index 86e3244e15dd..e187d356f6ff 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -25,8 +25,9 @@ IPATTERN("ada",
 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
 PATTERNS("dts",
 	 "!;\n"
+	 "!=\n"
 	 /* lines beginning with a word optionally preceded by '&' or the root */
-	 "^[ \t]*((/|&?[a-zA-Z_]).*)",
+	 "^[ \t]*((/[ \t]*\\{|&?[a-zA-Z_]).*)",
 	 /* -- */
 	 /* Property names and math operators */
 	 "[a-zA-Z0-9,._+?#-]+"
-- 
Sent by a computer through tubes

