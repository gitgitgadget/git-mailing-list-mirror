From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 3/9] Do not sleep after the last patch sent by e-mail
Date: Tue, 28 Apr 2009 16:09:52 +0100
Message-ID: <20090428150952.27261.5637.stgit@pc1117.cambridge.arm.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:13:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyp03-0002lt-7t
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbZD1PKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbZD1PKq
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:10:46 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48928 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932223AbZD1PKl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:10:41 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF6kZm027030;
	Tue, 28 Apr 2009 16:06:46 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:10:38 +0100
In-Reply-To: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:10:38.0424 (UTC) FILETIME=[7D05DD80:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117789>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/mail.py |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 46e4b55..69b19fa 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -219,7 +219,7 @@ def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg,
     s.quit()
 
 def __send_message(smtpserver, from_addr, to_addr_list, msg,
-                   sleep, smtpuser, smtppassword, use_tls):
+                   smtpuser, smtppassword, use_tls):
     """Message sending dispatcher.
     """
     if smtpserver.startswith('/'):
@@ -229,8 +229,6 @@ def __send_message(smtpserver, from_addr, to_addr_list, msg,
         # Use the SMTP server (we have host and port information)
         __send_message_smtp(smtpserver, from_addr, to_addr_list, msg,
                             smtpuser, smtppassword, use_tls)
-    # give recipients a chance of receiving patches in the correct order
-    time.sleep(sleep)
 
 def __build_address_headers(msg, options, extra_cc = []):
     """Build the address headers and check existing headers in the
@@ -619,7 +617,8 @@ def func(parser, options, args):
         else:
             out.start('Sending the cover message')
             __send_message(smtpserver, from_addr, to_addr_list, msg_string,
-                           sleep, smtpuser, smtppassword, smtpusetls)
+                           smtpuser, smtppassword, smtpusetls)
+            time.sleep(sleep)
             out.done()
 
     # send the patches
@@ -633,7 +632,7 @@ def func(parser, options, args):
         if not tmpl:
             raise CmdException, 'No e-mail template file found'
 
-    for (p, patch_nr) in zip(patches, range(1, len(patches) + 1)):
+    for (p, patch_nr) in zip(patches, range(1, total_nr + 1)):
         msg_id = email.Utils.make_msgid('stgit')
         msg = __build_message(tmpl, p, patch_nr, total_nr, msg_id, ref_id,
                               options)
@@ -650,5 +649,9 @@ def func(parser, options, args):
         else:
             out.start('Sending patch "%s"' % p)
             __send_message(smtpserver, from_addr, to_addr_list, msg_string,
-                           sleep, smtpuser, smtppassword, smtpusetls)
+                           smtpuser, smtppassword, smtpusetls)
+            # give recipients a chance of receiving related patches in the
+            # correct order.
+            if patch_nr < total_nr:
+                time.sleep(sleep)
             out.done()
