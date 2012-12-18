From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH v3] git-completion.bash: add support for path completion
Date: Tue, 18 Dec 2012 18:25:10 +0100
Message-ID: <1355851510-13438-1-git-send-email-manlio.perillo@gmail.com>
Cc: Manlio Perillo <manlio.perillo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 18:25:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl0vH-0003ZR-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 18:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab2LRRZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 12:25:25 -0500
Received: from mail-bk0-f42.google.com ([209.85.214.42]:43918 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab2LRRZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 12:25:25 -0500
Received: by mail-bk0-f42.google.com with SMTP id ji2so497112bkc.15
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=XcPA8iOm+byc9mT2GVQc1cJD6kWJtXrViEGXgt0NNhg=;
        b=gdhlyJ5QM4SavPZKrouXKDZU1Oxbufh4VUqSuDLJtHM1Kr1EWGWKqknIqZVCP0eKkA
         iF90mqoU0AYHsSkZ17YFoX1ZuwWayACsdDisiKSIb/P5rvuvBfPI4H2RT907Bk7c7wHw
         NnhKDPb1xlyEbu1fkVYZ3Pf3JlqfNv6hgNxvdCogwYyB5oSnoYrah8L3zEn8DxmXf0j6
         XSjWri85/D5C2ypVj0+ktUI3HcI6alFeRn9q7LLVDJ6312XA7ZYkZVFKOJYe896OnPa5
         xq4vGdKaKTyoVXuIMuaupaOoTh49jOHX04ont7kQPxBEcH2bjlmO3eHBClf0rSfMZ/8c
         Pk3g==
X-Received: by 10.204.129.66 with SMTP id n2mr1124023bks.94.1355851523665;
        Tue, 18 Dec 2012 09:25:23 -0800 (PST)
Received: from synapsis.synapsis ([151.70.213.162])
        by mx.google.com with ESMTPS id 18sm2032063bkv.0.2012.12.18.09.25.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2012 09:25:22 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.18.g9db0d25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211764>

The git-completion.bash script did not implemented full, git aware,
support for completion, for git commands that operate on files within
the current working directory or the index.

For these commands, only long options completion was available.
As an example:

	git add <TAB>

will suggest all files in the current working directory, including
ignored files and files that have not been modified.

Full support for completion is now implemented, for git commands where
the non-option arguments always refer to paths within the current
working directory or the index, as the follow:

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
 contrib/completion/git-completion.bash | 112 ++++++++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b77eb1..923ef37 100644
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
@@ -233,6 +234,59 @@ __gitcomp_nl ()
 	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
 }
 
+# Perl filter used to process path list returned by ls-files and
+# diff-index --name-only commands, in order to list file names
+# relative to a specified directory, and append a slash to directory
+# names.
+# The script expects the prefix path in the "pfx" environ variable.
+# The output must be processed with the uniq filter, to remove
+# duplicate directories.
+# XXX remove duplicates in the Perl script ?
+__git_index_file_list_filter='$pfx = $ENV{"pfx"};
+			$idx = index($_, $pfx);
+			if ($idx == 0) {
+				$_ = substr $_, length($pfx);
+				@segments = split("/", $_);
+				if ($segments[1]) {
+					print $segments[0], "/\n"
+				} else {
+					print $segments[0], "\n"
+				}
+			}'
+
+# __git_files accepts 1 or 2 arguments:
+# 1: A string for file index status mode ("c", "m", "d", "o"), as
+#    supported by git ls-files command.  This is required.
+# 2: An optional directory path.  If provided, only files within the
+#    specified directory are listed.  Sub directories are never recursed.
+#    Path must have a trailing slash.
+__git_files ()
+{
+	local dir="$(__gitdir)" flags="-${1}"
+
+	if [ -d "$dir" ]; then
+		git --git-dir="$dir" ls-files --exclude-standard ${flags} ${pfx} \
+			| pfx=$2 perl -ne "${__git_index_file_list_filter}" \
+			| uniq
+		return
+	fi
+}
+
+# __git_commit_files accepts 1 optional argument: a directory path.
+# If provided, only files within the specified directory are listed.
+# Sub directories are never recursed.  Path must have a trailing slash.
+__git_commit_files ()
+{
+	local dir="$(__gitdir)"
+
+	if [ -d "$dir" ]; then
+		git --git-dir="$dir" diff-index --name-only HEAD \
+			| pfx=$1 perl -ne "${__git_index_file_list_filter}" \
+			| uniq
+		return
+	fi
+}
+
 __git_heads ()
 {
 	local dir="$(__gitdir)"
@@ -430,6 +484,25 @@ __git_complete_revlist_file ()
 }
 
 
+# __git_complete_index_file requires 1 argument, the file index
+# status mode
+_git_complete_index_file ()
+{
+	local pfx cur_="$cur" flags=${1}
+	case "$cur_" in
+		?*/*)
+			pfx="${cur_%/*}"
+			cur_="${cur_##*/}"
+			pfx="${pfx}/"
+
+			__gitcomp_nl "$(__git_files ${flags} ${pfx})" "$pfx" "$cur_" ""
+			;;
+		*)
+			__gitcomp_nl "$(__git_files ${flags})" "" "$cur_" ""
+			;;
+	esac
+}
+
 __git_complete_file ()
 {
 	__git_complete_revlist_file
@@ -770,8 +843,6 @@ _git_apply ()
 
 _git_add ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -780,7 +851,8 @@ _git_add ()
 			"
 		return
 	esac
-	COMPREPLY=()
+	# XXX should we check for --update and --all options ?
+	_git_complete_index_file "om"
 }
 
 _git_archive ()
@@ -930,15 +1002,14 @@ _git_cherry_pick ()
 
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
+	# XXX should we check for -x option ?
+	_git_complete_index_file "o"
 }
 
 _git_clone ()
@@ -969,7 +1040,7 @@ _git_clone ()
 
 _git_commit ()
 {
-	__git_has_doubledash && return
+	local pfx cur_=${cur}
 
 	case "$cur" in
 	--cleanup=*)
@@ -997,8 +1068,20 @@ _git_commit ()
 			--verbose --quiet --fixup= --squash=
 			"
 		return
+		;;
+	?*/*)
+		pfx="${cur_%/*}"
+		cur_="${cur_##*/}"
+		pfx="${pfx}/"
+
+		__gitcomp_nl "$(__git_commit_files ${pfx})" "$pfx" "$cur_" ""
+		return
+		;;
+	*)
+		__gitcomp_nl "$(__git_commit_files)" "" "$cur_" ""
+		return
+		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_describe ()
@@ -1216,8 +1299,6 @@ _git_init ()
 
 _git_ls_files ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --deleted --modified --others --ignored
@@ -1230,7 +1311,9 @@ _git_ls_files ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	# XXX ignore options like --modified and always suggest all cached
+	# files.
+	_git_complete_index_file "c"
 }
 
 _git_ls_remote ()
@@ -1362,7 +1445,8 @@ _git_mv ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	# XXX needs more work
+	_git_complete_index_file "c"
 }
 
 _git_name_rev ()
@@ -2068,15 +2152,13 @@ _git_revert ()
 
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
+	_git_complete_index_file "c"
 }
 
 _git_shortlog ()
-- 
1.8.1.rc1.18.g9db0d25
