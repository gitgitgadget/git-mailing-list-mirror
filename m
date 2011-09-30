From: Michal Vyskocil <mvyskocil@suse.cz>
Subject: [RFC/PATCH]: reverse bisect v 2.0
Date: Fri, 30 Sep 2011 13:42:21 +0200
Message-ID: <20110930114220.GA742@zelva.suse.cz>
References: <20110929142027.GA4936@zelva.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 13:42:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9bU5-00038a-AY
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 13:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758311Ab1I3LmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 07:42:24 -0400
Received: from nat.scz.novell.com ([213.151.88.252]:34928 "EHLO zelva.site"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755564Ab1I3LmX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 07:42:23 -0400
Received: by zelva.site (Postfix, from userid 10112)
	id C5EB4411C45B; Fri, 30 Sep 2011 13:42:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110929142027.GA4936@zelva.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182480>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The bugfix command works like the previous git bisect start --reverse.
It switch the meaning of good(s) and bad from the default regression
search approach to the bugfix one.

I don't like adding more new subcommands into bisect, so I decided to
not add ideas I have found on this mailinglist, like 'git bisect
regression' or 'yes', 'no', 'fixed', 'unfixed' or whatever.

The git bisect start/bugfix good/bad/skip log replay and vizualize were
tested (however on simple linear example).

The missing points:
 * git-bisect--helper has the "bad" hardcoded, so the commit fixing a
   bug is reffered as a bad one
 * in git bisect vizualize, the good commit is shown under refs/bad in
   gitk (however that's the same problem if user reverse the usage of
   good/bad itself).
 * documentation and tests of course

Regards
Michal Vyskocil
---
 bisect.c      |    2 +-
 git-bisect.sh |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++---=
---
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index c7b7d79..2eb34db 100644
--- a/bisect.c
+++ b/bisect.c
@@ -768,7 +768,7 @@ static void handle_bad_merge_base(void)
=20
 	fprintf(stderr, "Some good revs are not ancestor of the bad rev.\n"
 		"git bisect cannot work properly in this case.\n"
-		"Maybe you mistake good and bad revs?\n");
+		"Try git bisect bugfix to switch the default bisect logic.\n");
 	exit(1);
 }
=20
diff --git a/git-bisect.sh b/git-bisect.sh
index 2524060..6959cf8 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -4,7 +4,9 @@ USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|rep=
lay|log|run]'
 LONG_USAGE=3D'git bisect help
 	print this long help message.
 git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
-	reset bisect state and start bisection.
+	reset bisect state and start bisection to find a regression.
+git bisect bugfix [--no-checkout] [<good> [<bad>...]] [--] [<pathspec>...]
+	reset bisect state and start bisection to find a bugfix.
 git bisect bad [<rev>]
 	mark <rev> a known-bad revision.
 git bisect good [<rev>...]
@@ -33,6 +35,29 @@ OPTIONS_SPEC=3D
 _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
=20
+setup_bugfix_mode() {
+	/bin/touch "$GIT_DIR/BISECT_BUGFIX"
+}
+
+bisect_bugfix_mode() {
+	test -f "$GIT_DIR/BISECT_BUGFIX"
+}
+
+bisect_check_state() {
+
+	if bisect_bugfix_mode; then
+		if test "$1" =3D "good"; then
+			echo "bad"
+			return 0
+		elif test "$1" =3D "bad"; then
+			echo "good"
+			return 0
+		fi
+	fi
+
+	echo $1
+}
+
 bisect_head()
 {
 	if test -f "$GIT_DIR/BISECT_HEAD"
@@ -69,6 +94,15 @@ bisect_start() {
 	# Check for one bad and then some good revisions.
 	#
 	has_double_dash=3D0
+	#
+	# Exchange the internal meaning of good/bad allowing bisect to find
+	# a commit fixing a bug, not "only" the one causes a regression
+	#
+	cmd=3D"start"
+	if test -n "$1" && test "$1" =3D "bugfix"; then
+		cmd=3D"bugfix"
+		shift 1
+	fi
 	for arg; do
 		case "$arg" in --) has_double_dash=3D1; break ;; esac
 	done
@@ -99,10 +133,17 @@ bisect_start() {
 				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
 				break
 			}
-			case $bad_seen in
-			0) state=3D'bad' ; bad_seen=3D1 ;;
-			*) state=3D'good' ;;
-			esac
+			#if test $cmd =3D "bisect"; then
+				case $bad_seen in
+				0) state=3D'bad' ; bad_seen=3D1 ;;
+				*) state=3D'good' ;;
+				esac
+			#else
+			#	case $bad_seen in
+			#	0) state=3D'good' ; bad_seen=3D1 ;;
+			#	*) state=3D'bad' ;;
+			#	esac
+			#fi
 			eval=3D"$eval bisect_write '$state' '$rev' 'nolog' &&"
 			shift
 			;;
@@ -169,7 +210,10 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
-	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
+	echo "git bisect $cmd$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
+	if test $cmd =3D "bugfix"; then
+		setup_bugfix_mode || exit
+	fi
 	#
 	# Check if we can proceed to the next bisect state.
 	#
@@ -225,7 +269,7 @@ bisect_skip() {
=20
 bisect_state() {
 	bisect_autostart
-	state=3D$1
+	state=3D$(bisect_check_state $1)
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")=
" ;;
@@ -377,6 +421,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_BUGFIX" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -401,7 +446,12 @@ bisect_replay () {
 		start)
 			cmd=3D"bisect_start $rev"
 			eval "$cmd" ;;
+		bugfix)
+			cmd=3D"bisect_start 'bugfix' $rev"
+			setup_bugfix_mode || exit
+			eval "$cmd" ;;
 		good|bad|skip)
+			command=3D$(bisect_check_state $1)
 			bisect_write "$command" "$rev" ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
@@ -485,6 +535,8 @@ case "$#" in
 		git bisect -h ;;
 	start)
 		bisect_start "$@" ;;
+	bugfix)
+		bisect_start "bugfix" "$@" ;;
 	bad|good)
 		bisect_state "$cmd" "$@" ;;
 	skip)
--=20
1.7.6.3


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk6FqxwACgkQGwzgx2QvQgTA1ACgguVYhYc96Y8H8Yqv8XOEhRAx
Pf0AnRGb9TX3qNDKrp5ZpOBMX3MBMXor
=6jmP
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
