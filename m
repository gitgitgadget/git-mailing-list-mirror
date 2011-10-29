From: Roland Kaufmann <rlndkfmn+git@gmail.com>
Subject: [PATCH] Display change history as a diff between two dirs
Date: Sat, 29 Oct 2011 22:51:49 +0200
Message-ID: <4EAC6765.4030003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 29 22:56:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKFww-0003DT-IO
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 22:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933081Ab1J2UvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Oct 2011 16:51:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63492 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183Ab1J2UvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2011 16:51:21 -0400
Received: by bkbzt4 with SMTP id zt4so1255957bkb.19
        for <git@vger.kernel.org>; Sat, 29 Oct 2011 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=I5hzXGdW2/A4pjGCssm/oJtKvkF5QbkWdElOQvwDak8=;
        b=rIhtpl1UDN5ir1jnURu7QbRpieQevwpVYes32lbHtUOUTq2cpZSgeSb+l7kuLFlGde
         Hc6SjGl038aNOkyv/+5sVB7pvXhQfuWVkNoKCrnzJZQYwG6CrLI89dIhRAFT/wibPajG
         6N6KciYmSs7KK+4ViafJ7+UOH0B+ovuPD3uno=
Received: by 10.204.152.68 with SMTP id f4mr6265402bkw.59.1319921479134;
        Sat, 29 Oct 2011 13:51:19 -0700 (PDT)
Received: from [192.168.1.7] (33.72.34.95.customer.cdi.no. [95.34.72.33])
        by mx.google.com with ESMTPS id g3sm11784790bka.4.2011.10.29.13.51.17
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Oct 2011 13:51:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184458>

Watching patches serially it can be difficult to get an overview of how
a pervasive change is distributed through-out different modules. Thus:

Extract snapshots of the files that have changed between two revisions
into temporary directories and launch a graphical tool to show the diff
between them.

Use existing functionality in git-diff to figure out which files have
changed, and to get the files themselves.

Based on a script called 'git-diffc' by Nitin Gupta.

Signed-off-by: Roland Kaufmann <rlndkfmn+git@gmail.com>
---

Requests for such a scripts surface occationally, so I believe it could
be useful to have in the distribution itself.

 Documentation/git-dirdiff.txt |   55 +++++++++++++++++++++++++++++++++++++++++
 Makefile                      |    2 +
 git-dirdiff--helper.sh        |   28 +++++++++++++++++++++
 git-dirdiff.sh                |   34 +++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-dirdiff.txt
 create mode 100755 git-dirdiff--helper.sh
 create mode 100755 git-dirdiff.sh

diff --git a/Documentation/git-dirdiff.txt b/Documentation/git-dirdiff.txt
new file mode 100644
index 0000000..bdd2581
--- /dev/null
+++ b/Documentation/git-dirdiff.txt
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
diff --git a/Makefile b/Makefile
index 3139c19..03771cf 100644
--- a/Makefile
+++ b/Makefile
@@ -365,6 +365,8 @@ unexport CDPATH
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
+SCRIPT_SH += git-dirdiff.sh
+SCRIPT_SH += git-dirdiff--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
diff --git a/git-dirdiff--helper.sh b/git-dirdiff--helper.sh
new file mode 100755
index 0000000..bc0b49d
--- /dev/null
+++ b/git-dirdiff--helper.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+#
+# Accumulate files in a changeset into a pre-defined directory.
+#
+# Copyright (C) 2011 Roland Kaufmann
+# Based on a script called git-diffc by Nitin Gupta
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of the official Git maintainer.
+
+# bail out if there is any problems copying
+set -e
+
+# check that we are called by git-dirdiff
+if [ -z $__GIT_DIFF_DIR ]; then
+  echo Error: Do not call $(basename $0) directly 1>&2
+  exit 1
+fi
+
+# don't attempt to copy new or removed files
+if [ "$2" != "/dev/null" ]; then
+  mkdir -p $__GIT_DIFF_DIR/old/$(dirname $1)
+  cp $2 $__GIT_DIFF_DIR/old/$1
+fi
+if [ "$5" != "/dev/null" ]; then
+  mkdir -p $__GIT_DIFF_DIR/new/$(dirname $1)
+  cp $5 $__GIT_DIFF_DIR/new/$1
+fi
diff --git a/git-dirdiff.sh b/git-dirdiff.sh
new file mode 100755
index 0000000..4e75eda
--- /dev/null
+++ b/git-dirdiff.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Display differences between two commits with a directory comparison.
+#
+# Copyright (C) 2011 Roland Kaufmann
+# Based on a script called git-diffc by Nitin Gupta
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of the official Git maintainer.
+
+# bail out if there is any problems in getting a diff
+set -e
+
+# create a temporary directory to hold snapshots of changed files
+__GIT_DIFF_DIR=$(mktemp --tmpdir -d git-dirdiff.XXXXXX)
+export __GIT_DIFF_DIR
+
+# cleanup after we're done
+trap 'rm -rf $__GIT_DIFF_DIR' 0
+
+# list all files that have changed. store this list in a separate
+# file so that we can test the exit status of this command. (if we had
+# bash we could use pipefail, or if we had Posix we could use mkfifo)
+git diff --raw "$@" > $__GIT_DIFF_DIR/toc
+
+# let the helper script accumulate them into the temporary directory
+cut -f 2- -s $__GIT_DIFF_DIR/toc | while read f; do
+  GIT_EXTERNAL_DIFF=git-dirdiff--helper git --no-pager diff "$@" $f
+done
+
+# run original diff program, reckoning it will understand directories
+# modes and shas does not apply to the root directories so submit dummy
+# values for those, hoping that the diff tool does not use them.
+git-difftool--helper - $__GIT_DIFF_DIR/old deadbeef 0755 $__GIT_DIFF_DIR/new babeface 0755
-- 
1.7.1
