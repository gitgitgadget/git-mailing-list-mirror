From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] cvsimport: start adding cvsps 3.x support
Date: Sun, 13 Jan 2013 17:40:29 -0800
Message-ID: <1358127629-7500-4-git-send-email-gitster@pobox.com>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358127629-7500-1-git-send-email-gitster@pobox.com>
Cc: jrnieder@gmail.com, mhagger@alum.mit.edu, esr@thyrsus.com,
	chris@rorvick.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 02:41:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuZ32-00022v-Qb
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 02:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab3ANBks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 20:40:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755Ab3ANBkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 20:40:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A030BCBB;
	Sun, 13 Jan 2013 20:40:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0zP2
	/bXmZyFMMiRZrLxyVfxvhVw=; b=sGkYKqyKutnaCPNoSiMU7CPs6bqd5JwEtqcs
	xeAw62RhKTvmPxgYmQqKultnaqy8fcNaGWIaF+41uWDXvG5xY8islbOeSAi387mh
	+eYcRQ3NVBj0tNWbfduDVkuUGV3kI/SZVXxnywmRDHxNDgRxcjxeb+38AM3G7pOL
	1kT1JuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Jy2tDXK70ZTgrP9zvvPbalqvw6izj7Q/gqgQXz16SKB5o9tjCmHtxFj2btTQwDBk
	3RlITu/b5xQyiP/zJbbkzf6XdAcLQCavPMVIvP9mmQikpIQjrBs5HxHnoYIP9gnq
	Aw12XHKiBkTWL6inZN25XIbtDIOpD4/NKIH1C3A4MMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5182BBCB8;
	Sun, 13 Jan 2013 20:40:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A3D2BC93; Sun, 13 Jan 2013
 20:40:43 -0500 (EST)
X-Mailer: git-send-email 1.8.1.421.g6236851
In-Reply-To: <1358127629-7500-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 69E52D9C-5DEB-11E2-878C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213417>

The new cvsps 3.x series lacks support of some options cvsps 2.x
series had and used by cvsimport-2; add a replacement program from
the author of cvsps 3.x and allow users to choose it by setting the
GIT_CVSPS_VERSION environment variable to 3.  We would later add
support to auto-detect the version of installed cvsps to this code
when the environment variable is not set.

Note that in this step, cvsimport-3 that relies on cvsps 3.x does
not have any test coverage.  As cvsimport-3 supports most of the
command line options cvsimport-2, we should be able to tweak some of
t96xx tests and run them with GIT_CVSPS_VERSION set to both 2 and 3,
but that is a topic of later patches that should come on top.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile           |  18 ++-
 git-cvsimport-3.py | 344 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-cvsimport.sh   |   4 +-
 3 files changed, 359 insertions(+), 7 deletions(-)
 create mode 100755 git-cvsimport-3.py

diff --git a/Makefile b/Makefile
index b022db2..060cdc2 100644
--- a/Makefile
+++ b/Makefile
@@ -470,8 +470,9 @@ SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
-SCRIPT_PYTHON += git-remote-testpy.py
+SCRIPT_PYTHON += git-cvsimport-3.py
 SCRIPT_PYTHON += git-p4.py
+SCRIPT_PYTHON += git-remote-testpy.py
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
@@ -575,8 +576,11 @@ endif
 ifndef CVSPS2_PATH
 	CVSPS2_PATH = cvsps
 endif
+ifndef CVSPS3_PATH
+	CVSPS3_PATH = cvsps
+endif
 
-export PERL_PATH PYTHON_PATH CVSPS2_PATH
+export PERL_PATH PYTHON_PATH CVSPS2_PATH CVSPS3_PATH
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
@@ -1515,6 +1519,7 @@ PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 CVSPS2_PATH_SQ = $(subst ','\'',$(CVSPS2_PATH))
+CVSPS3_PATH_SQ = $(subst ','\'',$(CVSPS3_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
@@ -1757,12 +1762,15 @@ ifndef NO_PYTHON
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
+	INSTLIBDIR_SQ=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
 		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
-		instlibdir` && \
+		instlibdir | \
+		sed -e "s/'/'\''/g"` && \
+	echo "InstLibDir is <$$INSTLIBDIR_SQ>" && \
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
-	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
+	    -e 's|@@CVSPS3_PATH@@|$(CVSPS3_PATH_SQ)|g' \
+	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR_SQ"'|g' \
 	    $@.py >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-cvsimport-3.py b/git-cvsimport-3.py
new file mode 100755
index 0000000..57f13b7
--- /dev/null
+++ b/git-cvsimport-3.py
@@ -0,0 +1,344 @@
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
+
+    cvsps = "@@CVSPS3_PATH@@"
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
+        return self.cvsps + "--fast-export " + self.opts
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
+
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
diff --git a/git-cvsimport.sh b/git-cvsimport.sh
index 71ba11d..52ce112 100755
--- a/git-cvsimport.sh
+++ b/git-cvsimport.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
 
-GIT_CVSPS_VERSION=2
+: ${GIT_CVSPS_VERSION=2}
 
-exec git cvsimport-$GIT_CVSPS_VERSION "$@"
+exec git "cvsimport-$GIT_CVSPS_VERSION" "$@"
-- 
1.8.1.421.g6236851
