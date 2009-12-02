From: Alex Chiang <achiang@hp.com>
Subject: [StGit PATCH v2 1/6] stg mail: Refactor __send_message and friends
Date: Tue,  1 Dec 2009 17:46:06 -0700
Message-ID: <20091202004605.7737.2077.stgit@bob.kio>
References: <20091202003503.7737.51579.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 01:46:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFdME-0005gK-Jn
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 01:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbZLBAqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 19:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754944AbZLBAqB
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 19:46:01 -0500
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:23200 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbZLBAqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 19:46:00 -0500
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id 1912214955;
	Wed,  2 Dec 2009 00:46:07 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id B0A65200A5;
	Wed,  2 Dec 2009 00:46:06 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 7B14BCF0010;
	Tue,  1 Dec 2009 17:46:06 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bn4TJ+ZcY6mv; Tue,  1 Dec 2009 17:46:06 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id 658ECCF0007;
	Tue,  1 Dec 2009 17:46:06 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id 453B426160; Tue,  1 Dec 2009 17:46:06 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091202003503.7737.51579.stgit@bob.kio>
User-Agent: StGit/0.15-6-gc6f39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134272>

Instead of passing all the various smtp* args to __send_message
individually, let's just pass the options list instead.

The main motivation is for future patches. The end goal is to
thin out stg mail's implementation and make it a minimal wrapper
around git send-email. By passing the options list to __send_message
we prepare to pass options directly to git send-email.

As a bonus, this change results in a cleaner internal API.

Finally, it also pushes the smtp logic where it belongs, viz. into
__send_message_smtp, instead of cluttering up the main body of
mail.func().

Cc: Karl Wiberg <kha@treskal.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 stgit/commands/mail.py |   43 +++++++++++++++++++------------------------
 1 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index abd42e4..a38e3e6 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -190,10 +190,20 @@ def __send_message_sendmail(sendmail, msg):
     cmd = sendmail.split()
     Run(*cmd).raw_input(msg).discard_output()
 
-def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg,
-                        smtpuser, smtppassword, use_tls):
+def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options):
     """Send the message using the given SMTP server
     """
+    smtppassword = options.smtp_password or config.get('stgit.smtppassword')
+    smtpuser = options.smtp_user or config.get('stgit.smtpuser')
+    smtpusetls = options.smtp_tls or config.get('stgit.smtptls') == 'yes'
+
+    if (smtppassword and not smtpuser):
+        raise Exception('SMTP password supplied, username needed')
+    if (smtpusetls and not smtpuser):
+        raise Exception('SMTP over TLS requested, username needed')
+    if (smtpuser and not smtppassword):
+        smtppassword = getpass.getpass("Please enter SMTP password: ")
+
     try:
         s = smtplib.SMTP(smtpserver)
     except Exception, err:
@@ -203,7 +213,7 @@ def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg,
     try:
         if smtpuser and smtppassword:
             s.ehlo()
-            if use_tls:
+            if smtpusetls:
                 if not hasattr(socket, 'ssl'):
                     raise CmdException,  "cannot use TLS - no SSL support in Python"
                 s.starttls()
@@ -218,17 +228,17 @@ def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg,
 
     s.quit()
 
-def __send_message(smtpserver, from_addr, to_addr_list, msg,
-                   smtpuser, smtppassword, use_tls):
+def __send_message(from_addr, to_addr_list, msg, options):
     """Message sending dispatcher.
     """
+    smtpserver = options.smtp_server or config.get('stgit.smtpserver')
+
     if smtpserver.startswith('/'):
         # Use the sendmail tool
         __send_message_sendmail(smtpserver, msg)
     else:
         # Use the SMTP server (we have host and port information)
-        __send_message_smtp(smtpserver, from_addr, to_addr_list, msg,
-                            smtpuser, smtppassword, use_tls)
+        __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options)
 
 def __build_address_headers(msg, options, extra_cc = []):
     """Build the address headers and check existing headers in the
@@ -543,8 +553,6 @@ def func(parser, options, args):
     """Send the patches by e-mail using the patchmail.tmpl file as
     a template
     """
-    smtpserver = options.smtp_server or config.get('stgit.smtpserver')
-
     applied = crt_series.get_applied()
 
     if options.all:
@@ -564,17 +572,6 @@ def func(parser, options, args):
             raise CmdException, 'Cannot send empty patch "%s"' % p
     out.done()
 
-    smtppassword = options.smtp_password or config.get('stgit.smtppassword')
-    smtpuser = options.smtp_user or config.get('stgit.smtpuser')
-    smtpusetls = options.smtp_tls or config.get('stgit.smtptls') == 'yes'
-
-    if (smtppassword and not smtpuser):
-        raise CmdException, 'SMTP password supplied, username needed'
-    if (smtpusetls and not smtpuser):
-        raise CmdException, 'SMTP over TLS requested, username needed'
-    if (smtpuser and not smtppassword):
-        smtppassword = getpass.getpass("Please enter SMTP password: ")
-
     total_nr = len(patches)
     if total_nr == 0:
         raise CmdException, 'No patches to send'
@@ -616,8 +613,7 @@ def func(parser, options, args):
             out.stdout_raw(msg_string + '\n')
         else:
             out.start('Sending the cover message')
-            __send_message(smtpserver, from_addr, to_addr_list, msg_string,
-                           smtpuser, smtppassword, smtpusetls)
+            __send_message(from_addr, to_addr_list, msg_string, options)
             time.sleep(sleep)
             out.done()
 
@@ -648,8 +644,7 @@ def func(parser, options, args):
             out.stdout_raw(msg_string + '\n')
         else:
             out.start('Sending patch "%s"' % p)
-            __send_message(smtpserver, from_addr, to_addr_list, msg_string,
-                           smtpuser, smtppassword, smtpusetls)
+            __send_message(from_addr, to_addr_list, msg_string, options)
             # give recipients a chance of receiving related patches in the
             # correct order.
             if patch_nr < total_nr:
