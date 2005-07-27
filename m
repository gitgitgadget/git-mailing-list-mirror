From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH/RFC] "Recursive Make considered harmful"
Date: Wed, 27 Jul 2005 04:39:10 -0400
Message-ID: <20050727083910.GG19290@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 27 10:39:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxhRf-0000Sq-TC
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 10:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVG0IjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 04:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVG0IjN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 04:39:13 -0400
Received: from mail.autoweb.net ([198.172.237.26]:64451 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261688AbVG0IjL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2005 04:39:11 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DxhRX-0006xq-Hr
	for git@vger.kernel.org; Wed, 27 Jul 2005 04:39:11 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DxhaW-0007Zr-00
	for <git@vger.kernel.org>; Wed, 27 Jul 2005 04:48:28 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DxhRW-0007bD-Tn
	for git@vger.kernel.org; Wed, 27 Jul 2005 04:39:10 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Convert build process from recurse Make to a single Make

The old Makefiles in Documentation/ and tools/ still exist until we feel
confident that I didn't miss anything on this conversion.

Most of this patch is fixing up the main Makefile to avoid overlapping
target names.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Documentation/Makefile.inc |   50 ++++++++++++++++++++++++++++++++++++++++++++
 Makefile                   |   24 ++++++++++++++-------
 tools/Makefile.inc         |   12 +++++++++++
 3 files changed, 78 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/Makefile.inc
 create mode 100644 tools/Makefile.inc

003afd3ed1f83b4533b628182fa16c9ab0dc0467
diff --git a/Documentation/Makefile.inc b/Documentation/Makefile.inc
new file mode 100644
--- /dev/null
+++ b/Documentation/Makefile.inc
@@ -0,0 +1,50 @@
+MAN1_TXT=$(wildcard Documentation/git-*.txt)
+MAN7_TXT=Documentation/git.txt
+
+DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
+
+DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
+DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
+
+mandir=$(prefix)/man
+man1=$(mandir)/man1
+man7=$(mandir)/man7
+
+#
+# Please note that there is a minor bug in asciidoc.
+# The version after 6.0.3 _will_ include the patch found here:
+#   http://marc.theaimsgroup.com/?l=git&m=111558757202243&w=2
+#
+# Until that version is released you may have to apply the patch
+# yourself - yes, all 6 characters of it!
+#
+
+all-doc: html man
+
+html: $(DOC_HTML)
+
+
+man: man1 man7
+man1: $(DOC_MAN1)
+man7: $(DOC_MAN7)
+
+install-doc:
+	$(INSTALL) -m755 -d $(dest)/$(man1) $(dest)/$(man7)
+	$(INSTALL) $(DOC_MAN1) $(dest)/$(man1)
+	$(INSTALL) $(DOC_MAN7) $(dest)/$(man7)
+
+# 'include' dependencies
+Documentation/git-diff-%.txt: Documentation/diff-format.txt Documentation/diff-options.txt
+	touch $@
+
+clean-doc:
+	rm -f Documentation/*.xml Documentation/*.html Documentation/*.1 Documentation/*.7
+
+%.html : %.txt
+	asciidoc -b xhtml11 -d manpage $<
+
+%.1 %.7 : %.xml
+	xmlto -o Documentation/ man $<
+
+%.xml : %.txt
+	asciidoc -b docbook -d manpage $<
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -54,9 +54,17 @@ PROG=   git-update-cache git-diff-files 
 	git-show-index git-daemon git-var git-peek-remote \
 	git-update-server-info git-show-rev-cache git-build-rev-cache
 
-all: $(PROG)
+include Documentation/Makefile.inc
+include tools/Makefile.inc
 
-install: $(PROG) $(SCRIPTS)
+all: all-bin all-doc
+all-bin: $(PROG)
+#all-tools
+
+install: install-bin install-doc
+#install-tools
+
+install-bin: $(PROG) $(SCRIPTS)
 	$(INSTALL) -m755 -d $(dest)$(bin)
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
@@ -204,20 +212,20 @@ rpm: dist
 test: all
 	$(MAKE) -C t/ all
 
-doc:
-	$(MAKE) -C Documentation all
+doc: all-doc
+#	$(MAKE) -C Documentation all
 
-install-tools:
+install-toolsxx:
 	$(MAKE) -C tools install
 
-install-doc:
+install-docxx:
 	$(MAKE) -C Documentation install
 
-clean:
+clean: clean-doc clean-tools
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
 	rm -f git-core-*.tar.gz git-core.spec
 	$(MAKE) -C tools/ clean
-	$(MAKE) -C Documentation/ clean
 
 backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
+
diff --git a/tools/Makefile.inc b/tools/Makefile.inc
new file mode 100644
--- /dev/null
+++ b/tools/Makefile.inc
@@ -0,0 +1,12 @@
+#
+# Make Linus git-tools
+#
+
+PROG += $(addprefix tools/,git-mailsplit git-mailinfo)
+SCRIPTS += $(addprefix tools/,git-applymbox git-applypatch)
+
+tools/git-%: tools/%.c
+	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^)
+
+clean-tools:
+	rm -f tools/*.o

-- 

Ryan Anderson
  sometimes Pug Majere
