From: Ron Panduwana <panduwana@gmail.com>
Subject: [PATCH] bash-completion: Make use of git status
Date: Tue, 16 Aug 2011 13:09:08 +0700
Message-ID: <1313474948-13531-1-git-send-email-panduwana@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Lee Marlow <lee.marlow@gmail.com>,
	Ron Panduwana <panduwana@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 08:09:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtCqO-0000g9-Dm
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 08:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab1HPGJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 02:09:39 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:45408 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab1HPGJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 02:09:38 -0400
Received: by iye16 with SMTP id 16so8954948iye.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 23:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aizkM1evOUkPOTidppNH5Uiz5uxzERYd3LZBqq4Dw1k=;
        b=k7EQp0uG+bj2gegRi+nN/8QXD4UV4Ubx7LhA8EgR+uK+jIk0oiCat1Ml9ldINC8pSf
         z5YcgxpGkPp2q/tHXmXS/hFs0souXZVZu5dkNb3Db9+EYdnsssKr+IsIdvW+oHSkviuC
         fjpG8ODePHMhmIT+MvfIsha8NAi579ZaNQDw4=
Received: by 10.43.132.72 with SMTP id ht8mr4984453icc.268.1313474977973;
        Mon, 15 Aug 2011 23:09:37 -0700 (PDT)
Received: from localhost.localdomain ([180.252.123.52])
        by mx.google.com with ESMTPS id bu8sm7752566icb.23.2011.08.15.23.09.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Aug 2011 23:09:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179405>

When autocompleting git add, rm, checkout --, and reset HEAD; Make it so they use git status to offer suitable files.

Signed-off-by: Ron Panduwana <panduwana@gmail.com>
---
Hello,

I made some little improvements to the bash autocompletion script for git add, rm, checkout --, and reset HEAD.
It's because sometimes after doing "git status" I need to do one/some of the commands and hope the autocompletion can make use the status info git already knows.
For example:

$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   path/to/deeply/located/added-file
#	modified:   path/to/deeply/located/old-file
#	deleted:    path/to/deeply/located/removed-file
#
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	deleted:    path/to/deeply/located/deleted-file
#	modified:   path/to/deeply/located/modified-file
#	deleted:    path/to/deeply/located/old-file
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	path/to/deeply/located/new-file


If I need to do one of the commands, I'd like my autocompletion to work like these:

$ git add [TAB]path/to/deeply/located/[TAB][TAB]
path/to/deeply/located/modified-file   path/to/deeply/located/new-file

$ git rm [TAB]path/to/deeply/located/[TAB][TAB]
path/to/deeply/located/deleted-file   path/to/deeply/located/old-file

$ git checkout -- [TAB]path/to/deeply/located/[TAB][TAB]
path/to/deeply/located/deleted-file    path/to/deeply/located/modified-file   path/to/deeply/located/old-file

$ git reset HEAD [TAB]path/to/deeply/located/[TAB][TAB]
path/to/deeply/located/added-file     path/to/deeply/located/old-file       path/to/deeply/located/removed-file


I think it's a good thing to be included as default, so here I send the diff of my modification of the autocompletion script.

PS: for the modification I've taken into account:
- has_doubledash
- when we meant to autocomplete the --switches
- for git rm, whether --cached presents
- for git checkout, only if it starts with "git checkout -- "
- for git reset, only if it starts with "git reset HEAD "
- (ie. when we meant to autocomplete git_refs)

Hope it'd be useful.

 contrib/completion/git-completion.bash |   76 ++++++++++++++++++++------------
 1 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5a83090..233bdbb 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1010,6 +1010,12 @@ __git_has_doubledash ()
 	return 1
 }

+# __git_files_having_status requires 1 argument
+__git_files_having_status ()
+{
+	echo "$(git status -uall --porcelain . 2>/dev/null | egrep "^$1" | cut -c4-)"
+}
+
 __git_whitespacelist="nowarn warn error error-all fix"

 _git_am ()
@@ -1058,17 +1064,17 @@ _git_apply ()

 _git_add ()
 {
-	__git_has_doubledash && return
-
-	case "$cur" in
-	--*)
-		__gitcomp "
-			--interactive --refresh --patch --update --dry-run
-			--ignore-errors --intent-to-add
-			"
-		return
-	esac
-	COMPREPLY=()
+	if ! __git_has_doubledash; then
+		case "$cur" in
+		--*)
+			__gitcomp "
+				--interactive --refresh --patch --update --dry-run
+				--ignore-errors --intent-to-add
+				"
+			return
+		esac
+	fi
+	__gitcomp "$(__git_files_having_status "(.[MAU]|UD|\?\?)")"
 }

 _git_archive ()
@@ -1171,7 +1177,12 @@ _git_bundle ()

 _git_checkout ()
 {
-	__git_has_doubledash && return
+	if __git_has_doubledash; then
+		if [[ ${words[2]} = "--" ]]; then
+			__gitcomp "$(__git_files_having_status ".[MD]")"
+		fi
+		return
+	fi

 	case "$cur" in
 	--conflict=*)
@@ -2313,14 +2324,18 @@ _git_replace ()

 _git_reset ()
 {
-	__git_has_doubledash && return
-
-	case "$cur" in
-	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+	if ! __git_has_doubledash; then
+		case "$cur" in
+		--*)
+			__gitcomp "--merge --mixed --hard --soft --patch"
+			return
+			;;
+		esac
+	fi
+	if [[ ${words[2]} = "HEAD" ]]; then
+		__gitcomp "$(__git_files_having_status "[ADM].")"
 		return
-		;;
-	esac
+	fi
 	__gitcomp "$(__git_refs)"
 }

@@ -2337,15 +2352,20 @@ _git_revert ()

 _git_rm ()
 {
-	__git_has_doubledash && return
-
-	case "$cur" in
-	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
-		return
-		;;
-	esac
-	COMPREPLY=()
+	if ! __git_has_doubledash; then
+		case "$cur" in
+		--*)
+			__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+			return
+			;;
+		esac
+	fi
+	# check if --cached was specified
+	if [ "$(__git_find_on_cmdline "--cached")" ]; then
+		COMPREPLY=()
+	else
+		__gitcomp "$(__git_files_having_status "(.D|DU|UA)")"
+	fi
 }

 _git_shortlog ()
--
1.7.1
