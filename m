From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Update tests to use test-chmtime
Date: Sat, 24 Feb 2007 16:59:52 -0800
Message-ID: <11723651934078-git-send-email-normalperson@yhbt.net>
References: <11723651923476-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 02:00:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL7kJ-0000xs-W4
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 02:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbXBYA75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 19:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932931AbXBYA74
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 19:59:56 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35751 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932934AbXBYA7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 19:59:55 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C552E2DC032;
	Sat, 24 Feb 2007 16:59:53 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Feb 2007 16:59:53 -0800
X-Mailer: git-send-email 1.5.0.137.ge6502
In-Reply-To: <11723651923476-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40529>

t4200-rerere:
  Removed non-portable date dependency and avoid touch
  Avoid "test -a" which isn't portable, either

lib-git-svn:
  Use test-chmtime instead of Perl one-liner to poke

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/lib-git-svn.sh  |    2 +-
 t/t4200-rerere.sh |   54 ++++++++++++++++++++--------------------------------
 2 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 27ad3b7..f6fe78c 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -46,5 +46,5 @@ rawsvnrepo="$svnrepo"
 svnrepo="file://$svnrepo"
 
 poke() {
-	perl -e '@x = stat($ARGV[0]); utime($x[8], $x[9] + 1, $ARGV[0])' "$1"
+	test-chmtime +1 "$1"
 }
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index c571a1b..d5bb6ec 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -112,39 +112,27 @@ rr2=.git/rr-cache/$sha2
 mkdir $rr2
 echo Hello > $rr2/preimage
 
-case "$(date -d @11111111 +%s 2>/dev/null)" in
-11111111)
-	# 'date' must be able to take arbitrary input with @11111111 notation.
-	# for this test to succeed.  We should fix this part using more
-	# portable script someday.
-
-	now=$(date +%s)
-	almost_15_days_ago=$(($now+60-15*86400))
-	just_over_15_days_ago=$(($now-1-15*86400))
-	almost_60_days_ago=$(($now+60-60*86400))
-	just_over_60_days_ago=$(($now-1-60*86400))
-	predate1="$(date -d "@$almost_60_days_ago" +%Y%m%d%H%M.%S)"
-	predate2="$(date -d "@$almost_15_days_ago" +%Y%m%d%H%M.%S)"
-	postdate1="$(date -d "@$just_over_60_days_ago" +%Y%m%d%H%M.%S)"
-	postdate2="$(date -d "@$just_over_15_days_ago" +%Y%m%d%H%M.%S)"
-
-	touch -m -t "$predate1" $rr/preimage
-	touch -m -t "$predate2" $rr2/preimage
-
-	test_expect_success 'garbage collection (part1)' 'git rerere gc'
-
-	test_expect_success 'young records still live' \
-		"test -f $rr/preimage -a -f $rr2/preimage"
-
-	touch -m -t "$postdate1" $rr/preimage
-	touch -m -t "$postdate2" $rr2/preimage
-
-	test_expect_success 'garbage collection (part2)' 'git rerere gc'
-
-	test_expect_success 'old records rest in peace' \
-		"test ! -f $rr/preimage -a ! -f $rr2/preimage"
-	;;
-esac
+now=$(date +%s)
+almost_15_days_ago=$(($now+60-15*86400))
+just_over_15_days_ago=$(($now-1-15*86400))
+almost_60_days_ago=$(($now+60-60*86400))
+just_over_60_days_ago=$(($now-1-60*86400))
+
+test-chmtime =$almost_60_days_ago $rr/preimage
+test-chmtime =$almost_15_days_ago $rr2/preimage
+
+test_expect_success 'garbage collection (part1)' 'git rerere gc'
+
+test_expect_success 'young records still live' \
+	"test -f $rr/preimage && test -f $rr2/preimage"
+
+test-chmtime =$just_over_60_days_ago $rr/preimage
+test-chmtime =$just_over_15_days_ago $rr2/preimage
+
+test_expect_success 'garbage collection (part2)' 'git rerere gc'
+
+test_expect_success 'old records rest in peace' \
+	"test ! -f $rr/preimage && test ! -f $rr2/preimage"
 
 test_done
 
-- 
1.5.0.137.ge6502
