Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE01211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 21:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfAKVva (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 16:51:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfAKVva (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 16:51:30 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D0E2133F;
        Fri, 11 Jan 2019 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547243488;
        bh=3rX6Ad1gXF2ak3jugqu4xDAGVcZTN1sIsnOPpYdCVGM=;
        h=From:To:Cc:Subject:Date:From;
        b=osgRjptDkVKTYVMIZxU9uuh2EimEbwwCNubhcd/ck5Fh8rh6a3+MRqtMJDwo1c4yz
         ZytL9qzuVmrzOgTtvvGf1GYKZQ3/90sDumMt2Z5vfN0NkxwUGuADRVHJqpL+lDYW1/
         XcPzwaWGwS246iQ3si52BiHYvwkaI6i68IBjkegk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     git@vger.kernel.org
Cc:     Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        Alban Gruin <alban.gruin@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] userdiff: Add a builtin pattern for dts files
Date:   Fri, 11 Jan 2019 13:51:27 -0800
Message-Id: <20190111215127.57356-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
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
index b8392fc3300c..14e5784b962d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -805,6 +805,8 @@ patterns are available:
 
 - `css` suitable for cascading style sheets.
 
+- `dts` suitable for devicetree (DTS) files.
+
 - `fortran` suitable for source code in the Fortran language.
 
 - `fountain` suitable for Fountain documents.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 22f9f88f0afc..8acd04b206d4 100755
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
index 000000000000..ed6ad9c65f8b
--- /dev/null
+++ b/t/t4034/dts/expect
@@ -0,0 +1,37 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index ce95e99..7803aee 100644<RESET>
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
+		prop = <(<RED>4?5<RESET><GREEN>1?2<RESET>:<RED>6<RESET><GREEN>3<RESET>)>;
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
index 000000000000..ce95e993ec93
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
+		prop = <(4?5:6)>;
+		list = <&this_handle>, <0 0 0 0>;
+	};
+
+	&phandle {
+		pre-phandle = <&this_handle>;
+	};
+};
diff --git a/userdiff.c b/userdiff.c
index 97007abe5b16..2bc964e11089 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -23,6 +23,15 @@ IPATTERN("ada",
 	 "[a-zA-Z][a-zA-Z0-9_]*"
 	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
+PATTERNS("dts",
+	 /* Node name (with optional label and unit address) */
+	 "^[ \t]*((([a-zA-Z_][a-zA-Z0-9_]*: )?[a-zA-Z][a-zA-Z0-9,._+-]*(@[a-zA-Z0-9,._+-]+)?"
+	 /* Reference */
+	 "|&[a-zA-Z_][a-zA-Z0-9_]*[ \t]*)[ \t]*\\{)[ \t]*$",
+	 /* -- */
+	 /* Property names and math operators */
+	 "[a-zA-Z0-9,._+?#-]+"
+	 "|[-+*/%&^|!~]"),
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
 	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
-- 
Sent by a computer through tubes

