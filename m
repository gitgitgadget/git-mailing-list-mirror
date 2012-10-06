From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch 5/5] Create pdf from all html files
Date: Sat, 6 Oct 2012 17:58:01 +0200 (CEST)
Message-ID: <1206625172.269796.1349539081024.JavaMail.ngmail@webmail08.arcor-online.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 17:58:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKWld-0004Yo-0Z
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 17:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536Ab2JFP6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 11:58:07 -0400
Received: from mail-in-18.arcor-online.net ([151.189.21.58]:45058 "EHLO
	mail-in-18.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755869Ab2JFP6E (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 11:58:04 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 136A83DD164
	for <git@vger.kernel.org>; Sat,  6 Oct 2012 17:58:01 +0200 (CEST)
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net [151.189.21.58])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 06D8E33EF6E;
	Sat,  6 Oct 2012 17:58:01 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-18.arcor-online.net (Postfix) with ESMTP id 0669D3DD164;
	Sat,  6 Oct 2012 17:58:01 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-18.arcor-online.net 0669D3DD164
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349539081; bh=CGSXe9F296ffOF9V6cv6rA+wU9e9k9BKX56JflqgwEA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=ldyx9xGq/yuQRCecfSRGySry93yaYK+aw+X71qc59HLi3IyW8sYwQStlSFb9d01iC
	 P/xEG1/6D88m3SXs5LTtCzeSCVOut3V1n0rISPkmcrVzUzh778pAMrPWuhgsEakNK7
	 cQplgfzUiyL7YqzyPKwWgCXQxnrCEgb8LjmAUwXg=
Received: from [94.217.29.222] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 6 Oct 2012 17:58:00 +0200 (CEST)
In-Reply-To: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.29.222
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207156>

- use wkhtmltopdf to combine all html files into a single pdf file "git-doc.pdf"
- provide make target "fullpdf" to create "git-doc.pdf"

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/.gitignore      |  1 +
 Documentation/Makefile        |  9 +++++++++
 Documentation/footerend.txt   |  4 ++++
 Documentation/footerstart.txt |  7 +++++++
 Documentation/makedocpdf.sh   | 25 +++++++++++++++++++++++++
 Makefile                      |  6 ++++++
 6 files changed, 52 insertions(+)
 create mode 100644 Documentation/footerend.txt
 create mode 100644 Documentation/footerstart.txt
 create mode 100644 Documentation/makedocpdf.sh

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index d62aebd..fba4730 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -10,3 +10,4 @@ howto-index.txt
 doc.dep
 cmds-*.txt
 manpage-base-url.xsl
+docfiles.txt
diff --git a/Documentation/Makefile b/Documentation/Makefile
index abd27b5..c4c2a30 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -189,6 +189,9 @@ info: git.info gitman.info
 
 pdf: user-manual.pdf
 
+fullpdf: pdf all
+	./makedocpdf.sh
+
 install: install-man
 
 install-man: man
@@ -213,6 +216,10 @@ install-pdf: pdf
 	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
 	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
 
+install-fullpdf: fullpdf install-pdf
+	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
+	$(INSTALL) -m 644 git-doc.pdf $(DESTDIR)$(pdfdir)
+
 install-html: html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
@@ -252,6 +259,8 @@ clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) *.pdf
+	$(RM) docfiles.txt
+	$(RM) RelNotes/*.html
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/*.html technical/api-index.txt
 	$(RM) $(cmds_txt) *.made
diff --git a/Documentation/footerend.txt b/Documentation/footerend.txt
new file mode 100644
index 0000000..ed16923
--- /dev/null
+++ b/Documentation/footerend.txt
@@ -0,0 +1,4 @@
+    </td>
+  </tr>
+</table>
+</body></html>
diff --git a/Documentation/footerstart.txt b/Documentation/footerstart.txt
new file mode 100644
index 0000000..a2746ef
--- /dev/null
+++ b/Documentation/footerstart.txt
@@ -0,0 +1,7 @@
+<html>
+<head></head>
+<body style="border:0; margin: 0;" onload="subst()">
+<table style="border-top: 1px solid black; width: 100%">
+  <tr>
+    <td class="section"></td>
+    <td style="text-align:center">
diff --git a/Documentation/makedocpdf.sh b/Documentation/makedocpdf.sh
new file mode 100644
index 0000000..fd9f5bb
--- /dev/null
+++ b/Documentation/makedocpdf.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+rm -f git-doc.pdf
+
+cat /dev/null >docfiles.txt
+
+ls gittutorial.html      >>docfiles.txt
+ls gittutorial-2.html    >>docfiles.txt
+ls everyday.html         >>docfiles.txt
+ls gitworkflows.html     >>docfiles.txt
+ls git-*.html            >>docfiles.txt
+ls git[acdghikmnr]*.html >>docfiles.txt
+ls gitweb*.html          >>docfiles.txt
+ls howto-index.html      >>docfiles.txt
+ls howto/*.html          >>docfiles.txt
+ls technical/*.html      >>docfiles.txt
+ls RelNotes/*.html       >>docfiles.txt
+
+cat /dev/null >footer.html
+
+cat footerstart.txt      >>footer.html
+cat ../GIT-VERSION-FILE  >>footer.html
+cat footerend.txt        >> footer.html
+
+cat docfiles.txt | xargs cat | wkhtmltopdf --book --footer-html footer.html --disable-external-links - git-doc.pdf
diff --git a/Makefile b/Makefile
index 8413606..2ddb3c9 100644
--- a/Makefile
+++ b/Makefile
@@ -2485,6 +2485,9 @@ info:
 pdf:
 	$(MAKE) -C Documentation pdf
 
+fullpdf:
+	$(MAKE) -C Documentation fullpdf
+
 XGETTEXT_FLAGS = \
 	--force-po \
 	--add-comments \
@@ -2796,6 +2799,9 @@ install-info:
 install-pdf:
 	$(MAKE) -C Documentation install-pdf
 
+install-fullpdf:
+	$(MAKE) -C Documentation install-fullpdf
+
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-- 
1.7.11.msysgit.1
