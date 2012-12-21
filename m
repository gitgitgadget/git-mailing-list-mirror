From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH v4] git-completion.bash: add support for path completion
Date: Fri, 21 Dec 2012 17:54:32 +0100
Message-ID: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com>
Cc: szeder@ira.uka.de, felipe.contreras@gmail.com,
	Manlio Perillo <manlio.perillo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 17:55:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm5sn-0002sq-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 17:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab2LUQzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 11:55:20 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:45560 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab2LUQzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 11:55:18 -0500
Received: by mail-we0-f178.google.com with SMTP id x43so2222753wey.23
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 08:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=tVdM3ZtWiMSAoLcsHeoGeZOEAc0KsUVWBs2LmdOgwMU=;
        b=BDMu1ktfIEoXGRzvBREAgd94stCP3UetPp5wMEVIy7h6a9VFLdmN1WvjvCKZHYxMfz
         5W5sZdpTizaf+7+af0nm9eAu2ZMaNlJVozPpsafumb2DIS4zk7KWeSnrRXJ18RJdSReK
         9vhptKEReMFSn018uDtGHF1bcOn4wHJScna0agx2qbuRxVdUJHSH/SSValfo2rDDdnjy
         IZReu/3hNY21/Ieiqal8MfGPQLr2VwrWz1YK8te7vn8M/UQfC2nFs2nCMHgYhfPY15yj
         EH3xUNDTb8q1Gof+69ksgcp9JYP6hkgOg9GerBP2pMdsrfHf96qZ+ATUg6Al9GoLIttx
         5u5w==
X-Received: by 10.180.87.228 with SMTP id bb4mr6800343wib.31.1356108917138;
        Fri, 21 Dec 2012 08:55:17 -0800 (PST)
Received: from synapsis.synapsis ([151.70.200.164])
        by mx.google.com with ESMTPS id p2sm19116707wic.7.2012.12.21.08.55.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 08:55:16 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.18.g9db0d25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211982>

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

Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
---

Changes from version 3:

	* Fixed quoting issues
	* Fixed default parameters handling
	* Fixed a typo in the commit message: the affected command was ls-files,
	  not ls-tree.
	* Fixed incorrect behavior when expanding a path in "git commit"
	  command, for a newly created repository (when HEAD does not
	  exists).
	* Make sure to always execute git commands with stderr redirected to
	  /dev/null.
	* Improved path completion for the git mv command.
	  This required a small refactorization of the __git_index_files
	  function, in order to support multiple options for ls-files.

 contrib/completion/git-completion.bash | 140 +++++++++++++++++++++++++++++----
 1 file changed, 124 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b77eb1..c8c6464 100644
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
@@ -233,6 +234,62 @@ __gitcomp_nl ()
 	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
 }
 
+# Process path list returned by "ls-files" and "diff-index --name-only"
+# commands, in order to list only file names relative to a specified
+# directory, and append a slash to directory names.
+# It accepts 1 optional argument: a directory path.  The path must have
+# a trailing slash.
+__git_index_file_list_filter ()
+{
+	local pfx="${1-}" offset=${#pfx} path
+
+	while read -r path; do
+		path="${path:$offset}"
+
+		case "$path" in
+		?*/*) echo "${path%%/*}/" ;;
+		*) echo $path ;;
+		esac
+	done
+}
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
+	local dir="$(__gitdir)"
+
+	if [ -d "$dir" ]; then
+		# NOTE: $1 is not quoted in order to support multiple options
+		git --git-dir="$dir" ls-files --exclude-standard $1 ${2+"$2"} 2>/dev/null |
+			__git_index_file_list_filter ${2+"$2"} |
+			uniq
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
+		git --git-dir="$dir" diff-index --name-only "$1" 2>/dev/null |
+			__git_index_file_list_filter ${2+"$2"} |
+			uniq
+	fi
+}
+
 __git_heads ()
 {
 	local dir="$(__gitdir)"
@@ -430,6 +487,46 @@ __git_complete_revlist_file ()
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
+		__gitcomp_nl "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_" ""
+		;;
+	*)
+		__gitcomp_nl "$(__git_index_files "$1")" "" "$cur_" ""
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
+		__gitcomp_nl "$(__git_diff_index_files "$1" "$pfx")" "$pfx" "$cur_" ""
+		;;
+	*)
+		__gitcomp_nl "$(__git_diff_index_files "$1")" "" "$cur_" ""
+		;;
+	esac
+}
+
 __git_complete_file ()
 {
 	__git_complete_revlist_file
@@ -770,8 +867,6 @@ _git_apply ()
 
 _git_add ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -780,7 +875,9 @@ _git_add ()
 			"
 		return
 	esac
-	COMPREPLY=()
+
+	# XXX should we check for --update and --all options ?
+	__git_complete_index_file "--others --modified"
 }
 
 _git_archive ()
@@ -930,15 +1027,15 @@ _git_cherry_pick ()
 
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
@@ -969,8 +1066,6 @@ _git_clone ()
 
 _git_commit ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--cleanup=*)
 		__gitcomp "default strip verbatim whitespace
@@ -998,7 +1093,13 @@ _git_commit ()
 			"
 		return
 	esac
-	COMPREPLY=()
+
+	if git rev-parse --verify --quiet HEAD 1>/dev/null; then
+		__git_complete_diff_index_file "HEAD"
+	else
+		# This is the first commit
+		__git_complete_index_file "--cached"
+	fi
 }
 
 _git_describe ()
@@ -1216,8 +1317,6 @@ _git_init ()
 
 _git_ls_files ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --deleted --modified --others --ignored
@@ -1230,7 +1329,10 @@ _git_ls_files ()
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
@@ -1362,7 +1464,14 @@ _git_mv ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+
+	if [ $cword -gt 2 ]; then
+		# We need to show both cached and untracked files (including
+		# empty directories) since this may not be the last argument.
+		__git_complete_index_file "--cached --others --directory"
+	else
+		__git_complete_index_file "--cached"
+	fi
 }
 
 _git_name_rev ()
@@ -2068,15 +2177,14 @@ _git_revert ()
 
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
-- 
1.8.1.rc1.18.g9db0d25
