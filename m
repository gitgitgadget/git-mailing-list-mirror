From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] contrib: add a credential helper for Mac OS X's keychain
Date: Sat, 10 Sep 2011 15:44:34 -0400
Message-ID: <1315683874-95583-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 21:44:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2TTv-0005Av-Kj
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 21:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933802Ab1IJToq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 15:44:46 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:39581 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759859Ab1IJToq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 15:44:46 -0400
Received: by vws10 with SMTP id 10so2875448vws.2
        for <git@vger.kernel.org>; Sat, 10 Sep 2011 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=C4oXwtVZQIF237OY/G3D/649YuVOAi7FGOWZOwiGRHU=;
        b=my6yD42wu8eK4OsCyTmNx/3zscQjKilM8PD5TJqdw7BSttytn2LYplrY9ovYwhrPuN
         3vRjmxRCelIKHVP/Z7IyuAMEckvLVzjCuG50dDwbawibemY5VJInHxlAmfPGnCiUurTe
         LSlySU+rZLnHm/GCLLWNGO0z404cmWzxndYxg=
Received: by 10.52.75.41 with SMTP id z9mr1333731vdv.93.1315683885256;
        Sat, 10 Sep 2011 12:44:45 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com [174.97.218.168])
        by mx.google.com with ESMTPS id jo8sm7181576vdb.20.2011.09.10.12.44.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Sep 2011 12:44:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.346.g5a895
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181160>

A credential helper which uses /usr/bin/security to add, search,
and remove entries from the Mac OS X keychain.

Tested with 10.6.8.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This is a quick script to explore the new credential API. A more robust
implementation would be to link to OS X's Security framework from C.

 contrib/credential/git-credential-osxkeychain |  148 +++++++++++++++++++++++++
 1 files changed, 148 insertions(+), 0 deletions(-)
 create mode 100755 contrib/credential/git-credential-osxkeychain

diff --git a/contrib/credential/git-credential-osxkeychain b/contrib/credential/git-credential-osxkeychain
new file mode 100755
index 0000000000..ae5ec00d68
--- /dev/null
+++ b/contrib/credential/git-credential-osxkeychain
@@ -0,0 +1,148 @@
+#!/usr/bin/python
+# Copyright 2011 Jay Soffian. All rights reserved.
+# FreeBSD License.
+"""
+A git credential helper that interfaces with the Mac OS X keychain via
+/usr/bin/security.
+"""
+
+import os
+import re
+import sys
+import termios
+from getpass import _raw_input
+from optparse import OptionParser
+from subprocess import Popen, PIPE
+
+USERNAME = 'USERNAME'
+PASSWORD = 'PASSWORD'
+PROMPTS = dict(USERNAME='Username', PASSWORD='Password')
+
+def prompt_tty(what, desc):
+    """Prompt on TTY for username or password with optional description"""
+    prompt = '%s%s: ' % (PROMPTS[what], " for '%s'" % desc if desc else '')
+    # Borrowed mostly from getpass.py
+    fd = os.open('/dev/tty', os.O_RDWR|os.O_NOCTTY)
+    tty = os.fdopen(fd, 'w+', 1)
+    if what == USERNAME:
+        return _raw_input(prompt, tty, tty)
+    old = termios.tcgetattr(fd) # a copy to save
+    new = old[:]
+    new[3] &= ~termios.ECHO  # 3 == 'lflags'
+    try:
+        termios.tcsetattr(fd, termios.TCSADRAIN, new)
+        return _raw_input(prompt, tty, tty)
+    finally:
+        termios.tcsetattr(fd, termios.TCSADRAIN, old)
+        tty.write('\n')
+
+def emit_user_pass(username, password):
+    if username:
+        print 'username=' + username
+    if password:
+        print 'password=' + password
+
+def make_security_args(command, protocol, hostname, username):
+    args = ['/usr/bin/security', command]
+    # tlfd is 'dflt' backwards - obvious /usr/bin/security bug
+    # but allows us to ignore matching saved web forms.
+    args.extend(['-t', 'tlfd'])
+    args.extend(['-r', protocol])
+    if hostname:
+        args.extend(['-s', hostname])
+    if username:
+        args.extend(['-a', username])
+    return args
+
+def find_internet_password(protocol, hostname, username):
+    args = make_security_args('find-internet-password',
+                              protocol, hostname, username)
+    args.append('-g') # asks for password on stderr
+    p = Popen(args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
+    # grok stdout for username
+    out, err = p.communicate()
+    if p.returncode != 0:
+        return
+    for line in out.splitlines(): # pylint:disable-msg=E1103
+        m = re.search(r'^\s+"acct"<blob>=[^"]*"(.*)"$', line)
+        if m:
+            username = m.group(1)
+            break
+    # grok stderr for password
+    m = re.search(r'^password:[^"]*"(.*)"$', err)
+    if not m:
+        return
+    emit_user_pass(username, m.group(1))
+    return True
+
+def delete_internet_password(protocol, hostname, username):
+    args = make_security_args('delete-internet-password',
+                              protocol, hostname, username)
+    p = Popen(args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
+    p.communicate()
+
+def add_internet_password(protocol, hostname, username, password):
+    # We do this over a pipe so that we can provide the password more
+    # securely than as an argument which would show up in ps output.
+    # Unfortunately this is possibly less robust since the security man
+    # page does not document how to quote arguments. Emprically it seems
+    # that using the double-quote, escaping \ and " works properly.
+    username = username.replace('\\', '\\\\').replace('"', '\\"')
+    password = password.replace('\\', '\\\\').replace('"', '\\"')
+    command = ' '.join([
+        'add-internet-password', '-U',
+        '-r', protocol,
+        '-s', hostname,
+        '-a "%s"' % username,
+        '-w "%s"' % password,
+        '-j default',
+        '-l "%s (%s)"' % (hostname, username),
+    ]) + '\n'
+    args = ['/usr/bin/security', '-i']
+    p = Popen(args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
+    p.communicate(command)
+
+def main():
+    p = OptionParser()
+    p.add_option('--description')
+    p.add_option('--reject', action='store_true')
+    p.add_option('--unique', dest='token', help='REQUIRED OPTION')
+    p.add_option('--username')
+    opts, _ = p.parse_args()
+
+    if not opts.token:
+        p.error('--unique option required')
+    if not ':' in opts.token:
+        print >> sys.stderr, "Invalid token: '%s'" % opts.token
+        return 1
+    protocol, hostname = opts.token.split(':', 1)
+    if protocol not in ('http', 'https'):
+        print >> sys.stderr, "Unsupported protocol: '%s'" % protocol
+        return 1
+    if protocol == 'https':
+        protocol = 'htps'
+
+    # "GitHub for Mac" compatibility
+    if hostname == 'github.com':
+        hostname = 'github.com/mac'
+
+    # if this is a rejection delete the existing creds
+    if opts.reject:
+        delete_internet_password(protocol, hostname, opts.username)
+        return 0
+
+    # otherwise look for creds
+    if find_internet_password(protocol, hostname, opts.username):
+        return 0
+
+    # creds not found, so prompt the user then store the creds
+    username = opts.username
+    if username is None:
+        username = prompt_tty(USERNAME, opts.description)
+    password = prompt_tty(PASSWORD, opts.description)
+    add_internet_password(protocol, hostname, username, password)
+    emit_user_pass(username, password)
+    return 0
+
+if __name__ == '__main__':
+    sys.exit(main())
-- 
1.7.6.346.g5a895
