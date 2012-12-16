From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH v2] git-completion.bash: add support for path completion
Date: Sun, 16 Dec 2012 23:20:55 +0100
Message-ID: <1355696455-11135-1-git-send-email-manlio.perillo@gmail.com>
Cc: Manlio Perillo <manlio.perillo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 23:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkMaO-0001lT-Bl
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 23:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab2LPWVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 17:21:10 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54213 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab2LPWVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 17:21:09 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2428321bkw.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XYjRRdAodyd2tVP78p96L6515bmApmUQ8YCoJaOQiPw=;
        b=pLM9bJtXxl6wzhAdSWBYHtwC1P1SCiBVF7/CB6ImyznZcMhI38+R22IcubuM4NeIED
         PEPeKssgKRTO8S90wtjP4FJHXfUM63FAjBxqO7kZ/PmfcF9J/xxIbuexyG50H3Gylghy
         d26eFu8dVPkoWmQ9elptd6jOtbuGnSXpAM+/MgTadcjJjd7lsPjqeoRHmCRvxG44cSNT
         5sRabN09r5rfOv4FnTUVS8B5ngHpGsP4wbdKHWZrMwPfsJKKzPna9STWcTZNCkqzzxtu
         Ziwu03lC/m5P+RLGpvmAQkhyXP64PNgjUFO8LgNsJ70inximsuAz6Dl6q3aVj+IN0Dtd
         h5Aw==
Received: by 10.204.5.133 with SMTP id 5mr5137170bkv.68.1355696468055;
        Sun, 16 Dec 2012 14:21:08 -0800 (PST)
Received: from synapsis.synapsis ([151.70.213.162])
        by mx.google.com with ESMTPS id y11sm8035983bkw.8.2012.12.16.14.21.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 14:21:06 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.18.g9db0d25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211615>

The git-completion.bash script did not implemented full support for
completion, for git commands that operate on files from the current
working directory or the index.

For these commands, only options completion was available.

Full support for completion is now implemented, for git commands where
the non-option arguments always refer to paths on the current working
directory or the index, as the follow:

* the path completion for the "git mv" and "git rm" commands is provided
  using "git ls-files --exclude-standard"

* the path completion for the "git add" command is provided using
  "git ls-files --exclude-standard -o -m"

* the path completion for the "git clean" command is provided using
  "git ls-files --exclude-standard -o"

* the path completion for the "git commit" command is provides using
  "git diff-index --name-only HEAD"

Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
---

Updated the script documentation.

 contrib/completion/git-completion.bash | 40 +++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b77eb1..3bd7fc8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -13,6 +13,7 @@
 #    *) .git/remotes file names
 #    *) git 'subcommands'
 #    *) tree paths within 'ref:path/to/file' expressions
+#    *) working directory and index file names
 #    *) common --long-options
 #
 # To use these routines:
@@ -233,6 +234,25 @@ __gitcomp_nl ()
 	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
 }
 
+__git_files ()
+{
+	local dir="$(__gitdir)"
+	if [ -d "$dir" ]; then
+		git --git-dir="$dir" ls-files --exclude-standard $*
+		return
+	fi
+}
+
+# Return all staged files with modification from current HEAD
+__git_commit_files ()
+{
+	local dir="$(__gitdir)"
+	if [ -d "$dir" ]; then
+		git --git-dir="$dir" diff-index --name-only HEAD
+		return
+	fi
+}
+
 __git_heads ()
 {
 	local dir="$(__gitdir)"
@@ -770,8 +790,6 @@ _git_apply ()
 
 _git_add ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -780,7 +798,8 @@ _git_add ()
 			"
 		return
 	esac
-	COMPREPLY=()
+	# XXX should we care for --update and --all options ?
+	__gitcomp_nl "$(__git_files -o -m)" "" "$cur" ""
 }
 
 _git_archive ()
@@ -930,15 +949,14 @@ _git_cherry_pick ()
 
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
+	# TODO: check for -x option
+	__gitcomp_nl "$(__git_files -o)" "" "$cur" ""
 }
 
 _git_clone ()
@@ -969,8 +987,6 @@ _git_clone ()
 
 _git_commit ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--cleanup=*)
 		__gitcomp "default strip verbatim whitespace
@@ -998,7 +1014,7 @@ _git_commit ()
 			"
 		return
 	esac
-	COMPREPLY=()
+	__gitcomp_nl "$(__git_commit_files)" "" "$cur" ""
 }
 
 _git_describe ()
@@ -1362,7 +1378,7 @@ _git_mv ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcomp_nl "$(__git_files)" "" "$cur" ""
 }
 
 _git_name_rev ()
@@ -2068,15 +2084,13 @@ _git_revert ()
 
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
+	__gitcomp_nl "$(__git_files)" "" "$cur" ""
 }
 
 _git_shortlog ()
-- 
1.8.1.rc1.18.g9db0d25
