From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 6/7] remote-helpers: add testgit helper
Date: Mon, 29 Mar 2010 11:48:28 -0500
Message-ID: <1269881309-19690-7-git-send-email-srabbelier@gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jonathan Niede
X-From: git-owner@vger.kernel.org Mon Mar 29 18:49:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwI9c-0007r6-4b
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab0C2Qs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:48:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60022 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab0C2Qs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:48:56 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so6755854pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cfEz8qBx27NblyQkpm1yuno8Chb5jXEGlQqSdB+VEwg=;
        b=os9fW7DZo3SEhfd/23ASnOwv9e2uMR/ecjnTheazwwrxPlDSQEfx/ZetXpD8mLMVq7
         iqZQRxCotFevrgWM8/DsOrfCfG/Ijt/MG8yo35PM2uFQMlL2nuq9B1DXIX1/So/ZujaD
         865sP5dHybRMvwNAf+wc0pO29fw7lGVNJ0Fqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F8iawaCREw43ckGxcIQxGsFpQj595YVX8/T0F6RwROqsFrxRbZcLY55pgWXp45S8Pn
         YDd4F5xtIVUPaD2O3RqB7TYHW01JRmkQgFh52vku5kQGT0TsXTTYBUxArLO/TBAmaApO
         JSRG94zJVPsnmoptFFx4mllNJDsKF2Xpmi8UE=
Received: by 10.140.56.6 with SMTP id e6mr4697479rva.81.1269881335609;
        Mon, 29 Mar 2010 09:48:55 -0700 (PDT)
Received: from localhost.localdomain (97-114-181-145.frgo.qwest.net [97.114.181.145])
        by mx.google.com with ESMTPS id 23sm4102040iwn.10.2010.03.29.09.48.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 09:48:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.317.gbb04ec
In-Reply-To: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143497>

Currently the remote helper infrastructure is only used by the curl
helper, which does not give a good impression of how remote helpers
can be used to interact with foreign repositories. Since implementing
such a helper is non-trivial it would be good to have at least one
easy-to-follow example demonstrating how to implement a helper that
interacts with a foreign vcs using fast-import/fast-export.

The testgit helper can be used to interact with remote git
repositories by prefixing the url with "testgit::".
---

	While working on git-remote-hg I tested the export code by
	just writing the fast-export stream to a file, and then
	manually importing it in a repo.

	I then had the crazy idea to "just write a native git helper"
	that would do just that. Turns out it's quite hard to get
	everything right. I guess that only shows that this example
	is really needed so that others can more easily create a
	helper.

 .gitignore                          |    1 +
 Makefile                            |    2 +
 git-remote-testgit.py               |  233 +++++++++++++++++++++++++++++++++++
 git_remote_helpers/git/exporter.py  |   51 ++++++++
 git_remote_helpers/git/importer.py  |   38 ++++++
 git_remote_helpers/git/non_local.py |   61 +++++++++
 git_remote_helpers/git/repo.py      |   70 +++++++++++
 7 files changed, 456 insertions(+), 0 deletions(-)
 create mode 100644 git-remote-testgit.py
 create mode 100644 git_remote_helpers/git/exporter.py
 create mode 100644 git_remote_helpers/git/importer.py
 create mode 100644 git_remote_helpers/git/non_local.py
 create mode 100644 git_remote_helpers/git/repo.py

diff --git a/.gitignore b/.gitignore
index 7b3acb7..7aebd6b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -112,6 +112,7 @@
 /git-remote-https
 /git-remote-ftp
 /git-remote-ftps
+/git-remote-testgit
 /git-repack
 /git-replace
 /git-repo-config
diff --git a/Makefile b/Makefile
index 3a6c6ea..b1e5f61 100644
--- a/Makefile
+++ b/Makefile
@@ -366,6 +366,8 @@ SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
+SCRIPT_PYTHON += git-remote-testgit.py
+
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
new file mode 100644
index 0000000..f61624e
--- /dev/null
+++ b/git-remote-testgit.py
@@ -0,0 +1,233 @@
+#!/usr/bin/env python
+
+import hashlib
+import sys
+
+from git_remote_helpers.util import die, debug, warn
+from git_remote_helpers.git.repo import GitRepo
+from git_remote_helpers.git.exporter import GitExporter
+from git_remote_helpers.git.importer import GitImporter
+from git_remote_helpers.git.non_local import NonLocalGit
+
+def get_repo(alias, url):
+    """Returns a git repository object initialized for usage.
+    """
+
+    repo = GitRepo(url)
+    repo.get_revs()
+    repo.get_head()
+
+    hasher = hashlib.sha1()
+    hasher.update(repo.path)
+    repo.hash = hasher.hexdigest()
+
+    repo.get_base_path = lambda base: os.path.join(
+        base, 'info', 'fast-import', repo.hash)
+
+    prefix = 'refs/testgit/%s/' % alias
+    debug("prefix: '%s'", prefix)
+
+    repo.gitdir = ""
+    repo.alias = alias
+    repo.prefix = prefix
+
+    repo.exporter = GitExporter(repo)
+    repo.importer = GitImporter(repo)
+    repo.non_local = NonLocalGit(repo)
+
+    return repo
+
+
+def local_repo(repo, path):
+    """Returns a git repository object initalized for usage.
+    """
+
+    local = GitRepo(path)
+
+    local.non_local = None
+    local.gitdir = repo.gitdir
+    local.alias = repo.alias
+    local.prefix = repo.prefix
+    local.hash = repo.hash
+    local.get_base_path = repo.get_base_path
+    local.exporter = GitExporter(local)
+    local.importer = GitImporter(local)
+
+    return local
+
+
+def do_capabilities(repo, args):
+    """Prints the supported capabilities.
+    """
+
+    print "import"
+    print "export"
+    print "gitdir"
+    print "refspec refs/heads/*:%s*" % repo.prefix
+
+    print # end capabilities
+
+
+def do_list(repo, args):
+    """Lists all known references.
+
+    Bug: This will always set the remote head to master for non-local
+    repositories, since we have no way of determining what the remote
+    head is at clone time.
+    """
+
+    for ref in repo.revs:
+        debug("? refs/heads/%s", ref)
+        print "? refs/heads/%s" % ref
+
+    if repo.head:
+        debug("@refs/heads/%s HEAD" % repo.head)
+        print "@refs/heads/%s HEAD" % repo.head
+    else:
+        debug("@refs/heads/master HEAD")
+        print "@refs/heads/master HEAD"
+
+    print # end list
+
+
+def update_local_repo(repo):
+    """Updates (or clones) a local repo.
+    """
+
+    if repo.local:
+        return repo
+
+    path = repo.non_local.clone(repo.gitdir)
+    repo.non_local.update(repo.gitdir)
+    repo = local_repo(repo, path)
+    return repo
+
+
+def do_import(repo, args):
+    """Exports a fast-import stream from testgit for git to import.
+    """
+
+    if len(args) != 1:
+        die("Import needs exactly one ref")
+
+    if not repo.gitdir:
+        die("Need gitdir to import")
+
+    repo = update_local_repo(repo)
+    repo.exporter.export_repo(repo.gitdir)
+
+
+def do_export(repo, args):
+    """Imports a fast-import stream from git to testgit.
+    """
+
+    if not repo.gitdir:
+        die("Need gitdir to export")
+
+    dirname = repo.get_base_path(repo.gitdir)
+
+    if not os.path.exists(dirname):
+        os.makedirs(dirname)
+
+    path = os.path.join(dirname, 'testgit.marks')
+    print path
+    print path if os.path.exists(path) else ""
+    sys.stdout.flush()
+
+    update_local_repo(repo)
+    repo.importer.do_import(repo.gitdir)
+    repo.non_local.push(repo.gitdir)
+
+
+def do_gitdir(repo, args):
+    """Stores the location of the gitdir.
+    """
+
+    if not args:
+        die("gitdir needs an argument")
+
+    repo.gitdir = ' '.join(args)
+
+
+COMMANDS = {
+    'capabilities': do_capabilities,
+    'list': do_list,
+    'import': do_import,
+    'export': do_export,
+    'gitdir': do_gitdir,
+}
+
+
+def sanitize(value):
+    """Cleans up the url.
+    """
+
+    if value.startswith('testgit::'):
+        value = value[9:]
+
+    return value
+
+
+def read_one_line(repo):
+    """Reads and processes one command.
+    """
+
+    line = sys.stdin.readline()
+
+    cmdline = line
+
+    if not cmdline:
+        warn("Unexpected EOF")
+        return False
+
+    cmdline = cmdline.strip().split()
+    if not cmdline:
+        # Blank line means we're about to quit
+        return False
+
+    cmd = cmdline.pop(0)
+    debug("Got command '%s' with args '%s'", cmd, ' '.join(cmdline))
+
+    if cmd not in COMMANDS:
+        die("Unknown command, %s", cmd)
+
+    func = COMMANDS[cmd]
+    func(repo, cmdline)
+    sys.stdout.flush()
+
+    return True
+
+
+def main(args):
+    """Starts a new remote helper for the specified repository.
+    """
+
+    if len(args) != 3:
+        die("Expecting exactly three arguments.")
+        sys.exit(1)
+
+    if os.getenv("GIT_DEBUG_TESTGIT"):
+        import git_remote_helpers.util
+        git_remote_helpers.util.DEBUG = True
+
+    alias = sanitize(args[1])
+    url = sanitize(args[2])
+
+    if not alias.isalnum():
+        warn("non-alnum alias '%s'", alias)
+        alias = "tmp"
+
+    args[1] = alias
+    args[2] = url
+
+    repo = get_repo(alias, url)
+
+    debug("Got arguments %s", args[1:])
+
+    more = True
+
+    while (more):
+        more = read_one_line(repo)
+
+if __name__ == '__main__':
+    sys.exit(main(sys.argv))
diff --git a/git_remote_helpers/git/exporter.py b/git_remote_helpers/git/exporter.py
new file mode 100644
index 0000000..dfaab00
--- /dev/null
+++ b/git_remote_helpers/git/exporter.py
@@ -0,0 +1,51 @@
+import os
+import subprocess
+import sys
+
+
+class GitExporter(object):
+    """An exporter for testgit repositories.
+
+    The exporter simply delegates to git fast-export.
+    """
+
+    def __init__(self, repo):
+        """Creates a new exporter for the specified repo.
+        """
+
+        self.repo = repo
+
+    def export_repo(self, base):
+        """Exports a fast-export stream for the given directory.
+
+        Simply delegates to git fast-epxort and pipes it through sed
+        to make the refs show up under the prefix rather than the
+        default refs/heads. This is to demonstrate how the export
+        data can be stored under it's own ref (using the refspec
+        capability).
+        """
+
+        dirname = self.repo.get_base_path(base)
+        path = os.path.abspath(os.path.join(dirname, 'testgit.marks'))
+
+        if not os.path.exists(dirname):
+            os.makedirs(dirname)
+
+        print "feature relative-marks"
+        if os.path.exists(os.path.join(dirname, 'git.marks')):
+            print "feature import-marks=%s/git.marks" % self.repo.hash
+        print "feature export-marks=%s/git.marks" % self.repo.hash
+        sys.stdout.flush()
+
+        args = ["git", "--git-dir=" + self.repo.gitpath, "fast-export", "--export-marks=" + path]
+
+        if os.path.exists(path):
+            args.append("--import-marks=" + path)
+
+        args.append("HEAD")
+
+        p1 = subprocess.Popen(args, stdout=subprocess.PIPE)
+
+        args = ["sed", "s_refs/heads/_" + self.repo.prefix + "_g"]
+
+        subprocess.check_call(args, stdin=p1.stdout)
diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
new file mode 100644
index 0000000..af2919d
--- /dev/null
+++ b/git_remote_helpers/git/importer.py
@@ -0,0 +1,38 @@
+import os
+import subprocess
+
+
+class GitImporter(object):
+    """An importer for testgit repositories.
+
+    This importer simply delegates to git fast-import.
+    """
+
+    def __init__(self, repo):
+        """Creates a new importer for the specified repo.
+        """
+
+        self.repo = repo
+
+    def do_import(self, base):
+        """Imports a fast-import stream to the given directory.
+
+        Simply delegates to git fast-import.
+        """
+
+        dirname = self.repo.get_base_path(base)
+        if self.repo.local:
+            gitdir = self.repo.gitpath
+        else:
+            gitdir = os.path.abspath(os.path.join(dirname, '.git'))
+        path = os.path.abspath(os.path.join(dirname, 'git.marks'))
+
+        if not os.path.exists(dirname):
+            os.makedirs(dirname)
+
+        args = ["git", "--git-dir=" + gitdir, "fast-import", "--quiet", "--export-marks=" + path]
+
+        if os.path.exists(path):
+            args.append("--import-marks=" + path)
+
+        subprocess.check_call(args)
diff --git a/git_remote_helpers/git/non_local.py b/git_remote_helpers/git/non_local.py
new file mode 100644
index 0000000..d75ef8f
--- /dev/null
+++ b/git_remote_helpers/git/non_local.py
@@ -0,0 +1,61 @@
+import os
+import subprocess
+
+from git_remote_helpers.util import die, warn
+
+
+class NonLocalGit(object):
+    """Handler to interact with non-local repos.
+    """
+
+    def __init__(self, repo):
+        """Creates a new non-local handler for the specified repo.
+        """
+
+        self.repo = repo
+
+    def clone(self, base):
+        """Clones the non-local repo to base.
+
+        Does nothing if a clone already exists.
+        """
+
+        path = os.path.join(self.repo.get_base_path(base), '.git')
+
+        # already cloned
+        if os.path.exists(path):
+            return path
+
+        os.makedirs(path)
+        args = ["git", "clone", "--bare", "--quiet", self.repo.gitpath, path]
+
+        subprocess.check_call(args)
+
+        return path
+
+    def update(self, base):
+        """Updates checkout of the non-local repo in base.
+        """
+
+        path = os.path.join(self.repo.get_base_path(base), '.git')
+
+        if not os.path.exists(path):
+            die("could not find repo at %s", path)
+
+        args = ["git", "--git-dir=" + path, "fetch", "--quiet", self.repo.gitpath]
+        subprocess.check_call(args)
+
+        args = ["git", "--git-dir=" + path, "update-ref", "refs/heads/master", "FETCH_HEAD"]
+        subprocess.check_call(args)
+
+    def push(self, base):
+        """Pushes from the non-local repo to base.
+        """
+
+        path = os.path.join(self.repo.get_base_path(base), '.git')
+
+        if not os.path.exists(path):
+            die("could not find repo at %s", path)
+
+        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath]
+        subprocess.check_call(args)
diff --git a/git_remote_helpers/git/repo.py b/git_remote_helpers/git/repo.py
new file mode 100644
index 0000000..82d5f78
--- /dev/null
+++ b/git_remote_helpers/git/repo.py
@@ -0,0 +1,70 @@
+import os
+import subprocess
+
+def sanitize(rev, sep='\t'):
+    """Converts a for-each-ref line to a name/value pair.
+    """
+
+    splitrev = rev.split(sep)
+    branchval = splitrev[0]
+    branchname = splitrev[1].strip()
+    if branchname.startswith("refs/heads/"):
+        branchname = branchname[11:]
+
+    return branchname, branchval
+
+def is_remote(url):
+    """Checks whether the specified value is a remote url.
+    """
+
+    prefixes = ["http", "file", "git"]
+
+    return any(url.startswith(i) for i in prefixes)
+
+class GitRepo(object):
+    """Repo object representing a repo.
+    """
+
+    def __init__(self, path):
+        """Initializes a new repo at the given path.
+        """
+
+        self.path = path
+        self.head = None
+        self.revmap = {}
+        self.local = not is_remote(self.path)
+
+        if(self.path.endswith('.git')):
+            self.gitpath = self.path
+        else:
+            self.gitpath = os.path.join(self.path, '.git')
+
+        if self.local and not os.path.exists(self.gitpath):
+            os.makedirs(self.gitpath)
+
+    def get_revs(self):
+        """Fetches all revs from the remote.
+        """
+
+        args = ["git", "ls-remote", self.gitpath]
+        path = ".cached_revs"
+        ofile = open(path, "w")
+
+        subprocess.check_call(args, stdout=ofile)
+        output = open(path).readlines()
+        self.revmap = dict(sanitize(i) for i in output)
+        if "HEAD" in self.revmap:
+            del self.revmap["HEAD"]
+        self.revs = self.revmap.keys()
+        ofile.close()
+
+    def get_head(self):
+        """Determines the head of a local repo.
+        """
+
+        if not self.local:
+            return
+
+        path = os.path.join(self.gitpath, "HEAD")
+        head = open(path).readline()
+        self.head, _ = sanitize(head, ' ')
-- 
1.7.0.3.317.gbb04ec
