From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/2] contacts: Add a Makefile to generate docs and install
Date: Wed, 15 Oct 2014 20:50:18 +0200
Message-ID: <543EC1EA.8040300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 20:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeTj6-0007Mu-Qr
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 20:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaJOSzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 14:55:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:52907 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbaJOSzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 14:55:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XeTix-0007Hd-NP
	for git@vger.kernel.org; Wed, 15 Oct 2014 20:55:03 +0200
Received: from p4ff44b8f.dip0.t-ipconnect.de ([79.244.75.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 20:55:03 +0200
Received: from sschuberth by p4ff44b8f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 20:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4ff44b8f.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also add a gitignore file for generated files.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 contrib/contacts/.gitignore |  3 ++
 contrib/contacts/Makefile   | 71 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 contrib/contacts/.gitignore
 create mode 100644 contrib/contacts/Makefile

diff --git a/contrib/contacts/.gitignore b/contrib/contacts/.gitignore
new file mode 100644
index 0000000..bc9ae70
--- /dev/null
+++ b/contrib/contacts/.gitignore
@@ -0,0 +1,3 @@
+git-contacts.1
+git-contacts.html
+git-contacts.xml
diff --git a/contrib/contacts/Makefile b/contrib/contacts/Makefile
new file mode 100644
index 0000000..a2990f0
--- /dev/null
+++ b/contrib/contacts/Makefile
@@ -0,0 +1,71 @@
+# The default target of this Makefile is...
+all::
+
+-include ../../config.mak.autogen
+-include ../../config.mak
+
+prefix ?= /usr/local
+gitexecdir ?= $(prefix)/libexec/git-core
+mandir ?= $(prefix)/share/man
+man1dir ?= $(mandir)/man1
+htmldir ?= $(prefix)/share/doc/git-doc
+
+../../GIT-VERSION-FILE: FORCE
+	$(MAKE) -C ../../ GIT-VERSION-FILE
+
+-include ../../GIT-VERSION-FILE
+
+# this should be set to a 'standard' bsd-type install program
+INSTALL  ?= install
+RM       ?= rm -f
+
+ASCIIDOC = asciidoc
+XMLTO    = xmlto
+
+ifndef SHELL_PATH
+	SHELL_PATH = /bin/sh
+endif
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+
+ASCIIDOC_CONF = ../../Documentation/asciidoc.conf
+MANPAGE_XSL   = ../../Documentation/manpage-normal.xsl
+
+GIT_CONTACTS := git-contacts
+
+GIT_CONTACTS_DOC := git-contacts.1
+GIT_CONTACTS_XML := git-contacts.xml
+GIT_CONTACTS_TXT := git-contacts.txt
+GIT_CONTACTS_HTML := git-contacts.html
+
+doc: $(GIT_CONTACTS_DOC) $(GIT_CONTACTS_HTML)
+
+install: $(GIT_CONTACTS)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
+	$(INSTALL) -m 755 $(GIT_CONTACTS) $(DESTDIR)$(gitexecdir)
+
+install-doc: install-man install-html
+
+install-man: $(GIT_CONTACTS_DOC)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
+	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
+
+install-html: $(GIT_CONTACTS_HTML)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
+	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
+
+$(GIT_CONTACTS_DOC): $(GIT_CONTACTS_XML)
+	$(XMLTO) -m $(MANPAGE_XSL) man $^
+
+$(GIT_CONTACTS_XML): $(GIT_CONTACTS_TXT)
+	$(ASCIIDOC) -b docbook -d manpage -f $(ASCIIDOC_CONF) \
+		-agit_version=$(GIT_VERSION) $^
+
+$(GIT_CONTACTS_HTML): $(GIT_CONTACTS_TXT)
+	$(ASCIIDOC) -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
+		-agit_version=$(GIT_VERSION) $^
+
+clean:
+	$(RM) $(GIT_CONTACTS)
+	$(RM) *.xml *.html *.1
+
+.PHONY: FORCE
-- 
1.9.4.msysgit.2
