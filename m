From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 5/5] submodules: ensure clean environment when operating in a submodule
Date: Wed, 24 Feb 2010 00:35:36 +0100
Message-ID: <1266968136-11129-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4Ia-0001Ms-37
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab0BWXgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:36:06 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:51835 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab0BWXgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:36:02 -0500
Received: by mail-ww0-f46.google.com with SMTP id 26so1011731wwf.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VS451I+z+u0UJqi9GtL5DLpheuBZwDU5fJjj3oqV1Es=;
        b=gqD5M1+UrtRNnIaaANsqhff06/LsV4h8bgOlivxfP64hvhOAoo/xVbDl+2PruGMka/
         mrcDzIoXmQCfpwuV9iPjQ9Wm0VKs3iuzix6lkYhxoiK/f24AOSef0WhUgq4EAdO1yc7F
         0EkvG+mR/eq1CWhSuFqv0JIxH5hZN+YjcfQik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gKxSn3zrIbYFOnPJZP8eeafpyrpkzMBBHISh2iyhg7llfA96akbIJ60TOJPI/vAwre
         6cBJbYpO783faEFXK9edxL9TgNU2f5YtcZ+3mdDC7MlNfLnUlrr/dY3D8ayrpHLt1i5w
         8Xc8CwQNDrCE0gxXySG2vbYApqwTSjJSOo9EQ=
Received: by 10.216.154.70 with SMTP id g48mr1195803wek.109.1266968158318;
        Tue, 23 Feb 2010 15:35:58 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id u14sm20132670gvf.2.2010.02.23.15.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 15:35:57 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36.dirty
In-Reply-To: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140872>

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
1.7.0.200.g5ba36.dirty
