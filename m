From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Sat, 06 Jun 2009 12:51:11 -0700
Message-ID: <7vskidcf9s.fsf@alter.siamese.dyndns.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 21:59:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD22x-0004IT-02
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 21:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbZFFTvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 15:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZFFTvK
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 15:51:10 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42330 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbZFFTvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 15:51:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090606195113.KOCT17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 6 Jun 2009 15:51:13 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0jrB1c00D4aMwMQ03jrBNA; Sat, 06 Jun 2009 15:51:11 -0400
X-VR-Score: -180.00
X-Authority-Analysis: v=1.0 c=1 a=ZlvubiwuF4QA:10 a=BRJNLUJM0I0A:10
 a=hpLoFPsW44nVjqyl1tQA:9 a=jTtF_HlCZp9UHjT6CPAA:7
 a=PeQL_h33Pq2HgQmy0RoufaJPKuEA:4
X-CM-Score: 0.00
In-Reply-To: <20090606043853.4031.78284.chriscool@tuxfamily.org> (Christian Couder's message of "Sat\, 06 Jun 2009 06\:41\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120931>

Here is a fairly unscientific test to see how these three patches improve
things.  It involves two test scripts:

 - ./+runme is a "bisect run" script.  It says "tests OK" for all the
   commits given, except that it says "untestable" for all commits that
   are on the side branch of a merge that we first test.  I think this
   reflects what happens in the real world setting very well, in that a
   merge brings in a topic whose breakge is irrelevant to the bug we are
   hunting.

 - ./+runall is run in one git tree with two parameters (bad commit and
   good commit); it assumes that

   - ./+runme script above is in /var/tmp/+runme;

   - a version of git without these three patches is installed with
     prefix=/var/tmp/cc-original;

   - a version of git with these three patches is installed with
     prefix=/var/tmp/cc-updated;

   and runs the bisection using both versions of git.

The results are not that great; these three patches do not give clear win
as we hoped:

    $ linux-2.6/master; /var/tmp/+runall v2.6.30-rc8 v2.6.30-rc1
    Total 2681 commits...
    Marked 254 commits as untestable
    Took 14 rounds with cc-updated
    Marked 254 commits as untestable
    Took 13 rounds with cc-original
    $ linux-2.6/master; /var/tmp/+runall v2.6.30-rc8 v2.6.29
    Total 12917 commits...
    Marked 141 commits as untestable
    Took 15 rounds with cc-updated
    Marked 141 commits as untestable
    Took 15 rounds with cc-original
    $ linux-2.6/master; /var/tmp/+runall v2.6.30-rc1 v2.6.29
    Total 10236 commits...
    Marked 7749 commits as untestable
    Took 15 rounds with cc-updated
    Marked 7749 commits as untestable
    Took 14 rounds with cc-original

I think this shows that the "skip ratio" heuristics based on the distance
in the "goodness scale" space does not help in avoiding commits that are
close in topological space.  There may be cases where the version with
patch gives fewer rounds especially when the history is very linear, but I
was mostly interested in the number of commits at least in the thousands,
which I think is what we should optimize things for, not a toy history of
linear 100 commits.

Here are the test scripts you can use to reproduce the results.

diff --git a/+runall b/+runall
new file mode 100755
index 0000000..291d000
--- /dev/null
+++ b/+runall
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+BAD=${1?BAD}
+GOOD=${2?GOOD}
+TOTAL=$(git rev-list $GOOD..$BAD | wc -l)
+
+echo Total $TOTAL commits...
+
+for git in cc-updated cc-original
+do
+	logfile=/var/tmp/log-$git-$BAD-$GOOD
+	(
+		PATH=/var/tmp/$git/bin:$PATH
+		export PATH
+		rm -f .git/UNTESTABLE
+		git bisect reset
+		git bisect start $BAD $GOOD
+		git bisect run /var/tmp/+runme
+		git bisect reset
+	) >$logfile 2>&1
+	grep "^Marked " $logfile
+	echo Took $(grep -c "Bisecting:" $logfile) rounds with $git
+done
diff --git a/+runme b/+runme
new file mode 100755
index 0000000..7b77338
--- /dev/null
+++ b/+runme
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+# Pretend that the first merged branch were untestable
+
+THIS=$(git rev-parse HEAD)
+
+if ! test -f .git/UNTESTABLE
+then
+	if MERGED=$(git rev-parse HEAD^2 2>/dev/null)
+	then
+		git rev-list HEAD^ ^$MERGED >.git/UNTESTABLE
+		echo Marked $(wc -l <.git/UNTESTABLE) commits as untestable
+		exit 125
+	else
+		exit 0
+	fi
+fi
+
+if grep "$THIS" .git/UNTESTABLE >/dev/null
+then
+	exit 125
+fi
+exit 0




   
