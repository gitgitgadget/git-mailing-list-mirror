From: Alex Chiang <achiang@hp.com>
Subject: [StGit PATCH v2 3/6] stg mail: make __send_message do more
Date: Tue,  1 Dec 2009 17:46:16 -0700
Message-ID: <20091202004616.7737.60382.stgit@bob.kio>
References: <20091202003503.7737.51579.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 01:46:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFdMk-0005qg-2H
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 01:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbZLBAq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 19:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbZLBAq0
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 19:46:26 -0500
Received: from g6t0187.atlanta.hp.com ([15.193.32.64]:42688 "EHLO
	g6t0187.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbZLBAqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 19:46:25 -0500
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g6t0187.atlanta.hp.com (Postfix) with ESMTP id 76E4828317;
	Wed,  2 Dec 2009 00:46:31 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 60A9714112;
	Wed,  2 Dec 2009 00:46:17 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 370F6CF0010;
	Tue,  1 Dec 2009 17:46:17 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3VTWUoTsDiDn; Tue,  1 Dec 2009 17:46:17 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id 18D32CF0007;
	Tue,  1 Dec 2009 17:46:17 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id 0660B26160; Tue,  1 Dec 2009 17:46:16 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091202003503.7737.51579.stgit@bob.kio>
User-Agent: StGit/0.15-6-gc6f39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134277>

Factor out the common code required to send either a cover mail
or patch, and implement it in __send_message.

WRY? DRY.

Cc: Karl Wiberg <kha@treskal.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 stgit/commands/mail.py |   65 +++++++++++++++++++++---------------------------
 1 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 35194a8..edff878 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -228,17 +228,39 @@ def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options):
 
     s.quit()
 
-def __send_message(from_addr, to_addr_list, msg, options):
+def __send_message(type, tmpl, options, *args):
     """Message sending dispatcher.
     """
-    smtpserver = options.smtp_server or config.get('stgit.smtpserver')
+    (build, outstr) = {'cover': (__build_cover, 'the cover message'),
+                       'patch': (__build_message, 'patch "%s"' % args[0])}[type]
+    if type == 'patch':
+        (patch_nr, total_nr) = (args[1], args[2])
+
+    msg_id = email.Utils.make_msgid('stgit')
+    msg = build(tmpl, msg_id, options, *args)
+
+    from_addr, to_addrs = __parse_addresses(msg)
+    msg_str = msg.as_string(options.mbox)
+    if options.mbox:
+        out.stdout_raw(msg_str + '\n')
+        return msg_id
+
+    out.start('Sending ' + outstr)
 
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
+    if type == 'cover' or (type == 'patch' and patch_nr < total_nr):
+        sleep = options.sleep or config.getint('stgit.smtpdelay')
+        time.sleep(sleep)
+    out.done()
+    return msg_id
 
 def __build_address_headers(msg, options, extra_cc = []):
     """Build the address headers and check existing headers in the
@@ -584,7 +606,6 @@ def func(parser, options, args):
     else:
         ref_id = None
 
-    sleep = options.sleep or config.getint('stgit.smtpdelay')
 
     # send the cover message (if any)
     if options.cover or options.edit_cover:
@@ -599,24 +620,12 @@ def func(parser, options, args):
             if not tmpl:
                 raise CmdException, 'No cover message template file found'
 
-        msg_id = email.Utils.make_msgid('stgit')
-        msg = __build_cover(tmpl, msg_id, options, patches)
-        from_addr, to_addr_list = __parse_addresses(msg)
-
-        msg_string = msg.as_string(options.mbox)
+        msg_id = __send_message('cover', tmpl, options, patches)
 
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
@@ -628,25 +637,9 @@ def func(parser, options, args):
         if not tmpl:
             raise CmdException, 'No e-mail template file found'
 
-    for (p, patch_nr) in zip(patches, range(1, total_nr + 1)):
-        msg_id = email.Utils.make_msgid('stgit')
-        msg = __build_message(tmpl, msg_id, options, p, patch_nr, total_nr,
-                              ref_id)
-        from_addr, to_addr_list = __parse_addresses(msg)
-
-        msg_string = msg.as_string(options.mbox)
+    for (p, n) in zip(patches, range(1, total_nr + 1)):
+        msg_id = __send_message('patch', tmpl, options, p, n, total_nr, ref_id)
 
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
