From: Alex Chiang <achiang@hp.com>
Subject: [StGit PATCH v3 1/6] stg mail: Refactor __send_message and friends
Date: Thu, 3 Dec 2009 13:46:35 -0700
Message-ID: <20091203204635.GH23258@ldl.fc.hp.com>
References: <20091202003503.7737.51579.stgit@bob.kio> <20091202004605.7737.2077.stgit@bob.kio> <b8197bcb0912012253l399bb542sab141021e7ff6353@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git <git@vger.kernel.org>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 21:47:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGIZl-0006MT-K5
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 21:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbZLCUqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 15:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755023AbZLCUqp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 15:46:45 -0500
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:43790 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbZLCUqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 15:46:44 -0500
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g5t0008.atlanta.hp.com (Postfix) with ESMTP id 3BC15240DD;
	Thu,  3 Dec 2009 20:46:51 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id B6C7B2003B;
	Thu,  3 Dec 2009 20:46:40 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 9899DCF001B;
	Thu,  3 Dec 2009 13:46:35 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PVkG7qpNujfX; Thu,  3 Dec 2009 13:46:35 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id 82CD8CF0007; Thu,  3 Dec 2009 13:46:35 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <b8197bcb0912012253l399bb542sab141021e7ff6353@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134476>

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

Catalin,

This is the only patch in the series that changed, so no sense in
sending out all the others.

 stgit/commands/mail.py |   43 +++++++++++++++++++------------------------
 1 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index abd42e4..777ee36 100644
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
+        raise CmdException('SMTP password supplied, username needed')
+    if (smtpusetls and not smtpuser):
+        raise CmdException('SMTP over TLS requested, username needed')
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
