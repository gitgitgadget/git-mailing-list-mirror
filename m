Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A870C1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 20:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437210AbfJPUcl (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 16:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437206AbfJPUcl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 16:32:41 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E256521835;
        Wed, 16 Oct 2019 20:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571257960;
        bh=ElojbImnshP0TRo09IZ/1koEsDY7xKuUkzV0BSp1hnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=C/DqzyeQX7UcuZh6nAZP4mLJqqu6ZtDtOVWa2eI9KbFUa/akgBj92iWvNjj/TSbms
         YbrZ7/BabJjCUC+B0swDDtegepTqQoNxp7nbx4bq79WeGdj4ZS81EokkMgfsmIOo3J
         YtEMf1D8F9gQI8Ig6wFDCK+nHHfid1ZZbC1eQ19E=
From:   Stephen Boyd <sboyd@kernel.org>
To:     git@vger.kernel.org
Cc:     Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        Junio C Hamano <gitster@pobox.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2] userdiff: Fix some corner cases in dts regex
Date:   Wed, 16 Oct 2019 13:32:39 -0700
Message-Id: <20191016203239.212174-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
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

Changes from v1:
 * Added a new boolean property unit test
 * Updated the regex to simplify multi-line property skipping
 * Added some space to multieline prop test between cells in
   first property

 t/t4018/dts-nodes-boolean-prop   |  9 +++++++++
 t/t4018/dts-nodes-multiline-prop | 14 ++++++++++++++
 t/t4018/dts-root                 |  2 +-
 t/t4018/dts-root-comment         |  8 ++++++++
 userdiff.c                       |  3 ++-
 5 files changed, 34 insertions(+), 2 deletions(-)
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
index 000000000000..db4b4bdda686
--- /dev/null
+++ b/t/t4018/dts-nodes-multiline-prop
@@ -0,0 +1,14 @@
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 {
+			multilineprop = <3>,
+
+
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

