From: Simon P <simon.git@le-huit.fr>
Subject: [git-multimail] smtplib, check certificate
Date: Thu, 21 Apr 2016 23:44:50 +0200
Message-ID: <571949D2.10507@le-huit.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000806070406020603010205"
Cc: mhagger@alum.mit.edu, matthieu.moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 23:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atMXT-0000oF-5i
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 23:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbcDUVx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 17:53:27 -0400
Received: from mail.gnubox.eu ([212.129.16.229]:35393 "EHLO mail.gnubox.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbcDUVx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 17:53:26 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Apr 2016 17:53:25 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.gnubox.eu (Postfix) with ESMTP id 642C85A6CD0;
	Thu, 21 Apr 2016 23:45:56 +0200 (CEST)
X-Virus-Scanned: by amavisd-new using ClamAV at gnubox.info
Received: from mail.gnubox.eu ([127.0.0.1])
	by localhost (mail.gnubox.eu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QOhui5hqMdEy; Thu, 21 Apr 2016 23:45:31 +0200 (CEST)
Received: from [192.168.0.73] (85-169-145-244.rev.numericable.fr [85.169.145.244])
	by mail.gnubox.eu (Postfix) with ESMTPSA id 225585A6CCE;
	Thu, 21 Apr 2016 23:45:31 +0200 (CEST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292154>

This is a multi-part message in MIME format.
--------------000806070406020603010205
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

It seems that smtplib doesn't check if a certificate is valid (signed by
a trusted CA).

For my personal usage, I patched the starttls code in git-multimail:
only for starttls with smtplib.

This patch is inspired from

https://github.com/graingert/secure-smtplib/blob/master/src/secure_smtplib/__init__.py

It could be easy to add support cert check in for smtps (see
secure_smtplib).

This patch was tested only on git-multimail (v1.2)

It introduces two new options:
  - multimailhook.smtpcheckcert (default false)
  - multimailhook.smtpcacerts (default
                               /etc/ssl/certs/ca-certificates.crt)

Best regards,
Simon P.

--------------000806070406020603010205
Content-Type: text/x-patch;
 name="git-multimail-secure-smtplib.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git-multimail-secure-smtplib.patch"

diff --git a/git-multimail/git_multimail.py b/git-multimail/git_multimail.py
index fae5c91..b49ed9d 100755
--- a/git-multimail/git_multimail.py
+++ b/git-multimail/git_multimail.py
@@ -57,6 +57,7 @@ import subprocess
 import shlex
 import optparse
 import smtplib
+import ssl
 import time
 import cgi
 
@@ -1945,6 +1946,7 @@ class SMTPMailer(Mailer):
                  smtpservertimeout=10.0, smtpserverdebuglevel=0,
                  smtpencryption='none',
                  smtpuser='', smtppass='',
+                 smtpcacerts='/etc/ssl/certs/ca-certificates.crt',smtpcheckcert=False
                  ):
         if not envelopesender:
             sys.stderr.write(
@@ -1974,13 +1976,43 @@ class SMTPMailer(Mailer):
             if self.security == 'none':
                 self.smtp = call(smtplib.SMTP, self.smtpserver, timeout=self.smtpservertimeout)
             elif self.security == 'ssl':
+                if smtpcheckcert:
+                    msg = "Checking certificate is not supported for ssl, prefer starttls"
+                    raise smtplib.SMTPException(msg)
                 self.smtp = call(smtplib.SMTP_SSL, self.smtpserver, timeout=self.smtpservertimeout)
             elif self.security == 'tls':
                 if ':' not in self.smtpserver:
                     self.smtpserver += ':587'  # default port for TLS
                 self.smtp = call(smtplib.SMTP, self.smtpserver, timeout=self.smtpservertimeout)
-                self.smtp.ehlo()
-                self.smtp.starttls()
+                if smtpcheckcert:
+                    # inspired form:
+                    #   https://github.com/graingert/secure-smtplib/blob/master/src/secure_smtplib/__init__.py
+                    # but add the path to trusted ca, and force ceritficate verification.
+                    self.smtp.ehlo_or_helo_if_needed()
+                    if not self.smtp.has_extn("starttls"):
+                        msg = "STARTTLS extension not supported by server"
+                        raise smtplib.SMTPException(msg)
+                    (resp, reply) = self.smtp.docmd("STARTTLS")
+                    if resp == 220:
+                        self.smtp.sock = ssl.wrap_socket(
+                            self.smtp.sock,
+                            ca_certs=smtpcacerts,
+                            cert_reqs=ssl.CERT_REQUIRED
+                        )
+                        if not hasattr(self.smtp.sock, "read"):
+                            # using httplib.FakeSocket with Python 2.5.x or earlier
+                            self.smtp.sock.read = self.smtp.sock.recv
+                        self.smtp.file = smtplib.SSLFakeFile(self.smtp.sock)
+                        self.smtp.helo_resp = None
+                        self.smtp.ehlo_resp = None
+                        self.smtp.esmtp_features = {}
+                        self.smtp.does_esmtp = 0
+                    else:
+                        msg = "Wrong answer to the STARTTLS command"
+                        raise smtplib.SMTPException(msg)
+                else:
+                    self.smtp.ehlo()
+                    self.smtp.starttls()
                 self.smtp.ehlo()
             else:
                 sys.stdout.write('*** Error: Control reached an invalid option. ***')
@@ -3500,6 +3532,8 @@ def choose_mailer(config, environment):
         smtpencryption = config.get('smtpencryption', default='none')
         smtpuser = config.get('smtpuser', default='')
         smtppass = config.get('smtppass', default='')
+        smtpcacerts = config.get('smtpcacerts', default='/etc/ssl/certs/ca-certificates.crt')
+        smtpcheckcert = config.get_bool('smtpcheckcert', default='false')
         mailer = SMTPMailer(
             envelopesender=(environment.get_sender() or environment.get_fromaddr()),
             smtpserver=smtpserver, smtpservertimeout=smtpservertimeout,
@@ -3507,6 +3541,8 @@ def choose_mailer(config, environment):
             smtpencryption=smtpencryption,
             smtpuser=smtpuser,
             smtppass=smtppass,
+            smtpcacerts=smtpcacerts,
+            smtpcheckcert=smtpcheckcert
             )
     elif mailer == 'sendmail':
         command = config.get('sendmailcommand')

--------------000806070406020603010205--
