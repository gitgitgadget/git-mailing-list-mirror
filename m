From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH] mail: Ask for the SMTP credentials before sending the
 messages
Date: Fri, 12 Feb 2010 16:11:51 +0000
Message-ID: <20100212161150.12036.62592.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, Alex Chiang <achiang@hp.com>
To: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 17:12:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfy7q-0000pm-LK
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 17:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977Ab0BLQMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 11:12:07 -0500
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38291 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756936Ab0BLQMD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 11:12:03 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o1CGBpeI000879;
	Fri, 12 Feb 2010 16:11:51 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 12 Feb 2010 16:11:51 +0000
User-Agent: StGit/0.15-53-gecb05-dirty
X-OriginalArrivalTime: 12 Feb 2010 16:11:51.0452 (UTC) FILETIME=[161CF5C0:01CAABFE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139719>

The original implementation was asking for the SMTP password on every
patch sent. This patch only asks the password once before sending or
even editing the cover message and patches.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Pavel Roskin <proski@gnu.org>
Cc: Alex Chiang <achiang@hp.com>
---
 stgit/commands/mail.py |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 34262d3..b0a8f13 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -192,9 +192,18 @@ def __send_message_sendmail(sendmail, msg):
     cmd = sendmail.split()
     Run(*cmd).raw_input(msg).discard_output()
 
-def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options):
-    """Send the message using the given SMTP server
+__smtp_credentials = None
+
+def __set_smtp_credentials(options):
+    """Set the (smtpuser, smtppassword, smtpusetls) credentials if the method
+    of sending is SMTP.
     """
+    global __smtp_credentials
+
+    smtpserver = options.smtp_server or config.get('stgit.smtpserver')
+    if options.git or smtpserver.startswith('/'):
+        return
+
     smtppassword = options.smtp_password or config.get('stgit.smtppassword')
     smtpuser = options.smtp_user or config.get('stgit.smtpuser')
     smtpusetls = options.smtp_tls or config.get('stgit.smtptls') == 'yes'
@@ -206,6 +215,13 @@ def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options):
     if (smtpuser and not smtppassword):
         smtppassword = getpass.getpass("Please enter SMTP password: ")
 
+    __smtp_credentials = (smtpuser, smtppassword, smtpusetls)
+
+def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options):
+    """Send the message using the given SMTP server
+    """
+    smtpuser, smtppassword, smtpusetls = __smtp_credentials
+
     try:
         s = smtplib.SMTP(smtpserver)
     except Exception, err:
@@ -652,6 +668,8 @@ def func(parser, options, args):
     else:
         ref_id = None
 
+    # get username/password if sending by SMTP
+    __set_smtp_credentials(options)
 
     # send the cover message (if any)
     if options.cover or options.edit_cover:
