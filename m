From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 3/6] stg mail: make __send_message do more
Date: Sat, 28 Nov 2009 12:50:27 -0700
Message-ID: <20091128195026.949.1772.stgit@bob.kio>
References: <20091128194056.949.88791.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 28 20:50:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETJZ-0000MT-UD
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 20:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbZK1TuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 14:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbZK1TuW
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 14:50:22 -0500
Received: from g4t0016.houston.hp.com ([15.201.24.19]:41773 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbZK1TuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 14:50:21 -0500
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g4t0016.houston.hp.com (Postfix) with ESMTP id B6989140AB;
	Sat, 28 Nov 2009 19:50:27 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id 7F0192009C;
	Sat, 28 Nov 2009 19:50:27 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 445B4CF0009;
	Sat, 28 Nov 2009 12:50:27 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0dJn+XoMn3Cd; Sat, 28 Nov 2009 12:50:27 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id 256F7CF0007;
	Sat, 28 Nov 2009 12:50:27 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id 1B42C26172; Sat, 28 Nov 2009 12:50:27 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091128194056.949.88791.stgit@bob.kio>
User-Agent: StGit/0.15-6-g435b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133977>

Factor out the common code required to send either a cover mail
or patch, and implement it in __send_message.

WRY? DRY.

Cc: Karl Wiberg <kha@treskal.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 stgit/commands/mail.py |   61 ++++++++++++++++++++----------------------------
 1 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index b6fc3d9..fe5742e 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -228,17 +228,37 @@ def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options):
 
     s.quit()
 
-def __send_message(from_addr, to_addr_list, msg, options):
+def __send_message(tmpl, options, *args):
     """Message sending dispatcher.
     """
-    smtpserver = options.smtp_server or config.get('stgit.smtpserver')
+    msg_id = email.Utils.make_msgid('stgit')
+    build = { 1: __build_cover, 4: __build_message }
+    msg = build[len(args)](tmpl, msg_id, options, *args)
+
+    from_addr, to_addrs = __parse_addresses(msg)
+    msg_str = msg.as_string(options.mbox)
+    if options.mbox:
+        out.stdout_raw(msg_str + '\n')
+        return msg_id
+
+    outstr = { 1: 'the cover message', 4: 'patch "%s"' % args[0] }
+    out.start('Sending ' + outstr[len(args)])
 
+    smtpserver = options.smtp_server or config.get('stgit.smtpserver')
     if smtpserver.startswith('/'):
         # Use the sendmail tool
-        __send_message_sendmail(smtpserver, msg)
+        __send_message_sendmail(smtpserver, msg_str)
     else:
         # Use the SMTP server (we have host and port information)
-        __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options)
+        __send_message_smtp(smtpserver, from_addr, to_addrs, msg_str, options)
+
+    # give recipients a chance of receiving related patches in correct order
+    #                                       patch_nr < total_nr
+    if len(args) == 1 or (len(args) == 4 and args[1] < args[2]):
+        sleep = options.sleep or config.getint('stgit.smtpdelay')
+        time.sleep(sleep)
+    out.done()
+    return msg_id
 
 def __build_address_headers(msg, options, extra_cc = []):
     """Build the address headers and check existing headers in the
@@ -584,7 +604,6 @@ def func(parser, options, args):
     else:
         ref_id = None
 
-    sleep = options.sleep or config.getint('stgit.smtpdelay')
 
     # send the cover message (if any)
     if options.cover or options.edit_cover:
@@ -599,24 +618,12 @@ def func(parser, options, args):
             if not tmpl:
                 raise CmdException, 'No cover message template file found'
 
-        msg_id = email.Utils.make_msgid('stgit')
-        msg = __build_cover(tmpl, msg_id, options, patches)
-        from_addr, to_addr_list = __parse_addresses(msg)
-
-        msg_string = msg.as_string(options.mbox)
+        msg_id = __send_message(tmpl, options, patches)
 
         # subsequent e-mails are seen as replies to the first one
         if not options.noreply:
             ref_id = msg_id
 
-        if options.mbox:
-            out.stdout_raw(msg_string + '\n')
-        else:
-            out.start('Sending the cover message')
-            __send_message(from_addr, to_addr_list, msg_string, options)
-            time.sleep(sleep)
-            out.done()
-
     # send the patches
     if options.template:
         tmpl = file(options.template).read()
@@ -629,24 +636,8 @@ def func(parser, options, args):
             raise CmdException, 'No e-mail template file found'
 
     for (p, patch_nr) in zip(patches, range(1, total_nr + 1)):
-        msg_id = email.Utils.make_msgid('stgit')
-        msg = __build_message(tmpl, msg_id, options, p, patch_nr, total_nr,
-                              ref_id)
-        from_addr, to_addr_list = __parse_addresses(msg)
-
-        msg_string = msg.as_string(options.mbox)
+        msg_id = __send_message(tmpl, options, p, patch_nr, total_nr, ref_id)
 
         # subsequent e-mails are seen as replies to the first one
         if not options.noreply and not options.unrelated and not ref_id:
             ref_id = msg_id
-
-        if options.mbox:
-            out.stdout_raw(msg_string + '\n')
-        else:
-            out.start('Sending patch "%s"' % p)
-            __send_message(from_addr, to_addr_list, msg_string, options)
-            # give recipients a chance of receiving related patches in the
-            # correct order.
-            if patch_nr < total_nr:
-                time.sleep(sleep)
-            out.done()
