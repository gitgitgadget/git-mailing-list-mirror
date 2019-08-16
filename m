Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A9E1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 23:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfHPXGf (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 19:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbfHPXGf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 19:06:35 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FAB82086C;
        Fri, 16 Aug 2019 22:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565996219;
        bh=ycCLJTX/dUWk5n58zNCglbYBSFR/d2QiQCc8LceTGik=;
        h=From:To:Cc:Subject:Date:From;
        b=SFRqdTTvIDqYugaueqTPxqBlVtU0FhEAD43VMLaXnUC0QrXrjhJM9hk1CTZBvU5gW
         SNmWzwpgFKPa8l0s27YEfO5oFaxJAava5mcOYx2LQqR4Scrl6uUuiHxwNzPjfIgLyy
         wssZetN7hhsbFEw7TUYcghnrKa1fvroeX3YY84Ao=
From:   Stephen Boyd <sboyd@kernel.org>
To:     git@vger.kernel.org
Cc:     Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        devicetree@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2] userdiff: Add a builtin pattern for dts files
Date:   Fri, 16 Aug 2019 15:56:58 -0700
Message-Id: <20190816225658.8946-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Linux kernel receives many patches to the devicetree files each
release. The hunk header for those patches typically show nothing,
making it difficult to figure out what node is being modified without
applying the patch or opening the file and seeking to the context. Let's
add a builtin 'dts' pattern to git so that users can get better diff
output on dts files when they use the diff=dts driver.

The regex has been constructed based on the spec at devicetree.org[1]

[1] https://github.com/devicetree-org/devicetree-specification/releases/latest

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Sending this again after getting feedback and it getting stuck in
review[1]. I'm not sure what happened with the meta question from Junio
to add a way for various projects to introduce their own patterns, but
I'd still prefer to have this in git proper because the kernel uses git
extensively and we rely on git formatted patches in our workflow. I
recently reviewed a dts change and remembered this never got accepted.

Changes from v1:
 * Updated regex to handle anything after node names instead of
   requiring a '{'
 * Updated test for boolean relation operators
 * Sent out a patch to devicetree spec to document % operator

[1] Feedback was in 16335abe-5e7e-fd7a-25f4-373f94e176e1@gmail.com

 Documentation/gitattributes.txt |  2 ++
 t/t4018-diff-funcname.sh        |  1 +
 t/t4018/dts-labels              |  8 +++++++
 t/t4018/dts-node-unitless       |  8 +++++++
 t/t4018/dts-nodes               |  8 +++++++
 t/t4018/dts-reference           |  8 +++++++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/dts/expect              | 37 +++++++++++++++++++++++++++++++++
 t/t4034/dts/post                | 32 ++++++++++++++++++++++++++++
 t/t4034/dts/pre                 | 32 ++++++++++++++++++++++++++++
 userdiff.c                      |  9 ++++++++
 11 files changed, 146 insertions(+)
 create mode 100644 t/t4018/dts-labels
 create mode 100644 t/t4018/dts-node-unitless
 create mode 100644 t/t4018/dts-nodes
 create mode 100644 t/t4018/dts-reference
 create mode 100644 t/t4034/dts/expect
 create mode 100644 t/t4034/dts/post
 create mode 100644 t/t4034/dts/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index fb1d188d440c..c5a528c667b6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -810,6 +810,8 @@ patterns are available:
 
 - `css` suitable for cascading style sheets.
 
+- `dts` suitable for devicetree (DTS) files.
+
 - `fortran` suitable for source code in the Fortran language.
 
 - `fountain` suitable for Fountain documents.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9261d6d3a000..6f5ef0035e92 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -31,6 +31,7 @@ diffpatterns="
 	cpp
 	csharp
 	css
+	dts
 	fortran
 	fountain
 	golang
diff --git a/t/t4018/dts-labels b/t/t4018/dts-labels
new file mode 100644
index 000000000000..27cd4921cfb6
--- /dev/null
+++ b/t/t4018/dts-labels
@@ -0,0 +1,8 @@
+/ {
+	label_1: node1@ff00 {
+		label2: RIGHT {
+			vendor,some-property;
+			ChangeMe = <0x45-30>;
+		};
+	};
+};
diff --git a/t/t4018/dts-node-unitless b/t/t4018/dts-node-unitless
new file mode 100644
index 000000000000..c5287d91416e
--- /dev/null
+++ b/t/t4018/dts-node-unitless
@@ -0,0 +1,8 @@
+/ {
+	label_1: node1 {
+		RIGHT {
+			prop-array = <1>, <4>;
+			ChangeMe = <0xffeedd00>;
+		};
+	};
+};
diff --git a/t/t4018/dts-nodes b/t/t4018/dts-nodes
new file mode 100644
index 000000000000..5a4334bb1645
--- /dev/null
+++ b/t/t4018/dts-nodes
@@ -0,0 +1,8 @@
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 {
+			#size-cells = <1>;
+			ChangeMe = <0xffeedd00>;
+		};
+	};
+};
diff --git a/t/t4018/dts-reference b/t/t4018/dts-reference
new file mode 100644
index 000000000000..f115d4291d25
--- /dev/null
+++ b/t/t4018/dts-reference
@@ -0,0 +1,8 @@
+&label_1 {
+	TEST = <455>;
+};
+
+&RIGHT {
+	vendor,some-property;
+	ChangeMe = <0x45-30>;
+};
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 912df91226f2..9a93c2a3e0dd 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -303,6 +303,7 @@ test_language_driver bibtex
 test_language_driver cpp
 test_language_driver csharp
 test_language_driver css
+test_language_driver dts
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
diff --git a/t/t4034/dts/expect b/t/t4034/dts/expect
new file mode 100644
index 000000000000..560fc9918476
--- /dev/null
+++ b/t/t4034/dts/expect
@@ -0,0 +1,37 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index b6a9051..7803aee 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,32 +1,32 @@<RESET>
+/ {<RESET>
+	<RED>this_handle<RESET><GREEN>HANDLE_2<RESET>: <RED>node<RESET><GREEN>new-node<RESET>@<RED>f00<RESET><GREEN>eeda<RESET> {
+		compatible = "<RED>mydev<RESET><GREEN>vendor,compat<RESET>";
+		string-prop = <RED>start<RESET><GREEN>end<RESET>: "hello <RED>world!<RESET><GREEN>world?<RESET>" <RED>end<RESET><GREEN>start<RESET>: ;
+		<RED>#size-cells<RESET><GREEN>#address-cells<RESET> = <<RED>0+0<RESET><GREEN>0+40<RESET>>;
+		reg = <<RED>0xf00<RESET><GREEN>0xeeda<RESET>>;
+		prop = <<GREEN>(<RESET>1<GREEN>)<RESET>>;
+		prop = <<GREEN>(<RESET>-1e10<GREEN>)<RESET>>;
+		prop = <(!<RED>3<RESET><GREEN>1<RESET>)>;
+		prop = <(~<RED>3<RESET><GREEN>1<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>*<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>&<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>*<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>/<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>%<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3+4<RESET><GREEN>1+2<RESET>)>;
+		prop = <(<RED>3-4<RESET><GREEN>1-2<RESET>)>;
+		prop = /bits/ <RED>64<RESET><GREEN>32<RESET> <(<RED>3<RESET><GREEN>1<RESET><<<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>>><RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>&<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>^<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>|<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>&&<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>3<RESET><GREEN>1<RESET>||<RED>4<RESET><GREEN>2<RESET>)>;
+		prop = <(<RED>4?5<RESET><GREEN>1?2<RESET>:3)>;
+		list = <&<RED>this_handle<RESET><GREEN>HANDLE_2<RESET>>, <0 0 0 <RED>0<RESET><GREEN>1<RESET>>;
+	};<RESET>
+
+	&<RED>phandle<RESET><GREEN>phandle2<RESET> {
+		<RED>pre-phandle<RESET><GREEN>prop_handle<RESET> = <&<RED>this_handle<RESET><GREEN>HANDLE_2<RESET>>;
+	};<RESET>
+};<RESET>
diff --git a/t/t4034/dts/post b/t/t4034/dts/post
new file mode 100644
index 000000000000..7803aee28093
--- /dev/null
+++ b/t/t4034/dts/post
@@ -0,0 +1,32 @@
+/ {
+	HANDLE_2: new-node@eeda {
+		compatible = "vendor,compat";
+		string-prop = end: "hello world?" start: ;
+		#address-cells = <0+40>;
+		reg = <0xeeda>;
+		prop = <(1)>;
+		prop = <(-1e10)>;
+		prop = <(!1)>;
+		prop = <(~1)>;
+		prop = <(1*2)>;
+		prop = <(1&2)>;
+		prop = <(1*2)>;
+		prop = <(1/2)>;
+		prop = <(1%2)>;
+		prop = <(1+2)>;
+		prop = <(1-2)>;
+		prop = /bits/ 32 <(1<<2)>;
+		prop = <(1>>2)>;
+		prop = <(1&2)>;
+		prop = <(1^2)>;
+		prop = <(1|2)>;
+		prop = <(1&&2)>;
+		prop = <(1||2)>;
+		prop = <(1?2:3)>;
+		list = <&HANDLE_2>, <0 0 0 1>;
+	};
+
+	&phandle2 {
+		prop_handle = <&HANDLE_2>;
+	};
+};
diff --git a/t/t4034/dts/pre b/t/t4034/dts/pre
new file mode 100644
index 000000000000..b6a905113c22
--- /dev/null
+++ b/t/t4034/dts/pre
@@ -0,0 +1,32 @@
+/ {
+	this_handle: node@f00 {
+		compatible = "mydev";
+		string-prop = start: "hello world!" end: ;
+		#size-cells = <0+0>;
+		reg = <0xf00>;
+		prop = <1>;
+		prop = <-1e10>;
+		prop = <(!3)>;
+		prop = <(~3)>;
+		prop = <(3*4)>;
+		prop = <(3&4)>;
+		prop = <(3*4)>;
+		prop = <(3/4)>;
+		prop = <(3%4)>;
+		prop = <(3+4)>;
+		prop = <(3-4)>;
+		prop = /bits/ 64 <(3<<4)>;
+		prop = <(3>>4)>;
+		prop = <(3&4)>;
+		prop = <(3^4)>;
+		prop = <(3|4)>;
+		prop = <(3&&4)>;
+		prop = <(3||4)>;
+		prop = <(4?5:3)>;
+		list = <&this_handle>, <0 0 0 0>;
+	};
+
+	&phandle {
+		pre-phandle = <&this_handle>;
+	};
+};
diff --git a/userdiff.c b/userdiff.c
index e74a6d402255..1db5d30aaebe 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -23,6 +23,15 @@ IPATTERN("ada",
 	 "[a-zA-Z][a-zA-Z0-9_]*"
 	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
+PATTERNS("dts",
+	 /* Node name with optional label and unit address */
+	 "^[ \t]*((([a-zA-Z_][a-zA-Z0-9_]*:[ \t]*)?[a-zA-Z][a-zA-Z0-9,._+-]*(@[a-zA-Z0-9,._+-]+)?"
+	 /* Reference */
+	 "|&[a-zA-Z_][a-zA-Z0-9_]*)[ \t]*[^;]*)$",
+	 /* -- */
+	 /* Property names and math operators */
+	 "[a-zA-Z0-9,._+?#-]+"
+	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
 	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
-- 
Sent by a computer through tubes

