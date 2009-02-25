From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] [TOPGIT] allow working with annihilated branches
Date: Wed, 25 Feb 2009 21:03:57 +0100
Message-ID: <1235592240-12616-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090225195856.GA12372@pengutronix.de>
 <1235592240-12616-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 21:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcQ0u-0007ne-My
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208AbZBYUEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 15:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758189AbZBYUEG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:04:06 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45153 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758149AbZBYUEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 15:04:02 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0002ld-8m
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0003Hu-6U
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1235592240-12616-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111488>

If you decide that you want to drop a patch, you can just merge in its
base with strategy "theirs".  Then you have base=3Dtopic and so no .top=
*
files any more.  This patch fixes tg summary and the helper function
recurse_deps() to handle these annihilated branches as if they don't
exist and don't show up in .topdeps files.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 tg-summary.sh |   11 ++++++++++-
 tg.sh         |   17 ++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tg-summary.sh b/tg-summary.sh
index 842d95a..50ee883 100644
--- a/tg-summary.sh
+++ b/tg-summary.sh
@@ -53,13 +53,22 @@ fi
 git for-each-ref refs/top-bases |
 	while read rev type ref; do
 		name=3D"${ref#refs/top-bases/}"
+		if branch_annihilated "$name"; then
+			continue;
+		fi;
+
 		if [ -n "$terse" ]; then
 			echo "$name"
 			continue
 		fi
 		if [ -n "$graphviz" ]; then
 			git cat-file blob "$name:.topdeps" | while read dep; do
-				echo "\"$name\" -> \"$dep\";"
+				dep_is_tgish=3Dtrue
+				ref_exists "refs/top-bases/$dep"  ||
+					dep_is_tgish=3Dfalse
+				if ! "$dep_is_tgish" || ! branch_annihilated $dep; then
+					echo "\"$name\" -> \"$dep\";"
+				fi
 			done
 			continue
 		fi
diff --git a/tg.sh b/tg.sh
index ccb40cd..5bb2d0c 100644
--- a/tg.sh
+++ b/tg.sh
@@ -94,6 +94,16 @@ has_remote()
 	[ -n "$base_remote" ] && ref_exists "remotes/$base_remote/$1"
 }
=20
+branch_annihilated()
+{
+	_name=3D"$1";
+
+	# use the merge base in case the base is ahead.
+	mb=3D"$(git merge-base "refs/top-bases/$_name" "$_name")";
+
+	test "$(git rev-parse "$mb^{tree}")" =3D "$(git rev-parse "$_name^{tr=
ee}")";
+}
+
 # recurse_deps CMD NAME [BRANCHPATH...]
 # Recursively eval CMD on all dependencies of NAME.
 # CMD can refer to $_name for queried branch name,
@@ -116,7 +126,12 @@ recurse_deps()
 	if has_remote "top-bases/$_name"; then
 		echo "refs/remotes/$base_remote/top-bases/$_name" >>"$_depsfile"
 	fi
-	git cat-file blob "$_name:.topdeps" >>"$_depsfile"
+
+	# if the branch was annihilated, there exists no .topdeps file
+	if ! branch_annihilated "$_name"; then
+		#TODO: handle nonexisting .topdeps?
+		git cat-file blob "$_name:.topdeps" >>"$_depsfile";
+	fi;
=20
 	_ret=3D0
 	while read _dep; do
--=20
1.5.6.5
