From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 5/6] stg mail: add basic support for git send-email
Date: Sat, 28 Nov 2009 12:50:37 -0700
Message-ID: <20091128195037.949.63611.stgit@bob.kio>
References: <20091128194056.949.88791.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 28 20:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETJm-0000Sq-GN
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 20:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbZK1Tue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 14:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbZK1Tud
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 14:50:33 -0500
Received: from g1t0026.austin.hp.com ([15.216.28.33]:34423 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbZK1Tuc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 14:50:32 -0500
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g1t0026.austin.hp.com (Postfix) with ESMTP id 827E4C245;
	Sat, 28 Nov 2009 19:50:38 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 2572014036;
	Sat, 28 Nov 2009 19:50:38 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id EA58CCF0009;
	Sat, 28 Nov 2009 12:50:37 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id weP6uF957+W5; Sat, 28 Nov 2009 12:50:37 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id CCCC9CF0007;
	Sat, 28 Nov 2009 12:50:37 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id C3A1326172; Sat, 28 Nov 2009 12:50:37 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091128194056.949.88791.stgit@bob.kio>
User-Agent: StGit/0.15-6-g435b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133978>

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

 stgit/commands/mail.py |   60 +++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 7f811e8..81ec77e 100644
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
@@ -228,6 +230,52 @@ def __send_message_smtp(smtpserver, from_addr, to_addr_list, msg, options):
 
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
+
+    # XXX: yuck, there's gotta be a more pythonic way. Ideally we'd like
+    # to use the git_opts dictionary as our mapping between stg mail and
+    # git send-email; extract k, v pairs from git_opts, and use those
+    # to iterate across options somehow.
+    git_opts = { 'to': '--to=', 'cc': '--cc=', 'bcc': '--bcc=' }
+    if options.to:
+        for a in options.to:
+            cmd.append("--to=%s" % a)
+    if options.cc:
+        for a in options.cc:
+            cmd.append("--cc=%s" % a)
+    if options.bcc:
+        for a in options.bcc:
+            cmd.append("--bcc=%s" % a)
+    if not options.auto:
+        cmd.append("--suppress-cc=body")
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
+        cmd.append(path)
+        call(cmd)
+    except Exception, err:
+        os.unlink(path)
+        raise CmdException, str(err)
+
+    os.unlink(path)
+
 def __send_message(tmpl, options, *args):
     """Message sending dispatcher.
     """
@@ -242,10 +290,13 @@ def __send_message(tmpl, options, *args):
         return msg_id
 
     outstr = { 1: 'the cover message', 4: 'patch "%s"' % args[0] }
-    out.start('Sending ' + outstr[len(args)])
+    if not options.git:
+        out.start('Sending ' + outstr[len(args)])
 
     smtpserver = options.smtp_server or config.get('stgit.smtpserver')
-    if smtpserver.startswith('/'):
+    if options.git:
+        __send_message_git(msg, options)
+    elif smtpserver.startswith('/'):
         # Use the sendmail tool
         __send_message_sendmail(smtpserver, msg_str)
     else:
@@ -257,7 +308,8 @@ def __send_message(tmpl, options, *args):
     if len(args) == 1 or (len(args) == 4 and args[1] < args[2]):
         sleep = options.sleep or config.getint('stgit.smtpdelay')
         time.sleep(sleep)
-    out.done()
+    if not options.git:
+        out.done()
     return msg_id
 
 def __update_header(msg, header, addr = '', ignore = ()):
