From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 17/23] transport-helper: update ref status after push with export
Date: Sat, 16 Jul 2011 15:03:37 +0200
Message-ID: <1310821424-4750-18-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4YX-0005RE-2G
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab1GPNE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:04:59 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37348 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab1GPNE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:04:57 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996059ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2XpttXqCXhuTQ1iOXYzbtrq6dTnGn9oKf8jYgNL6ow4=;
        b=K39KqO9C9zHHvbf88IbgCudbK/gcgnsb+kJAdebDUjvAVQxsYb2nxKeeOY+boBNLPO
         vi8FXidvBrM8AYDU/UDWMiNpw3ThLqBdiv8MH/2cxIYVYolsmZ3ilesHTP+ZEd1zXmRG
         Hd6/LrqTrmc7UJp7YyNfqfneiR5r1k/yCYRHs=
Received: by 10.213.105.145 with SMTP id t17mr1662639ebo.31.1310821496266;
        Sat, 16 Jul 2011 06:04:56 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177264>

Also add check_output from python 2.7.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged, although see later patches that demonstrate that
  deleted refs don't work.

 git-remote-testgit.py              |    6 +++++-
 git_remote_helpers/git/importer.py |   28 +++++++++++++++++++++++++++-
 git_remote_helpers/util.py         |   34 ++++++++++++++++++++++++++++++++++
 transport-helper.c                 |    1 +
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index af4d040..0b5928d 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -147,11 +147,15 @@ def do_export(repo, args):
     sys.stdout.flush()
 
     update_local_repo(repo)
-    repo.importer.do_import(repo.gitdir)
+    changed = repo.importer.do_import(repo.gitdir)
 
     if not repo.local:
         repo.non_local.push(repo.gitdir)
 
+    for ref in changed:
+        print "ok %s" % ref
+    print
+
 
 COMMANDS = {
     'capabilities': do_capabilities,
diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index 02a719a..5c6b595 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -1,7 +1,7 @@
 import os
 import subprocess
 
-from git_remote_helpers.util import check_call
+from git_remote_helpers.util import check_call, check_output
 
 
 class GitImporter(object):
@@ -16,6 +16,18 @@ class GitImporter(object):
 
         self.repo = repo
 
+    def get_refs(self, gitdir):
+        """Returns a dictionary with refs.
+        """
+        args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
+        lines = check_output(args).strip().split('\n')
+        refs = {}
+        for line in lines:
+            value, name = line.split(' ')
+            name = name.strip('commit\t')
+            refs[name] = value
+        return refs
+
     def do_import(self, base):
         """Imports a fast-import stream to the given directory.
 
@@ -32,9 +44,23 @@ class GitImporter(object):
         if not os.path.exists(dirname):
             os.makedirs(dirname)
 
+        refs_before = self.get_refs(gitdir)
+
         args = ["git", "--git-dir=" + gitdir, "fast-import", "--quiet", "--export-marks=" + path]
 
         if os.path.exists(path):
             args.append("--import-marks=" + path)
 
         check_call(args)
+
+        refs_after = self.get_refs(gitdir)
+
+        changed = {}
+
+        for name, value in refs_after.iteritems():
+            if refs_before.get(name) == value:
+                continue
+
+            changed[name] = value
+
+        return changed
diff --git a/git_remote_helpers/util.py b/git_remote_helpers/util.py
index 1652c65..fbbb01b 100644
--- a/git_remote_helpers/util.py
+++ b/git_remote_helpers/util.py
@@ -175,6 +175,40 @@ def check_call(*popenargs, **kwargs):
     return 0
 
 
+# from python2.7:subprocess.py
+def check_output(*popenargs, **kwargs):
+    r"""Run command with arguments and return its output as a byte string.
+
+    If the exit code was non-zero it raises a CalledProcessError.  The
+    CalledProcessError object will have the return code in the returncode
+    attribute and output in the output attribute.
+
+    The arguments are the same as for the Popen constructor.  Example:
+
+    >>> check_output(["ls", "-l", "/dev/null"])
+    'crw-rw-rw- 1 root root 1, 3 Oct 18  2007 /dev/null\n'
+
+    The stdout argument is not allowed as it is used internally.
+    To capture standard error in the result, use stderr=STDOUT.
+
+    >>> check_output(["/bin/sh", "-c",
+    ...               "ls -l non_existent_file ; exit 0"],
+    ...              stderr=STDOUT)
+    'ls: non_existent_file: No such file or directory\n'
+    """
+    if 'stdout' in kwargs:
+        raise ValueError('stdout argument not allowed, it will be overridden.')
+    process = subprocess.Popen(stdout=subprocess.PIPE, *popenargs, **kwargs)
+    output, unused_err = process.communicate()
+    retcode = process.poll()
+    if retcode:
+        cmd = kwargs.get("args")
+        if cmd is None:
+            cmd = popenargs[0]
+        raise subprocess.CalledProcessError(retcode, cmd)
+    return output
+
+
 def file_reader_method (missing_ok = False):
     """Decorator for simplifying reading of files.
 
diff --git a/transport-helper.c b/transport-helper.c
index 4c0d861..a8f69b0 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -764,6 +764,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
+	push_update_refs_status(data, remote_refs);
 	return 0;
 }
 
-- 
1.7.5.1.292.g728120
