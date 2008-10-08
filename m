From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] guilt: add git commit level versioning
Date: Tue,  7 Oct 2008 22:08:42 -0400
Message-ID: <1223431722-12259-1-git-send-email-paul.gortmaker@windriver.com>
Cc: git@vger.kernel.org
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed Oct 08 04:14:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnOZe-0000dX-5a
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 04:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbYJHCI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 22:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYJHCI5
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 22:08:57 -0400
Received: from mail.windriver.com ([147.11.1.11]:64556 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbYJHCI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 22:08:57 -0400
Received: from localhost.localdomain (yow-pgortmak-d1.ottawa.windriver.com [128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m9828gcF025193;
	Tue, 7 Oct 2008 19:08:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97756>

Shamelessly steal the dynamic versioning goodies from git
itself.  Now when you do "guilt --version" you can expect to
see things like:

	Guilt version 0.31.2.14.gece1.dirty

assuming you've 14 commits since 0.31.2 and also some changes
that you've not committed yet.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .gitignore             |    2 ++
 Documentation/Makefile |    4 ++--
 GUILT-VERSION-GEN      |   42 ++++++++++++++++++++++++++++++++++++++++++
 Makefile               |   21 ++++++++++++++++-----
 guilt                  |    4 +++-
 5 files changed, 65 insertions(+), 8 deletions(-)
 create mode 100755 GUILT-VERSION-GEN

diff --git a/.gitignore b/.gitignore
index c81112b..61161ef 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,3 +7,5 @@
 #
 *~
 *.swp
+guilt.bin
+GUILT-VERSION-FILE
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9fc1165..4b7d037 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -7,7 +7,7 @@ DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
 DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
 
 USAGE=$(patsubst %.txt,usage-%.txt,$(MAN1_TXT))
-VERSION=$(shell git describe 2> /dev/null || sed -n -e '/^GUILT_VERSION=/ { s/^GUILT_VERSION="/v/; s/"//; p; q; }' ../guilt)
+include ../GUILT-VERSION-FILE
 
 prefix?=$(PREFIX)
 bindir?=$(prefix)/bin
@@ -51,7 +51,7 @@ doc.dep : $(wildcard *.txt) build-docdep.perl
 -include doc.dep
 
 version.txt:
-	echo "(Generated for Guilt $(VERSION))" > version.txt
+	echo "(Generated for Guilt $(GUILT_VERSION))" > version.txt
 
 cmds.txt: cmd-list.sh $(MAN1_TXT)
 	sh ./cmd-list.sh
diff --git a/GUILT-VERSION-GEN b/GUILT-VERSION-GEN
new file mode 100755
index 0000000..66b40e2
--- /dev/null
+++ b/GUILT-VERSION-GEN
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+GVF=GUILT-VERSION-FILE
+DEF_VER=v0.31.2
+
+LF='
+'
+
+# First see if there is a version file (included in release tarballs),
+# then try git-describe, then default.
+if test -f version
+then
+	VN=$(cat version) || VN="$DEF_VER"
+elif test -d .git -o -f .git &&
+	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
+	case "$VN" in
+	*$LF*) (exit 1) ;;
+	v[0-9]*)
+		git update-index -q --refresh
+		test -z "$(git diff-index --name-only HEAD --)" ||
+		VN="$VN-dirty" ;;
+	esac
+then
+	VN=$(echo "$VN" | sed -e 's/-/./g');
+else
+	VN="$DEF_VER"
+fi
+
+VN=$(expr "$VN" : v*'\(.*\)')
+
+if test -r $GVF
+then
+	VC=$(sed -e 's/^GUILT_VERSION = //' <$GVF)
+else
+	VC=unset
+fi
+test "$VN" = "$VC" || {
+	echo >&2 "GUILT_VERSION=$VN"
+	echo "GUILT_VERSION=$VN" >$GVF
+}
+
+
diff --git a/Makefile b/Makefile
index af53fb5..f3cf0b3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,25 +1,35 @@
 PREFIX=/usr/local
 DESTDIR=
 
-SCRIPTS = guilt \
-	  $(filter-out $(wildcard *~),$(wildcard guilt-*))
+SCRIPTS = $(filter-out $(wildcard *~),$(wildcard guilt-*))
 
-.PHONY: all 
-all: doc
+all::
+
+.PHONY: .FORCE-GUILT-VERSION-FILE
+GUILT-VERSION-FILE: .FORCE-GUILT-VERSION-FILE
+	@$(SHELL_PATH) ./GUILT-VERSION-GEN
+-include GUILT-VERSION-FILE
+
+.PHONY: all
+all:: doc guilt.bin
 	@echo "Nothing to build, it is all bash :)"
 	@echo "Try make install"
 
+guilt.bin: GUILT-VERSION-FILE
+	@sed 's/^GUILT_VERSION=$$/GUILT_VERSION="$(GUILT_VERSION)"/' < guilt > guilt.bin
+
 .PHONY: install
 install:
 	install -d $(DESTDIR)$(PREFIX)/bin/
 	install -m 755 $(SCRIPTS) $(DESTDIR)$(PREFIX)/bin/
+	install -m 755 guilt.bin $(DESTDIR)$(PREFIX)/bin/guilt
 
 .PHONY: uninstall
 uninstall:
 	./uninstall $(DESTDIR)$(PREFIX)/bin/ $(SCRIPTS)
 
 .PHONY: doc
-doc:
+doc: GUILT-VERSION-FILE
 	$(MAKE) -C Documentation all
 
 .PHONY: install-doc
@@ -33,3 +43,4 @@ test:
 .PHONY: clean
 clean: 
 	$(MAKE) -C Documentation clean 
+	$(RM) GUILT-VERSION-FILE guilt.bin
diff --git a/guilt b/guilt
index fabee17..7cfa23b 100755
--- a/guilt
+++ b/guilt
@@ -3,7 +3,9 @@
 # Copyright (c) Josef "Jeff" Sipek, 2006-2008
 #
 
-GUILT_VERSION="0.31.2"
+# Version replaced at build time. Could have in separate file, but why
+# do a "source version_file" on every guilt operation?
+GUILT_VERSION=
 GUILT_NAME="Ciuleandra"
 
 # If the first argument is one of the below, display the man page instead of
-- 
1.6.0
