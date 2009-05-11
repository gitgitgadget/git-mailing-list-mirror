From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: [PATCH] topgit tg push feature
Date: Mon, 11 May 2009 23:06:14 +0200
Message-ID: <20090511210614.GA6118@gmx.de>
References: <20090425163447.GE19142@gmx.de> <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de> <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com> <20090507084355.GA11680@pengutronix.de> <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com> <20090509103625.GC13344@lapse.rw.madduck.net> <20090509190910.GA9655@gmx.de> <20090511032813.GA15540@gmx.de> <20090511195532.GA28340@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 23:06:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3chy-00056a-PN
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 23:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759057AbZEKVGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 17:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759007AbZEKVGe
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 17:06:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:46857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758376AbZEKVGd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 17:06:33 -0400
Received: (qmail invoked by alias); 11 May 2009 21:06:31 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp056) with SMTP; 11 May 2009 23:06:31 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/DQFRtYjjDvPvUhqVB5JZYxlhDjXlvaD12dTbN+W
	OPR8UVIeZpBQsz
Received: by mail.gmx.net (sSMTP sendmail emulation); Mon, 11 May 2009 23:06:15 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090511195532.GA28340@pengutronix.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118848>

Thanks to Bert Wesarg, Uwe Kleine-K=C3=B6nig and Martin f Krafft the
patch is finally ready to be comitted (?) I included ukleineks last
nitpicks.

ukleinek, usage line: remote2 =3D just another remote location.

Marc Weber

commit 0bfa198a3cae72d75ca1311bb7a8d495ca2b42cc
Author: Marc Weber <marco-oweber@gmx.de>
Date:   Mon May 11 23:04:20 2009 +0200

    add tg-push pushing the branch, its deps and their bases
   =20
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
=20
diff --git a/README b/README
index d2f095d..495c70b 100644
--- a/README
+++ b/README
@@ -480,6 +480,12 @@ tg update
=20
 	TODO: tg update -a for updating all topic branches
=20
+tg push
+~~~~~~~
+	pushes a TopGit-controlled topic branch to a remote
+	repository.  By default the remote gets all dependencies
+	(both tgish and non-tgish) and bases pushed to.
+
 TODO: tg rename
=20
=20
diff --git a/tg-push.sh b/tg-push.sh
new file mode 100644
index 0000000..5df5073
--- /dev/null
+++ b/tg-push.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# GPLv2
+
+remotes=3D"$base_remote" # honor -r flag of the tg command
+
+## Parse options see README
+
+recurse_deps=3Dtrue
+tgish_deps_only=3Dfalse
+dry_run=3D
+
+while [ -n "$1" ]; do
+	arg=3D"$1"; shift
+	case "$arg" in
+	--no-deps)
+		recurse_deps=3Dfalse;;
+	--dry-run)
+		dry_run=3D--dry-run;;
+	--tgish-only)
+		tgish_deps_only=3Dtrue;;
+	-h|--help)
+		echo "Usage: tg [-r remote] push [--dry-run] [--no-deps] [--tgish-on=
ly] [-r "remote2 remote3"]* branch*"
+		exit 0;;
+	-r)
+		remotes=3D"$remotes $1"
+		shift
+		;;
+	*)
+		branches=3D"$branches $arg";;
+	esac
+done
+
+if [ -z "$remotes" ]; then
+	remotes=3D"$(git config topgit.remote 2>/dev/null)"
+fi
+
+if [ -z "$remotes" ]; then
+	die "no remote location given. Either use -r remote argument or set t=
opgit.remote"
+fi
+
+if [ -z "$branches" ]; then
+	branches=3D"$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+fi
+
+for name in $branches; do
+	ref_exists "$name" || die "detached HEAD? Can't push $name"
+done
+
+push_branch(){
+	# if so desired omit non tgish deps
+	$tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
+
+	echo "$_dep"
+	local base=3D"top-bases/$_dep"
+	if ref_exists "$base"; then
+		echo "top-bases/$_dep"
+	else
+		echo "warning, no base found $base" 1>&2
+	fi
+}
+
+for remote in $remotes; do
+	for name in $branches; do
+		list=3D"$(
+			# deps
+			if $recurse_deps; then
+				no_remotes=3D1 recurse_deps push_branch "$name"
+			fi
+			# current branch
+			_dep=3D"$name"
+			_dep_is_tgish=3D1
+			push_branch "$name"
+		)"
+		echo "pushing:"; echo $list
+        git push $dry_run "$remote" $list
+	done
+done
diff --git a/tg.sh b/tg.sh
index 0804f73..7d98dbd 100644
--- a/tg.sh
+++ b/tg.sh
@@ -136,6 +136,7 @@ branch_annihilated()
 # of the whole function.
 # If recurse_deps() hits missing dependencies, it will append
 # them to space-separated $missing_deps list and skip them.
+# set no_remotes to any value to omit remote dependencies (-> tg push)
 recurse_deps()
 {
 	_cmd=3D"$1"; shift
@@ -145,9 +146,8 @@ recurse_deps()
 	_depsfile=3D"$(mktemp -t tg-depsfile.XXXXXX)"
 	# Check also our base against remote base. Checking our head
 	# against remote head has to be done in the helper.
-	if has_remote "top-bases/$_name"; then
+	has_remote "top-bases/$_name" && [ -z "$no_remotes" ] &&
 		echo "refs/remotes/$base_remote/top-bases/$_name" >>"$_depsfile"
-	fi
=20
 	# if the branch was annihilated, there exists no .topdeps file
 	if ! branch_annihilated "$_name"; then
@@ -366,6 +366,8 @@ help|--help|-h)
 --hooks-path)
 	# Internal command
 	echo "@hooksdir@";;
+eval)
+	eval "$@";;
 *)
 	[ -r "@cmddir@"/tg-$cmd ] || {
 		echo "Unknown subcommand: $cmd" >&2
