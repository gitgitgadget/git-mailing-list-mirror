From: Alex Chiang <achiang@hp.com>
Subject: [StGit PATCH v2 5/6] stg mail: add basic support for git send-email
Date: Tue,  1 Dec 2009 17:46:27 -0700
Message-ID: <20091202004627.7737.23460.stgit@bob.kio>
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
	id 1NFdMj-0005qg-H9
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 01:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbZLBAqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 19:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbZLBAqX
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 19:46:23 -0500
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:5223 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbZLBAqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 19:46:21 -0500
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g5t0009.atlanta.hp.com (Postfix) with ESMTP id 46DAE30295;
	Wed,  2 Dec 2009 00:46:28 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id 1EC06200A3;
	Wed,  2 Dec 2009 00:46:28 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id E6AA8CF000A;
	Tue,  1 Dec 2009 17:46:27 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1cc8nDdezVK; Tue,  1 Dec 2009 17:46:27 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id C8104CF0007;
	Tue,  1 Dec 2009 17:46:27 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id AD61226160; Tue,  1 Dec 2009 17:46:27 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091202003503.7737.51579.stgit@bob.kio>
User-Agent: StGit/0.15-6-gc6f39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134276>

This is the first step in turning stg mail into a wrapper for
git send-email. It requires passing the --git option to stg mail
for now.

Only a few basic options are supported for now, namely To/Cc/Bcc.

git send-email options used:
  --suppress-cc=self	prevent further information prompts
  --quiet		reduce git send-email output

Cc: Karl Wiberg <kha@treskal.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 stgit/commands/mail.py |   50 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index f430a13..8a33c22 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -140,7 +140,9 @@ options = [
     opt('-b', '--branch', args = [argparse.stg_branches],
         short = 'Use BRANCH instead of the default branch'),
     opt('-m', '--mbox', action = 'store_true',
-        short = 'Generate an mbox file instead of sending')
+        short = 'Generate an mbox file instead of sending'),
+    opt('--git', action = 'store_true',
+        short = 'Use git send-email (EXPERIMENTAL)')
     ] + argparse.diff_opts_option()
 
 directory = DirectoryHasRepository(log = False)
@@ -228,6 +230,42 @@ def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options):
 
     s.quit()
 
+def __send_message_git(msg, options):
+    """Send the message using git send-email
+    """
+    from subprocess import call
+    from tempfile import mkstemp
+
+    cmd = ["git", "send-email", "--from=%s" % msg['From']]
+    cmd.append("--quiet")
+    cmd.append("--suppress-cc=self")
+    if not options.auto:
+        cmd.append("--suppress-cc=body")
+
+    # We only support To/Cc/Bcc in git send-email for now.
+    for x in ['to', 'cc', 'bcc']:
+        if getattr(options, x):
+            cmd.extend('--%s=%s' % (x, a) for a in getattr(options, x))
+
+    # XXX: hack for now so that we don't duplicate To/Cc/Bcc headers
+    # in the mail, as git send-email inserts those for us.
+    del msg['To']
+    del msg['Cc']
+    del msg['Bcc']
+
+    (fd, path) = mkstemp()
+    os.write(fd, msg.as_string(options.mbox))
+    os.close(fd)
+
+    try:
+        try:
+            cmd.append(path)
+            call(cmd)
+        except Exception, err:
+            raise CmdException, str(err)
+    finally:
+        os.unlink(path)
+
 def __send_message(type, tmpl, options, *args):
     """Message sending dispatcher.
     """
@@ -245,10 +283,13 @@ def __send_message(type, tmpl, options, *args):
         out.stdout_raw(msg_str + '\n')
         return msg_id
 
-    out.start('Sending ' + outstr)
+    if not options.git:
+        out.start('Sending ' + outstr)
 
     smtpserver = options.smtp_server or config.get('stgit.smtpserver')
-    if smtpserver.startswith('/'):
+    if options.git:
+        __send_message_git(msg, options)
+    elif smtpserver.startswith('/'):
         # Use the sendmail tool
         __send_message_sendmail(smtpserver, msg_str)
     else:
@@ -259,7 +300,8 @@ def __send_message(type, tmpl, options, *args):
     if type == 'cover' or (type == 'patch' and patch_nr < total_nr):
         sleep = options.sleep or config.getint('stgit.smtpdelay')
         time.sleep(sleep)
-    out.done()
+    if not options.git:
+        out.done()
     return msg_id
 
 def __update_header(msg, header, addr = '', ignore = ()):
