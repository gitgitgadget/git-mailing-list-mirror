From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v4] contrib: added git-diffall
Date: Fri, 24 Feb 2012 14:48:57 -0500
Message-ID: <1330112937-7134-1-git-send-email-tim.henigan@gmail.com>
Cc: davvid@gmail.com, stefano.lattarini@gmail.com,
	tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 27 17:19:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S23Ig-0001lX-Fi
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 17:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab2B0QTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 11:19:41 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48990 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab2B0QTk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 11:19:40 -0500
Received: by vbbff1 with SMTP id ff1so973737vbb.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 08:19:39 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.52.35.69 as permitted sender) client-ip=10.52.35.69;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.52.35.69 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.52.35.69])
        by 10.52.35.69 with SMTP id f5mr7492696vdj.29.1330359579833 (num_hops = 1);
        Mon, 27 Feb 2012 08:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=q9uIKfexYXdVBOUM+xDqpRtcXIxISYzY7U7HWx13bgo=;
        b=q14IERpXvBJfqF88CwPO5WpBzFXgi6CkxI5ThNlH74rUIqeONJUV8iNQQjYOKicXpm
         M3XHVpD8C7Ihj7DpbgPfSGhUFk22Rkimtblt55p5nmifAuKMHPWSlaQky95dfAvgS9BW
         yRBsmo77dLhTF5HPnmB1AnJOGU66bR3834nuI=
Received: by 10.52.35.69 with SMTP id f5mr6070902vdj.29.1330359579676;
        Mon, 27 Feb 2012 08:19:39 -0800 (PST)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id ei6sm11216156vdc.6.2012.02.27.08.19.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 08:19:38 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191627>

The 'git difftool' command allows the user to view diffs using an
external tool.  It runs a separate instance of the tool for each
file in the diff. This makes it tedious to review changes spanning
multiple files.

The 'git-diffall' script instead prepares temporary directories
with the files to be compared and launches a single instance of
the external diff tool to view them (i.e. a directory diff).

The 'diff.tool' or 'merge.tool' configuration variable is used
to specify which external tool is used.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This script has been hosted on GitHub [1] since April 2010. Enough people
have found it useful that I hope it will be considered for inclusion in
the standard git install, either in contrib or as a new core command.

Changes in v4:
  - Corrected location of hard-coded tmp dir
  - Renamed 'path_sep' to 'dashdash_seen'
  - Documented '--extcmd' in the README
  - Changed test for '--extcmd=<command>' to use $#
  - Documented that '--' is mandatory if a pathspec is given

  v4 matches commit 251177b8e4 on GitHub [1].

Changes in v3:
  - Fixed a bug that caused failures if file names included spaces
  - Added unique suffix to tmp dir name (tmp/git-diffall-tmp.$$)
  - Renamed "common_ancestor" to "merge_base"
  - Cleaned up README to be more accurate
  - Added useful error message if --extcmd is final option, but no
    command was specified
  - Removed spaces after redirection operators

  v3 matches commit f36e4881e5 on GitHub [1].

Changes in v2:
  - Changed to #!/bin/sh
  - Eliminated use of 'which' statements
  - Fixed trap function to actually run on abnormal exit
  - Simplified path concatenation logic ($IFS)
  - Corrected indentation errors
  - Improved readability of while loop
  - Cleaned up quoting of variables

  v2 matches commit 5d4b90de3 on GitHub [1].

[1]: https://github.com/thenigan/git-diffall


 contrib/diffall/README      |   31 +++++
 contrib/diffall/git-diffall |  261 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+), 0 deletions(-)
 create mode 100644 contrib/diffall/README
 create mode 100755 contrib/diffall/git-diffall

diff --git a/contrib/diffall/README b/contrib/diffall/README
new file mode 100644
index 0000000..507f17d
--- /dev/null
+++ b/contrib/diffall/README
@@ -0,0 +1,31 @@
+The git-diffall script provides a directory based diff mechanism
+for git.
+
+To determine what diff viewer is used, the script requires either
+the 'diff.tool' or 'merge.tool' configuration option to be set.
+
+This script is compatible with most common forms used to specify a
+range of revisions to diff:
+
+  1. git diffall: shows diff between working tree and staged changes
+  2. git diffall --cached [<commit>]: shows diff between staged
+     changes and HEAD (or other named commit)
+  3. git diffall <commit>: shows diff between working tree and named
+     commit
+  4. git diffall <commit> <commit>: show diff between two named commits
+  5. git diffall <commit>..<commit>: same as above
+  6. git diffall <commit>...<commit>: show the changes on the branch
+     containing and up to the second, starting at a common ancestor
+     of both <commit>
+
+Note: all forms take an optional path limiter [-- <path>*]
+
+The '--extcmd=<command>' option allows the user to specify a custom
+command for viewing diffs.  When given, configured defaults are
+ignored and the script runs $command $LOCAL $REMOTE.  Additionally,
+$BASE is set in the environment.
+
+This script is based on an example provided by Thomas Rast on the
+Git list [1]:
+
+[1] http://thread.gmane.org/gmane.comp.version-control.git/124807
diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
new file mode 100755
index 0000000..b9d51ca
--- /dev/null
+++ b/contrib/diffall/git-diffall
@@ -0,0 +1,261 @@
+#!/bin/sh
+# Copyright 2010 - 2012, Tim Henigan <tim.henigan@gmail.com>
+#
+# Perform a directory diff between commits in the repository using
+# the external diff or merge tool specified in the user's config.
+
+USAGE='[--cached] [--copy-back] [-x|--extcmd=<command>] <commit>{0,2} [-- <path>*]
+
+    --cached     Compare to the index rather than the working tree.
+
+    --copy-back  Copy files back to the working tree when the diff
+                 tool exits (in case they were modified by the
+                 user).  This option is only valid if the diff
+                 compared with the working tree.
+
+    -x=<command>
+    --extcmd=<command>  Specify a custom command for viewing diffs.
+                 git-diffall ignores the configured defaults and
+                 runs $command $LOCAL $REMOTE when this option is
+                 specified. Additionally, $BASE is set in the
+                 environment.
+'
+
+SUBDIRECTORY_OK=1
+. "$(git --exec-path)/git-sh-setup"
+
+TOOL_MODE=diff
+. "$(git --exec-path)/git-mergetool--lib"
+
+merge_tool="$(get_merge_tool)"
+if test -z "$merge_tool"
+then
+	echo "Error: Either the 'diff.tool' or 'merge.tool' option must be set."
+	usage
+fi
+
+start_dir=$(pwd)
+
+# needed to access tar utility
+cdup=$(git rev-parse --show-cdup) &&
+cd "$cdup" || {
+	echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
+	exit 1
+}
+
+# mktemp is not available on all platforms (missing from msysgit)
+# Use a hard-coded tmp dir if it is not available
+tmp="$(mktemp -d -t tmp.XXXXXX 2>/dev/null)" || {
+	tmp=/tmp/git-diffall-tmp.$$
+	mkdir "$tmp" || exit 1
+}
+
+trap 'rm -rf "$tmp" 2>/dev/null' EXIT
+
+left=
+right=
+paths=
+dashdash_seen=
+compare_staged=
+merge_base=
+left_dir=
+right_dir=
+diff_tool=
+copy_back=
+
+while test $# != 0
+do
+	case "$1" in
+	-h|--h|--he|--hel|--help)
+		usage
+		;;
+	--cached)
+		compare_staged=1
+		;;
+	--copy-back)
+		copy_back=1
+		;;
+	-x|--e|--ex|--ext|--extc|--extcm|--extcmd)
+		if test $# == 1
+		then
+			echo You must specify the tool for use with --extcmd
+			usage
+		else
+			diff_tool=$2
+			shift
+		fi
+		;;
+	--)
+		dashdash_seen=1
+		;;
+	-*)
+		echo Invalid option: "$1"
+		usage
+		;;
+	*)
+		# could be commit, commit range or path limiter
+		case "$1" in
+		*...*)
+			left=${1%...*}
+			right=${1#*...}
+			merge_base=1
+			;;
+		*..*)
+			left=${1%..*}
+			right=${1#*..}
+			;;
+		*)
+			if test -n "$dashdash_seen"
+			then
+				paths="$paths$1 "
+			elif test -z "$left"
+			then
+				left=$1
+			elif test -z "$right"
+			then
+				right=$1
+			else
+				paths="$paths$1 "
+			fi
+			;;
+		esac
+		;;
+	esac
+	shift
+done
+
+# Determine the set of files which changed
+if test -n "$left" && test -n "$right"
+then
+	left_dir="cmt-$(git rev-parse --short $left)"
+	right_dir="cmt-$(git rev-parse --short $right)"
+
+	if test -n "$compare_staged"
+	then
+		usage
+	elif test -n "$merge_base"
+	then
+		git diff --name-only "$left"..."$right" -- $paths >"$tmp/filelist"
+	else
+		git diff --name-only "$left" "$right" -- $paths >"$tmp/filelist"
+	fi
+elif test -n "$left"
+then
+	left_dir="cmt-$(git rev-parse --short $left)"
+
+	if test -n "$compare_staged"
+	then
+		right_dir="staged"
+		git diff --name-only --cached "$left" -- $paths >"$tmp/filelist"
+	else
+		right_dir="working_tree"
+		git diff --name-only "$left" -- $paths >"$tmp/filelist"
+	fi
+else
+	left_dir="HEAD"
+
+	if test -n "$compare_staged"
+	then
+		right_dir="staged"
+		git diff --name-only --cached -- $paths >"$tmp/filelist"
+	else
+		right_dir="working_tree"
+		git diff --name-only -- $paths >"$tmp/filelist"
+	fi
+fi
+
+# Exit immediately if there are no diffs
+if test ! -s "$tmp/filelist"
+then
+	exit 0
+fi
+
+if test -n "$copy_back" && test "$right_dir" != "working_tree"
+then
+	echo "--copy-back is only valid when diff includes the working tree."
+	exit 1
+fi
+
+# Create the named tmp directories that will hold the files to be compared
+mkdir -p "$tmp/$left_dir" "$tmp/$right_dir"
+
+# Populate the tmp/right_dir directory with the files to be compared
+if test -n "$right"
+then
+	while read name
+	do
+		ls_list=$(git ls-tree $right "$name")
+		if test -n "$ls_list"
+		then
+			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
+			git show "$right":"$name" >"$tmp/$right_dir/$name" || true
+		fi
+	done < "$tmp/filelist"
+elif test -n "$compare_staged"
+then
+	while read name
+	do
+		ls_list=$(git ls-files -- "$name")
+		if test -n "$ls_list"
+		then
+			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
+			git show :"$name" >"$tmp/$right_dir/$name"
+		fi
+	done < "$tmp/filelist"
+else
+	# Mac users have gnutar rather than tar
+	(tar --ignore-failed-read -c -T "$tmp/filelist" | (cd "$tmp/$right_dir" && tar -x)) || {
+		gnutar --ignore-failed-read -c -T "$tmp/filelist" | (cd "$tmp/$right_dir" && gnutar -x)
+	}
+fi
+
+# Populate the tmp/left_dir directory with the files to be compared
+while read name
+do
+	if test -n "$left"
+	then
+		ls_list=$(git ls-tree $left "$name")
+		if test -n "$ls_list"
+		then
+			mkdir -p "$tmp/$left_dir/$(dirname "$name")"
+			git show "$left":"$name" >"$tmp/$left_dir/$name" || true
+		fi
+	else
+		if test -n "$compare_staged"
+		then
+			ls_list=$(git ls-tree HEAD "$name")
+			if test -n "$ls_list"
+			then
+				mkdir -p "$tmp/$left_dir/$(dirname "$name")"
+				git show HEAD:"$name" >"$tmp/$left_dir/$name"
+			fi
+		else
+			mkdir -p "$tmp/$left_dir/$(dirname "$name")"
+			git show :"$name" >"$tmp/$left_dir/$name"
+		fi
+	fi
+done < "$tmp/filelist"
+
+cd "$tmp"
+LOCAL="$left_dir"
+REMOTE="$right_dir"
+
+if test -n "$diff_tool"
+then
+	export BASE
+	eval $diff_tool '"$LOCAL"' '"$REMOTE"'
+else
+	run_merge_tool "$merge_tool" false
+fi
+
+# Copy files back to the working dir, if requested
+if test -n "$copy_back" && test "$right_dir" = "working_tree"
+then
+	cd "$start_dir"
+	git_top_dir=$(git rev-parse --show-toplevel)
+	find "$tmp/$right_dir" -type f |
+	while read file
+	do
+		cp "$file" "$git_top_dir/${file#$tmp/$right_dir/}"
+	done
+fi
-- 
1.7.9.1
