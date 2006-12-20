X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] Add a test for git-rerere
Date: Wed, 20 Dec 2006 17:37:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612201737190.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 16:38:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34948>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx4SF-0004CU-CE for gcvg-git@gmane.org; Wed, 20 Dec
 2006 17:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030202AbWLTQhs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 11:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWLTQhs
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 11:37:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:38723 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030202AbWLTQhr
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 11:37:47 -0500
Received: (qmail invoked by alias); 20 Dec 2006 16:37:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 20 Dec 2006 17:37:46 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/t4200-rerere.sh |  154 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
new file mode 100644
index 0000000..263c3d4
--- /dev/null
+++ b/t/t4200-rerere.sh
@@ -0,0 +1,154 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Johannes E. Schindelin
+#
+
+test_description='git-rerere
+'
+
+. ./test-lib.sh
+
+cat > a1 << EOF
+Whether 'tis nobler in the mind to suffer
+The slings and arrows of outrageous fortune,
+Or to take arms against a sea of troubles,
+And by opposing end them? To die: to sleep;
+No more; and by a sleep to say we end
+The heart-ache and the thousand natural shocks
+That flesh is heir to, 'tis a consummation
+Devoutly to be wish'd.
+EOF
+
+git add a1
+git commit -q -a -m initial
+
+git checkout -b first
+cat >> a1 << EOF
+To die, to sleep;
+To sleep: perchance to dream: ay, there's the rub;
+For in that sleep of death what dreams may come
+When we have shuffled off this mortal coil,
+Must give us pause: there's the respect
+That makes calamity of so long life;
+EOF
+git commit -q -a -m first
+
+git checkout -b second master
+git show first:a1 | sed 's/To die, t/To die! T/' > a1
+git commit -q -a -m second
+
+# activate rerere
+mkdir .git/rr-cache
+
+test_expect_failure 'conflicting merge' 'git pull . first'
+
+sha1=4f58849a60b4f969a2848966b6d02893b783e8fb
+rr=.git/rr-cache/$sha1
+test_expect_success 'recorded preimage' "grep ======= $rr/preimage"
+
+test_expect_success 'no postimage or thisimage yet' \
+	"test ! -f $rr/postimage -a ! -f $rr/thisimage"
+
+git show first:a1 > a1
+
+cat > expect << EOF
+--- a/a1
++++ b/a1
+@@ -6,11 +6,7 @@
+ The heart-ache and the thousand natural shocks
+ That flesh is heir to, 'tis a consummation
+ Devoutly to be wish'd.
+-<<<<<<<
+-To die! To sleep;
+-=======
+ To die, to sleep;
+->>>>>>>
+ To sleep: perchance to dream: ay, there's the rub;
+ For in that sleep of death what dreams may come
+ When we have shuffled off this mortal coil,
+EOF
+
+git rerere diff > out
+
+test_expect_success 'rerere diff' 'diff -u expect out'
+
+cat > expect << EOF
+a1
+EOF
+
+git rerere status > out
+
+test_expect_success 'rerere status' 'diff -u expect out'
+
+test_expect_success 'commit succeeds' \
+	"git commit -q -a -m 'prefer first over second'"
+
+test_expect_success 'recorded postimage' "test -f $rr/postimage"
+
+git checkout -b third master
+git show second^:a1 | sed 's/To die: t/To die! T/' > a1
+git commit -q -a -m third
+
+test_expect_failure 'another conflicting merge' 'git pull . first'
+
+git show first:a1 | sed 's/To die: t/To die! T/' > expect
+test_expect_success 'rerere kicked in' "! grep ======= a1"
+
+test_expect_success 'rerere prefers first change' 'diff -u a1 expect'
+
+rm $rr/postimage
+echo -ne "$sha1\ta1\0" > .git/rr-cache/MERGE_RR
+
+test_expect_success 'rerere clear' 'git rerere clear'
+
+test_expect_success 'clear removed the directory' "test ! -d $rr"
+
+mkdir $rr
+echo Hello > $rr/preimage
+echo World > $rr/postimage
+
+sha2=4000000000000000000000000000000000000000
+rr2=.git/rr-cache/$sha2
+mkdir $rr2
+echo Hello > $rr2/preimage
+
+case "$(date -d @11111111 +%s 2>/dev/null)" in
+[1-9]*)
+	# it is a recent GNU date. good.
+	now=$(date +%s)
+	let almost_15_days_ago=$now+60-15*86400
+	let just_over_15_days_ago=$now-1-15*86400
+	let almost_60_days_ago=$now+60-60*86400
+	let just_over_60_days_ago=$now-1-60*86400
+	predate1="$(date -d "@$almost_60_days_ago" +%c)"
+	predate2="$(date -d "@$almost_15_days_ago" +%c)"
+	postdate1="$(date -d "@$just_over_60_days_ago" +%c)"
+	postdate2="$(date -d "@$just_over_15_days_ago" +%c)"
+	;;
+*)
+	# it is not GNU date. oh, well.
+	predate1="$(date)"
+	predate2="$(date)"
+	postdate1='1 Oct 2006 00:00:00'
+	postdate2='1 Dec 2006 00:00:00'
+esac
+
+touch -m -d "$predate1" $rr/preimage
+touch -m -d "$predate2" $rr2/preimage
+
+test_expect_success 'garbage collection (part1)' 'git rerere gc'
+
+test_expect_success 'young records still live' \
+	"test -f $rr/preimage -a -f $rr2/preimage"
+
+touch -m -d "$postdate1" $rr/preimage
+touch -m -d "$postdate2" $rr2/preimage
+
+test_expect_success 'garbage collection (part2)' 'git rerere gc'
+
+test_expect_success 'old records rest in peace' \
+	"test ! -f $rr/preimage -a ! -f $rr2/preimage"
+
+test_done
+
+
-- 
1.4.4.2.g35224
