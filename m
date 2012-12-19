From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH v3] git-completion.bash: add support for path completion
Date: Wed, 19 Dec 2012 19:58:16 +0100
Message-ID: <1355943496-5533-1-git-send-email-manlio.perillo@gmail.com>
Cc: Manlio Perillo <manlio.perillo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 19:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlOqx-0001H4-01
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 19:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab2LSS6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 13:58:33 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:63302 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab2LSS6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 13:58:32 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1074445wgb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=89EA85jREseBGvjVutPLuSGU4V3pSKpH1gN6qc5QdfU=;
        b=j92NR9VyUNnBdYFqU4zwCNoCLEHgjFVZSRSonLB++xwUPc5TEOQoxCucBHz+Zk0JGn
         DNMQ0xuYD2lF6vAE+W8HCzimBmRv7IjvOu3c33kAX92VU4912umHXKnyZkjxCKKOuwM+
         WQFQeLpq+cYJ+YQD/ZY8fkCPYoo0YRSfnGlvP/FJlee5nT1l5euw8ixPlwWiff810yg5
         WokuOLynQPJED9BAkxFTRMS1fw7P/jN1/9Cx48cuQI0HXdN7MeXWnt/8vK4NQGq4+7x7
         sQDZ9J+WZfATQUynKKLtkatoJD0eazUbQY8f/Cl9UTyK6/m7lLuG3FuzP93R6b2YFvPG
         z3zQ==
X-Received: by 10.194.242.69 with SMTP id wo5mr13515821wjc.10.1355943510720;
        Wed, 19 Dec 2012 10:58:30 -0800 (PST)
Received: from synapsis.synapsis ([151.70.213.162])
        by mx.google.com with ESMTPS id dw4sm9259756wib.1.2012.12.19.10.58.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 10:58:28 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.18.g9db0d25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211842>

The git-completion.bash script did not implemented full, git aware,
support to complete paths, for git commands that operate on files within
the current working directory or the index.

As an example:

	git add <TAB>

will suggest all files in the current working directory, including
ignored files and files that have not been modified.

Support path completion, for git commands where the non-option arguments
always refer to paths within the current working directory or the index,
as the follow:

* the path completion for the "git mv", "git rm" and "git ls-tree"
  commands will suggest all cached files.

* the path completion for the "git add" command will suggest all
  untracked and modified files.  Ignored files are excluded.

* the path completion for the "git clean" command will suggest all
  untracked files.  Ignored files are excluded.

* the path completion for the "git commit" command will suggest all
  files that have been modified from the HEAD.

For all affected commands, completion will always stop at directory
boundary.  Only standard ignored files are excluded, using the
--exclude-standard option of the ls-files command.

Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
---

Changes from version 2:

	* Perl is no more used.
	* Fixed some coding style issues.
	* Refactorized code, to improve future path completion support for
	  the "git reset" command.

 contrib/completion/git-completion.bash | 127 ++++++++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b77eb1..fc12d0f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -13,6 +13,7 @@
 #    *) .git/remotes file names
 #    *) git 'subcommands'
 #    *) tree paths within 'ref:path/to/file' expressions
+#    *) file paths within current working directory and index
 #    *) common --long-options
 #
 # To use these routines:
@@ -233,6 +234,58 @@ __gitcomp_nl ()
 	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
 }
 
+# Process path list returned by "ls-files" and "diff-index --name-only"
+# commands, in order to list only file names relative to a specified
+# directory, and append a slash to directory names.
+# It accepts 1 optional argument: a directory path.  The path must have
+# a trailing slash.
+__git_index_file_list_filter ()
+{
+	local path
+
+	while read -r path; do
+		path=${path#$1}
+
+		case "$path" in
+		?*/*) echo "${path%%/*}/" ;;
+		*) echo $path ;;
+		esac
+	done
+}
+
+# __git_index_files accepts 1 or 2 arguments:
+# 1: A string for file index status mode ("c", "m", "d", "o"), as
+#    supported by git ls-files command.
+# 2: A directory path (optional).
+#    If provided, only files within the specified directory are listed.
+#    Sub directories are never recursed.  Path must have a trailing
+#    slash.
+__git_index_files ()
+{
+	local dir="$(__gitdir)"
+
+	if [ -d "$dir" ]; then
+		git --git-dir="$dir" ls-files --exclude-standard "-${1}" "${2}" |
+			__git_index_file_list_filter ${2} | uniq
+	fi
+}
+
+# __git_diff_index_files accepts 1 or 2 arguments:
+# 1) The id of a tree object.
+# 2) A directory path (optional).
+#    If provided, only files within the specified directory are listed.
+#    Sub directories are never recursed.  Path must have a trailing
+#    slash.
+__git_diff_index_files ()
+{
+	local dir="$(__gitdir)"
+
+	if [ -d "$dir" ]; then
+		git --git-dir="$dir" diff-index --name-only "${1}" |
+			__git_index_file_list_filter "${2}" | uniq
+	fi
+}
+
 __git_heads ()
 {
 	local dir="$(__gitdir)"
@@ -430,6 +483,46 @@ __git_complete_revlist_file ()
 }
 
 
+# __git_complete_index_file requires 1 argument: the file index
+# status mode
+__git_complete_index_file ()
+{
+	local pfx cur_="$cur"
+
+	case "$cur_" in
+		?*/*)
+			pfx="${cur_%/*}"
+			cur_="${cur_##*/}"
+			pfx="${pfx}/"
+
+			__gitcomp_nl "$(__git_index_files ${1} ${pfx})" "$pfx" "$cur_" ""
+			;;
+		*)
+			__gitcomp_nl "$(__git_index_files ${1})" "" "$cur_" ""
+			;;
+	esac
+}
+
+# __git_complete_diff_index_file requires 1 argument: the id of a tree
+# object
+__git_complete_diff_index_file ()
+{
+	local pfx cur_="$cur"
+
+	case "$cur_" in
+		?*/*)
+			pfx="${cur_%/*}"
+			cur_="${cur_##*/}"
+			pfx="${pfx}/"
+
+			__gitcomp_nl "$(__git_diff_index_files ${1} ${pfx})" "$pfx" "$cur_" ""
+			;;
+		*)
+			__gitcomp_nl "$(__git_diff_index_files ${1})" "" "$cur_" ""
+			;;
+	esac
+}
+
 __git_complete_file ()
 {
 	__git_complete_revlist_file
@@ -770,8 +863,6 @@ _git_apply ()
 
 _git_add ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -780,7 +871,9 @@ _git_add ()
 			"
 		return
 	esac
-	COMPREPLY=()
+
+	# XXX should we check for --update and --all options ?
+	__git_complete_index_file "om"
 }
 
 _git_archive ()
@@ -930,15 +1023,15 @@ _git_cherry_pick ()
 
 _git_clean ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run --quiet"
 		return
 		;;
 	esac
-	COMPREPLY=()
+
+	# XXX should we check for -x option ?
+	__git_complete_index_file "o"
 }
 
 _git_clone ()
@@ -969,8 +1062,6 @@ _git_clone ()
 
 _git_commit ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--cleanup=*)
 		__gitcomp "default strip verbatim whitespace
@@ -997,8 +1088,10 @@ _git_commit ()
 			--verbose --quiet --fixup= --squash=
 			"
 		return
+		;;
 	esac
-	COMPREPLY=()
+
+	__git_complete_diff_index_file "HEAD"
 }
 
 _git_describe ()
@@ -1216,8 +1309,6 @@ _git_init ()
 
 _git_ls_files ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --deleted --modified --others --ignored
@@ -1230,7 +1321,10 @@ _git_ls_files ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+
+	# XXX ignore options like --modified and always suggest all cached
+	# files.
+	__git_complete_index_file "c"
 }
 
 _git_ls_remote ()
@@ -1362,7 +1456,9 @@ _git_mv ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+
+	# XXX needs more work
+	__git_complete_index_file "c"
 }
 
 _git_name_rev ()
@@ -2068,15 +2164,14 @@ _git_revert ()
 
 _git_rm ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
 		return
 		;;
 	esac
-	COMPREPLY=()
+
+	__git_complete_index_file "c"
 }
 
 _git_shortlog ()
-- 
1.8.1.rc1.18.g9db0d25
