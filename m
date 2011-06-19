From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 10/20] git-remote-testgit: fix error handling
Date: Sun, 19 Jun 2011 17:18:35 +0200
Message-ID: <1308496725-22329-11-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJnW-00042G-El
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab1FSPT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:58 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52873 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab1FSPTt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:49 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so294388eyx.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=uMmEnXFr2sVJzwhpXGdycU/Xoi3jEEN5LqZIK5tL2ss=;
        b=wF622b+WjrhsDeHO3NJBUrhzpbCvsZy7TpuSPk+lC7KYX7dEqMtUTzo6XZM4pGyXT1
         2SHODoMrUiiUfmlSX6MKSV/u8avt36Ne0k7qcJ1x5+zVTEx37KpJ9ZlrAgWwlYQknaaw
         DoXzehk2QM9eQk3zn2VyWKQVUb8fyxhW2p3jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HVYbKAAL1pLjyKx9hAgWtYFPwEHUgQDSIHSVBDDCcQOxFMLq0b/oItlWFlaDPXPnb1
         5/PlD3tWy4Sq2FgUPBGwzS6BKUJ1xkf85WvWZ5uoX9UCXbEfvc8k3rpGGzDoFR4eQP3z
         qmSRocqxeNMSDL49rXV8/hC8gjZxIYI89y2iU=
Received: by 10.213.105.66 with SMTP id s2mr1690947ebo.78.1308496789028;
        Sun, 19 Jun 2011 08:19:49 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176012>

If fast-export did not complete successfully the error handling code
itself would error out.

This was broken in commit 23b093ee0 (Brandon Casey, Wed Jun 9 2010,
Remove python 2.5'isms). Revert that commit an introduce our own copy
of check_call in util.py instead.

Tested by changing 'if retcode' to 'if not retcode' temporarily.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  This was broken in many places, not just the one place I fixed it
  in the last version of this commit.

 git_remote_helpers/git/exporter.py  |    6 +++---
 git_remote_helpers/git/importer.py  |    6 +++---
 git_remote_helpers/git/non_local.py |   18 +++++-------------
 git_remote_helpers/git/repo.py      |    7 ++++---
 git_remote_helpers/util.py          |   32 ++++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/git_remote_helpers/git/exporter.py b/git_remote_helpers/git/exporter.py
index bc39163..9ee5f96 100644
--- a/git_remote_helpers/git/exporter.py
+++ b/git_remote_helpers/git/exporter.py
@@ -2,6 +2,8 @@ import os
 import subprocess
 import sys
 
+from git_remote_helpers.util import check_call
+
 
 class GitExporter(object):
     """An exporter for testgit repositories.
@@ -53,6 +55,4 @@ class GitExporter(object):
 
         args = ["sed", "s_refs/heads/_" + self.repo.prefix + "_g"]
 
-        child = subprocess.Popen(args, stdin=p1.stdout)
-        if child.wait() != 0:
-            raise CalledProcessError
+        check_call(args, stdin=p1.stdout)
diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index 70a7127..02a719a 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -1,6 +1,8 @@
 import os
 import subprocess
 
+from git_remote_helpers.util import check_call
+
 
 class GitImporter(object):
     """An importer for testgit repositories.
@@ -35,6 +37,4 @@ class GitImporter(object):
         if os.path.exists(path):
             args.append("--import-marks=" + path)
 
-        child = subprocess.Popen(args)
-        if child.wait() != 0:
-            raise CalledProcessError
+        check_call(args)
diff --git a/git_remote_helpers/git/non_local.py b/git_remote_helpers/git/non_local.py
index c53e074..e700250 100644
--- a/git_remote_helpers/git/non_local.py
+++ b/git_remote_helpers/git/non_local.py
@@ -1,7 +1,7 @@
 import os
 import subprocess
 
-from git_remote_helpers.util import die, warn
+from git_remote_helpers.util import check_call, die, warn
 
 
 class NonLocalGit(object):
@@ -29,9 +29,7 @@ class NonLocalGit(object):
         os.makedirs(path)
         args = ["git", "clone", "--bare", "--quiet", self.repo.gitpath, path]
 
-        child = subprocess.Popen(args)
-        if child.wait() != 0:
-            raise CalledProcessError
+        check_call(args)
 
         return path
 
@@ -45,14 +43,10 @@ class NonLocalGit(object):
             die("could not find repo at %s", path)
 
         args = ["git", "--git-dir=" + path, "fetch", "--quiet", self.repo.gitpath]
-        child = subprocess.Popen(args)
-        if child.wait() != 0:
-            raise CalledProcessError
+        check_call(args)
 
         args = ["git", "--git-dir=" + path, "update-ref", "refs/heads/master", "FETCH_HEAD"]
-        child = subprocess.Popen(args)
-        if child.wait() != 0:
-            raise CalledProcessError
+        child = check_call(args)
 
     def push(self, base):
         """Pushes from the non-local repo to base.
@@ -64,6 +58,4 @@ class NonLocalGit(object):
             die("could not find repo at %s", path)
 
         args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath, "--all"]
-        child = subprocess.Popen(args)
-        if child.wait() != 0:
-            raise CalledProcessError
+        child = check_call(args)
diff --git a/git_remote_helpers/git/repo.py b/git_remote_helpers/git/repo.py
index 58e1cdb..acbf8d7 100644
--- a/git_remote_helpers/git/repo.py
+++ b/git_remote_helpers/git/repo.py
@@ -1,6 +1,9 @@
 import os
 import subprocess
 
+from git_remote_helpers.util import check_call
+
+
 def sanitize(rev, sep='\t'):
     """Converts a for-each-ref line to a name/value pair.
     """
@@ -53,9 +56,7 @@ class GitRepo(object):
         path = ".cached_revs"
         ofile = open(path, "w")
 
-        child = subprocess.Popen(args, stdout=ofile)
-        if child.wait() != 0:
-            raise CalledProcessError
+        check_call(args, stdout=ofile)
         output = open(path).readlines()
         self.revmap = dict(sanitize(i) for i in output)
         if "HEAD" in self.revmap:
diff --git a/git_remote_helpers/util.py b/git_remote_helpers/util.py
index dce83e6..8b9f302 100644
--- a/git_remote_helpers/util.py
+++ b/git_remote_helpers/util.py
@@ -128,6 +128,38 @@ def run_command (args, cwd = None, shell = False, add_env = None,
     return (exit_code, output, errors)
 
 
+# from python2.7:subprocess.py
+def call(*popenargs, **kwargs):
+    """Run command with arguments.  Wait for command to complete, then
+    return the returncode attribute.
+
+    The arguments are the same as for the Popen constructor.  Example:
+
+    retcode = call(["ls", "-l"])
+    """
+    return subprocess.Popen(*popenargs, **kwargs).wait()
+
+
+# from python2.7:subprocess.py
+def check_call(*popenargs, **kwargs):
+    """Run command with arguments.  Wait for command to complete.  If
+    the exit code was zero then return, otherwise raise
+    CalledProcessError.  The CalledProcessError object will have the
+    return code in the returncode attribute.
+
+    The arguments are the same as for the Popen constructor.  Example:
+
+    check_call(["ls", "-l"])
+    """
+    retcode = call(*popenargs, **kwargs)
+    if retcode:
+        cmd = kwargs.get("args")
+        if cmd is None:
+            cmd = popenargs[0]
+        raise subprocess.CalledProcessError(retcode, cmd)
+    return 0
+
+
 def file_reader_method (missing_ok = False):
     """Decorator for simplifying reading of files.
 
-- 
1.7.5.1.292.g728120
