From: Roland Kaufmann <rlndkfmn+git@gmail.com>
Subject: [PATCH v4] Display change history as a diff between two dirs
Date: Sat, 25 Feb 2012 22:47:47 +0100
Message-ID: <4F495703.10401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 25 22:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1PT6-0000j7-Rn
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 22:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab2BYVrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 16:47:48 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52028 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753671Ab2BYVrr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Feb 2012 16:47:47 -0500
Received: by lagu2 with SMTP id u2so4058025lag.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 13:47:45 -0800 (PST)
Received-SPF: pass (google.com: domain of rlndkfmn+git@gmail.com designates 10.152.148.230 as permitted sender) client-ip=10.152.148.230;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of rlndkfmn+git@gmail.com designates 10.152.148.230 as permitted sender) smtp.mail=rlndkfmn+git@gmail.com; dkim=pass header.i=rlndkfmn+git@gmail.com
Received: from mr.google.com ([10.152.148.230])
        by 10.152.148.230 with SMTP id tv6mr6197065lab.12.1330206465736 (num_hops = 1);
        Sat, 25 Feb 2012 13:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=3aLAuXwoznUCjaEzHkUV6RBRdTZaykkN/mJOKdRIoKo=;
        b=mlgSwOpnme6FpxT3QrA1nPM0yhQlFEdS5sKex9AtNUTPZz832E7MFQdLu+mGfc/2dN
         FPmJluHI5l1ev1gguWC81rUxCRxgKanbzuA9/LxVdBa4oQuwtES2L2vPDgV8Jjdk4EvS
         Gk2oTkH/Fq0i1hmwg45PID1EPpRQDR+E1tc7M=
Received: by 10.152.148.230 with SMTP id tv6mr5163621lab.12.1330206465671;
        Sat, 25 Feb 2012 13:47:45 -0800 (PST)
Received: from [192.168.1.7] (124.229.202.84.customer.cdi.no. [84.202.229.124])
        by mx.google.com with ESMTPS id os5sm8588463lab.13.2012.02.25.13.47.43
        (version=SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 13:47:44 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191547>

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
Issue addressed in this revision:
* If changes were made in subdirectories the script though the diff
  set between the two trees was empty, because it only checked for
  regular files.

 contrib/dirdiff/README                 |   10 ++++
 contrib/dirdiff/git-dirdiff--helper.sh |   37 ++++++++++++++++
 contrib/dirdiff/git-dirdiff.sh         |   72 ++++++++++++++++++++++++++++++++
 contrib/dirdiff/git-dirdiff.txt        |   71 +++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+), 0 deletions(-)
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
index 0000000..a23efee
--- /dev/null
+++ b/contrib/dirdiff/git-dirdiff--helper.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Accumulate files in a changeset into a pre-defined directory.
+#
+# Copyright (C) 2011-2012 Roland Kaufmann
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
index 0000000..33c294d
--- /dev/null
+++ b/contrib/dirdiff/git-dirdiff.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Display differences between two commits with a directory comparison.
+#
+# Copyright (C) 2011-2012 Roland Kaufmann
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
+# fallback on crippled platforms is to use a Perl module
+case $(uname -s) in
+Linux | *BSD | Darwin | windows* | CYGWIN_NT*)
+  __GIT_DIFF_DIR=$(mktemp -d "$TMPDIR/git-dirdiff.XXXXXX")
+  ;;
+*)
+  __GIT_DIFF_DIR=$(perl -e "use File::Temp qw/tempdir/; print tempdir(\"git-dirdiff.XXXXXX\", DIR=>\"$TMPDIR\")")
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
+# first and second argument will always be the special directory links
+# if there are no hidden files nor regular files, then $3 will be the
+# second wildcard unexpanded
+isempty () {
+  set - $1/.* $1/*
+  test ! -e "$3"
+}
+
+# no-op if no files were changed
+isempty "$__GIT_DIFF_DIR/old" && isempty "$__GIT_DIFF_DIR/new" &&
+  exit 0
+
+# if a different tool is setup for tree comparison, launch that instead
+# if GIT_EXTERNAL_TREEDIFF is not set, then use GIT_EXTERNAL_DIFF
+if test -n "$GIT_EXTERNAL_DIFF"
+then
+  GIT_DIFFTOOL_EXTCMD=$GIT_EXTERNAL_DIFF
+  export GIT_DIFFTOOL_EXTCMD
+fi
+if test -n "$GIT_EXTERNAL_TREEDIFF"
+then
+  GIT_DIFFTOOL_EXTCMD=$GIT_EXTERNAL_TREEDIFF
+  export GIT_DIFFTOOL_EXTCMD
+fi
+
+# run original diff program, reckoning it will understand directories
+# modes and shas does not apply to the root directories so submit dummy
+# values for those, hoping that the diff tool does not use them.
+git-difftool--helper - "$__GIT_DIFF_DIR/old" deadbeef 0755 "$__GIT_DIFF_DIR/new" babeface 0755 ||
+  exit $?
diff --git a/contrib/dirdiff/git-dirdiff.txt b/contrib/dirdiff/git-dirdiff.txt
new file mode 100644
index 0000000..b80430a
--- /dev/null
+++ b/contrib/dirdiff/git-dirdiff.txt
@@ -0,0 +1,71 @@
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
+ENVIRONMENT VARIABLES
+---------------------
+'GIT_EXTERNAL_TREEDIFF'::
+	When 'GIT_EXTERNAL_TREEDIFF' is set, the program named by it is
+	used as a diff viewer. The program must accept 7 parameters, where
+	parameter 2 is the path to a temporary directory containing the
+	"old" revision, and parameter 5 is the path of the "new" revision.
+	The other five parameters will only contain dummy values, and their
+	contents are subject to change.
+
+'GIT_EXTERNAL_DIFF'::
+	If and only if 'GIT_EXTERNAL_TREEDIFF' is not set, 'git dirdiff'
+	will use the contents of 'GIT_EXTERNAL_DIFF' as the name of the
+	diff viewer.
+
+CONFIG VARIABLES
+----------------
+If none of the above environment variables are set, 'git dirdiff' will
+use the same config variables as linkgit:git-difftool[1] to determine
+which difftool should be used.
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
