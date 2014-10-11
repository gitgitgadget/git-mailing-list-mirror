From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/4] Documentation: implement linkgit macro for Asciidoctor
Date: Sat, 11 Oct 2014 23:37:36 +0000
Message-ID: <1413070656-241955-5-git-send-email-sandals@crustytoothpaste.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 01:37:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xd6ER-0004Jk-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 01:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbaJKXhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 19:37:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49220 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785AbaJKXhq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2014 19:37:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6080628094
	for <git@vger.kernel.org>; Sat, 11 Oct 2014 23:37:44 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

AsciiDoc uses a configuration file to implement macros like linkgit,
while Asciidoctor uses Ruby extensions.  Implement a Ruby extension that
implements the linkgit macro for Asciidoctor in the same way that
asciidoc.conf does for AsciiDoc.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/extensions.rb | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/extensions.rb

diff --git a/Documentation/extensions.rb b/Documentation/extensions.rb
new file mode 100644
index 0000000..c33a50d
--- /dev/null
+++ b/Documentation/extensions.rb
@@ -0,0 +1,39 @@
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
+          generate_html(parent, target, attrs)
+        elsif parent.document.basebackend? 'docbook'
+          generate_docbook(parent, target, attrs)
+        end
+      end
+
+      private
+
+      def generate_html(parent, target, attrs)
+        section = attrs.has_key?(1) ? "(#{attrs[1]})" : ''
+        prefix = parent.document.attr('git-relative-html-prefix') || ''
+        %(<a href="#{prefix}#{target}.html">#{target}#{section}</a>\n)
+      end
+
+      def generate_docbook(parent, target, attrs)
+        %(<citerefentry>
+<refentrytitle>#{target}</refentrytitle><manvolnum>#{attrs[1]}</manvolnum>
+</citerefentry>
+)
+      end
+    end
+  end
+end
+
+Asciidoctor::Extensions.register do
+  inline_macro Git::Documentation::LinkGitProcessor, :linkgit
+end
-- 
2.1.1
