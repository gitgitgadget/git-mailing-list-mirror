From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH v5] git-completion.bash: add support for path completion
Date: Fri, 11 Jan 2013 19:48:43 +0100
Message-ID: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
Cc: gitster@pobox.com, szeder@ira.uka.de, felipe.contreras@gmail.com,
	peff@peff.net, Manlio Perillo <manlio.perillo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 19:49:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtjfY-00085U-4m
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 19:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab3AKStL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 13:49:11 -0500
Received: from mail-ee0-f50.google.com ([74.125.83.50]:50385 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080Ab3AKStK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 13:49:10 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so300505eek.9
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 10:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=qfR9ayvIxA0tnF6xOKSTsXxFnYJn6ibsmJzazRyN3aA=;
        b=eySNhNrYv/tl3RT/zd7mim/kKX+M8qscnohkphpJ1b9+ESTp1GeVESaPPti3i03Udt
         PhAAmECZ7T8AVFQiSKOUUDCTC6x61elvS8DlDiGN9e825DH+QSqGDMJ8CvmHRi+fT1vs
         s2NHJsBTAh3LyoQyfYFhQo3Mt4O/LAsKbwde2BgokHIQjSRdvlW7Tc3h+uOjUDLmCPBR
         ZYTagG2U3bifuTKPz7GYbB7f7fr0104UzKQhAF/eGCLf+rXXOFqMp9WQdK60JaRgg5Mg
         u5p2xBzjzHeEroc5HJ7b9m3LrHdVkWtafsC1cZxVKs9zngqnXre2FMFOmzAIl+GpoisF
         I/rA==
X-Received: by 10.14.225.72 with SMTP id y48mr202632792eep.46.1357930148673;
        Fri, 11 Jan 2013 10:49:08 -0800 (PST)
Received: from synapsis.synapsis ([151.70.220.147])
        by mx.google.com with ESMTPS id f6sm9552137eeo.7.2013.01.11.10.49.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 10:49:07 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.31.ga3c84da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213232>

The git-completion.bash script did not implemented full, git aware,
support to complete paths, for git commands that operate on files within
the current working directory or the index.

As an example:

	git add <TAB>

will suggest all files in the current working directory, including
ignored files and files that have not been modified.

Support path completion, for git commands where the non-option arguments
always refer to paths within the current working directory or the index,
as follows:

* the path completion for the "git rm" and "git ls-files"
  commands will suggest all cached files.

* the path completion for the "git add" command will suggest all
  untracked and modified files.  Ignored files are excluded.

* the path completion for the "git clean" command will suggest all
  untracked files.  Ignored files are excluded.

* the path completion for the "git mv" command will suggest all cached
  files when expanding the first argument, and all untracked and cached
  files for subsequent arguments.  In the latter case, empty directories
  are included and ignored files are excluded.

* the path completion for the "git commit" command will suggest all
  files that have been modified from the HEAD, if HEAD exists, otherwise
  it will suggest all cached files.

For all affected commands, completion will always stop at directory
boundary.  Only standard ignored files are excluded, using the
--exclude-standard option of the ls-files command.

When using a recent Bash version, Git path completion will be the same
as builtin file completion, e.g.

	git add contrib/

will suggest relative file names.

Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
---

Changes:

	* Applied Junio patch to fix completion inside a subdirectory.
	* Quoted the hopefully last incorrectly unquoted variable.
	* Fixed coding style (removed stdout file descriptor in shell
	  redirection, since it is redundant).
	* Fixed regression in path completion, when using non canonicalized
	  or absolute path names.
	  The problem has been solved making sure to chdir to the specified
	  directory before executing ls-files and diff-index commands.

	  The only issue is that there is no tilde expansion, but this is
	  harmless, since default bash completion will be used (the old
	  behaviour).
	* Improved path completion when the new compopt builtin is available
	  (Bash >= 4.x).
	  Now git paths completion is done in exactly the same way as Bash
	  builtin filenames completion.
    * Updated the zsh compatibility code to use the improved path
      completion support
	* Fixed incorrect git mv arguments count used to check the first
	  path to be renamed.
	  When options are used (unless they are git main options), -- is
	  required to separate options from non options arguments.
	  It is harmless to not use --; in this case bash will suggest
	  untracked files and directories for the first argument.

	  XXX: should I add this implementation note in the commit message?
	* Make sure to sort ls-files and diff-index filtered output before
	  removing duplicate directories.
	* Merged master.
	 
Please note that before merging this patch in next, we need to update the
zsh and tcsh completion scripts.
I have the changes ready, but I will post them later since both scripts
needs more patches (I have posted an informal patch for zsh, and changes
to tcsh should be in pu, but I need to test them).

 contrib/completion/git-completion.bash | 250 ++++++++++++++++++++++++++++++---
 1 file changed, 234 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a4c48e1..51b8b3b 100644
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
@@ -233,6 +234,118 @@ __gitcomp_nl ()
 	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
 }
 
+# Generates completion reply with compgen from newline-separated possible
+# completion filenames.
+# It accepts 1 to 3 arguments:
+# 1: List of possible completion filenames, separated by a single newline.
+# 2: A directory prefix to be added to each possible completion filename
+#    (optional).
+# 3: Generate possible completion matches for this word (optional).
+__gitcomp_file ()
+{
+	local IFS=$'\n'
+
+	# XXX does not work when the directory prefix contains a tilde,
+	# since tilde expansion is not applied.
+	# This means that COMPREPLY will be empty and Bash default
+	# completion will be used.
+	COMPREPLY=($(compgen -P "${2-}" -W "$1" -- "${3-$cur}"))
+
+	# Tell Bash that compspec generates filenames.
+	compopt -o filenames 2>/dev/null
+}
+
+__git_index_file_list_filter_compat ()
+{
+	local path
+
+	while read -r path; do
+		case "$path" in
+		?*/*) echo "${path%%/*}/" ;;
+		*) echo "$path" ;;
+		esac
+	done
+}
+
+__git_index_file_list_filter_bash ()
+{
+	local path
+
+	while read -r path; do
+		case "$path" in
+		?*/*)
+			# XXX if we append a slash to directory names when using
+			# `compopt -o filenames`, Bash will append another slash.
+			# This is pretty stupid, and this the reason why we have to
+			# define a compatible version for this function.
+			echo "${path%%/*}" ;;
+		*)
+			echo "$path" ;;
+		esac
+	done
+}
+
+# Process path list returned by "ls-files" and "diff-index --name-only"
+# commands, in order to list only file names relative to a specified
+# directory, and append a slash to directory names.
+__git_index_file_list_filter ()
+{
+	# Default to Bash >= 4.x
+	__git_index_file_list_filter_bash
+}
+
+# Execute git ls-files, returning paths relative to the directory
+# specified in the first argument, and using the options specified in
+# the second argument.
+__git_ls_files_helper ()
+{
+	# NOTE: $2 is not quoted in order to support multiple options
+	cd "$1" && git ls-files --exclude-standard $2
+} 2>/dev/null
+
+
+# Execute git diff-index, returning paths relative to the directory
+# specified in the first argument, and using the tree object id
+# specified in the second argument.
+__git_diff_index_helper ()
+{
+	cd "$1" && git diff-index --name-only --relative "$2"
+} 2>/dev/null
+
+# __git_index_files accepts 1 or 2 arguments:
+# 1: Options to pass to ls-files (required).
+#    Supported options are --cached, --modified, --deleted, --others,
+#    and --directory.
+# 2: A directory path (optional).
+#    If provided, only files within the specified directory are listed.
+#    Sub directories are never recursed.  Path must have a trailing
+#    slash.
+__git_index_files ()
+{
+	local dir="$(__gitdir)" root="${2-.}"
+
+	if [ -d "$dir" ]; then
+		__git_ls_files_helper "$root" "$1" | __git_index_file_list_filter |
+			sort | uniq
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
+	local dir="$(__gitdir)" root="${2-.}"
+
+	if [ -d "$dir" ]; then
+		__git_diff_index_helper "$root" "$1" | __git_index_file_list_filter |
+			sort | uniq
+	fi
+}
+
 __git_heads ()
 {
 	local dir="$(__gitdir)"
@@ -430,6 +543,46 @@ __git_complete_revlist_file ()
 }
 
 
+# __git_complete_index_file requires 1 argument: the options to pass to
+# ls-file
+__git_complete_index_file ()
+{
+	local pfx cur_="$cur"
+
+	case "$cur_" in
+	?*/*)
+		pfx="${cur_%/*}"
+		cur_="${cur_##*/}"
+		pfx="${pfx}/"
+
+		__gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
+		;;
+	*)
+		__gitcomp_file "$(__git_index_files "$1")" "" "$cur_"
+		;;
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
+	?*/*)
+		pfx="${cur_%/*}"
+		cur_="${cur_##*/}"
+		pfx="${pfx}/"
+
+		__gitcomp_file "$(__git_diff_index_files "$1" "$pfx")" "$pfx" "$cur_"
+		;;
+	*)
+		__gitcomp_file "$(__git_diff_index_files "$1")" "" "$cur_"
+		;;
+	esac
+}
+
 __git_complete_file ()
 {
 	__git_complete_revlist_file
@@ -722,6 +875,43 @@ __git_has_doubledash ()
 	return 1
 }
 
+# Try to count non option arguments passed on the command line for the
+# specified git command.
+# When options are used, it is necessary to use the special -- option to
+# tell the implementation were non option arguments begin.
+# XXX this can not be improved, since options can appear everywhere, as
+# an example:
+#	git mv x -n y
+#
+# __git_count_arguments requires 1 argument: the git command executed.
+__git_count_arguments ()
+{
+	local word i c=0
+
+	# Skip "git" (first argument)
+	for ((i=1; i < ${#words[@]}; i++)); do
+		word="${words[i]}"
+
+		case "$word" in
+			--)
+				# Good; we can assume that the following are only non
+				# option arguments.
+				((c = 0))
+				;;
+			"$1")
+				# Skip the specified git command and discard git
+				# main options
+				((c = 0))
+				;;
+			?*)
+				((c++))
+				;;
+		esac
+	done
+
+	printf "%d" $c
+}
+
 __git_whitespacelist="nowarn warn error error-all fix"
 
 _git_am ()
@@ -770,8 +960,6 @@ _git_apply ()
 
 _git_add ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -780,7 +968,9 @@ _git_add ()
 			"
 		return
 	esac
-	COMPREPLY=()
+
+	# XXX should we check for --update and --all options ?
+	__git_complete_index_file "--others --modified"
 }
 
 _git_archive ()
@@ -930,15 +1120,15 @@ _git_cherry_pick ()
 
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
+	__git_complete_index_file "--others"
 }
 
 _git_clone ()
@@ -969,8 +1159,6 @@ _git_clone ()
 
 _git_commit ()
 {
-	__git_has_doubledash && return
-
 	case "$prev" in
 	-c|-C)
 		__gitcomp_nl "$(__git_refs)" "" "${cur}"
@@ -1005,7 +1193,13 @@ _git_commit ()
 			"
 		return
 	esac
-	COMPREPLY=()
+
+	if git rev-parse --verify --quiet HEAD >/dev/null; then
+		__git_complete_diff_index_file "HEAD"
+	else
+		# This is the first commit
+		__git_complete_index_file "--cached"
+	fi
 }
 
 _git_describe ()
@@ -1223,8 +1417,6 @@ _git_init ()
 
 _git_ls_files ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --deleted --modified --others --ignored
@@ -1237,7 +1429,10 @@ _git_ls_files ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+
+	# XXX ignore options like --modified and always suggest all cached
+	# files.
+	__git_complete_index_file "--cached"
 }
 
 _git_ls_remote ()
@@ -1369,7 +1564,14 @@ _git_mv ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+
+	if [ $(__git_count_arguments "mv") -gt 0 ]; then
+		# We need to show both cached and untracked files (including
+		# empty directories) since this may not be the last argument.
+		__git_complete_index_file "--cached --others --directory"
+	else
+		__git_complete_index_file "--cached"
+	fi
 }
 
 _git_name_rev ()
@@ -2075,15 +2277,14 @@ _git_revert ()
 
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
+	__git_complete_index_file "--cached"
 }
 
 _git_shortlog ()
@@ -2448,6 +2649,15 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 	}
 
+	__gitcomp_file ()
+	{
+		emulate -L zsh
+
+		local IFS=$'\n'
+		compset -P '*[=:]'
+		compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+	}
+
 	__git_zsh_helper ()
 	{
 		emulate -L ksh
@@ -2469,6 +2679,14 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 
 	compdef _git git gitk
 	return
+elif [[ -n ${BASH_VERSION-} ]]; then
+	if ((${BASH_VERSINFO[0]} < 4)); then
+		# compopt is not supported
+		__git_index_file_list_filter ()
+		{
+			__git_index_file_list_filter_compat
+		}
+	fi
 fi
 
 __git_func_wrap ()
-- 
1.8.1.rc1.31.ga3c84da
