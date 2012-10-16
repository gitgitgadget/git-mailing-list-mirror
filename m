From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v3 7/8] Create pdf from all html files
Date: Tue, 16 Oct 2012 19:27:25 +0200 (CEST)
Message-ID: <814705718.154269.1350408445020.JavaMail.ngmail@webmail15.arcor-online.net>
References: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de, git@drmicha.warpmail.net
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:27:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAvb-0007Wx-IE
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab2JPR12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:27:28 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:49349 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755013Ab2JPR10 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 13:27:26 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id 527C82D665F;
	Tue, 16 Oct 2012 19:27:25 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 4AC0E208025;
	Tue, 16 Oct 2012 19:27:25 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 0B0B1108715;
	Tue, 16 Oct 2012 19:27:25 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 0B0B1108715
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1350408445; bh=Ed6Ls5UQfbuMWAtUgmmu+g/8PjOtWDWL2sDRcN01bR8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Sn+FzXsjwUKMykMBa55Q/n2dpbr7z+GvDytG8E7SUufwKbTRVCB9ABv0UkT8wolsM
	 MVP0bsVjJuBF1z4n0yIIG0sR7omka+Ob2iMJwKVFu7CW/16FSdrnpBcS19vMk5pjzs
	 BFrf0TbdIPYGUo6zPdH6QmIgi+iNNwwCvquOquNg=
Received: from [188.98.243.159] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Tue, 16 Oct 2012 19:27:24 +0200 (CEST)
In-Reply-To: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.243.159
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207861>


- use wkhtmltopdf ("patched QT" version) to combine all html files into a single pdf file "git-doc.pdf"
- insert page breaks to separate major sections

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/.gitignore      |  1 +
 Documentation/footerend.txt   |  4 ++++
 Documentation/footerstart.txt |  7 ++++++
 Documentation/makedocpdf.sh   | 53 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/pagebreak.txt   |  1 +
 5 files changed, 66 insertions(+)
 create mode 100644 Documentation/footerend.txt
 create mode 100644 Documentation/footerstart.txt
 create mode 100755 Documentation/makedocpdf.sh
 create mode 100644 Documentation/pagebreak.txt

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index d62aebd..fba4730 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -10,3 +10,4 @@ howto-index.txt
 doc.dep
 cmds-*.txt
 manpage-base-url.xsl
+docfiles.txt
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
new file mode 100755
index 0000000..5f1a2c1
--- /dev/null
+++ b/Documentation/makedocpdf.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+rm -f git-doc.pdf
+
+cat pagebreak.txt                  >pagebreak.html
+
+cat /dev/null                      >docfiles.txt
+
+ls gittutorial.html                >>docfiles.txt
+ls gittutorial-2.html              >>docfiles.txt
+ls everyday.html                   >>docfiles.txt
+ls gitworkflows.html               >>docfiles.txt
+
+ls pagebreak.html                  >>docfiles.txt
+ls git.html                        >>docfiles.txt
+ls git-a*.html                     >>docfiles.txt
+ls git-bisect.html                 >>docfiles.txt
+ls git-b[j-z]*.html                >>docfiles.txt
+ls git-[c-s]*.html                 >>docfiles.txt
+ls git-ta*.html                    >>docfiles.txt
+ls gitk.html                       >>docfiles.txt
+ls git-[u-z]*.html                 >>docfiles.txt
+
+ls pagebreak.html                  >>docfiles.txt
+ls gita*.html                      >>docfiles.txt
+ls git-bisect-lk2009.html          >>docfiles.txt
+ls git[cdghimnr]*.html             >>docfiles.txt
+ls git-tools.html                  >>docfiles.txt
+ls gitweb*.html                    >>docfiles.txt
+
+ls pagebreak.html                  >>docfiles.txt
+ls howto-index.html                >>docfiles.txt
+ls howto/*.html                    >>docfiles.txt
+
+ls pagebreak.html                  >>docfiles.txt
+ls technical/[b-z]*.html           >>docfiles.txt
+
+ls pagebreak.html                  >>docfiles.txt
+ls technical/api-index.html        >>docfiles.txt
+ls technical/api-[a-h]*.html       >>docfiles.txt
+ls technical/api-in-*.html         >>docfiles.txt
+ls technical/api-[j-z]*.html       >>docfiles.txt
+
+ls pagebreak.html                  >>docfiles.txt
+ls RelNotes/*.html                 >>docfiles.txt
+
+cat /dev/null                      >footer.html
+
+cat footerstart.txt                >>footer.html
+cat ../GIT-VERSION-FILE            >>footer.html
+cat footerend.txt                  >>footer.html
+
+cat docfiles.txt | xargs cat | wkhtmltopdf --book --footer-html footer.html --disable-external-links - git-doc.pdf
diff --git a/Documentation/pagebreak.txt b/Documentation/pagebreak.txt
new file mode 100644
index 0000000..fdaffd1
--- /dev/null
+++ b/Documentation/pagebreak.txt
@@ -0,0 +1 @@
+</p style="page-break-after: always">
-- 
1.7.11.msysgit.1


---
Thomas
