From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk.git: Add Makefile with rules for po file creation.
Date: Sat, 28 Jul 2007 14:52:17 +0200
Message-ID: <200707281452.17560.stimming@tuhh.de>
References: <959247.27950.qm@web38905.mail.mud.yahoo.com> <18090.44180.802184.747398@cargo.ozlabs.ibm.com> <200707281440.26660.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Junio Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 14:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IElmm-00071M-Se
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 14:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXG1Mwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 08:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbXG1Mwb
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 08:52:31 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:34144 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbXG1Mwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 08:52:30 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6SCqOkf002770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 28 Jul 2007 14:52:24 +0200
Received: from [192.168.2.102] (p549024E3.dip0.t-ipconnect.de [84.144.36.227])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6SCqNnh002206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jul 2007 14:52:24 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200707281440.26660.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54030>

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
Similar to the previous patch with the message markup, this one has also been created against the kernel.org gitk.git. These would be the necessary Makefile rules for string extraction by gettext.

 Makefile |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 Makefile

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..d7b75fb
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,39 @@
+# Set the installation directories; this section is needed only in
+# gitk.git but not in git.git.
+ifndef gitexecdir
+	gitexecdir := $(shell git --exec-path)
+endif
+ifndef sharedir
+	sharedir := $(dir $(gitexecdir))share
+endif
+
+# From here on, all is needed in git.git/Makefile.
+libdir   ?= $(sharedir)/gitk/lib
+msgsdir    ?= $(libdir)/msgs
+msgsdir_SQ  = $(subst ','\'',$(msgsdir))
+
+## Beginning of po-file creation rules
+XGETTEXT   ?= xgettext
+PO_TEMPLATE = po/gitk.pot
+ALL_POFILES = $(wildcard po/*.po)
+ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
+
+$(PO_TEMPLATE): gitk
+	$(XGETTEXT) -kmc -LTcl -o $@ gitk
+update-po:: $(PO_TEMPLATE)
+	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
+$(ALL_MSGFILES): %.msg : %.po
+	@echo Generating catalog $@
+	msgfmt --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
+
+all:: $(ALL_MSGFILES)
+
+clean::
+	rm -f $(ALL_PROGRAMS) po/*.msg
+## End of po-file creation rules
+
+# Install rules for po-files
+install: all
+	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(msgsdir_SQ)' $(INSTALL_D1)
+	$(QUIET)$(foreach p,$(ALL_MSGFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
+
-- 
1.5.2
