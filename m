From: Roland Kaufmann <rlndkfmn+git@gmail.com>
Subject: [PATCH v2] Display change history as a diff between two dirs
Date: Mon, 31 Oct 2011 23:21:58 +0100
Message-ID: <4EAF1F86.5020108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 31 23:21:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL0Em-0000u0-0J
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 23:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934284Ab1JaWVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 18:21:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55925 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934198Ab1JaWV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 18:21:28 -0400
Received: by bkbzt4 with SMTP id zt4so2540739bkb.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=+/pQXHqzAxGeGG9vcsvk97HPCMjrGKDCdRrO9fW/uw0=;
        b=Rs2tN+3qnp9pipLwTWjBeomo9ZUbf3vMiqmEw9mHG+dARvTyGUONcdg7EhYYPThJKE
         sljPRTYqo7gdsL0m+8WdLW7DHfgbk0epVJp2drjms2KyyQfyC6pKTh3C+2w9SaAWuKtI
         CxYEuAyPYATMrgzvxT/Ru+j2hzwiRwhsrRp2Q=
Received: by 10.204.139.199 with SMTP id f7mr5116799bku.88.1320099687150;
        Mon, 31 Oct 2011 15:21:27 -0700 (PDT)
Received: from [192.168.1.7] (33.72.34.95.customer.cdi.no. [95.34.72.33])
        by mx.google.com with ESMTPS id k6sm18615199bkv.8.2011.10.31.15.21.24
        (version=SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 15:21:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184528>

Watching patches serially it can be difficult to get an overview of how
a pervasive change is distributed through-out different modules. Thus;

Extract snapshots of the files that have changed between two revisions
into temporary directories and launch a graphical tool to show the diff
between them.

Use existing functionality in git-diff to get the files themselves, and
git-difftool to launch the diff viewer.

Based on a script called 'git-diffc' by Nitin Gupta.

Signed-off-by: Roland Kaufmann <rlndkfmn+git@gmail.com>
---
Following issues are addressed in this revised patch:

* Test explicitly for errors. Use `die` to show messages and exit. 
  However, I assume that git, mkdir and cp are capable of producing 
  sensible messages themselves, and in those cases just exit.

* Temporary directory is created using mktemp using the -d option which
  is usable on most modern platforms. On more crippled platforms, I 
  revert to using Perl, since it has the best chance of being available 
  (if not, then I reckon there are larger parts of Git that won't work).

  I have tested this approach with msysGit. Unfortunately, I don't have
  testing capabilities for Solaris, HP-UX or AIX.

* Snapshots are taken using only one invocation of `git diff`; no 
  separate listing of files processed.

* If there are no files in either snapshots (i.e. you are comparing two
  empty directories), then don't launch the diff-viewer. This takes
  care of many cases where it is invoked with options that are really 
  not applicable.

* Scripts and manpage are put in contrib/ to gather feedback about the
  usefulness and design issues before I make a go at adding it as an
  option to git-diff itself. (README tells how to install since it is
  not in the main Makefile).

 contrib/dirdiff/README                 |   10 +++++
 contrib/dirdiff/git-dirdiff--helper.sh |   37 ++++++++++++++++++++
 contrib/dirdiff/git-dirdiff.sh         |   58 ++++++++++++++++++++++++++++++++
 contrib/dirdiff/git-dirdiff.txt        |   55 ++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 0 deletions(-)
 create mode 100644 contrib/dirdiff/README
 create mode 100755 contrib/dirdiff/git-dirdiff--helper.sh
 create mode 100755 contrib/dirdiff/git-dirdiff.sh
 create mode 100644 contrib/dirdiff/git-dirdiff.txt

diff --git a/contrib/dirdiff/README b/contrib/dirdiff/README
new file mode 100644
index 0000000..d06461a
--- /dev/null
+++ b/contrib/dirdiff/README
@@ -0,0 +1,10 @@
+# install on GNU, BSD:
+for f in "" "--helper"; do
+  b=git-dirdiff$f
+  sudo install -m 0755 contrib/dirdiff/$b.sh $(git --exec-path)/$b
+done
+
+# install on Windows
+for /f %a in ('git --exec-path') do set GIT_PATH=%a
+set GIT_PATH=%GIT_PATH:/=\%
+for %a in ("" "--helper") do copy contrib\dirdiff\git-dirdiff%~a.sh "%GIT_PATH%\%~a" /y
diff --git a/contrib/dirdiff/git-dirdiff--helper.sh b/contrib/dirdiff/git-dirdiff--helper.sh
new file mode 100755
index 0000000..8ff0124
--- /dev/null
+++ b/contrib/dirdiff/git-dirdiff--helper.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Accumulate files in a changeset into a pre-defined directory.
+#
+# Copyright (C) 2011 Roland Kaufmann
+#
+# Based on a script called git-diffc by Nitin Gupta and valuable
+# suggestions by Junio C. Hamano.
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of the official Git maintainer.
+
+. git-sh-setup
+
+# check that we are called by git-dirdiff
+test -z "$__GIT_DIFF_DIR" &&
+  die Error: Do not call $(basename "$0") directly
+
+# what is the directory name of the file that has changed
+RELDIR=$(dirname "$1") ||
+  exit $?
+
+# don't attempt to copy new or removed files
+if test "$2" != "/dev/null"
+then
+  mkdir -p "$__GIT_DIFF_DIR/old/$RELDIR" ||
+    exit $?
+  cp "$2" "$__GIT_DIFF_DIR/old/$1" ||
+    exit $?
+fi
+if test "$5" != "/dev/null"
+then
+  mkdir -p "$__GIT_DIFF_DIR/new/$RELDIR" ||
+    exit $?
+  cp "$5" "$__GIT_DIFF_DIR/new/$1" ||
+    exit $?
+fi
diff --git a/contrib/dirdiff/git-dirdiff.sh b/contrib/dirdiff/git-dirdiff.sh
new file mode 100755
index 0000000..faf2f00
--- /dev/null
+++ b/contrib/dirdiff/git-dirdiff.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+# Display differences between two commits with a directory comparison.
+#
+# Copyright (C) 2011 Roland Kaufmann
+#
+# Based on a script called git-diffc by Nitin Gupta and valuable
+# suggestions by Junio C. Hamano.
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of the official Git maintainer.
+
+. git-sh-setup
+
+# TMPDIR points to the designated space for temporary files; only if
+# not set use /tmp (MSYS even mounts %TEMP% to there)
+test -z "$TMPDIR" && TMPDIR=/tmp
+
+# create a temporary directory to hold snapshots of changed files
+# note that SunOS and MSYS do not have mktemp (but GnuWin32 has!)
+case $(uname -s) in
+MINGW* | SunOS* | HP-UX* | AIX*)
+  __GIT_DIFF_DIR=$(perl -e "use File::Temp qw/tempdir/; print tempdir(\"git-dirdiff.XXXXXX\", DIR=>\"$TMPDIR\")")
+  ;;
+*)
+  __GIT_DIFF_DIR=$(mktemp -d "$TMPDIR/git-dirdiff.XXXXXX")
+  ;;
+esac
+test -d "$__GIT_DIFF_DIR" -a -w "$__GIT_DIFF_DIR" ||
+  die Error: Could not create a temporary subdir in $TMPDIR
+
+# cleanup after we're done
+trap 'rm -rf $__GIT_DIFF_DIR' 0
+
+# export this variable so that scripts called indirectly can access it
+export __GIT_DIFF_DIR
+
+# let the helper script accumulate all changed files into the temporary
+# directory letting 'git diff' do all the heavy lifting
+GIT_EXTERNAL_DIFF=git-dirdiff--helper git --no-pager diff "$@" ||
+  exit $?
+
+# if there are only hidden files, then the first argument will be the
+# wildcard, and $2 and $3 will be the special directory files . and ..
+isempty () {
+  set - $1/* $1/.*
+  test ! \( -f "$1" -o -f "$4" \)
+}
+
+# no-op if no files were changed
+isempty "$__GIT_DIFF_DIR/old" && isempty "$__GIT_DIFF_DIR/new" &&
+  exit 0
+
+# run original diff program, reckoning it will understand directories
+# modes and shas does not apply to the root directories so submit dummy
+# values for those, hoping that the diff tool does not use them.
+git-difftool--helper - "$__GIT_DIFF_DIR/old" deadbeef 0755 "$__GIT_DIFF_DIR/new" babeface 0755 ||
+  exit $?
diff --git a/contrib/dirdiff/git-dirdiff.txt b/contrib/dirdiff/git-dirdiff.txt
new file mode 100644
index 0000000..bdd2581
--- /dev/null
+++ b/contrib/dirdiff/git-dirdiff.txt
@@ -0,0 +1,55 @@
+git-dirdiff(1)
+==============
+
+NAME
+----
+git-dirdiff - Show changes using directory compare
+
+SYNOPSIS
+--------
+[verse]
+'git dirdiff' [<options>] [<commit> [<commit>]] [--] [<path>...]
+
+DESCRIPTION
+-----------
+'git dirdiff' is a git command that allows you to compare revisions
+as a difference between two directories. 'git dirdiff' is a frontend
+to linkgit:git-diff[1].
+
+OPTIONS
+-------
+See linkgit:git-diff[1] for the list of supported options.
+
+CONFIG VARIABLES
+----------------
+'git dirdiff' uses the same config variables as linkgit:git-difftool[1]
+to determine which difftool should be used.
+
+TEMPORARY FILES
+---------------
+'git dirdiff' creates a directory with 'mktemp' to hold snapshots of the
+files which are different in the two revisions. This directory is removed
+when the diff viewer terminates.
+
+NOTES
+-----
+The diff viewer must support being passed directories instead of files
+as its arguments.
++
+Files that are not put under version control are not included when
+viewing the difference between a revision and the working directory.
+
+SEE ALSO
+--------
+linkgit:git-diff[1]::
+	 Show changes between commits, commit and working tree, etc
+
+linkgit:git-difftool[1]::
+	Show changes using common diff tools
+
+linkgit:git-config[1]::
+	 Get and set repository or global options
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.7.1
