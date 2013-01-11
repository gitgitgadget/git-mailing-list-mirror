From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Thu, 10 Jan 2013 19:32:32 -0800
Message-ID: <1357875152-19899-1-git-send-email-gitster@pobox.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 04:33:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtVMY-0003hx-3J
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 04:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab3AKDci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 22:32:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab3AKDcg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 22:32:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 029CBABBF;
	Thu, 10 Jan 2013 22:32:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=G8U0ZqOQYPCsbMWajgHH93vI/Vk
	=; b=LeCLss+JhITK2pSesaZHmVIedjtsx4wLaZIA+P4azfwM2eqwMdyiM88UTLx
	nopy5DYyUSwfsPprDa3O5/dakPQfWJUxCXiZEWGviSapE6Rn3qEmVFgi2o2ZxAJR
	iuS9yvrIfHN7UVuq2WO7wQcjICvWvQTawOQhiz8aS0Xda5Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=so5CrIVHQQjRWR6JWzMvl
	U+yW9CdZlI7jArjY6bVvfV4IAzX2YR4acS8EUPCLeDCfQfNJZ052zvZfBDM+aqqN
	wDRuGNB2LC+xxv48v7+0xnyxZZgh0MJMC7OmTp0RWhUjhZ8JeXRoXo44w3e+BJ9l
	Xuuw8zcu+z1dkgpeiHQlQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E652FABBE;
	Thu, 10 Jan 2013 22:32:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9865ABBB; Thu, 10 Jan 2013
 22:32:33 -0500 (EST)
X-Mailer: git-send-email 1.8.1.407.g59f98af
X-Pobox-Relay-ID: 895C95A0-5B9F-11E2-BD49-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213170>

From: "Eric S. Raymond" <esr@thyrsus.com>

The combination of git-cvsimport and cvsps had serious problems.

Among these were:

 (1) Analysis of branchy repos was buggy in multiple ways in both
     programs, leading to incorrect repo translations.

 (2) Even after a correct branch analysis, extra (redundant) fileops
     would often be generated on the new-branch side.

 (3) Inability to report more than one tag pointing to the same revision.

 (4) Failure in certain cases of clock-skew reported by the t9603 test.

 (5) Failure to use commitids for changeset ordering in cases were this
     would have prevented clock skew from causing incorrect grouping.

Problems 2-5 and portions of problem 1 have been solved by a major
rewrite of cvsps (the 3.x release series); it now emits a git
fast-import stream.  Also, the buggy attempt at ancestry-branch
tracking previously invoked by -A has been replaced with a simpler and
better topo analysis.  cvsps is now about 20% smaller than formerly.

All this changed cvsps's interface enough to require a complete
rewrite of git-cvsimport (hence this patch). In the process the code
size of the wrapper script dropped by about x3 and it can now support
alternate conversion engines; the first new engine is cvs2git, with
parsecvs expected to follow shortly.

The old Perl git-cvsimport is moved to git-cvsimport-fallback; new
git-cvsimport will hand off to the fallback script when it detects
that the user has a pre-3.x cvsps.  The fallback is only there so that
people with simple enough repositories that can be correctly handled
by cvsps-2.x but without the bleeding-edge cvsps 3.x installed does
not have to be left without any cvsimport that works for them (with
the same bugs and all).  The fallback support will be removed after
cvsps 3.x and the rewritten cvsimport matures and gets widely
available.

This patch also removes Michael Haggerty's git-cvsimport tests
(t960[123]) from the git tree.  These are actually conversion-engine
tests and have been merged into a larger cvsps test suite, which I
intend to spin out into a general CVS-lifting test that can also be
applied to utilities such as cvs2git and parsecvs.  The t9604 test
will move in a future patch, when I likewise have it integrated
into the general test suite.

The following known bug has not been fixed: "If any files were ever
"cvs import"ed more than once (e.g., import of more than one vendor
release) the HEAD contains the wrong content." However, cvsps now
emits a warning in this case. There is also one pathological tagging
case that was successful in the former t9602 test that now fails
(with a warning).

I plan to address these problems. This patch at least gets the
cvsps-3.x/git-cvsimport combination to a state that is not too
broken to ship - that is, in all failure cases known to me it
now emits useful warnings rather than silently botching the
import.

Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This was (re)sent privately to me; the previous attempt by Eric
   somehow did not reach the list.  Let me see if I have better
   luck, as we really would want to be reviewing these patches.

   I rewrote one paragraph in the log about the fallback, though.
   For the record the original read like this:

     The old Perl git-cvsimport is moved to git-cvsimport-fallback; new
     git-cvsimport will hand off to the fallback script when it detects
     that the user has a pre-3.x cvsps.  I make no warranties that
     cvsps-2.x will actually work or do anything more useful than make
     demons fly out of your nose; the fallback is only there because Junio
     disliked the idea of a flag day, and should be removed after a decent
     interval.

   which I felt somewhat irresponsible to existing users.

 Makefile                                           |   3 +-
 git-cvsimport.perl => git-cvsimport-fallback.perl  |   8 +
 git-cvsimport.py                                   | 354 +++++++++++++++++++++
 t/t9601/cvsroot/.gitattributes                     |   1 -
 t/t9601/cvsroot/CVSROOT/.gitignore                 |   2 -
 t/t9601/cvsroot/module/added-imported.txt,v        |  44 ---
 t/t9601/cvsroot/module/imported-anonymously.txt,v  |  42 ---
 .../module/imported-modified-imported.txt,v        |  76 -----
 t/t9601/cvsroot/module/imported-modified.txt,v     |  59 ----
 t/t9601/cvsroot/module/imported-once.txt,v         |  43 ---
 t/t9601/cvsroot/module/imported-twice.txt,v        |  60 ----
 t/t9602/README                                     |  62 ----
 t/t9602/cvsroot/.gitattributes                     |   1 -
 t/t9602/cvsroot/CVSROOT/.gitignore                 |   2 -
 t/t9602/cvsroot/module/default,v                   | 102 ------
 t/t9602/cvsroot/module/sub1/default,v              | 102 ------
 t/t9602/cvsroot/module/sub1/subsubA/default,v      | 101 ------
 t/t9602/cvsroot/module/sub1/subsubB/default,v      | 107 -------
 .../module/sub2/Attic/branch_B_MIXED_only,v        |  59 ----
 t/t9602/cvsroot/module/sub2/default,v              | 102 ------
 t/t9602/cvsroot/module/sub2/subsubA/default,v      | 102 ------
 t/t9602/cvsroot/module/sub3/default,v              | 102 ------
 t/t9603/cvsroot/.gitattributes                     |   1 -
 t/t9603/cvsroot/CVSROOT/.gitignore                 |   2 -
 t/t9603/cvsroot/module/a,v                         |  74 -----
 t/t9603/cvsroot/module/b,v                         |  90 ------
 26 files changed, 364 insertions(+), 1337 deletions(-)
 rename git-cvsimport.perl => git-cvsimport-fallback.perl (98%)
 create mode 100755 git-cvsimport.py
 delete mode 100644 t/t9601/cvsroot/.gitattributes
 delete mode 100644 t/t9601/cvsroot/CVSROOT/.gitignore
 delete mode 100644 t/t9601/cvsroot/module/added-imported.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-anonymously.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-modified-imported.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-modified.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-once.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-twice.txt,v
 delete mode 100644 t/t9602/README
 delete mode 100644 t/t9602/cvsroot/.gitattributes
 delete mode 100644 t/t9602/cvsroot/CVSROOT/.gitignore
 delete mode 100644 t/t9602/cvsroot/module/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub1/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub1/subsubA/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub1/subsubB/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
 delete mode 100644 t/t9602/cvsroot/module/sub2/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub2/subsubA/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub3/default,v
 delete mode 100644 t/t9603/cvsroot/.gitattributes
 delete mode 100644 t/t9603/cvsroot/CVSROOT/.gitignore
 delete mode 100644 t/t9603/cvsroot/module/a,v
 delete mode 100644 t/t9603/cvsroot/module/b,v

diff --git a/Makefile b/Makefile
index 736ecd4..ca5d9e9 100644
--- a/Makefile
+++ b/Makefile
@@ -464,7 +464,7 @@ SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
-SCRIPT_PERL += git-cvsimport.perl
+SCRIPT_PERL += git-cvsimport-fallback.perl
 SCRIPT_PERL += git-cvsserver.perl
 SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
@@ -472,6 +472,7 @@ SCRIPT_PERL += git-svn.perl
 
 SCRIPT_PYTHON += git-remote-testgit.py
 SCRIPT_PYTHON += git-p4.py
+SCRIPT_PYTHON += git-cvsimport.py
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
diff --git a/git-cvsimport.perl b/git-cvsimport-fallback.perl
similarity index 98%
rename from git-cvsimport.perl
rename to git-cvsimport-fallback.perl
index 0a31ebd..4bc0717 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport-fallback.perl
@@ -1,4 +1,8 @@
 #!/usr/bin/perl
+# This code became obsolete in January 2013, and is retained only as a
+# fallback from git-cvsimport.py for users who have only cvsps-2.x.
+# It (and the code in cvsimport.py that calls it) should be removed
+# once the 3.x version has had a reasonable time to propagate.
 
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
@@ -27,6 +31,10 @@
 use POSIX qw(strftime tzset dup2 ENOENT);
 use IPC::Open2;
 
+print(STDERR "You do not appear to have cvsps 3.x.\n");
+print(STDERR "Falling back to unmaintained Perl cvsimport for cvsps 2.x.\n");
+print(STDERR "Upgrade your cvsps for best results.\n");
+
 $SIG{'PIPE'}="IGNORE";
 set_timezone('UTC');
 
diff --git a/git-cvsimport.py b/git-cvsimport.py
new file mode 100755
index 0000000..129471e
--- /dev/null
+++ b/git-cvsimport.py
@@ -0,0 +1,354 @@
+#!/usr/bin/env python
+#
+# Import CVS history into git
+#
+# Intended to be a near-workalike of Matthias Urlichs's Perl implementation.
+#
+# By Eric S. Raymond <esr@thyrsus.com>, December 2012
+# May be redistributed under the license of the git project.
+
+import sys
+
+if sys.hexversion < 0x02060000:
+    sys.stderr.write("git cvsimport: requires Python 2.6 or later.\n")
+    sys.exit(1)
+
+import os, getopt, subprocess, tempfile, shutil
+
+DEBUG_COMMANDS = 1
+
+class Fatal(Exception):
+    "Unrecoverable error."
+    def __init__(self, msg):
+        Exception.__init__(self)
+        self.msg = msg
+
+def do_or_die(dcmd, legend=""):
+    "Either execute a command or raise a fatal exception."
+    if legend:
+        legend = " "  + legend
+    if verbose >= DEBUG_COMMANDS:
+        sys.stdout.write("git cvsimport: executing '%s'%s\n" % (dcmd, legend))
+    try:
+        retcode = subprocess.call(dcmd, shell=True)
+        if retcode < 0:
+            raise Fatal("git cvsimport: child was terminated by signal %d." % -retcode)
+        elif retcode != 0:
+            raise Fatal("git cvsimport: child returned %d." % retcode)
+    except (OSError, IOError) as e:
+        raise Fatal("git cvsimport: execution of %s%s failed: %s" % (dcmd, legend, e))
+
+def capture_or_die(dcmd, legend=""):
+    "Either execute a command and capture its output or die."
+    if legend:
+        legend = " "  + legend
+    if verbose >= DEBUG_COMMANDS:
+        sys.stdout.write("git cvsimport: executing '%s'%s\n" % (dcmd, legend))
+    try:
+        return subprocess.check_output(dcmd, shell=True)
+    except subprocess.CalledProcessError as e:
+        if e.returncode < 0:
+            sys.stderr.write("git cvsimport: child was terminated by signal %d." % -e.returncode)
+        elif e.returncode != 0:
+            sys.stderr.write("git cvsimport: child returned %d." % e.returncode)
+        sys.exit(1)
+
+class cvsps:
+    "Method class for cvsps back end."
+    def __init__(self):
+        self.opts = ""
+        self.revmap = None
+    def set_repo(self, val):
+        "Set the repository root option."
+        if not val.startswith(":"):
+            if not val.startswith(os.sep):
+                val = os.path.abspath(val)
+            val = ":local:" + val
+        self.opts += " --root '%s'" % val
+    def set_authormap(self, val):
+        "Set the author-map file."
+        self.opts += " -A '%s'" % val
+    def set_fuzz(self, val):
+        "Set the commit-similarity window."
+        self.opts += " -z %s" % val
+    def set_nokeywords(self):
+        "Suppress CVS keyword expansion."
+        self.opts += " -k"
+    def add_opts(self, val):
+        "Add options to the engine command line."
+        self.opts += " " + val
+    def set_exclusion(self, val):
+        "Set a file exclusion regexp."
+        self.opts += " -n -f '%s'" % val
+    def set_after(self, val):
+        "Set a date threshold for incremental import."
+        self.opts += " -d '%s'" % val
+    def set_revmap(self, val):
+        "Set the file to which the engine should dump a reference map."
+        self.revmap = val
+        self.opts += " -R '%s'" % self.revmap
+    def set_module(self, val):
+        "Set the module to query."
+        self.opts += " " + val
+    def command(self):
+        "Emit the command implied by all previous options."
+        return "cvsps --fast-export " + self.opts
+
+class cvs2git:
+    "Method class for cvs2git back end."
+    def __init__(self):
+        self.opts = ""
+        self.modulepath = "."
+    def set_authormap(self, _val):
+        "Set the author-map file."
+        sys.stderr.write("git cvsimport: author maping is not supported with cvs2git.\n")
+        sys.exit(1)
+    def set_repo(self, _val):
+        "Set the repository root option."
+        sys.stderr.write("git cvsimport: cvs2git must run within a repository checkout directory.\n")
+        sys.exit(1)
+    def set_fuzz(self, _val):
+        "Set the commit-similarity window."
+        sys.stderr.write("git cvsimport: fuzz setting is not supported with cvs2git.\n")
+        sys.exit(1)
+    def set_nokeywords(self):
+        "Suppress CVS keyword expansion."
+        self.opts += " --keywords-off"
+    def add_opts(self, val):
+        "Add options to the engine command line."
+        self.opts += " " + val
+    def set_exclusion(self, val):
+        "Set a file exclusion regexp."
+        self.opts += " --exclude='%s'" % val
+    def set_after(self, _val):
+        "Set a date threshold for incremental import."
+        sys.stderr.write("git cvsimport: incremental import is not supported with cvs2git.\n")
+        sys.exit(1)
+    def set_revmap(self, _val):
+        "Set the file to which the engine should dump a reference map."
+        sys.stderr.write("git cvsimport: can't get a reference map from cvs2git.\n")
+        sys.exit(1)
+    def set_module(self, val):
+        "Set the module to query."
+        self.modulepath = " " + val
+    def command(self):
+        "Emit the command implied by all previous options."
+        return "(cvs2git --username=git-cvsimport --quiet --quiet --blobfile={0} --dumpfile={1} {2} {3} && cat {0} {1} && rm {0} {1})".format(tempfile.mkstemp()[1], tempfile.mkstemp()[1], self.opts, self.modulepath)
+
+class filesource:
+    "Method class for file-source back end."
+    def __init__(self, filename):
+        self.filename = filename
+    def __complain(self, legend):
+        sys.stderr.write("git cvsimport: %s with file source.\n" % legend)
+        sys.exit(1)
+    def set_repo(self, _val):
+        "Set the repository root option."
+        self.__complain("repository can't be set")
+    def set_authormap(self, _val):
+        "Set the author-map file."
+        sys.stderr.write("git cvsimport: author mapping is not supported with filesource.\n")
+        sys.exit(1)
+    def set_fuzz(self, _val):
+        "Set the commit-similarity window."
+        self.__complain("fuzz can't be set")
+    def set_nokeywords(self, _val):
+        "Suppress CVS keyword expansion."
+        self.__complain("keyword suppression can't be set")
+    def add_opts(self, _val):
+        "Add options to the engine command line."
+        self.__complain("other options can't be set")
+    def set_exclusion(self, _val):
+        "Set a file exclusion regexp."
+        self.__complain("exclusions can't be set")
+    def set_after(self, _val):
+        "Set a date threshold for incremental import."
+        pass
+    def set_revmap(self, _val):
+        "Set the file to which the engine should dump a reference map."
+        sys.stderr.write("git cvsimport: can't get a reference map from cvs2git.\n")
+        sys.exit(1)
+    def set_module(self, _val):
+        "Set the module to query."
+        self.__complain("module can't be set")
+    def command(self):
+        "Emit the command implied by all previous options."
+        return "cat " + self.filename
+
+if __name__ == '__main__':
+    if sys.hexversion < 0x02060000:
+        sys.stderr.write("git cvsimport: requires Python 2.6 or later.\n")
+        sys.exit(1)
+    (options, arguments) = getopt.getopt(sys.argv[1:], "vbe:d:C:r:o:ikus:p:z:P:S:aL:A:Rh")
+    verbose = 0
+    bare = False
+    root = None
+    outdir = os.getcwd()
+    remotize = False
+    import_only = False
+    underscore_to_dot = False
+    slashsubst = None
+    authormap = None
+    revisionmap = False
+    backend = cvsps()
+    for (opt, val) in options:
+        if opt == '-v':
+            verbose += 1
+        elif opt == '-b':
+            bare = True
+        elif opt == '-e':
+            for cls in (cvsps, cvs2git):
+                if cls.__name__ == val:
+                    backend = cls()
+                    break
+            else:
+                sys.stderr.write("git cvsimport: unknown engine %s.\n" % val)
+                sys.exit(1)
+        elif opt == '-d':
+            backend.set_repo(val)
+        elif opt == '-C':
+            outdir = val
+        elif opt == '-r':
+            remotize = True
+        elif opt == '-o':
+            sys.stderr.write("git cvsimport: -o is no longer supported.\n")
+            sys.exit(1)
+        elif opt == '-i':
+            import_only = True
+        elif opt == '-k':
+            backend.set_nokeywords()
+        elif opt == '-u':
+            underscore_to_dot = True
+        elif opt == '-s':
+            slashsubst = val
+        elif opt == '-p':
+            backend.add_opts(val.replace(",", " "))
+        elif opt == '-z':
+            backend.set_fuzz(val)
+        elif opt == '-P':
+            backend = filesource(val)
+            sys.exit(1)
+        elif opt in ('-m', '-M'):
+            sys.stderr.write("git cvsimport: -m and -M are no longer supported: use reposurgeon instead.\n")
+            sys.exit(1)
+        elif opt == '-S':
+            backend.set_exclusion(val)
+        elif opt == '-a':
+            sys.stderr.write("git cvsimport: -a is no longer supported.\n")
+            sys.exit(1)
+        elif opt == '-L':
+            sys.stderr.write("git cvsimport: -L is no longer supported.\n")
+            sys.exit(1)
+        elif opt == '-A':
+            authormap = os.path.abspath(val)
+        elif opt == '-R':
+            revisionmap = True
+        else:
+            print """\
+git cvsimport [-A <author-conv-file>] [-C <git_repository>] [-b] [-d <CVSROOT>]
+     [-e engine] [-h] [-i] [-k] [-p <options-for-cvsps>] [-P <source-file>]
+     [-r <remote>] [-R] [-s <subst>] [-S <regex>] [-u] [-v] [-z <fuzz>]
+     [<CVS_module>]
+"""
+    def metadata(fn, outdir='.'):
+        if bare:
+            return os.path.join(outdir, fn)
+        else:
+            return os.path.join(outdir, ".git", fn)
+    # Ugly fallback code for people with only cvsps-2.x
+    # Added January 2013 - should be removed after a decent interval.
+    if backend.__class__.__name__ == "cvsps":
+        try:
+            subprocess.check_output("cvsps -V 2>/dev/null", shell=True)
+        except subprocess.CalledProcessError as e:
+            if e.returncode == 1:
+                sys.stderr.write("cvsimport: falling back to old version...\n")
+                sys.exit(os.system("git-cvsimport-fallback " + " ".join(sys.argv[1:])))
+            else:
+                sys.stderr.write("cvsimport: cannot execute cvsps.\n")
+                sys.exit(1)
+    # Real mainline code begins here
+    try:
+        if outdir:
+            try:
+                # If the output directory does not exist, create it
+                # and initialize it as a git repository.
+                os.mkdir(outdir)
+                do_or_die("git init --quiet " + outdir)
+            except OSError:
+                # Otherwise, assume user wants incremental import.
+                if not bare and not os.path.exists(os.path.join(outdir, ".git")):
+                    raise Fatal("output directory is not a git repository")
+                threshold = capture_or_die("git log -1 --format=%ct").strip()
+                backend.set_after(threshold)
+        if revisionmap:
+            backend.set_revmap(tempfile.mkstemp()[1])
+            markmap = tempfile.mkstemp()[1]
+        if arguments:
+            backend.set_module(arguments[0])
+        gitopts = ""
+        if bare:
+            gitopts += " --bare"
+        if revisionmap:
+            gitopts += " --export-marks='%s'" % markmap
+        if authormap:
+            shutil.copyfile(authormap, metadata("cvs-authors", outdir))
+        if os.path.exists(metadata("cvs-authors", outdir)):
+            backend.set_authormap(metadata("cvs-authors", outdir))
+        do_or_die("%s | (cd %s >/dev/null; git fast-import --quiet %s)" \
+                  % (backend.command(), outdir, gitopts))
+        os.chdir(outdir)
+        if underscore_to_dot or slashsubst:
+            tagnames = capture_or_die("git tag -l")
+            for tag in tagnames.split():
+                if tag:
+                    changed = tag
+                    if underscore_to_dot:
+                        changed = changed.replace("_", ".")
+                    if slashsubst:
+                        changed = changed.replace(os.sep, slashsubst)
+                    if changed != tag:
+                        do_or_die("git tag -f %s %s >/dev/null" % (tag, changed))
+        if underscore_to_dot or slashsubst or remotize:
+            branchnames = capture_or_die("git branch -l")
+            for branch in branchnames.split():
+                if branch:
+                    # Ugh - fragile dependency on branch -l output format
+                    branch = branch[2:]
+                    changed = branch
+                    if underscore_to_dot:
+                        changed = changed.replace("_", ".")
+                    if slashsubst:
+                        changed = changed.replace(os.sep, slashsubst)
+                    if remotize:
+                        changed = os.path.join("remotes", remotize, branch)
+                    if changed != branch:
+                        do_or_die("branch --m %s %s >/dev/null" % (branch, changed))
+        if revisionmap:
+            refd = {}
+            for line in open(backend.revmap):
+                if line.startswith("#"):
+                    continue
+                (fn, rev, mark) = line.split()
+                refd[(fn, rev)] = mark
+            markd = {}
+            for line in open(markmap):
+                if line.startswith("#"):
+                    continue
+                (mark, hashd) = line.split()
+                markd[mark] = hashd
+            with open(metadata("cvs-revisions"), "a") as wfp:
+                for ((fn, rev), val) in refd.items():
+                    if val in markd:
+                        wfp.write("%s %s %s\n" % (fn, rev, markd[val]))
+            os.remove(markmap)
+            os.remove(backend.revmap)
+        if not import_only and not bare:
+            do_or_die("git checkout -q")
+    except Fatal, err:
+        sys.stderr.write("git_cvsimport: " + err.msg + "\n")
+        sys.exit(1)
+    except KeyboardInterrupt:
+        pass
+
+# end
diff --git a/t/t9601/cvsroot/.gitattributes b/t/t9601/cvsroot/.gitattributes
deleted file mode 100644
index 562b12e..0000000
--- a/t/t9601/cvsroot/.gitattributes
+++ /dev/null
@@ -1 +0,0 @@
-* -whitespace
diff --git a/t/t9601/cvsroot/CVSROOT/.gitignore b/t/t9601/cvsroot/CVSROOT/.gitignore
deleted file mode 100644
index 3bb9b34..0000000
--- a/t/t9601/cvsroot/CVSROOT/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-history
-val-tags
diff --git a/t/t9601/cvsroot/module/added-imported.txt,v b/t/t9601/cvsroot/module/added-imported.txt,v
deleted file mode 100644
index 5f83072..0000000
--- a/t/t9601/cvsroot/module/added-imported.txt,v
+++ /dev/null
@@ -1,44 +0,0 @@
-head	1.1;
-access;
-symbols
-	vtag-4:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2004.02.09.15.43.15;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.16;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@Add a file to the working copy.
-@
-text
-@Adding this file, before importing it with different contents.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-4).
-@
-text
-@d1 1
-a1 1
-This is vtag-4 (on vbranchA) of added-then-imported.txt.
-@
-
diff --git a/t/t9601/cvsroot/module/imported-anonymously.txt,v b/t/t9601/cvsroot/module/imported-anonymously.txt,v
deleted file mode 100644
index 55e1b0c..0000000
--- a/t/t9601/cvsroot/module/imported-anonymously.txt,v
+++ /dev/null
@@ -1,42 +0,0 @@
-head	1.1;
-branch	1.1.1;
-access;
-symbols
-	vtag-1:1.1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@This is vtag-1 (on vbranchA) of imported-anonymously.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
diff --git a/t/t9601/cvsroot/module/imported-modified-imported.txt,v b/t/t9601/cvsroot/module/imported-modified-imported.txt,v
deleted file mode 100644
index e5830ae..0000000
--- a/t/t9601/cvsroot/module/imported-modified-imported.txt,v
+++ /dev/null
@@ -1,76 +0,0 @@
-head	1.2;
-access;
-symbols
-	vtag-2:1.1.1.2
-	vtag-1:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2004.02.09.15.43.14;	author kfogel;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	1.1.1.2;
-
-1.1.1.2
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@First regular commit, to imported-modified-imported.txt, on HEAD.
-@
-text
-@This is a modification of imported-modified-imported.txt on HEAD.
-It should supersede the version from the vendor branch.
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d1 2
-a2 1
-This is vtag-1 (on vbranchA) of imported-modified-imported.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
-1.1.1.2
-log
-@Import (vbranchA, vtag-2).
-@
-text
-@d1 1
-a1 1
-This is vtag-2 (on vbranchA) of imported-modified-imported.txt.
-@
-
-
diff --git a/t/t9601/cvsroot/module/imported-modified.txt,v b/t/t9601/cvsroot/module/imported-modified.txt,v
deleted file mode 100644
index bbcfe44..0000000
--- a/t/t9601/cvsroot/module/imported-modified.txt,v
+++ /dev/null
@@ -1,59 +0,0 @@
-head	1.2;
-access;
-symbols
-	vtag-1:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2004.02.09.15.43.14;	author kfogel;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Commit on HEAD.
-@
-text
-@This is a modification of imported-modified.txt on HEAD.
-It should supersede the version from the vendor branch.
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d1 2
-a2 1
-This is vtag-1 (on vbranchA) of imported-modified.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
diff --git a/t/t9601/cvsroot/module/imported-once.txt,v b/t/t9601/cvsroot/module/imported-once.txt,v
deleted file mode 100644
index c5dd82b..0000000
--- a/t/t9601/cvsroot/module/imported-once.txt,v
+++ /dev/null
@@ -1,43 +0,0 @@
-head	1.1;
-branch	1.1.1;
-access;
-symbols
-	vtag-1:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@This is vtag-1 (on vbranchA) of imported-once.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
diff --git a/t/t9601/cvsroot/module/imported-twice.txt,v b/t/t9601/cvsroot/module/imported-twice.txt,v
deleted file mode 100644
index d1f3f1b..0000000
--- a/t/t9601/cvsroot/module/imported-twice.txt,v
+++ /dev/null
@@ -1,60 +0,0 @@
-head	1.1;
-branch	1.1.1;
-access;
-symbols
-	vtag-2:1.1.1.2
-	vtag-1:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	1.1.1.2;
-
-1.1.1.2
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@This is vtag-1 (on vbranchA) of imported-twice.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
-1.1.1.2
-log
-@Import (vbranchA, vtag-2).
-@
-text
-@d1 1
-a1 1
-This is vtag-2 (on vbranchA) of imported-twice.txt.
-@
-
-
diff --git a/t/t9602/README b/t/t9602/README
deleted file mode 100644
index c231e0f..0000000
--- a/t/t9602/README
+++ /dev/null
@@ -1,62 +0,0 @@
-This repository is for testing the ability to group revisions
-correctly along tags and branches.  Here is its history:
-
-  1.  The initial import (revision 1.1 of everybody) created a
-      directory structure with a file named `default' in each dir:
-
-            ./
-              default
-              sub1/default
-                   subsubA/default
-                   subsubB/default
-              sub2/default
-                   subsubA/default
-              sub3/default
-
-  2.  Then tagged everyone with T_ALL_INITIAL_FILES.
-
-  3.  Then tagged everyone except sub1/subsubB/default with
-      T_ALL_INITIAL_FILES_BUT_ONE.
-
-  4.  Then created branch B_FROM_INITIALS on everyone.
-
-  5.  Then created branch B_FROM_INITIALS_BUT_ONE on everyone except
-      /sub1/subsubB/default.
-
-  6.  Then committed modifications to two files: sub3/default, and
-      sub1/subsubA/default.
-
-  7.  Then committed a modification to all 7 files.
-
-  8.  Then backdated sub3/default to revision 1.2, and
-      sub2/subsubA/default to revision 1.1, and tagged with T_MIXED.
-
-  9.  Same as 8, but tagged with -b to create branch B_MIXED.
-
-  10. Switched the working copy to B_MIXED, and added
-      sub2/branch_B_MIXED_only.  (That's why the RCS file is in
-      sub2/Attic/ -- it never existed on trunk.)
-
-  11. In one commit, modified default, sub1/default, and
-      sub2/subsubA/default, on branch B_MIXED.
-
-  12. Did "cvs up -A" on sub2/default, then in one commit, made a
-      change to sub2/default and sub2/branch_B_MIXED_only.  So this
-      commit should be spread between the branch and the trunk.
-
-  13. Do "cvs up -A" to get everyone back to trunk, then make a new
-      branch B_SPLIT on everyone except sub1/subsubB/default,v.
-
-  14. Switch to branch B_SPLIT (see sub1/subsubB/default disappear)
-      and commit a change that affects everyone except sub3/default.
-
-  15. An hour or so later, "cvs up -A" to get sub1/subsubB/default
-      back, then commit a change on that file, on trunk.  (It's
-      important that this change happened after the previous commits
-      on B_SPLIT.)
-
-  16. Branch sub1/subsubB/default to B_SPLIT, then "cvs up -r B_SPLIT"
-      to switch the whole working copy to the branch.
-
-  17. Commit a change on B_SPLIT, to sub1/subsubB/default and
-      sub3/default.
diff --git a/t/t9602/cvsroot/.gitattributes b/t/t9602/cvsroot/.gitattributes
deleted file mode 100644
index 562b12e..0000000
--- a/t/t9602/cvsroot/.gitattributes
+++ /dev/null
@@ -1 +0,0 @@
-* -whitespace
diff --git a/t/t9602/cvsroot/CVSROOT/.gitignore b/t/t9602/cvsroot/CVSROOT/.gitignore
deleted file mode 100644
index 3bb9b34..0000000
--- a/t/t9602/cvsroot/CVSROOT/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-history
-val-tags
diff --git a/t/t9602/cvsroot/module/default,v b/t/t9602/cvsroot/module/default,v
deleted file mode 100644
index 3b68382..0000000
--- a/t/t9602/cvsroot/module/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.2;
-access;
-symbols
-	B_SPLIT:1.2.0.4
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.2.2.1
-	1.2.4.1;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2003.05.23.00.31.36;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.4.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is the file `default' in the top level of the project.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.2.4.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a5 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.2.2.1
-log
-@Modify three files, on branch B_MIXED.
-@
-text
-@a5 2
-
-This line was added on branch B_MIXED only (affecting 3 files).
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub1/default,v b/t/t9602/cvsroot/module/sub1/default,v
deleted file mode 100644
index b7fdccd..0000000
--- a/t/t9602/cvsroot/module/sub1/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.2;
-access;
-symbols
-	B_SPLIT:1.2.0.4
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.2.2.1
-	1.2.4.1;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2003.05.23.00.31.36;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.4.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is sub1/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.2.4.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a5 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.2.2.1
-log
-@Modify three files, on branch B_MIXED.
-@
-text
-@a5 2
-
-This line was added on branch B_MIXED only (affecting 3 files).
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub1/subsubA/default,v b/t/t9602/cvsroot/module/sub1/subsubA/default,v
deleted file mode 100644
index 472b7b2..0000000
--- a/t/t9602/cvsroot/module/sub1/subsubA/default,v
+++ /dev/null
@@ -1,101 +0,0 @@
-head	1.3;
-access;
-symbols
-	B_SPLIT:1.3.0.4
-	B_MIXED:1.3.0.2
-	T_MIXED:1.3
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.3.4.1;
-next	1.2;
-
-1.2
-date	2003.05.23.00.15.26;	author jrandom;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.3.4.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is sub1/subsubA/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added by the first commit (affecting two files).
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.3.4.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a7 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.2
-log
-@First commit to proj, affecting two files.
-@
-text
-@d6 2
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub1/subsubB/default,v b/t/t9602/cvsroot/module/sub1/subsubB/default,v
deleted file mode 100644
index fe6efa4..0000000
--- a/t/t9602/cvsroot/module/sub1/subsubB/default,v
+++ /dev/null
@@ -1,107 +0,0 @@
-head	1.3;
-access;
-symbols
-	B_SPLIT:1.3.0.2
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2003.06.03.04.29.14;	author jrandom;	state Exp;
-branches
-	1.3.2.1;
-next	1.2;
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.3.2.1
-date	2003.06.03.04.33.13;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@A trunk change to sub1/subsubB/default.  This was committed about an
-hour after an earlier change that affected most files on branch
-B_SPLIT.  This file is not on that branch yet, but after this commit,
-we'll branch to B_SPLIT, albeit rooted in a revision that didn't exist
-at the time the rest of B_SPLIT was created.
-@
-text
-@This is sub1/subsubB/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-
-This bit was committed on trunk about an hour after an earlier change
-to everyone else on branch B_SPLIT.  Afterwards, we'll finally branch
-this file to B_SPLIT, but rooted in a revision that didn't exist at
-the time the rest of B_SPLIT was created.
-@
-
-
-1.3.2.1
-log
-@This change affects sub3/default and sub1/subsubB/default, on branch
-B_SPLIT.  Note that the latter file did not even exist on this branch
-until after some other files had had revisions committed on B_SPLIT.
-@
-text
-@a10 4
-
-This change affects sub3/default and sub1/subsubB/default, on branch
-B_SPLIT.  Note that the latter file did not even exist on this branch
-until after some other files had had revisions committed on B_SPLIT.
-@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@d6 5
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v b/t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
deleted file mode 100644
index 34c9789..0000000
--- a/t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
+++ /dev/null
@@ -1,59 +0,0 @@
-head	1.1;
-access;
-symbols
-	B_MIXED:1.1.0.2;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2003.05.23.00.25.26;	author jrandom;	state dead;
-branches
-	1.1.2.1;
-next	;
-
-1.1.2.1
-date	2003.05.23.00.25.26;	author jrandom;	state Exp;
-branches;
-next	1.1.2.2;
-
-1.1.2.2
-date	2003.05.23.00.48.51;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@file branch_B_MIXED_only was initially added on branch B_MIXED.
-@
-text
-@@
-
-
-1.1.2.1
-log
-@Add a file on branch B_MIXED.
-@
-text
-@a0 1
-This file was added on branch B_MIXED.  It never existed on trunk.
-@
-
-
-1.1.2.2
-log
-@A single commit affecting one file on branch B_MIXED and one on trunk.
-@
-text
-@a1 3
-
-The same commit added these two lines here on branch B_MIXED, and two
-similar lines to ./default on trunk.
-@
-
-
diff --git a/t/t9602/cvsroot/module/sub2/default,v b/t/t9602/cvsroot/module/sub2/default,v
deleted file mode 100644
index 018f7f8..0000000
--- a/t/t9602/cvsroot/module/sub2/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.3;
-access;
-symbols
-	B_SPLIT:1.3.0.2
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2003.05.23.00.48.51;	author jrandom;	state Exp;
-branches
-	1.3.2.1;
-next	1.2;
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.3.2.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@A single commit affecting one file on branch B_MIXED and one on trunk.
-@
-text
-@This is sub2/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-
-The same commit added these two lines here on trunk, and two similar
-lines to ./branch_B_MIXED_only on branch B_MIXED.
-@
-
-
-1.3.2.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a8 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@d6 3
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub2/subsubA/default,v b/t/t9602/cvsroot/module/sub2/subsubA/default,v
deleted file mode 100644
index d13242c..0000000
--- a/t/t9602/cvsroot/module/sub2/subsubA/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.2;
-access;
-symbols
-	B_SPLIT:1.2.0.2
-	B_MIXED:1.1.0.2
-	T_MIXED:1.1
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.2.2.1;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1
-	1.1.2.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.1.2.1
-date	2003.05.23.00.31.36;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is sub2/subsub2/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.2.2.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a5 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.2.1
-log
-@Modify three files, on branch B_MIXED.
-@
-text
-@a3 2
-
-This line was added on branch B_MIXED only (affecting 3 files).
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub3/default,v b/t/t9602/cvsroot/module/sub3/default,v
deleted file mode 100644
index 88e4567..0000000
--- a/t/t9602/cvsroot/module/sub3/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.3;
-access;
-symbols
-	B_SPLIT:1.3.0.2
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.3.2.1;
-next	1.2;
-
-1.2
-date	2003.05.23.00.15.26;	author jrandom;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.3.2.1
-date	2003.06.03.04.33.13;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is sub3/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added by the first commit (affecting two files).
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.3.2.1
-log
-@This change affects sub3/default and sub1/subsubB/default, on branch
-B_SPLIT.  Note that the latter file did not even exist on this branch
-until after some other files had had revisions committed on B_SPLIT.
-@
-text
-@a7 4
-
-This change affects sub3/default and sub1/subsubB/default, on branch
-B_SPLIT.  Note that the latter file did not even exist on this branch
-until after some other files had had revisions committed on B_SPLIT.
-@
-
-
-1.2
-log
-@First commit to proj, affecting two files.
-@
-text
-@d6 2
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9603/cvsroot/.gitattributes b/t/t9603/cvsroot/.gitattributes
deleted file mode 100644
index 562b12e..0000000
--- a/t/t9603/cvsroot/.gitattributes
+++ /dev/null
@@ -1 +0,0 @@
-* -whitespace
diff --git a/t/t9603/cvsroot/CVSROOT/.gitignore b/t/t9603/cvsroot/CVSROOT/.gitignore
deleted file mode 100644
index 3bb9b34..0000000
--- a/t/t9603/cvsroot/CVSROOT/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-history
-val-tags
diff --git a/t/t9603/cvsroot/module/a,v b/t/t9603/cvsroot/module/a,v
deleted file mode 100644
index ba8fd5a..0000000
--- a/t/t9603/cvsroot/module/a,v
+++ /dev/null
@@ -1,74 +0,0 @@
-head	1.2;
-access;
-symbols
-	A:1.2.0.2;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2009.02.21.18.11.14;	author tester;	state Exp;
-branches
-	1.2.2.1;
-next	1.1;
-
-1.1
-date	2009.02.21.18.11.43;	author tester;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2009.03.11.19.03.52;	author tester;	state Exp;
-branches;
-next	1.2.2.2;
-
-1.2.2.2
-date	2009.03.11.19.09.10;	author tester;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Rev 2
-@
-text
-@1.2
-@
-
-
-1.2.2.1
-log
-@Rev 4 Branch A
-@
-text
-@d1 1
-a1 1
-1.2.2.1
-@
-
-
-1.2.2.2
-log
-@Rev 5 Branch A
-@
-text
-@d1 1
-a1 1
-1.2.2.2
-@
-
-
-1.1
-log
-@Rev 1
-@
-text
-@d1 1
-a1 1
-1.1
-@
diff --git a/t/t9603/cvsroot/module/b,v b/t/t9603/cvsroot/module/b,v
deleted file mode 100644
index d268855..0000000
--- a/t/t9603/cvsroot/module/b,v
+++ /dev/null
@@ -1,90 +0,0 @@
-head	1.3;
-access;
-symbols
-	A:1.2.0.2;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2009.03.11.19.05.08;	author tester;	state Exp;
-branches;
-next	1.2;
-
-1.2
-date	2009.02.21.18.11.43;	author tester;	state Exp;
-branches
-	1.2.2.1;
-next	1.1;
-
-1.1
-date	2009.02.21.18.11.14;	author tester;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2009.03.11.19.03.52;	author tester;	state Exp;
-branches;
-next	1.2.2.2;
-
-1.2.2.2
-date	2009.03.11.19.09.10;	author tester;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@Rev 4
-@
-text
-@1.3
-@
-
-
-1.2
-log
-@Rev 3
-@
-text
-@d1 1
-a1 1
-1.2
-@
-
-
-1.2.2.1
-log
-@Rev 4 Branch A
-@
-text
-@d1 1
-a1 1
-1.2.2.1
-@
-
-
-1.2.2.2
-log
-@Rev 5 Branch A
-@
-text
-@d1 1
-a1 1
-1.2
-@
-
-
-1.1
-log
-@Rev 2
-@
-text
-@d1 1
-a1 1
-1.1
-@
-- 
1.8.1.407.g59f98af
