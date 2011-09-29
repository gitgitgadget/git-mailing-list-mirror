From: Michal Vyskocil <mvyskocil@suse.cz>
Subject: RFC: reverse bisect
Date: Thu, 29 Sep 2011 16:20:29 +0200
Message-ID: <20110929142027.GA4936@zelva.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 16:20:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9HTY-00083f-3i
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 16:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab1I2OUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 10:20:31 -0400
Received: from nat.scz.novell.com ([213.151.88.252]:38460 "EHLO zelva.site"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752452Ab1I2OUa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 10:20:30 -0400
Received: by zelva.site (Postfix, from userid 10112)
	id 482F6411C45B; Thu, 29 Sep 2011 16:20:29 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182398>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Following proposed patch try to implement reverse mode for git bisect.

The git bisect command is written in the regression-finding in mind. IOW
it expects the good commit is older than the later one, which caused a
regression.

However common usage for (at least) package maintainer is not to find a
regression and fix it. The main task it to identify a bugfix!. In this
case git bisect is still helpfull as it reduces a time a lot, but user
needs to exchange the good<->bad in his mind, which is confusing and in
case there are delays in the work, it's trivial to forgot that I have to
type git bisect good, when I'm in the bad revision.

This simple patch try to address the problem of poor package
maintainer's brain and introduces --reverse argument for the git bisect
start command.

In this mode, bisect internally exchange the behavior of good/bad
itself, so there's no need to do it manually. I did some basic testing
and

git bisect start --reverse HEAD~999 HEAD
git bisect good/bad/skip/run

really works well, allowing user to identify a first good commit instead
of the first bad one. I did not test other commands like visualize or
replay.

What do you think about it? Do you see other problems I'm not aware of?
---
 bisect.c      |    2 +-
 git-bisect.sh |   49 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index c7b7d79..33aaeaa 100644
--- a/bisect.c
+++ b/bisect.c
@@ -768,7 +768,7 @@ static void handle_bad_merge_base(void)
=20
 	fprintf(stderr, "Some good revs are not ancestor of the bad rev.\n"
 		"git bisect cannot work properly in this case.\n"
-		"Maybe you mistake good and bad revs?\n");
+		"Try --reverse to switch the bisect logic.\n");
 	exit(1);
 }
=20
diff --git a/git-bisect.sh b/git-bisect.sh
index 2524060..5c95f25 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -33,6 +33,25 @@ OPTIONS_SPEC=3D
 _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
=20
+bisect_reverse_mode() {
+	test -f "$GIT_DIR/BISECT_REVERSE"
+}
+
+bisect_reverse_state() {
+
+	if bisect_reverse_mode; then
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
@@ -69,6 +88,11 @@ bisect_start() {
 	# Check for one bad and then some good revisions.
 	#
 	has_double_dash=3D0
+	#
+	# Exchange the internal meainng of good/bad allowing bisect to find
+	# a commit fixing a bug, not "only" the one causes a regression
+	#
+	reverse_mode=3D1
 	for arg; do
 		case "$arg" in --) has_double_dash=3D1; break ;; esac
 	done
@@ -91,6 +115,9 @@ bisect_start() {
 		--no-checkout)
 			mode=3D--no-checkout
 			shift ;;
+		--reverse)
+			reverse_mode=3D0
+			shift ;;
 		--*)
 			die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 		*)
@@ -99,10 +126,17 @@ bisect_start() {
 				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
 				break
 			}
-			case $bad_seen in
-			0) state=3D'bad' ; bad_seen=3D1 ;;
-			*) state=3D'good' ;;
-			esac
+			if test $reverse_mode -ne 0; then
+				case $bad_seen in
+				0) state=3D'bad' ; bad_seen=3D1 ;;
+				*) state=3D'good' ;;
+				esac
+			else
+				case $bad_seen in
+				0) state=3D'good' ; bad_seen=3D1 ;;
+				*) state=3D'bad' ;;
+				esac
+			fi
 			eval=3D"$eval bisect_write '$state' '$rev' 'nolog' &&"
 			shift
 			;;
@@ -170,6 +204,9 @@ bisect_start() {
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
+	if test $reverse_mode -eq 0; then
+		/bin/touch "$GIT_DIR/BISECT_REVERSE" || exit
+	fi
 	#
 	# Check if we can proceed to the next bisect state.
 	#
@@ -225,7 +262,7 @@ bisect_skip() {
=20
 bisect_state() {
 	bisect_autostart
-	state=3D$1
+	state=3D$(bisect_reverse_state $1)
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")=
" ;;
@@ -377,6 +414,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_REVERSE" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -402,6 +440,7 @@ bisect_replay () {
 			cmd=3D"bisect_start $rev"
 			eval "$cmd" ;;
 		good|bad|skip)
+			command=3D$(bisect_reverse_state $1)
 			bisect_write "$command" "$rev" ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
--=20
1.7.6.3


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk6EfqsACgkQGwzgx2QvQgTgqwCfcs5Jc7LJGmB124o2OLLZL4+o
kHUAoIfWN8ciAZ/RKwO3ZSHbA/NLYBCp
=Gwp1
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
