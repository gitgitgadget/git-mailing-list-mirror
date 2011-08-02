From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v13 1/8] bisect: move argument parsing before state modification.
Date: Tue,  2 Aug 2011 21:28:58 +1000
Message-ID: <1312284545-2426-2-git-send-email-jon.seymour@gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 13:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDAl-0004Rs-17
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 13:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab1HBLaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 07:30:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41800 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab1HBL34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 07:29:56 -0400
Received: by gyh3 with SMTP id 3so3985580gyh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 04:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZxVwOWnOt5HIILPz3VmFmls+NwYXzamsehljUdvKoLo=;
        b=gZ7w91rxmMP5eWKYEwyN8CyNq293GEi2ZeELz7BgDK2fqRyz9mtIUr27X4v5vyGKv5
         yrYyfHlhFY2xyQpAX/dzUCh4yQ6p3ls7k86K+8TXgTzAIGqQJ5HX8ef7y76IbePMn522
         v9Y/GwIEl68q6gJLzpcecw8ceVQFovgBVQrjA=
Received: by 10.142.71.4 with SMTP id t4mr3526527wfa.101.1312284595036;
        Tue, 02 Aug 2011 04:29:55 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id t20sm3715018wfe.12.2011.08.02.04.29.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 04:29:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g3461
In-Reply-To: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178451>

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
1.7.6.353.g3461
