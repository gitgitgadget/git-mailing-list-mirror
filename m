Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A54EA1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 00:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdAZANx (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 19:13:53 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38104 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750853AbdAZANw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Jan 2017 19:13:52 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7C2A6280AD;
        Thu, 26 Jan 2017 00:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485389630;
        bh=swuGsnNggvyPN1tH8eQ0AIzBvtS8yCGK24oGRZIFMJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqjI3PnML0HcuZgFB1U53sy7qgasrYGfOcryWX+zO6y2+N+xvRAD2BGDu5pWKNgel
         xdJQm3eUtWdBwjUGyeMXRm+HUPhuUdYnBDQC0wN08ZHpJi1sgR5hZPPV0w5C4T9R42
         6l1PSm8CvtQnnIaoh+y4k6oem26DNq6lE9x6SP1wpsq0PloYcFTpaMP7Pe/7UWDCo3
         1UTJpCVds6QfJGwEe4bA0jvr0qWQS5nA+ClenUddRleVfT+046NH4/0EJLvopAUvqW
         gnL+yw1mg3kSUcR+xyXPFikAzRavnpZ9bzaxp1La32fbf+fL0SJWDUzr714FpVf6ec
         BCqgWuFFIAVnmPte8AUxZ2890x/NA1vasxEnePcx+3Rnh6LPGNXHe4hZpKw3bM0OM2
         HsqnAHUq0/VZYY+8on+5GPeEi0GZQrJVAJ7dxAzG6Puy7H5mSBVgjvG8BOgU/TDZ6f
         1u1qBLu6wnFUR2pa7d+sm3ERJc+u/lIoQj7MfMlC3SJWbOzYG38
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
Subject: [PATCH] Documentation: implement linkgit macro for Asciidoctor
Date:   Thu, 26 Jan 2017 00:13:44 +0000
Message-Id: <20170126001344.445534-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net>
References: <20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

AsciiDoc uses a configuration file to implement macros like linkgit,
while Asciidoctor uses Ruby extensions.  Implement a Ruby extension that
implements the linkgit macro for Asciidoctor in the same way that
asciidoc.conf does for AsciiDoc.  Adjust the Makefile to use it by
default.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile                  |  5 +----
 Documentation/asciidoctor-extensions.rb | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/asciidoctor-extensions.rb

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 19c42eb60..d1b7a6865 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -179,10 +179,7 @@ ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
 ASCIIDOC_HTML = xhtml5
 ASCIIDOC_DOCBOOK = docbook45
-ifdef ASCIIDOCTOR_EXTENSIONS_LAB
-ASCIIDOC_EXTRA = -I$(ASCIIDOCTOR_EXTENSIONS_LAB) -rasciidoctor/extensions -rman-inline-macro
-endif
-ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
 endif
 
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
new file mode 100644
index 000000000..09f7088ee
--- /dev/null
+++ b/Documentation/asciidoctor-extensions.rb
@@ -0,0 +1,28 @@
+require 'asciidoctor'
+require 'asciidoctor/extensions'
+
+module Git
+  module Documentation
+    class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
+      use_dsl
+
+      named :chrome
+
+      def process(parent, target, attrs)
+        if parent.document.basebackend? 'html'
+          prefix = parent.document.attr('git-relative-html-prefix')
+          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>\n)
+        elsif parent.document.basebackend? 'docbook'
+          %(<citerefentry>
+<refentrytitle>#{target}</refentrytitle><manvolnum>#{attrs[1]}</manvolnum>
+</citerefentry>
+)
+        end
+      end
+    end
+  end
+end
+
+Asciidoctor::Extensions.register do
+  inline_macro Git::Documentation::LinkGitProcessor, :linkgit
+end
-- 
2.11.0

