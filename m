From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 1/2] Documentation: Allow @@GIT_VERSION@@ in asciidoc.conf
Date: Fri, 23 Mar 2007 19:54:04 +0100
Message-ID: <11746760451462-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 19:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUovP-0004WJ-B8
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 19:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbXCWSzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 14:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbXCWSzj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 14:55:39 -0400
Received: from mail.lenk.info ([217.160.134.107]:59467 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbXCWSzi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 14:55:38 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HUovo-00087J-S1; Fri, 23 Mar 2007 19:56:08 +0100
Received: from p3ee3db96.dip.t-dialin.net ([62.227.219.150] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HUovH-0002vu-K8; Fri, 23 Mar 2007 19:55:35 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HUotp-0000gm-S1; Fri, 23 Mar 2007 19:54:05 +0100
X-Mailer: git-send-email 1.5.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42954>

Rename asciidoc.conf to asciidoc.conf.in and create
the former on build time after piping it through sed.

This is useful to allow us to include the git version
in the documentation.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/Makefile         |   11 ++++++++---
 Documentation/asciidoc.conf    |   39 ---------------------------------------
 Documentation/asciidoc.conf.in |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/asciidoc.conf
 create mode 100644 Documentation/asciidoc.conf.in

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7c1c9e1..6197929 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -38,6 +38,7 @@ DOC_REF = origin/man
 
 -include ../config.mak.autogen
 -include ../config.mak
+-include ../GIT-VERSION-FILE
 
 #
 # Please note that there is a minor bug in asciidoc.
@@ -90,16 +91,20 @@ $(cmds_txt): cmd-list.perl $(MAN1_TXT)
 git.7 git.html: git.txt core-intro.txt
 
 clean:
-	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep
+	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep asciidoc.conf
 	rm -f $(cmds_txt)
 
-%.html : %.txt
+asciidoc.conf: asciidoc.conf.in
+	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $< >$@+
+	mv $@+ $@
+
+%.html : %.txt asciidoc.conf
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) $<
 
 %.1 %.7 : %.xml
 	xmlto -m callouts.xsl man $<
 
-%.xml : %.txt
+%.xml : %.txt asciidoc.conf
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf $<
 
 user-manual.xml: user-manual.txt user-manual.conf
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
deleted file mode 100644
index 44b1ce4..0000000
--- a/Documentation/asciidoc.conf
+++ /dev/null
@@ -1,39 +0,0 @@
-## gitlink: macro
-#
-# Usage: gitlink:command[manpage-section]
-#
-# Note, {0} is the manpage section, while {target} is the command.
-#
-# Show GIT link as: <command>(<section>); if section is defined, else just show
-# the command.
-
-[attributes]
-caret=^
-startsb=&#91;
-endsb=&#93;
-tilde=&#126;
-
-ifdef::backend-docbook[]
-[gitlink-inlinemacro]
-{0%{target}}
-{0#<citerefentry>}
-{0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
-{0#</citerefentry>}
-endif::backend-docbook[]
-
-ifdef::backend-docbook[]
-# "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
-[listingblock]
-<example><title>{title}</title>
-<literallayout>
-|
-</literallayout>
-{title#}</example>
-endif::backend-docbook[]
-
-ifdef::backend-xhtml11[]
-[gitlink-inlinemacro]
-<a href="{target}.html">{target}{0?({0})}</a>
-endif::backend-xhtml11[]
-
-
diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
new file mode 100644
index 0000000..44b1ce4
--- /dev/null
+++ b/Documentation/asciidoc.conf.in
@@ -0,0 +1,39 @@
+## gitlink: macro
+#
+# Usage: gitlink:command[manpage-section]
+#
+# Note, {0} is the manpage section, while {target} is the command.
+#
+# Show GIT link as: <command>(<section>); if section is defined, else just show
+# the command.
+
+[attributes]
+caret=^
+startsb=&#91;
+endsb=&#93;
+tilde=&#126;
+
+ifdef::backend-docbook[]
+[gitlink-inlinemacro]
+{0%{target}}
+{0#<citerefentry>}
+{0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
+{0#</citerefentry>}
+endif::backend-docbook[]
+
+ifdef::backend-docbook[]
+# "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
+[listingblock]
+<example><title>{title}</title>
+<literallayout>
+|
+</literallayout>
+{title#}</example>
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[gitlink-inlinemacro]
+<a href="{target}.html">{target}{0?({0})}</a>
+endif::backend-xhtml11[]
+
+
-- 
1.5.0.3
