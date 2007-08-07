From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add support for SMTP over Transport Layer Security (TLS)
Date: Mon, 06 Aug 2007 21:16:43 -0400
Message-ID: <20070807011643.20454.8122.stgit@gx.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 03:26:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIDqC-0006ew-3F
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 03:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbXHGB03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 21:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbXHGB02
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 21:26:28 -0400
Received: from c60.cesmail.net ([216.154.195.49]:5420 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbXHGB01 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 21:26:27 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Aug 2007 21:26:27 EDT
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 06 Aug 2007 21:16:45 -0400
Received: from gx.roinet.com (c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166])
	by relay.cesmail.net (Postfix) with ESMTP id 68777618FE1;
	Mon,  6 Aug 2007 21:16:44 -0400 (EDT)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55193>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 examples/gitconfig     |    1 +
 stgit/commands/mail.py |   22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/examples/gitconfig b/examples/gitconfig
index bbb943f..3abbe6a 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -21,6 +21,7 @@
 	#smtpserver = localhost:25
 	#smtpuser = username
 	#smtppassword = password
+	#smtptls = no
 
 	# delay between messages in seconds (defaults to 5)
 	#smtpdelay = 5
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index cb8dc74..7ed5c27 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -15,7 +15,7 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os, re, time, datetime, smtplib
+import sys, os, re, time, datetime, socket, smtplib
 import email, email.Utils, email.Header
 from optparse import OptionParser, make_option
 
@@ -53,7 +53,8 @@ replies to a different e-mail by using the '--refid' option.
 
 SMTP authentication is also possible with '--smtp-user' and
 '--smtp-password' options, also available as configuration settings:
-'smtpuser' and 'smtppassword'.
+'smtpuser' and 'smtppassword'. TLS encryption can be enabled by
+'--smtp-tls' option and 'smtptls' setting.
 
 The patch e-mail template accepts the following variables:
 
@@ -121,6 +122,9 @@ options = [make_option('-a', '--all',
                        help = 'username for SMTP authentication'),
            make_option('-p', '--smtp-password', metavar = 'PASSWORD',
                        help = 'username for SMTP authentication'),
+           make_option('-T', '--smtp-tls',
+                       help = 'use SMTP with TLS encryption',
+                       action = 'store_true'),
            make_option('-b', '--branch',
                        help = 'use BRANCH instead of the default one'),
            make_option('-O', '--diff-opts',
@@ -165,7 +169,7 @@ def __parse_addresses(msg):
     return (from_addr_list[0], to_addr_list)
 
 def __send_message(smtpserver, from_addr, to_addr_list, msg, sleep,
-                   smtpuser, smtppassword):
+                   smtpuser, smtppassword, use_tls):
     """Send the message using the given SMTP server
     """
     try:
@@ -177,6 +181,11 @@ def __send_message(smtpserver, from_addr, to_addr_list, msg, sleep,
     try:
         if smtpuser and smtppassword:
             s.ehlo()
+            if use_tls:
+                if not hasattr(socket, 'ssl'):
+                    raise CmdException,  "cannot use TLS - no SSL support in Python"
+                s.starttls()
+                s.ehlo()
             s.login(smtpuser, smtppassword)
 
         result = s.sendmail(from_addr, to_addr_list, msg)
@@ -479,11 +488,14 @@ def func(parser, options, args):
 
     smtppassword = options.smtp_password or config.get('stgit.smtppassword')
     smtpuser = options.smtp_user or config.get('stgit.smtpuser')
+    smtpusetls = options.smtp_tls or config.get('stgit.smtptls') == 'yes'
 
     if (smtppassword and not smtpuser):
         raise CmdException, 'SMTP password supplied, username needed'
     if (smtpuser and not smtppassword):
         raise CmdException, 'SMTP username supplied, password needed'
+    if (smtpusetls and not smtpuser):
+        raise CmdException, 'SMTP over TLS requested, username needed'
 
     total_nr = len(patches)
     if total_nr == 0:
@@ -527,7 +539,7 @@ def func(parser, options, args):
         else:
             out.start('Sending the cover message')
             __send_message(smtpserver, from_addr, to_addr_list, msg_string,
-                           sleep, smtpuser, smtppassword)
+                           sleep, smtpuser, smtppassword, smtpusetls)
             out.done()
 
     # send the patches
@@ -555,5 +567,5 @@ def func(parser, options, args):
         else:
             out.start('Sending patch "%s"' % p)
             __send_message(smtpserver, from_addr, to_addr_list, msg_string,
-                           sleep, smtpuser, smtppassword)
+                           sleep, smtpuser, smtppassword, smtpusetls)
             out.done()
