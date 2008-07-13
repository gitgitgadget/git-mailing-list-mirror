From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 1/4] Allow e-mails to be sent with the Unix sendmail tool
Date: Sun, 13 Jul 2008 12:40:26 +0100
Message-ID: <20080713114026.18845.77979.stgit@localhost.localdomain>
References: <20080713113853.18845.37686.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 13:41:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHzxL-0006CF-Fk
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 13:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbYGMLkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 07:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbYGMLkb
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 07:40:31 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:59299 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692AbYGMLka (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 07:40:30 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080713114519.CGKN28496.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Sun, 13 Jul 2008 12:45:19 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080713114359.OGYO29365.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Sun, 13 Jul 2008 12:43:59 +0100
In-Reply-To: <20080713113853.18845.37686.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3.163.g06f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88301>

If the stgit.smtpserver configuration option does not have a host:port
format, it is assumed to be an external tool. For example, to use
sendmail just set this variable to "/usr/sbin/sendmail -t -i" (see the
examples/gitconfig file).

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 examples/gitconfig     |    1 +
 stgit/commands/mail.py |   46 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 12 deletions(-)

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
index b4d4e18..c87d67e 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -24,6 +24,7 @@ from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git, version, templates
 from stgit.config import config
+from stgit.run import Run
 
 
 help = 'send a patch or series of patches by e-mail'
@@ -31,13 +32,15 @@ usage = r"""%prog [options] [<patch1>] [<patch2>] [<patch3>..<patch4>]
 
 Send a patch or a range of patches by e-mail using the SMTP server
 specified by the 'stgit.smtpserver' configuration option, or the
-'--smtp-server' command line option. The From address and the e-mail
-format are generated from the template file passed as argument to
-'--template' (defaulting to '.git/patchmail.tmpl' or
-'~/.stgit/templates/patchmail.tmpl' or
+'--smtp-server' command line option. This option can also be an
+absolute path to 'sendmail' followed by command line arguments.
+
+The From address and the e-mail format are generated from the template
+file passed as argument to '--template' (defaulting to
+'.git/patchmail.tmpl' or '~/.stgit/templates/patchmail.tmpl' or
 '/usr/share/stgit/templates/patchmail.tmpl'). A patch can be sent as
-attachment using the --attach option in which case the 'mailattch.tmpl'
-template will be used instead of 'patchmail.tmpl'.
+attachment using the --attach option in which case the
+'mailattch.tmpl' template will be used instead of 'patchmail.tmpl'.
 
 The To/Cc/Bcc addresses can either be added to the template file or
 passed via the corresponding command line options. They can be e-mail
@@ -133,8 +136,9 @@ options = [make_option('-a', '--all',
                        help = 'sleep for SECONDS between e-mails sending'),
            make_option('--refid',
                        help = 'use REFID as the reference id'),
-           make_option('--smtp-server', metavar = 'HOST[:PORT]',
-                       help = 'SMTP server to use for sending mail'),
+           make_option('--smtp-server',
+                       metavar = 'HOST[:PORT] or "/path/to/sendmail -t -i"',
+                       help = 'SMTP server or command to use for sending mail'),
            make_option('-u', '--smtp-user', metavar = 'USER',
                        help = 'username for SMTP authentication'),
            make_option('-p', '--smtp-password', metavar = 'PASSWORD',
@@ -184,8 +188,14 @@ def __parse_addresses(msg):
 
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
@@ -207,13 +217,25 @@ def __send_message(smtpserver, from_addr, to_addr_list, msg, sleep,
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
