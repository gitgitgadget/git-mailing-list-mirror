From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-multimail: update to release 1.1.0
Date: Fri,  3 Jul 2015 16:53:43 +0200
Message-ID: <1435935223-9730-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 03 16:53:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB2Lm-0000ql-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 16:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456AbbGCOxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 10:53:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46012 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbbGCOxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 10:53:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t63ErjRs001391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2015 16:53:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t63Erkqa031866;
	Fri, 3 Jul 2015 16:53:46 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZB2LZ-0002rr-Tc; Fri, 03 Jul 2015 16:53:45 +0200
X-Mailer: git-send-email 2.5.0.rc0.7.ge1edd74.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Jul 2015 16:53:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t63ErjRs001391
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436540028.37504@PZqwSa3IxLfqJBf3pujUjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273292>

The only change is a bugfix: the SMTP mailer was not working with
Python 2.4.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/hooks/multimail/CHANGES          |  5 +++++
 contrib/hooks/multimail/README           |  2 +-
 contrib/hooks/multimail/README.Git       |  4 ++--
 contrib/hooks/multimail/git_multimail.py | 12 +++++++++---
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/contrib/hooks/multimail/CHANGES b/contrib/hooks/multimail/CHANGES
index 0b823d8..6bb1230 100644
--- a/contrib/hooks/multimail/CHANGES
+++ b/contrib/hooks/multimail/CHANGES
@@ -1,3 +1,8 @@
+Release 1.1.1 (bugfix-only release)
+===================================
+
+* The SMTP mailer was not working with Python 2.4.
+
 Release 1.1.0
 =============
 
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
index 3a33cb7..e552c90 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -1,4 +1,4 @@
-git-multimail Version 1.1.0
+git-multimail Version 1.1.1
 ===========================
 
 .. image:: https://travis-ci.org/git-multimail/git-multimail.svg?branch=master
diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multimail/README.Git
index 449d36f..f5d59a8 100644
--- a/contrib/hooks/multimail/README.Git
+++ b/contrib/hooks/multimail/README.Git
@@ -6,10 +6,10 @@ website:
     https://github.com/git-multimail/git-multimail
 
 The version in this directory was obtained from the upstream project
-on Jun 18 2015 and consists of the "git-multimail" subdirectory from
+on July 03 2015 and consists of the "git-multimail" subdirectory from
 revision
 
-    1f0dbb3b60035767889b913df16d9231ecdb8709 refs/tags/1.1.0
+    6d6c9eb62a054143322cfaecde3949189c065b46 refs/tags/1.1.1
 
 Please see the README file in this directory for information about how
 to report bugs or contribute to git-multimail.
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index 7cb2b36..c06ce7a 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -1745,14 +1745,20 @@ class SMTPMailer(Mailer):
         self.username = smtpuser
         self.password = smtppass
         try:
+            def call(klass, server, timeout):
+                try:
+                    return klass(server, timeout=timeout)
+                except TypeError:
+                    # Old Python versions do not have timeout= argument.
+                    return klass(server)
             if self.security == 'none':
-                self.smtp = smtplib.SMTP(self.smtpserver, timeout=self.smtpservertimeout)
+                self.smtp = call(smtplib.SMTP, self.smtpserver, timeout=self.smtpservertimeout)
             elif self.security == 'ssl':
-                self.smtp = smtplib.SMTP_SSL(self.smtpserver, timeout=self.smtpservertimeout)
+                self.smtp = call(smtplib.SMTP_SSL, self.smtpserver, timeout=self.smtpservertimeout)
             elif self.security == 'tls':
                 if ':' not in self.smtpserver:
                     self.smtpserver += ':587'  # default port for TLS
-                self.smtp = smtplib.SMTP(self.smtpserver, timeout=self.smtpservertimeout)
+                self.smtp = call(smtplib.SMTP, self.smtpserver, timeout=self.smtpservertimeout)
                 self.smtp.ehlo()
                 self.smtp.starttls()
                 self.smtp.ehlo()
-- 
2.5.0.rc0.7.ge1edd74.dirty
