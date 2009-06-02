From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] bisect: add "--ratio=<ratio>" option to "git bisect skip"
Date: Tue, 02 Jun 2009 22:16:32 +0200
Message-ID: <20090602201634.3630.25125.chriscool@tuxfamily.org>
References: <20090602200731.3630.33652.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBaRf-0008Np-Eb
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 22:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbZFBURo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 16:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbZFBURn
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:17:43 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:55064 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754820AbZFBURk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:17:40 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id EBFA4D48212;
	Tue,  2 Jun 2009 22:17:34 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id CABB0D480E6;
	Tue,  2 Jun 2009 22:17:31 +0200 (CEST)
X-git-sha1: 5da47be5d99ff57aab493c8f9e40a2e1d40cc534 
X-Mailer: git-mail-commits v0.4.5
In-Reply-To: <20090602200731.3630.33652.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120540>

This option will be passed to "git bisect--helper" using its
"--skip-ratio" option.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 8969553..176b21d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -9,7 +9,7 @@ git bisect bad [<rev>]
         mark <rev> a known-bad revision.
 git bisect good [<rev>...]
         mark <rev>... known-good revisions.
-git bisect skip [(<rev>|<range>)...]
+git bisect skip [--ratio=<ratio>] [(<rev>|<range>)...]
         mark <rev>... untestable revisions.
 git bisect next
         find next bisection to test and check it out.
@@ -178,18 +178,27 @@ check_expected_revs() {
 }
 
 bisect_skip() {
-        all=''
-	for arg in "$@"
+	all=''
+	unset BISECT_SKIP_RATIO
+	while [ $# -gt 0 ]
 	do
-	    case "$arg" in
-            *..*)
-                revs=$(git rev-list "$arg") || die "Bad rev input: $arg" ;;
-            *)
-                revs=$(git rev-parse --sq-quote "$arg") ;;
-	    esac
-            all="$all $revs"
-        done
-        eval bisect_state 'skip' $all
+		arg="$1"
+		case "$arg" in
+		--ratio)
+			shift; BISECT_SKIP_RATIO="$1" ;;
+		--ratio=*)
+			BISECT_SKIP_RATIO=$(expr "$arg" : '--ratio=\(.*\)') ;;
+		*..*)
+			revs=$(git rev-list "$arg") ||
+			die "Bad rev input: $arg"
+			all="$all $revs" ;;
+		*)
+			revs=$(git rev-parse --sq-quote "$arg")
+			all="$all $revs" ;;
+		esac
+		shift
+	done
+	eval bisect_state 'skip' $all
 }
 
 bisect_state() {
@@ -270,8 +279,10 @@ bisect_next() {
 	bisect_autostart
 	bisect_next_check good
 
+	skip_ratio="${BISECT_SKIP_RATIO+--skip-ratio=$BISECT_SKIP_RATIO}"
+
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all
+	git bisect--helper --next-all $skip_ratio
 	res=$?
 
         # Check if we should exit because bisection is finished
-- 
1.6.3.GIT
