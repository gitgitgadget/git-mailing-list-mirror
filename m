From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH] Allow e-mails to be sent with the Unix sendmail tool
Date: Sat, 14 Jun 2008 08:28:24 +0100
Message-ID: <20080614072824.7899.42222.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 09:29:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7QCR-0008Ky-PY
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbYFNH2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbYFNH2a
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:28:30 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:34245 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752919AbYFNH22 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jun 2008 03:28:28 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080614073242.LKCJ28496.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sat, 14 Jun 2008 08:32:42 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080614073747.PUMZ8797.aamtaout03-winn.ispmail.ntl.com@localhost.localdomain>;
          Sat, 14 Jun 2008 08:37:47 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84984>

If the stgit.smtpserver configuration option does not have a host:port
format, it is assumed to be an external tool. For example, to use
sendmail just set this variable to "/usr/sbin/sendmail -t -i" (see the
examples/gitconfig file).

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 examples/gitconfig     |    1 +
 stgit/commands/mail.py |   29 ++++++++++++++++++++++++-----
 stgit/config.py        |    4 ++--
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/examples/gitconfig b/examples/gitconfig
index c16f786..28d94af 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -19,6 +19,7 @@
 	#autoresolved = no
 
 	# SMTP server for sending patches
+	#smtpserver = /usr/sbin/sendmail -t -i
 	#smtpserver = localhost:25
 
 	# Set to 'yes' to use SMTP over TLS
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index b4d4e18..67b94c1 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -24,6 +24,7 @@ from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git, version, templates
 from stgit.config import config
+from stgit.run import Run
 
 
 help = 'send a patch or series of patches by e-mail'
@@ -184,8 +185,14 @@ def __parse_addresses(msg):
 
     return (from_addr_list[0], to_addr_list)
 
-def __send_message(smtpserver, from_addr, to_addr_list, msg, sleep,
-                   smtpuser, smtppassword, use_tls):
+def __send_message_sendmail(sendmail, msg):
+    """Send the message using the sendmail command.
+    """
+    cmd = sendmail.split()
+    Run(*cmd).raw_input(msg).discard_output()
+
+def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg,
+                        smtpuser, smtppassword, use_tls):
     """Send the message using the given SMTP server
     """
     try:
@@ -207,13 +214,25 @@ def __send_message(smtpserver, from_addr, to_addr_list, msg, sleep,
         result = s.sendmail(from_addr, to_addr_list, msg)
         if len(result):
             print "mail server refused delivery for the following recipients: %s" % result
-        # give recipients a chance of receiving patches in the correct order
-        time.sleep(sleep)
     except Exception, err:
         raise CmdException, str(err)
 
     s.quit()
 
+def __send_message(smtpserver, from_addr, to_addr_list, msg,
+                   sleep, smtpuser, smtppassword, use_tls):
+    """Message sending dispatcher.
+    """
+    if smtpserver.startswith('/'):
+        # Use the sendmail tool
+        __send_message_sendmail(smtpserver, msg)
+    else:
+        # Use the SMTP server (we have host and port information)
+        __send_message_smtp(smtpserver, from_addr, to_addr_list, msg,
+                            smtpuser, smtppassword, use_tls)
+    # give recipients a chance of receiving patches in the correct order
+    time.sleep(sleep)
+
 def __build_address_headers(msg, options, extra_cc = []):
     """Build the address headers and check existing headers in the
     template.
@@ -338,7 +357,7 @@ def __build_cover(tmpl, patches, msg_id, options):
             prefix_str = confprefix + ' '
         else:
             prefix_str = ''
-        
+
     total_nr_str = str(len(patches))
     patch_nr_str = '0'.zfill(len(total_nr_str))
     if len(patches) > 1:
diff --git a/stgit/config.py b/stgit/config.py
index 9bfdd52..fcf3a5d 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -29,7 +29,7 @@ class GitConfigException(StgException):
 class GitConfig:
     __defaults={
         'stgit.autoresolved':	'no',
-        'stgit.smtpserver':	'localhost:25',
+        'stgit.smtpserver':	'/usr/sbin/sendmail -t -i',
         'stgit.smtpdelay':	'5',
         'stgit.pullcmd':	'git pull',
         'stgit.fetchcmd':	'git fetch',
@@ -102,7 +102,7 @@ class GitConfig:
             if m:
                 result.append(m.group(1))
         return result
-        
+
 config=GitConfig()
 
 def config_setup():
