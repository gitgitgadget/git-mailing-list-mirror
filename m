From: Bryan larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/1] Add authentication capability to the mail command.
Date: Thu, 21 Jul 2005 16:22:06 -0400
Message-ID: <20050721202206.8119.61954.stgit@h164.c77.b0.tor.eicat.ca>
Cc: catalin.marinas@gmail.com, Bryan Larsen <bryan.larsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:22:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvhYe-0004PK-No
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 22:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVGUUWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 16:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVGUUWK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 16:22:10 -0400
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:19125 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261872AbVGUUWI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 16:22:08 -0400
Received: (qmail 85994 invoked from network); 21 Jul 2005 20:22:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Subject:Date:Message-Id;
  b=KrPgnXYrtH4IOu8NxqJC4Nu8j/4CK/rq+mSebfcSrfvJBsll5lHTTeo/O0RjsWmogTeCJ7utslgmZEcLBMSwalLZfKxUuNp9NGJPfOCFUJQzgb1uWfBYrpYwDRGsg8Z1lYf6TkBBg9QQVFjeXY5RBSnWS/ePmUv/i4vDLhI3XSY=  ;
Received: from unknown (HELO h164.c77.b0.tor.eicat.ca) (bryanlarsen@72.0.77.164 with plain)
  by smtp111.mail.sc5.yahoo.com with SMTP; 21 Jul 2005 20:22:04 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add authentication capability to the mail command.  Added 'smtppassword'
and 'smtpuser' to config file and --smtp-user, --smtp-password to command
line.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 stgit/commands/mail.py |   34 ++++++++++++++++++++++++++++++----
 1 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -41,7 +41,11 @@ options = [make_option('-a', '--all',
            make_option('-s', '--sleep', type = 'int', metavar = 'SECONDS',
                        help = 'sleep for SECONDS between e-mails sending'),
            make_option('--refid',
-                       help = 'Use REFID as the reference id')]
+                       help = 'Use REFID as the reference id'),
+           make_option('-u', '--smtp-user', metavar = 'USER',
+                       help = 'username for SMTP authentication'),
+           make_option('-p', '--smtp-password', metavar = 'PASSWORD',
+                       help = 'username for SMTP authentication')]
 
 
 def __parse_addresses(string):
@@ -65,7 +69,7 @@ def __parse_addresses(string):
 
     return (from_addr_list[0], to_addr_list)
 
-def __send_message(smtpserver, from_addr, to_addr_list, msg, sleep):
+def __send_message(smtpserver, from_addr, to_addr_list, msg, sleep, smtpuser, smtppassword):
     """Send the message using the given SMTP server
     """
     if smtpserver.find(':')==-1:
@@ -80,6 +84,10 @@ def __send_message(smtpserver, from_addr
         raise CmdException, str(err)
 
     s.set_debuglevel(0)
+    if smtpuser and smtppassword:
+        s.ehlo()
+        s.login(smtpuser, smtppassword)
+
     try:
         s.sendmail(from_addr, to_addr_list, msg)
         # give recipients a chance of receiving patches in the correct order
@@ -174,6 +182,13 @@ def func(parser, options, args):
         raise CmdException, 'smtpserver not defined'
     smtpserver = config.get('stgit', 'smtpserver')
 
+    smtpuser = None
+    smtppassword = None
+    if config.has_option('stgit', 'smtpuser'):
+        smtpuser = config.get('stgit', 'smtpuser')
+    if config.has_option('stgit', 'smtppassword'):
+        smtppassword = config.get('stgit', 'smtppassword')
+
     applied = crt_series.get_applied()
 
     if len(args) == 1:
@@ -216,6 +231,17 @@ def func(parser, options, args):
     else:
         raise CmdException, 'Incorrect options. Unknown patches to send'
 
+    if options.smtp_password:
+        smtppassword = options.smtp_password
+
+    if options.smtp_user:
+        smtpuser = options.smtp_user
+
+    if (smtppassword and not smtpuser):
+        raise CmdException, 'SMTP password supplied, username needed'
+    if (smtpuser and not smtppassword):
+        raise CmdException, 'SMTP username supplied, password needed'
+
     total_nr = len(patches)
     if total_nr == 0:
         raise CmdException, 'No patches to send'
@@ -241,7 +267,7 @@ def func(parser, options, args):
         print 'Sending file "%s"...' % options.first,
         sys.stdout.flush()
 
-        __send_message(smtpserver, from_addr, to_addr_list, msg, sleep)
+        __send_message(smtpserver, from_addr, to_addr_list, msg, sleep, smtpuser, smtppassword)
 
         print 'done'
 
@@ -264,6 +290,6 @@ def func(parser, options, args):
         print 'Sending patch "%s"...' % p,
         sys.stdout.flush()
 
-        __send_message(smtpserver, from_addr, to_addr_list, msg, sleep)
+        __send_message(smtpserver, from_addr, to_addr_list, msg, sleep, smtpuser, smtppassword)
 
         print 'done'
