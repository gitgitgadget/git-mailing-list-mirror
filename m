From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 5/6] submodules: ensure clean environment when operating in a submodule
Date: Wed, 24 Feb 2010 08:23:15 +0100
Message-ID: <1266996196-25978-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBb8-0003WY-TC
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab0BXHXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:23:47 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43618 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab0BXHXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:23:45 -0500
Received: by mail-ww0-f46.google.com with SMTP id 26so1156644wwf.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 23:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OnDevk1brsQn4s9JAeYfUeIVwev/RkSb6RRUiyjBQCc=;
        b=LQDFJQrbR2w5mE+T5Ru8t/Hid/BuSBZ5lNke9T2N3zihVq+McFffz6b2YN7NxF87vD
         knv/CkbSkDjEvJ5px6V9sm1id98NucHWb2iGX89+Cj51Q5R5NSE/JK0fBO77A26SZshQ
         tCx6BIY0cX25emuuS0yA0+jkxwNEm12+veILU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mG04Lok6OvlZ6YX30R/BFhAw38PCOunrD1fb1X+izNS/QHqQNdccKPmeLtte+2UD8F
         kgeJsXoJ0qqoIvxVteNGCljjm2LZrdfTkhbKjmTyBxVivHWnh1TYREJIB95I8jxwxnv4
         cW1E0g48SqlkSNyhei+NAfeXH05ev7MFffltg=
Received: by 10.216.90.201 with SMTP id e51mr379138wef.59.1266996224996;
        Tue, 23 Feb 2010 23:23:44 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id x6sm21487124gvf.13.2010.02.23.23.23.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 23:23:44 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g4e217.dirty
In-Reply-To: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140912>

git-submodule used to take care of clearing GIT_DIR whenever it operated
on a submodule index or configuration, but forgot to unset GIT_WORK_TREE
or other repo-local variables. This would lead to failures e.g. when
GIT_WORK_TREE was set.

This only happened in very unusual contexts such as operating on the
main worktree from outside of it, but since "git-gui: set GIT_DIR and
GIT_WORK_TREE after setup" (a9fa11fe5bd5978bb) such failures could also
be provoked by invoking an external tool such as "git submodule update"
from the Git Gui in a standard setup.

Solve by using the newly introduced clear_local_git_env() shell function
to ensure that all repo-local environment variables are unset.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-submodule.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5869c00..1ea4143 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -222,7 +222,7 @@ cmd_add()
 
 		module_clone "$path" "$realrepo" "$reference" || exit
 		(
-			unset GIT_DIR
+			clear_local_git_env
 			cd "$path" &&
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
@@ -278,7 +278,7 @@ cmd_foreach()
 			name=$(module_name "$path")
 			(
 				prefix="$prefix$path/"
-				unset GIT_DIR
+				clear_local_git_env
 				cd "$path" &&
 				eval "$@" &&
 				if test -n "$recursive"
@@ -434,7 +434,7 @@ cmd_update()
 			module_clone "$path" "$url" "$reference"|| exit
 			subsha1=
 		else
-			subsha1=$(unset GIT_DIR; cd "$path" &&
+			subsha1=$(clear_local_git_env; cd "$path" &&
 				git rev-parse --verify HEAD) ||
 			die "Unable to find current revision in submodule path '$path'"
 		fi
@@ -454,7 +454,7 @@ cmd_update()
 
 			if test -z "$nofetch"
 			then
-				(unset GIT_DIR; cd "$path" &&
+				(clear_local_git_env; cd "$path" &&
 					git-fetch) ||
 				die "Unable to fetch in submodule path '$path'"
 			fi
@@ -477,14 +477,14 @@ cmd_update()
 				;;
 			esac
 
-			(unset GIT_DIR; cd "$path" && $command "$sha1") ||
+			(clear_local_git_env; cd "$path" && $command "$sha1") ||
 			die "Unable to $action '$sha1' in submodule path '$path'"
 			say "Submodule path '$path': $msg '$sha1'"
 		fi
 
 		if test -n "$recursive"
 		then
-			(unset GIT_DIR; cd "$path" && cmd_update $orig_args) ||
+			(clear_local_git_env; cd "$path" && cmd_update $orig_args) ||
 			die "Failed to recurse into submodule path '$path'"
 		fi
 	done
@@ -492,7 +492,7 @@ cmd_update()
 
 set_name_rev () {
 	revname=$( (
-		unset GIT_DIR
+		clear_local_git_env
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
@@ -760,7 +760,7 @@ cmd_status()
 		else
 			if test -z "$cached"
 			then
-				sha1=$(unset GIT_DIR; cd "$path" && git rev-parse --verify HEAD)
+				sha1=$(clear_local_git_env; cd "$path" && git rev-parse --verify HEAD)
 				set_name_rev "$path" "$sha1"
 			fi
 			say "+$sha1 $displaypath$revname"
@@ -770,7 +770,7 @@ cmd_status()
 		then
 			(
 				prefix="$displaypath/"
-				unset GIT_DIR
+				clear_local_git_env
 				cd "$path" &&
 				cmd_status $orig_args
 			) ||
@@ -821,7 +821,7 @@ cmd_sync()
 		if test -e "$path"/.git
 		then
 		(
-			unset GIT_DIR
+			clear_local_git_env
 			cd "$path"
 			remote=$(get_default_remote)
 			say "Synchronizing submodule url for '$name'"
-- 
1.7.0.212.g4e217.dirty
