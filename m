From: Marc Weber <marco-oweber@gmx.de>
Subject: [PATCH] topgit  tg push feature
Date: Sat, 25 Apr 2009 18:13:00 +0200
Message-ID: <20090425161300.GD19142@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: u.kleine-koenig@pengutronix.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 16:15:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxiez-00038C-To
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 16:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbZDYONM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 10:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbZDYONK
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 10:13:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:57551 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752557AbZDYONJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 10:13:09 -0400
Received: (qmail invoked by alias); 25 Apr 2009 14:13:04 -0000
Received: from pD9507C22.dip.t-dialin.net (EHLO mail.gmx.net) [217.80.124.34]
  by mail.gmx.net (mp046) with SMTP; 25 Apr 2009 16:13:04 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX18AZAUTDxkAYLlUkpnuG0Fety62ZudqDAV5H0LAMR
	+fBxj1OKatyCD5
Received: by mail.gmx.net (sSMTP sendmail emulation); Sat, 25 Apr 2009 18:13:00 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org,
	u.kleine-koenig@pengutronix.de
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117554>

The patch should apply cleanly on 9f685cd79.
Or fetch it from branch t/tg-push at git://mawercer.de/topGit

Until now you've had two choices:

git push --all # pushing all top-bases and all other branches
or run
git push t/foo top-bases/foo # + all deps manually

tg push allows you to
a) push branch and its base, the branch you're on is used
b) push branch its deps and their bases (adding -r)

using tg push remoteA remoteB you can push to multiple remote locations.

Marc Weber

commit 2db369ff6dcfe9d5c4a9bab3eaf33c2a9b742f3d
Author: Marc Weber <marco-oweber@gmx.de>
Date:   Sat Apr 25 17:52:44 2009 +0200

    add tg-push [-r] pushing the branch and its base
    
    -r: also push tgish dependencies
    
    Signed-off-by: Marc Weber <marco-oweber@gmx.de>

diff --git a/.gitignore b/.gitignore
index eb56446..2f6d991 100644
--- a/.gitignore
+++ b/.gitignore
@@ -21,6 +21,8 @@
 /tg-import.txt
 /tg-remote
 /tg-remote.txt
+/tg-push
+/tg-push.txt
 /tg
 .*.swp
 
diff --git a/README b/README
index d2f095d..f90a7b3 100644
--- a/README
+++ b/README
@@ -480,6 +480,13 @@ tg update
 
 	TODO: tg update -a for updating all topic branches
 
+tg push
+~~~~~~~
+	git push remote branch doesn't push the base.
+        git push remote pushes all branches (and bases)
+        You use tg push [-r] to push only the current branch [ and deps] with
+        its base to a remote location.
+
 TODO: tg rename
 
 
diff --git a/tg-push.sh b/tg-push.sh
new file mode 100644
index 0000000..0f8c964
--- /dev/null
+++ b/tg-push.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# GPLv2
+
+recurse=
+remotes=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-r)
+		recurse=1;;
+	*)
+		remotes="$remotes $arg";;
+	esac
+done
+
+if [ -z "$remotes" ]; then
+	remotes="$(git config topgit.remote 2>/dev/null)"
+fi
+
+if [ -z "$remotes" ]; then
+	die "no remote location given. Either add a remote as additional argument or set topgit.remote"
+fi
+
+name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+ref_exists "$name" || die "detached HEAD? Can't push that"
+
+push_branch(){

+	echo "$_dep" >> "$to_be_pushed"
+	base="top-bases/$_dep"
+	if ref_exists "$base"; then
+		echo "top-bases/$_dep" >> "$to_be_pushed"
+	else
+		echo "warning, no base found $base"
+	fi
+}
+
+to_be_pushed="$(mktemp -t tg-depsfile.XXXXXX)"
+trap 'rm -rf "$to_be_pushed"' EXIT
+
+for remote in $remotes; do
+	: > $to_be_pushed # empty file
+
+	if [ -n "$recurse" ]; then
+		recurse_deps push_branch "$name"
+	fi
+	_dep="$name"
+	_dep_is_tgish=1
+	push_branch
+	echo git push $remote `cat $to_be_pushed`
+	git push $remote `cat $to_be_pushed`
+done
diff --git a/tg-push.txt b/tg-push.txt
new file mode 100644
index 0000000..de9b259
--- /dev/null
+++ b/tg-push.txt
@@ -0,0 +1,3 @@
+	push branch and base. If you also use -r all tgish dependencies
+        will be pushed as well.
+        Use tg push remoteA remoteB to push to remoteA and remoteB locations
