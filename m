From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 16/20] transport-helper: update ref status after push with export
Date: Sun, 19 Jun 2011 17:18:41 +0200
Message-ID: <1308496725-22329-17-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJnZ-00042G-88
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab1FSPUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:11 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52873 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441Ab1FSPUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:20:08 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so294388eyx.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=k6M4nl7fSxENAhSVbY6MttCyp3Duk2V0k3c8n15xnrU=;
        b=l/gexTJAUOkGQ/eNBG6T+luOTiuVb99oMVin67zNFKaarVsUVSC1MngC/9+rKDaIm8
         esoYmbsox8mTUZ47U37LkX8iM8jXLwFa9U6Ecpg7PqBDeNtCkkVr+gmGdydcBiERnWA6
         XTwshZCQC8M8Zmb9nCgZgGMupzqjfBWvAUUYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TypdngTEJx5n7T9lPa7Ix6t4Xe1E0PnBzn6th/yWym9/O966f4PX8XVD/NGB1uTTy/
         dUxolAxvyZl2bIDVrjqSekCAUIvWbE2iQ5PEaz40Wlokks7M9x2I7izrx6l3yZ3sWrbP
         Tg6fsdnb2GZNMhBUS5QsGme/VgAHR4EO3WksE=
Received: by 10.14.17.97 with SMTP id i73mr1502167eei.124.1308496807002;
        Sun, 19 Jun 2011 08:20:07 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.20.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:20:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176015>


Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  This time a proper implementation of this patch.

 git-remote-testgit.py              |    6 +++++-
 git_remote_helpers/git/importer.py |   28 +++++++++++++++++++++++++++-
 git_remote_helpers/util.py         |   34 ++++++++++++++++++++++++++++++++++
 transport-helper.c                 |    1 +
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index a8e47d9..854e27e 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -148,11 +148,15 @@ def do_export(repo, args):
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
 
 def do_gitdir(repo, args):
     """Stores the location of the gitdir.
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
index 8b9f302..6a9ec5c 100644
--- a/git_remote_helpers/util.py
+++ b/git_remote_helpers/util.py
@@ -160,6 +160,40 @@ def check_call(*popenargs, **kwargs):
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
index b0361c2..bb1b97f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -760,6 +760,7 @@ static int push_refs_with_export(struct transport *transport,
 	data->no_disconnect_req = 1;
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
+	push_update_refs_status(data, remote_refs);
 	return 0;
 }
 
-- 
1.7.5.1.292.g728120
