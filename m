From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH next 2/2 v2] Remove python 2.5'isms
Date: Wed,  9 Jun 2010 19:24:54 -0500
Message-ID: <5ep6Hc9Nl3QLKwV46xET5ZLhqo2uNlnUL1-nNsG9p2IWyX-odykArvT4ontRdeBUA9ouCPQGFwQ@cipher.nrlssc.navy.mil>
References: <201006100040.54375.johan@herland.net>
Cc: git@vger.kernel.org, srabbelier@gmail.com, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: johan@herland.net
X-From: git-owner@vger.kernel.org Thu Jun 10 02:25:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMVaL-0002Zf-3o
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 02:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024Ab0FJAZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 20:25:24 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58188 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033Ab0FJAZX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 20:25:23 -0400
Received: by mail.nrlssc.navy.mil id o5A0PG29025705; Wed, 9 Jun 2010 19:25:17 -0500
In-Reply-To: <201006100040.54375.johan@herland.net>
X-OriginalArrivalTime: 10 Jun 2010 00:25:17.0350 (UTC) FILETIME=[66EF3C60:01CB0833]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148827>

From: Brandon Casey <drafnel@gmail.com>

The following python 2.5 features were worked around:

    * the sha module is used as a fallback when the hashlib module is
      not available
    * the 'any' built-in method was replaced with a 'for' loop
    * a conditional expression was replaced with an 'if' statement
    * the subprocess.check_call method was replaced by a call to
      subprocess.Popen followed by a call to subprocess.wait with a
      check of its return status

These changes allow the python infrastructure to be used with python 2.4
which is distributed with RedHat's RHEL 5, for example.

t5800 was updated to check for python >= 2.4 to reflect these changes.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


On 06/09/2010 05:40 PM, Johan Herland wrote:

> On my Python v2.6.5. I get the following:
> 
>>>> import sha
> __main__:1: DeprecationWarning: the sha module is deprecated; use the 
> hashlib module instead
> 
> This is added to the output of every python program that imports sha. I 
> believe we should really try to use the hashlib module when available, and 
> only fall back to sha when necessary. Please use something like this 
> instead:
> 
>   # hashlib is only available in python >= 2.5 
>   try: 
>       import hashlib 
>       _digest = hashlib.sha1 
>   except ImportError: 
>       import sha
>       _digest = sha.sha 
> 
> so that we don't get the hideous DeprecationWarning.

Like this? ...


 git-remote-testgit.py               |   15 ++++++++++++---
 git_remote_helpers/git/exporter.py  |    4 +++-
 git_remote_helpers/git/importer.py  |    4 +++-
 git_remote_helpers/git/non_local.py |   16 ++++++++++++----
 git_remote_helpers/git/repo.py      |    9 +++++++--
 t/t5800-remote-helpers.sh           |    4 ++--
 6 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 9253922..df9d512 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -1,6 +1,12 @@
 #!/usr/bin/env python
 
-import hashlib
+# hashlib is only available in python >= 2.5
+try:
+    import hashlib
+    _digest = hashlib.sha1
+except ImportError:
+    import sha
+    _digest = sha.new
 import sys
 import os
 sys.path.insert(0, os.getenv("GITPYTHONLIB","."))
@@ -19,7 +25,7 @@ def get_repo(alias, url):
     repo.get_revs()
     repo.get_head()
 
-    hasher = hashlib.sha1()
+    hasher = _digest()
     hasher.update(repo.path)
     repo.hash = hasher.hexdigest()
 
@@ -133,7 +139,10 @@ def do_export(repo, args):
 
     path = os.path.join(dirname, 'testgit.marks')
     print path
-    print path if os.path.exists(path) else ""
+    if os.path.exists(path):
+        print path
+    else:
+        print ""
     sys.stdout.flush()
 
     update_local_repo(repo)
diff --git a/git_remote_helpers/git/exporter.py b/git_remote_helpers/git/exporter.py
index dfaab00..f40f9d6 100644
--- a/git_remote_helpers/git/exporter.py
+++ b/git_remote_helpers/git/exporter.py
@@ -48,4 +48,6 @@ class GitExporter(object):
 
         args = ["sed", "s_refs/heads/_" + self.repo.prefix + "_g"]
 
-        subprocess.check_call(args, stdin=p1.stdout)
+        child = subprocess.Popen(args, stdin=p1.stdout)
+        if child.wait() != 0:
+            raise CalledProcessError
diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index af2919d..70a7127 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -35,4 +35,6 @@ class GitImporter(object):
         if os.path.exists(path):
             args.append("--import-marks=" + path)
 
-        subprocess.check_call(args)
+        child = subprocess.Popen(args)
+        if child.wait() != 0:
+            raise CalledProcessError
diff --git a/git_remote_helpers/git/non_local.py b/git_remote_helpers/git/non_local.py
index d75ef8f..f27389b 100644
--- a/git_remote_helpers/git/non_local.py
+++ b/git_remote_helpers/git/non_local.py
@@ -29,7 +29,9 @@ class NonLocalGit(object):
         os.makedirs(path)
         args = ["git", "clone", "--bare", "--quiet", self.repo.gitpath, path]
 
-        subprocess.check_call(args)
+        child = subprocess.Popen(args)
+        if child.wait() != 0:
+            raise CalledProcessError
 
         return path
 
@@ -43,10 +45,14 @@ class NonLocalGit(object):
             die("could not find repo at %s", path)
 
         args = ["git", "--git-dir=" + path, "fetch", "--quiet", self.repo.gitpath]
-        subprocess.check_call(args)
+        child = subprocess.Popen(args)
+        if child.wait() != 0:
+            raise CalledProcessError
 
         args = ["git", "--git-dir=" + path, "update-ref", "refs/heads/master", "FETCH_HEAD"]
-        subprocess.check_call(args)
+        child = subprocess.Popen(args)
+        if child.wait() != 0:
+            raise CalledProcessError
 
     def push(self, base):
         """Pushes from the non-local repo to base.
@@ -58,4 +64,6 @@ class NonLocalGit(object):
             die("could not find repo at %s", path)
 
         args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath]
-        subprocess.check_call(args)
+        child = subprocess.Popen(args)
+        if child.wait() != 0:
+            raise CalledProcessError
diff --git a/git_remote_helpers/git/repo.py b/git_remote_helpers/git/repo.py
index 82d5f78..58e1cdb 100644
--- a/git_remote_helpers/git/repo.py
+++ b/git_remote_helpers/git/repo.py
@@ -19,7 +19,10 @@ def is_remote(url):
 
     prefixes = ["http", "file", "git"]
 
-    return any(url.startswith(i) for i in prefixes)
+    for prefix in prefixes:
+        if url.startswith(prefix):
+            return True
+    return False
 
 class GitRepo(object):
     """Repo object representing a repo.
@@ -50,7 +53,9 @@ class GitRepo(object):
         path = ".cached_revs"
         ofile = open(path, "w")
 
-        subprocess.check_call(args, stdout=ofile)
+        child = subprocess.Popen(args, stdout=ofile)
+        if child.wait() != 0:
+            raise CalledProcessError
         output = open(path).readlines()
         self.revmap = dict(sanitize(i) for i in output)
         if "HEAD" in self.revmap:
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 22c7df4..4ee7b65 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -9,13 +9,13 @@ test_description='Test remote-helper import and export commands'
 
 if test_have_prereq PYTHON && "$PYTHON_PATH" -c '
 import sys
-if sys.hexversion < 0x02050000:
+if sys.hexversion < 0x02040000:
     sys.exit(1)
 '
 then
 	:
 else
-	say 'skipping git remote-testgit tests: requires Python 2.5 or newer'
+	say 'skipping git remote-testgit tests: requires Python 2.4 or newer'
 	test_done
 fi
 
-- 
1.6.6.2
