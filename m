From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v11 1/7] bisect: move argument parsing before state modification.
Date: Mon,  1 Aug 2011 21:56:11 +1000
Message-ID: <1312199777-10144-2-git-send-email-jon.seymour@gmail.com>
References: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnr7X-00062W-ET
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab1HAL5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:57:01 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42860 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab1HAL44 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:56:56 -0400
Received: by ywn13 with SMTP id 13so633522ywn.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zpV8mBlYSU+wtLhNQnYbAU+GMSCStG72x4dF5vAxZnA=;
        b=E8TjgtBmWVr9LrLL7UYgXZQaqzBpw3yGzDwFsY+GHN8IjIIGJsShBqGgLkRfAik8xk
         RhjEdMl9LDt/v2GUyL60HqKUiYIqnws5yx2Xx+M2MaQhdn8OfIVFvUSKr6ld490G6AJN
         SfyVFCJLm8VkkAe2Xh4Dqrp16g8a8khqhyweQ=
Received: by 10.142.144.15 with SMTP id r15mr2954140wfd.439.1312199814980;
        Mon, 01 Aug 2011 04:56:54 -0700 (PDT)
Received: from localhost.localdomain ([120.16.6.238])
        by mx.google.com with ESMTPS id a4sm3060009wfm.4.2011.08.01.04.56.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 04:56:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g0c69b
In-Reply-To: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178338>

Currently 'git bisect start' modifies some state prior to checking
that its arguments are valid.

This change moves argument validation before state modification
with the effect that state modification does not occur
unless argument validations succeeds.

An existing test is changed to check that new bisect state
is not created if arguments are invalid.

A new test is added to check that existing bisect state
is not modified if arguments are invalid.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh               |   66 +++++++++++++++++++++---------------------
 t/t6030-bisect-porcelain.sh |   14 +++++++--
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b2186a8..20f6dd5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -60,6 +60,39 @@ bisect_autostart() {
 
 bisect_start() {
 	#
+	# Check for one bad and then some good revisions.
+	#
+	has_double_dash=0
+	for arg; do
+	    case "$arg" in --) has_double_dash=1; break ;; esac
+	done
+	orig_args=$(git rev-parse --sq-quote "$@")
+	bad_seen=0
+	eval=''
+	while [ $# -gt 0 ]; do
+	    arg="$1"
+	    case "$arg" in
+	    --)
+		shift
+		break
+		;;
+	    *)
+		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
+		    test $has_double_dash -eq 1 &&
+			die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
+		    break
+		}
+		case $bad_seen in
+		0) state='bad' ; bad_seen=1 ;;
+		*) state='good' ;;
+		esac
+		eval="$eval bisect_write '$state' '$rev' 'nolog'; "
+		shift
+		;;
+	    esac
+	done
+
+	#
 	# Verify HEAD.
 	#
 	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref -q HEAD) ||
@@ -98,39 +131,6 @@ bisect_start() {
 	bisect_clean_state || exit
 
 	#
-	# Check for one bad and then some good revisions.
-	#
-	has_double_dash=0
-	for arg; do
-	    case "$arg" in --) has_double_dash=1; break ;; esac
-	done
-	orig_args=$(git rev-parse --sq-quote "$@")
-	bad_seen=0
-	eval=''
-	while [ $# -gt 0 ]; do
-	    arg="$1"
-	    case "$arg" in
-	    --)
-		shift
-		break
-		;;
-	    *)
-		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
-		    test $has_double_dash -eq 1 &&
-			die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
-		    break
-		}
-		case $bad_seen in
-		0) state='bad' ; bad_seen=1 ;;
-		*) state='good' ;;
-		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog'; "
-		shift
-		;;
-	    esac
-	done
-
-	#
 	# Change state.
 	# In case of mistaken revs or checkout error, or signals received,
 	# "bisect_auto_next" below may exit or misbehave.
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b5063b6..b3d1b14 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -138,15 +138,23 @@ test_expect_success 'bisect start: back in good branch' '
 	grep "* other" branch.output > /dev/null
 '
 
-test_expect_success 'bisect start: no ".git/BISECT_START" if junk rev' '
-	git bisect start $HASH4 $HASH1 -- &&
-	git bisect good &&
+test_expect_success 'bisect start: no ".git/BISECT_START" created if junk rev' '
+	git bisect reset &&
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
 	grep "* other" branch.output > /dev/null &&
 	test_must_fail test -e .git/BISECT_START
 '
 
+test_expect_success 'bisect start: existing ".git/BISECT_START" not modified if junk rev' '
+	git bisect start $HASH4 $HASH1 -- &&
+	git bisect good &&
+	cp .git/BISECT_START saved &&
+	test_must_fail git bisect start $HASH4 foo -- &&
+	git branch > branch.output &&
+	grep "* (no branch)" branch.output > /dev/null &&
+	test_cmp saved .git/BISECT_START
+'
 test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken rev' '
 	git bisect start $HASH4 $HASH1 -- &&
 	git bisect good &&
-- 
1.7.6.352.g0c69b
