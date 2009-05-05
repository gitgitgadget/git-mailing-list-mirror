From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: [PATCH] topgit tg push feature
Date: Tue, 5 May 2009 11:34:48 +0200
Message-ID: <20090505093448.GC16524@gmx.de>
References: <20090425161300.GD19142@gmx.de> <20090425163447.GE19142@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: u.kleine-koenig@pengutronix.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 11:39:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1H3S-0007R9-6R
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 11:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbZEEJew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 05:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbZEEJew
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 05:34:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:55603 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752993AbZEEJev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 05:34:51 -0400
Received: (qmail invoked by alias); 05 May 2009 09:34:49 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp070) with SMTP; 05 May 2009 11:34:49 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/ojrMZLNTogpUzOOCGypCJyUFQpgFRFd3Zg0FmCK
	8OmDf0HqKFegxP
Received: by mail.gmx.net (sSMTP sendmail emulation); Tue, 05 May 2009 11:34:48 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org,
	u.kleine-koenig@pengutronix.de
Content-Disposition: inline
In-Reply-To: <20090425163447.GE19142@gmx.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118284>

updated version is availible:
changes:
* push deps (even non-tgish) by default. You can switch off both by
  --no-deps and --only-tgish
* fixed remote check
* adding --dry-run
* no longer using temp file.


The patch should apply cleanly on 9f685cd79.
You can also get it by pulling from branch t/tg-push at git://mawercer.de/topGit


commit 30f6a7bc1d656249643f0c59e3095620990351d8
Author: Marc Weber <marco-oweber@gmx.de>
Date:   Tue May 5 11:31:53 2009 +0200

    t/tg-push
    
    add tg-push  pushing the branch, its deps and their bases
    
    Usage: tg push [(--no-deps | --tgish-only)] remote*
    
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
index d2f095d..290e883 100644
--- a/README
+++ b/README
@@ -480,6 +480,19 @@ tg update
 
 	TODO: tg update -a for updating all topic branches
 
+tg push
+~~~~~~~
+	Usage: tg push [(--no-deps | --tgish-only)] remote*
+	
+	$git push remote branch # this doesn't push the base.
+	$git push remote        # pushes all branches (and bases)
+	You use
+
+	$tg push remote
+	to push the current branch, its deps and their both tgish
+	and non-tgish deps. You may add --no-deps and or --tgish-only
+	to change this default behaviour
+
 TODO: tg rename
 
 
diff --git a/tg-push.sh b/tg-push.sh
new file mode 100644
index 0000000..e79c19f
--- /dev/null
+++ b/tg-push.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# GPLv2
+
+remotes=
+
+## Parse options see README
+
+recurse_deps=1
+tgish_deps_only=
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	--no-deps)
+		recurse_deps=;;
+	--dry-run)
+		dry_run=1;;
+	--tgish-only)
+		tgish_deps_only=1;;
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
+	# don't push remotes, don't push non tg branches
+	[ -n "${_dep##*/remotes/*}" ] || [ -n "$_dep_is_tgish" ] || return 0
+	# if so desired omit non tgish deps
+	[ -z "$tgish_deps_only" ] || [ -n "$_dep_is_tgish" ] || return 0
+
+	echo "$_dep"
+	local base="top-bases/$_dep"
+	if ref_exists "$base"; then
+		echo "top-bases/$_dep"
+	else
+		echo "warning, no base found $base" 1>&2
+	fi
+}
+
+for remote in $remotes; do
+	list="$(
+		# deps
+		if [ -n "$recurse_deps" ]; then
+			recurse_deps push_branch "$name"
+		fi
+		# current branch
+		_dep="$name"
+		_dep_is_tgish=1
+	)"
+	echo "pushing:"; echo $list
+	if [ -n "$dry_run" ]; then
+		echo git push $remote $list
+	else
+		git push $remote $list
+	fi
+done
