From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/2] contrib: Add diff viewing capability for Microsoft Word documents
Date: Thu, 27 Sep 2007 13:45:58 +0200
Message-ID: <11908935593618-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Sep 27 13:46:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaros-0004wU-Cw
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbXI0LqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbXI0LqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:46:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51043 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbXI0LqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:46:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1Iarof-0007JV-Ca; Thu, 27 Sep 2007 13:46:04 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A004F69F; Thu, 27 Sep 2007 13:46:00 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 43C6BFA46; Thu, 27 Sep 2007 13:46:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.gcc9e
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59288>

A shell script opens WinWord with the documents and a document template.
The document template contains a VBA macro that is run automatically.
It looks up the two documents and performs the comparison.

Unfortunately, the user's help is needed to construct the document template
with the macro from a plain text file, so we print the instructions from
the Makefile.

The README file contains instructions how to use this feature.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	Ok, here's something that shows how git helps solve REAL PROBLEMS.

	I've been using this for a day or two now with the MinGW port.
	Other Windows prisoners might be interested, too.
	Be sure to read the README and take a deap breath of the
	fresh air.

	;)

	This was only tested with a localized version Microsoft Office 2000,
	so your milage may vary.

	-- Hannes

 contrib/winword/diff/.gitignore      |    2 +
 contrib/winword/diff/Makefile        |   39 ++++++++++++++++++++++++++++++++++
 contrib/winword/diff/README          |   34 +++++++++++++++++++++++++++++
 contrib/winword/diff/winworddiff.bas |   13 +++++++++++
 contrib/winword/diff/winworddiff.sh  |   15 +++++++++++++
 5 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 contrib/winword/diff/.gitignore
 create mode 100644 contrib/winword/diff/Makefile
 create mode 100644 contrib/winword/diff/README
 create mode 100644 contrib/winword/diff/winworddiff.bas
 create mode 100755 contrib/winword/diff/winworddiff.sh

diff --git a/contrib/winword/diff/.gitignore b/contrib/winword/diff/.gitignore
new file mode 100644
index 0000000..f37a3c4
--- /dev/null
+++ b/contrib/winword/diff/.gitignore
@@ -0,0 +1,2 @@
+winworddiff
+winworddiff.dot
diff --git a/contrib/winword/diff/Makefile b/contrib/winword/diff/Makefile
new file mode 100644
index 0000000..61de940
--- /dev/null
+++ b/contrib/winword/diff/Makefile
@@ -0,0 +1,39 @@
+prefix = $(HOME)
+bindir = $(prefix)/bin
+datadir = $(prefix)/share/winworddiff
+
+WINWORDEXE = C:/Program Files/Microsoft Office/Office/WINWORD.EXE
+INSTALL = install
+
+all: winworddiff winworddiff.dot
+
+winworddiff: winworddiff.sh
+	sed	-e 's|@@WINWORDEXE@@|$(WINWORDEXE)|' \
+		-e 's|@@PREFIX@@|$(prefix)|' \
+		< $@.sh > $@
+
+winworddiff.dot: winworddiff.bas
+	@echo
+	@echo '****  ATTENTION  ***'
+	@echo '* $@ must be created from $<'
+	@echo '* This cannot be done automatically, so your help is needed:'
+	@echo '* 1. Start Microsoft Word; create a new document *template*'
+	@echo '* 2. Open the Tools->Macro->Visual Basic Editor'
+	@echo '* 3. In the Project browser, locate and open:'
+	@echo '*        TemplateProject (Template1)'
+	@echo '*           Microsoft Word Objects'
+	@echo '*              ThisDocument'
+	@echo '* 4. Double-click "ThisDocument"'
+	@echo '* 5. Choose Insert->File... and select this file:'
+	@echo; echo "`pwd`/$<"; echo
+	@echo '* 6. Close the Visual Basic Editor'
+	@echo '* 7. Save the template as this file (overwrite if necessary):'
+	@echo; echo "`pwd`/$@"; echo
+	@echo '* 8. Run make again'
+	@exit 1
+
+-include ../../../config.mak
+
+install: all
+	$(INSTALL) winworddiff $(bindir)
+	$(INSTALL) winworddiff.dot $(datadir)
diff --git a/contrib/winword/diff/README b/contrib/winword/diff/README
new file mode 100644
index 0000000..dfbcdc3
--- /dev/null
+++ b/contrib/winword/diff/README
@@ -0,0 +1,34 @@
+This directory contains facilities that allow to highlight changes
+between two revisions of WinWord documents.
+
+1.	Installation:
+	a.	Set the variable WINWORDEXE in ../../../config.mak to point
+		to your installed WinWord.exe
+	b.	Run 'make'. This will fail with instructions to
+		create a document template. (It boils down to import
+		a macro file into the template.) Once you have completed
+		the instructions, 'make' will no longer fail.
+	c.	Run 'make install'
+
+2.	Activate diff in your repository
+	a.	Define a custom diff driver:
+
+			$ git config diff.docdiff.command winworddiff
+
+	b.	Use the custom driver for your Word documents, i.e. put
+		a line like this in your .git/info/attributes:
+
+			*.doc	diff=docdiff
+
+3.	Enjoy the diffs:
+
+		$ git diff HEAD~1.. -- UserManual.doc
+
+4.	Caveats:
+
+	-	Macros must be enabled.
+
+	-	A new WinWord instance is started *for*each*document* that
+		is covered by the 'git diff' invocation; therefore, to be
+		on the safe side, always specify a path limiter. Use git-gui
+		and gitk to inspect diffs without path limiters.
diff --git a/contrib/winword/diff/winworddiff.bas b/contrib/winword/diff/winworddiff.bas
new file mode 100644
index 0000000..c7c7630
--- /dev/null
+++ b/contrib/winword/diff/winworddiff.bas
@@ -0,0 +1,13 @@
+Sub Document_Open()
+    ' pick the last 2 documents, present changes from second-last to last
+    ' (the third document is this one)
+    Dim olddoc As Document, newdoc As Document
+    With Application.Documents
+        If .Count < 3 Then Exit Sub
+        Set newdoc = .Item(.Count)
+        Set olddoc = .Item(.Count - 1)
+    End With
+    newdoc.Activate
+    newdoc.Compare Name:=olddoc.FullName
+    newdoc.ShowRevisions = True
+End Sub
diff --git a/contrib/winword/diff/winworddiff.sh b/contrib/winword/diff/winworddiff.sh
new file mode 100755
index 0000000..5adb97d
--- /dev/null
+++ b/contrib/winword/diff/winworddiff.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+word="@@WINWORDEXE@@"
+difftempl="@@PREFIX@@/share/winworddiff/winworddiff.dot"
+
+test $# = 7 || {
+	echo >&2 "$0: expected 7 arguments:"
+	echo >&2 "	path old oldsha1 oldmode new newsha1 newmode"
+	exit 1;
+}
+
+of="$2"
+nf="$5"
+
+"$word" -w "$nf" "$of" "$difftempl"
-- 
1.5.3.3.gcc9e
