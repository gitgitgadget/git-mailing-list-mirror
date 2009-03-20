From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] quiltimport: use quilt to do patch/series parsing and application
Date: Fri, 20 Mar 2009 20:18:03 +0100
Message-ID: <1237576683-5516-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090320190617.GA28784@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan Nicholson <dbn.lists@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Gerrit Pape <pape@smarden.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkkFs-00074w-B1
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 20:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760008AbZCTTSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 15:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758990AbZCTTSN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 15:18:13 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36018 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758701AbZCTTSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 15:18:12 -0400
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LkkEG-0003S4-Pa; Fri, 20 Mar 2009 20:18:07 +0100
X-Mailer: git-send-email 1.6.2
In-Reply-To: <20090320190617.GA28784@pengutronix.de>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.5 tests=BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113992>

quilt supports packed patches that are not recognized by quiltimport.
Instead of adding this feature explicitly, use quilt to do the dirty
work.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Dan Nicholson <dbn.lists@gmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Gerrit Pape <pape@smarden.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Pierre Habouzit <madcoder@debian.org>
---
Hello,

note I didn't test it deeply, but I succeeded to import the preempt-rt =
patch.

Things that might be worth testing are:

	missing patches referenced in series
	patch conflicts

Best regards
Uwe

 git-quiltimport.sh |   51 ++++++++++++++++++++++++--------------------=
-------
 1 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 9a6ba2b..8b76682 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -51,6 +51,7 @@ if ! [ -d "$QUILT_PATCHES" ] ; then
 	echo "The \"$QUILT_PATCHES\" directory does not exist."
 	exit 1
 fi
+export QUILT_PATCHES
=20
 # Temporary directories
 tmp_dir=3D"$GIT_DIR"/rebase-apply
@@ -62,31 +63,23 @@ tmp_info=3D"$tmp_dir/info"
 # Find the intial commit
 commit=3D$(git rev-parse HEAD)
=20
+# TODO: assert wc =3D=3D index =3D=3D HEAD
+# TODO: assert .pc doesn't exist
+
+# detach HEAD
+git checkout -q "$commit"
+
 mkdir $tmp_dir || exit 2
-while read patch_name level garbage <&3
+while quilt unapplied > /dev/null
 do
-	case "$patch_name" in ''|'#'*) continue;; esac
-	case "$level" in
-	-p*)	;;
-	''|'#'*)
-		level=3D;;
-	*)
-		echo "unable to parse patch level, ignoring it."
-		level=3D;;
-	esac
-	case "$garbage" in
-	''|'#'*);;
-	*)
-		echo "trailing garbage found in series file: $garbage"
-		exit 1;;
-	esac
-	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
-		echo "$patch_name doesn't exist. Skipping."
-		continue
-	fi
+	# apply patch
+	quilt push || exit 3
+
+	patch_name=3D"$(quilt top)";
+
 	echo $patch_name
-	git mailinfo "$tmp_msg" "$tmp_patch" \
-		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
+	(quilt header; echo "---") | git mailinfo "$tmp_msg" "$tmp_patch" \
+		>"$tmp_info" || exit 3
 	test -s "$tmp_patch" || {
 		echo "Patch is empty.  Was it split wrong?"
 		exit 1
@@ -129,10 +122,14 @@ do
 	fi
=20
 	if [ -z "$dry_run" ] ; then
-		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
-		tree=3D$(git write-tree) &&
-		commit=3D$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tre=
e $tree -p $commit) &&
-		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
+		quilt files | git update-index --add --remove --stdin &&
+		(echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit -F - ||
+		exit 4
 	fi
-done 3<"$QUILT_PATCHES/series"
+done
+
+if [ -n "$dry_run" ] ; then
+	quilt pop -a;
+fi
+
 rm -rf $tmp_dir || exit 5
--=20
1.6.2
