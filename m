From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add a test for git-rerere
Date: Thu, 21 Dec 2006 10:21:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612211018430.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612201737190.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4prqfm6c.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612210927150.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhcvpej3i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 10:21:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxK7O-0004VI-PB
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 10:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422899AbWLUJVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 04:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422923AbWLUJVc
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 04:21:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:48319 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422920AbWLUJV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 04:21:29 -0500
Received: (qmail invoked by alias); 21 Dec 2006 09:21:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 21 Dec 2006 10:21:28 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhcvpej3i.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35038>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Thu, 21 Dec 2006, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> >> > +rm $rr/postimage
	> >> > +echo -ne "$sha1\ta1\0" > .git/rr-cache/MERGE_RR
	> >> 
	> >> Hmmmmmm.  I've stayed away from "echo -e" so far...
	> >
	> > Rather do it with tr? Like this:
	> >
	> > 	echo -n "$sha1	a1X" | tr X '\0' > .git/rr-cache/MERGE_RR
	> 
	> Bog-standard old timer's way is not to use -n nor X but just do:
	> 
	> 	echo "stuff you want to NUL terminate" | tr '\012' '\0'
	> 
	> > Is $((1+2)) portable enough? I always thought this is a bashism...
	> 
	> That's also in ksh and dash (and in POSIX) and recent updates to
	> out *.sh scripts make liberal use of them.  As long as you do
	> not overflow you are fine.

	Done.

	BTW I think this test should be 3/3 instead of 2/3, since it fails 
	with the Perl rerere if you do not have the required modules 
	installed.

 t/t4200-rerere.sh |  154 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
new file mode 100644
index 0000000..5ee5b23
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
+echo "$sha1	a1" | tr '\012' '\0' > .git/rr-cache/MERGE_RR
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
+	almost_15_days_ago=$(($now+60-15*86400))
+	just_over_15_days_ago=$(($now-1-15*86400))
+	almost_60_days_ago=$(($now+60-60*86400))
+	just_over_60_days_ago=$(($now-1-60*86400))
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
