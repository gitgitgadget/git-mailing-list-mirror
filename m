From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH] git-completion.bash: add support for path completion
Date: Sun, 16 Dec 2012 22:24:40 +0100
Message-ID: <1355693080-4765-1-git-send-email-manlio.perillo@gmail.com>
Cc: Manlio Perillo <manlio.perillo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 22:25:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkLi1-0000pA-Vc
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 22:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab2LPVY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 16:24:59 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50796 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2LPVY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 16:24:59 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2419839bkw.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 13:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=TvKS+FG/8h5EZWUpaigmrO64B3R9eefpa0Sj4TBdOZk=;
        b=1Ahej8MEhtueV4xoEgSsiXdct0a4dVvvrSDafkJJwreLD2dymSysGTaQ9JY1ZiwjZx
         OJvXqBBapinnZ4AvBdfqkAV0jqw6/Bj93H5ccYQsPPn0iOcHuX0l/N4DPKnNM3qw/82V
         4NcVIYBL+Ac12BlTvwujpCM6LHH9/GW3PIwvXy70SnMxpbDnJB9QnAwVYFlyY2iVMGmA
         5/0EeNjR3Bah1YEPDEvp9njG4uZJciajlv0FHxtQC24uO/o9OPdwd06CSN5iJQc3parq
         WNTQOTEVeyZOOelHsK6f+hnw/BTUUuAJmFnEr3NpESOH+S2Nqs0UJtPg26e2rASeZgRk
         Zy5Q==
Received: by 10.204.149.26 with SMTP id r26mr5113069bkv.71.1355693097602;
        Sun, 16 Dec 2012 13:24:57 -0800 (PST)
Received: from synapsis.synapsis ([151.70.213.162])
        by mx.google.com with ESMTPS id d16sm7976539bkw.2.2012.12.16.13.24.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 13:24:56 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.18.g9db0d25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211613>

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
 contrib/completion/git-completion.bash | 39 ++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b77eb1..8b348c3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -233,6 +233,25 @@ __gitcomp_nl ()
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
@@ -770,8 +789,6 @@ _git_apply ()
 
 _git_add ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -780,7 +797,8 @@ _git_add ()
 			"
 		return
 	esac
-	COMPREPLY=()
+	# XXX should we care for --update and --all options ?
+	__gitcomp_nl "$(__git_files -o -m)" "" "$cur" ""
 }
 
 _git_archive ()
@@ -930,15 +948,14 @@ _git_cherry_pick ()
 
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
@@ -969,8 +986,6 @@ _git_clone ()
 
 _git_commit ()
 {
-	__git_has_doubledash && return
-
 	case "$cur" in
 	--cleanup=*)
 		__gitcomp "default strip verbatim whitespace
@@ -998,7 +1013,7 @@ _git_commit ()
 			"
 		return
 	esac
-	COMPREPLY=()
+	__gitcomp_nl "$(__git_commit_files)" "" "$cur" ""
 }
 
 _git_describe ()
@@ -1362,7 +1377,7 @@ _git_mv ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcomp_nl "$(__git_files)" "" "$cur" ""
 }
 
 _git_name_rev ()
@@ -2068,15 +2083,13 @@ _git_revert ()
 
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
