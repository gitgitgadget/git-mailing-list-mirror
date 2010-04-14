From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] contrib/diffall: Add script to perform directory diff using
 external diff tool
Date: Tue, 13 Apr 2010 21:15:21 -0400
Message-ID: <4BC51729.7090906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Seba Illingworth <seba.illingworth@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 03:15:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1rCa-0007EB-KR
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 03:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0DNBPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 21:15:30 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:63326 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab0DNBP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 21:15:29 -0400
Received: by qyk9 with SMTP id 9so169772qyk.1
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=wVB6shehwA+W15bvJ2nOGMrcAX1eCuGm17+YtxFcFIg=;
        b=JCRe6mQpugAnyHKEAl1yV6nPljy+PSGGsrhXDGU06ONON3xZvAVt8TZo3+LDiOfYZ5
         hZGYGFE1w7GL0VRey72cU9/Tlf9szi9jXX0yGyaNquY8a028mLLtdEgVtIlJ0ZLByocY
         qsSOK4VL3+9vvFXmx0bjEzMCw8gvfcASkc1aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=YGlbnVvfFGpiDkgBFy+pXZkHXRo3ufyOFN4XjpR1Dnnx1cBIAbFggLLp2ypPTxH1aT
         xFtege0LWj2trW754PSQ6wqH6x9ooRCfO/oPSfpjCuE1+vIbfOuw78qRdFxucXp2M8fh
         +PYvHFz/5lJuDgJ80L1FE1zNH2dOMOfXn2TB4=
Received: by 10.229.218.2 with SMTP id ho2mr4401784qcb.51.1271207728317;
        Tue, 13 Apr 2010 18:15:28 -0700 (PDT)
Received: from [192.168.1.70] ([75.38.216.51])
        by mx.google.com with ESMTPS id x34sm8243951qce.15.2010.04.13.18.15.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 18:15:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144839>

The existing 'git difftool' command allows the user to view git diffs
using an external diff tool.  However, if multiple files contain
differences, a separate instance of the diff tool is launched for
each one.

This script launches a single instance of the external diff tool
and performs a directory diff between the specified revisions.
The before/after files are copied to a tmp directory to do this.

The 'diff.tool' configuration option must be set for this script
to work.

The user interface matches the standard 'git diff' command.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This script is based on an example provided by Thomas Rast on the Git list [1].

I tested with:
  - msysgit and kdiff3 (the platform where I first needed this script)
  - cygwin git and kdiff3
  - git and meld

[1] http://thread.gmane.org/gmane.comp.version-control.git/124807


 contrib/diffall/git-diffall |  159 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 159 insertions(+), 0 deletions(-)
 create mode 100755 contrib/diffall/git-diffall

diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
new file mode 100755
index 0000000..c24fba9
--- /dev/null
+++ b/contrib/diffall/git-diffall
@@ -0,0 +1,159 @@
+#!/bin/sh -e
+# Copyright 2010, Tim Henigan <tim.henigan@gmail.com>
+#
+# Perform a directory diff between commits in the repository using
+# the external diff tool specified in the 'diff.tool' configuration
+# option.
+
+USAGE='<options> <commit>{0,2} -- <path>*
+
+--cached  Compare to the index rather than the working tree
+commit    SHA1 of a commit
+path      Limit the diff to the specified paths
+'
+
+. git-sh-setup
+
+if [ -z $(git config --get diff.tool) ]; then
+    echo "Error: The 'diff.tool' configuration option must be set."
+    usage
+fi
+
+start_dir=$(pwd)
+cd_to_toplevel      # needed to access tar utility
+
+# mktemp is not available on all platforms (missing from msysgit)
+# Use a hard-coded tmp dir if it is not available
+if [ -z $(which mktemp) ]; then
+    tmp=/tmp/git-diffall-tmp
+else
+    tmp="$(mktemp -d)"
+fi
+mkdir -p "$tmp" "$tmp"/a "$tmp"/b
+
+left=
+right=
+paths=
+path_sep=
+compare_staged=
+common_anscestor=
+
+while test $# != 0; do
+	case "$1" in
+    -h|--h|--he|--hel|--help)
+        usage
+        ;;
+    --cached)
+        compare_staged=1
+        ;;
+    --)
+        path_sep=1
+        ;;
+    -*)
+        echo Invalid option: "$1"
+        usage
+        ;;
+    *)
+        # could be commit, commit range or path limiter
+        case "$1" in
+        *...*)
+            left=${1%...*}
+            right=${1#*...}
+            common_anscestor=1
+            ;;
+        *..*)
+            left=${1%..*}
+            right=${1#*..}
+            ;;
+        *)
+            if [ -n "$path_sep" ]; then
+                if [ -z "$paths" ]; then
+                    paths=$1
+                else
+                    paths="$paths $1"
+                fi
+            elif [ -z "$left" ]; then
+                left=$1
+            elif [ -z "$right" ]; then
+                right=$1
+            else
+                if [ -z "$paths" ]; then
+                    paths=$1
+                else
+                    paths="$paths $1"
+                fi
+            fi
+            ;;
+        esac
+        ;;
+    esac
+    shift
+done
+
+# Determine the set of files which changed
+if [ -n "$left" ] && [ -n "$right" ]; then
+    if [ -n "$compare_staged" ]; then
+        usage
+    elif [ -n "$common_anscestor" ]; then
+        git diff --name-only "$left"..."$right" -- "$paths" > "$tmp"/filelist
+    else
+        git diff --name-only "$left" "$right" -- "$paths" > "$tmp"/filelist
+    fi
+elif [ -n "$left" ]; then
+    if [ -n "$compare_staged" ]; then
+        git diff --name-only --cached "$left" -- "$paths" > "$tmp"/filelist
+    else
+        git diff --name-only "$left" -- "$paths" > "$tmp"/filelist
+    fi
+else
+    if [ -n "$compare_staged" ]; then
+        git diff --name-only --cached -- "$paths" > "$tmp"/filelist
+    else
+        git diff --name-only -- "$paths" > "$tmp"/filelist
+    fi
+fi
+
+# Exit immediately if there are no diffs
+if [ ! -s "$tmp"/filelist ]; then
+    exit 0
+fi
+
+# Populate the tmp/b directory with the files to be compared
+if [ -n "$right" ]; then
+	while read name; do
+		mkdir -p "$tmp"/b/"$(dirname "$name")"
+		git show "$right":"$name" > "$tmp"/b/"$name"
+	done < "$tmp"/filelist
+elif [ -n "$compare_staged" ]; then
+	while read name; do
+		mkdir -p "$tmp"/b/"$(dirname "$name")"
+		git show :"$name" > "$tmp"/b/"$name"
+	done < "$tmp"/filelist
+else
+    tar -c -T "$tmp"/filelist | (cd "$tmp"/b && tar -x)
+fi
+
+# Populate the tmp/a directory with the files to be compared
+while read name; do
+	mkdir -p "$tmp"/a/"$(dirname "$name")"
+    if [ -n "$left" ]; then
+	    git show "$left":"$name" > "$tmp"/a/"$name"
+    else
+        if [ -n "$compare_staged" ]; then
+            git show HEAD:"$name" > "$tmp"/a/"$name"
+        else
+            git show :"$name" > "$tmp"/a/"$name"
+        fi
+    fi
+done < "$tmp"/filelist
+
+cd "$tmp"
+$(git config --get diff.tool) a b
+
+# On exit, remove the tmp directory
+cleanup () {
+    cd "$start_dir"
+	rm -rf "$tmp"
+}
+
+trap cleanup EXIT
-- 
1.7.0.3.291.g5e4f6.dirty
