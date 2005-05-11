From: Jonas Fonseca <fonseca@diku.dk>
Subject: [RFC] Embedding asciidoc manpages in the cg scripts
Date: Wed, 11 May 2005 03:44:45 +0200
Message-ID: <20050511014445.GA14377@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 03:37:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVgAI-0006q4-Ee
	for gcvg-git@gmane.org; Wed, 11 May 2005 03:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVEKBo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 21:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVEKBo6
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 21:44:58 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:11750 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261873AbVEKBoq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 21:44:46 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 5DAED6E0EE8; Wed, 11 May 2005 03:44:42 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id F3E566E0207; Wed, 11 May 2005 03:44:41 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 4C47C61FDE; Wed, 11 May 2005 03:44:45 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Pasky,

I am still a bit unsure how you want to embed asciidoc in the cg scripts
so I hope you will comment on this patch probe.

The Makefile stuff is pretty much ripped off from the recent Makefile by
David Greaves. I don't know if it should also live in
Documentation/Makefile.

You mentioned that you wanted the usage info in the USAGE variable. The
variable is initialized so that the usage info can be sed'ed out and
become part of the manpage. I assume the reason for this is to add a
usage function to cg-Xlib and use it as I have done in cg-add. This
should of course be done in a separate patch.

Finally, the embedded asciidoc markup. I still don't understand why you
dislike the cg-CMD strings in the NAME section. Asciidoc expects them
there and it will be so much harder to add them to the output of
$(cg-help cg-CMD).

---

 Makefile  |   28 +++++++++++++++++++++++++
 cg-Xlib   |    7 +++++-
 cg-add    |   28 ++++++++++++++++++++++---
 cg-commit |    4 +--
 cg-log    |   68 ++++++++++++++++++++++++++++++++++++++++++++------------------
 5 files changed, 110 insertions(+), 25 deletions(-)

Index: Makefile
===================================================================
--- 1cfa9d5a4f751f8ddd8b9a40758b8d6d0141264e/Makefile  (mode:100644)
+++ uncommitted/Makefile  (mode:100644)
@@ -29,6 +29,7 @@
 
 bindir?=$(prefix)/bin
 libdir?=$(prefix)/lib/cogito
+mandir?=$(prefix)/man/man1
 
 CC?=gcc
 AR?=ar
@@ -136,6 +137,8 @@
 	$(INSTALL) $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
 	$(INSTALL) -m755 -d $(DESTDIR)$(libdir)
 	$(INSTALL) $(LIB_SCRIPT) $(DESTDIR)$(libdir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(mandir)
+	$(INSTALL) $(MANDOC) $(DESTDIR)$(mandir)
 	cd $(DESTDIR)$(bindir); \
 	for file in $(SCRIPT); do \
 		sed -e 's/\$${COGITO_LIB}/\$${COGITO_LIB:-$(sedlibdir)\/}/g' $$file > $$file.new; \
@@ -157,3 +160,31 @@
 
 backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
+
+
+DOCSRC	= cg-log cg-add
+HTMLDIR	= Documentation/html
+MANDIR	= Documentation/man/man1
+HTMLDOC	= $(patsubst %,$(HTMLDIR)/%.html,$(DOCSRC))
+MANDOC	= $(patsubst %,$(MANDIR)/%.1,$(DOCSRC))
+
+doc-clean:
+	$(RM) $(HTMLDOC) $(MANDOC)
+
+html: $(HTMLDOC)
+man: $(MANDOC)
+
+$(HTMLDIR):
+	$(INSTALL) -m755 -d $@
+
+$(MANDIR)/%.1: %.xml
+	xmlto man $< -o $(@D)
+
+%.xml: %.txt
+	asciidoc -b docbook -d manpage -o $@ $<
+
+$(HTMLDIR)/%.html: %.txt $(HTMLDIR)
+	asciidoc -b css-embedded -d manpage -o $@ $<
+
+%.txt: %
+	cg-help $< > $@
Index: cg-Xlib
===================================================================
--- 1cfa9d5a4f751f8ddd8b9a40758b8d6d0141264e/cg-Xlib  (mode:100755)
+++ uncommitted/cg-Xlib  (mode:100755)
@@ -17,6 +17,11 @@
 	exit 1
 }
 
+usage () {
+	echo "usage: $USAGE" >&2
+	exit 1
+}
+
 
 mktemp () {
 	if [ ! "$BROKEN_MKTEMP" ]; then
@@ -52,7 +57,7 @@
 
 print_help () {
 	which "cg-$1" >/dev/null 2>&1 || exit 1
-	cat $(which cg-$1) | sed -n '3,/^$/s/^# *//p'
+	cat $(which cg-$1) | sed 's/^USAGE="\(.*\)"/# \1/' | sed -n '3,/^$/s/^# *//p'
 	exit
 }
 
Index: cg-add
===================================================================
--- 1cfa9d5a4f751f8ddd8b9a40758b8d6d0141264e/cg-add  (mode:100755)
+++ uncommitted/cg-add  (mode:100755)
@@ -1,14 +1,36 @@
 #!/usr/bin/env bash
 #
-# Add new file to a GIT repository.
-# Copyright (c) Petr Baudis, 2005
+# CG-ADD(1)
+# =========
 #
+# NAME
+# ----
+# cg-add - add files to a GIT repository
+#
+# SYNOPSIS
+# --------
+USAGE="cg-add FILE..."
+#
+# DESCRIPTION
+# -----------
 # Takes a list of file names at the command line, and schedules them
 # for addition to the GIT repository at the next commit.
+#
+# The command will fail if one of the given files does not exist.
+#
+# cg-add is part of Cogito, an SCM-like toolkit for managing GIT trees.
+#
+# OPTIONS
+# -------
+# No options.
+#
+# COPYING
+# -------
+# Copyright (c) Petr Baudis, 2005.
 
 . ${COGITO_LIB}cg-Xlib
 
-[ "$1" ] || die "usage: cg-add FILE..."
+[ "$1" ] || usage
 
 for file in "$@"; do
 	if [ -f "$file" ]; then
Index: cg-log
===================================================================
--- 1cfa9d5a4f751f8ddd8b9a40758b8d6d0141264e/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -1,26 +1,56 @@
 #!/usr/bin/env bash
 #
-# Make a log of changes in a GIT branch.
-# Copyright (c) Petr Baudis, 2005.
-# Copyright (c) David Woodhouse, 2005.
-#
-# Takes a -c option to add color to the output.
-# Currently, the colors are:
+# CG-LOG(1)
+# =========
 #
-#	header		Green	
-#	author 		Cyan
-#	committer	Magenta
-#	files		Blue
-#	signoff		Yellow
-#
-# Takes an -f option to list which files was changed.
-#
-# Takes an -r followed with id resolving to a commit to start from
-# (HEAD by default), or id1:id2 representing an (id1;id2] range
-# of commits to show.
+# NAME
+# ----
+# cg-log - show log information for files or a range of commits
+#
+# SYNOPSIS
+# --------
+USAGE="cg-log [ -c ] [ -f ] [ --help | -h ] [-r FROM_ID[:TO_ID]]... [FILE]..."
+#
+# DESCRIPTION
+# -----------
+# Display log information for files or a range of commits. The output
+# will automatically be displayed in pager unless it is piped.
+#
+# cg-log is part of Cogito, an SCM-like toolkit for managing GIT trees.
+#
+# OPTIONS
+# -------
+# Arguments not interpreted as options will be interpreted as filenames;
+# cg-log then displays only changes in those files.
+#
+# --help, -h::
+#	Print this documentation
+#
+# -c::
+#	Add color to the output. Currently, the colors are:
+#
+#		header		Green
+#		author		Cyan
+#		committer	Magenta
+#		files		Blue
+#		signoff		Yellow
+#
+# -f::
+#	List which files were changed.
+#
+# -r FROM_ID[:TO_ID]::
+#	Limit the log information to a range of commits. The range of
+#	included commits can be specified either as -r FROM_ID[:TO_ID]
+#	or as -r FROM_ID -r TO_ID. In both situations the -r option
+#	expects ID arguments which resolve to commits. For ranges, the
+#	log for both the specified IDs will be included. If TO_ID is
+#	left out all commits older than FROM_ID will not be shown. If no
+#	-r option is given commits starting from HEAD will be shown.
 #
-# The rest of arguments are took as filenames; cg-log then displays
-# only changes in those files.
+# COPYING
+# -------
+# Copyright (c) Petr Baudis, 2005.
+# Copyright (c) David Woodhouse, 2005.
 
 . ${COGITO_LIB}cg-Xlib
 # Try to fix the annoying "Broken pipe" output. May not help, but apparently
-- 
Jonas Fonseca
