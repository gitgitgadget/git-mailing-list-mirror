From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] submodules: ensure clean environment when operating in a submodule
Date: Mon, 22 Feb 2010 23:16:55 +0100
Message-ID: <1266877015-7943-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <20100218203726.GD12660@book.hvoigt.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:17:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njgam-0002yF-Nu
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab0BVWRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:17:15 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:46962 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab0BVWRN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:17:13 -0500
Received: by ewy28 with SMTP id 28so3332419ewy.28
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 14:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=H1FypegybXns7QpAu22zBIWAACEgrPcprelaDlruKoQ=;
        b=GisdDAw7OBaa8bzY65Uf+SWnwBrUJBvzLzhxecyyToKR91xj6yIKjTcrufRJSt1Ny+
         8AVtXXOmn1HtaMNwvC1Cj3uy7GGGkBpIEUWZn2C9Z9JgEFeYKuPL6Ol+Ijs2CXyPiMvR
         Q0OOqFxVKy2QZ1fAmzKx23ZzbZiIjH+KO4PcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UyNDc7FjqvIwp3oz2VhGYAWRK0RJSg7S/IjaxVhr9iT1hOjAsZi4MnBgkMLeaUUr6d
         p1/uT2RSolLpb9SLaFe74zUivNtZtgw9VT7s9gJKchY14PYdzD3yefBVv5cHbIjxDUQv
         5Bg9B1fSteR2lnA1t3hc1oWgSPvplcI5OEpr4=
Received: by 10.216.184.205 with SMTP id s55mr1240459wem.149.1266877031702;
        Mon, 22 Feb 2010 14:17:11 -0800 (PST)
Received: from localhost ([151.60.177.169])
        by mx.google.com with ESMTPS id x6sm16073980gvf.13.2010.02.22.14.17.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 14:17:10 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36
In-Reply-To: <20100218203726.GD12660@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140719>

git-submodule takes care of clearing GIT_DIR whenever it operates
on a submodule index or configuration, but forgot to unset GIT_WORK_TREE
before operating on the submodule worktree, which would lead to failures
when GIT_WORK_TREE was set.

This only happened in very unusual contexts such as operating on the
main worktree from outside of it, but since "git-gui: set GIT_DIR and
GIT_WORK_TREE after setup" (a9fa11fe5bd5978bb) such failures could also
be provoked by invoking an external tool such as "git submodule update"
from the Git GUI in a standard setup.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-submodule.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

The bug (git submodules not working in Git GUI since my patch) was spotted by
Heiko Voigt working on/with msysgit, and he kindly provided a recipe to
replicate it:
http://article.gmane.org/gmane.comp.version-control.msysgit/8755

I'm pretty confident fixing this on the submodules side is the more correct
approach, since otherwise even a simple
$ GIT_WORK_TREE=. git submodule update
on the command-line can fail.

I also believe this is material for git maint.

diff --git a/git-submodule.sh b/git-submodule.sh
index 5869c00..69afc84 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -223,6 +223,7 @@ cmd_add()
 		module_clone "$path" "$realrepo" "$reference" || exit
 		(
 			unset GIT_DIR
+			unset GIT_WORK_TREE
 			cd "$path" &&
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
@@ -279,6 +280,7 @@ cmd_foreach()
 			(
 				prefix="$prefix$path/"
 				unset GIT_DIR
+				unset GIT_WORK_TREE
 				cd "$path" &&
 				eval "$@" &&
 				if test -n "$recursive"
@@ -477,7 +479,7 @@ cmd_update()
 				;;
 			esac
 
-			(unset GIT_DIR; cd "$path" && $command "$sha1") ||
+			(unset GIT_DIR; unset GIT_WORK_TREE; cd "$path" && $command "$sha1") ||
 			die "Unable to $action '$sha1' in submodule path '$path'"
 			say "Submodule path '$path': $msg '$sha1'"
 		fi
@@ -771,6 +773,7 @@ cmd_status()
 			(
 				prefix="$displaypath/"
 				unset GIT_DIR
+				unset GIT_WORK_TREE
 				cd "$path" &&
 				cmd_status $orig_args
 			) ||
-- 
1.7.0.199.g49ef3.dirty
