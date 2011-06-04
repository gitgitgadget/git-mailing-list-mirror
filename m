From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH] Profile feedback based optimization
Date: Sat,  4 Jun 2011 12:38:21 -0300
Message-ID: <1307201901-8298-1-git-send-email-cesarb@cesarb.net>
Cc: Henrique Bastos <henrique@bastos.net>,
	Cesar Eduardo Barros <cesarb@cesarb.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 17:38:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSsw3-0007DS-2a
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 17:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab1FDPil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2011 11:38:41 -0400
Received: from smtp-03.mandic.com.br ([200.225.81.143]:42517 "EHLO
	smtp-03.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab1FDPil (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2011 11:38:41 -0400
Received: (qmail 19750 invoked from network); 4 Jun 2011 15:38:36 -0000
Received: from unknown (HELO localhost.localdomain) (zNDjxNx/wczd2NLJraWToZWJlF6Wp6IuYnI=@[177.41.25.169])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-03.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 4 Jun 2011 15:38:36 -0000
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175059>

gcc has options to instrument the generated executable and use the
collected information to better optimize the generated code.

To use the profile feedback options, you have to compile twice. After
the first compilation, you have to run the executable with a
representative set of data to generate the statistics for the second
compilation.

A benchmark was chosen as the representative set of data because a
benchmark focuses on measuring the code speed. A good benchmark should
be designed considering how git is commonly used, emphasizing the most
used parts, but without neglecting the less used parts.

To simplify the patch and focus on the Makefile rules, a dummy benchmark
was used, which does only a few simple operations a hundred times.

Even with just that simple benchmark, it seems to already have some
effect. These were the results of a test run of "./git fsck --full" on
the git repository, recorded via perf stat, ran twice without profile
feedback and then twice with profile feedback:

Without profile feedback:

 Performance counter stats for './git fsck --full':

       84159,595732  task-clock-msecs         #      0,998 CPUs
               8470  context-switches         #      0,000 M/sec
                  7  CPU-migrations           #      0,000 M/sec
             263682  page-faults              #      0,003 M/sec
       179028259343  cycles                   #   2127,247 M/sec
       222624952497  instructions             #      1,244 IPC
        22651880335  branches                 #    269,154 M/sec
         1798298585  branch-misses            #      7,939 %
         1380706193  cache-references         #     16,406 M/sec
          588704688  cache-misses             #      6,995 M/sec

       84,360035244  seconds time elapsed

 Performance counter stats for './git fsck --full':

       84207,836012  task-clock-msecs         #      0,998 CPUs
               8450  context-switches         #      0,000 M/sec
                  2  CPU-migrations           #      0,000 M/sec
             211878  page-faults              #      0,003 M/sec
       179131407549  cycles                   #   2127,253 M/sec
       222395625483  instructions             #      1,242 IPC
        22614432765  branches                 #    268,555 M/sec
         1798786420  branch-misses            #      7,954 %
         1384878082  cache-references         #     16,446 M/sec
          594115144  cache-misses             #      7,055 M/sec

       84,404733868  seconds time elapsed

With profile feedback:

 Performance counter stats for './git fsck --full':

       83576,534090  task-clock-msecs         #      0,998 CPUs
               8610  context-switches         #      0,000 M/sec
                 10  CPU-migrations           #      0,000 M/sec
             211882  page-faults              #      0,003 M/sec
       177777232502  cycles                   #   2127,119 M/sec
       200278330301  instructions             #      1,127 IPC
        21014495344  branches                 #    251,440 M/sec
         1659583500  branch-misses            #      7,897 %
         2297603485  cache-references         #     27,491 M/sec
         1314536406  cache-misses             #     15,729 M/sec

       83,783009768  seconds time elapsed

 Performance counter stats for './git fsck --full':

       83288,834113  task-clock-msecs         #      0,998 CPUs
               8365  context-switches         #      0,000 M/sec
                  5  CPU-migrations           #      0,000 M/sec
             174403  page-faults              #      0,002 M/sec
       177173914267  cycles                   #   2127,223 M/sec
       200234762879  instructions             #      1,130 IPC
        21006452953  branches                 #    252,212 M/sec
         1659600980  branch-misses            #      7,900 %
         2298086212  cache-references         #     27,592 M/sec
         1309056989  cache-misses             #     15,717 M/sec

       83,482945132  seconds time elapsed

Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 Makefile |   20 ++++++++++++++++++++
 bench.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100755 bench.sh

diff --git a/Makefile b/Makefile
index e40ac0c..8eaa8a0 100644
--- a/Makefile
+++ b/Makefile
@@ -2486,3 +2486,23 @@ cover_db: coverage-report
 
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
+
+### Profile feedback based optimization
+#
+.PHONY: benchmark profile-generate profile-use profile-optimized-build
+
+benchmark:
+	time ./bench.sh
+
+profile-generate:
+	$(MAKE) clean coverage-clean
+	$(MAKE) CFLAGS="$(CFLAGS) -fprofile-generate" LDFLAGS="$(LDFLAGS) -fprofile-generate" all
+
+profile-use:
+	$(MAKE) clean
+	$(MAKE) CFLAGS="$(CFLAGS) -fprofile-use" LDFLAGS="$(LDFLAGS) -fprofile-use" all
+
+profile-optimized-build:
+	$(MAKE) profile-generate
+	$(MAKE) -j1 benchmark
+	$(MAKE) profile-use
diff --git a/bench.sh b/bench.sh
new file mode 100755
index 0000000..939f3b3
--- /dev/null
+++ b/bench.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+set -eu
+
+BENCHDIR="$PWD/bench"
+GIT_BUILD_DIR="$BENCHDIR/.."
+export PATH="$GIT_BUILD_DIR/bin-wrappers:$PATH"
+
+mkdir "$BENCHDIR"
+cd "$BENCHDIR"
+
+git --version
+exec > bench.log 2>&1
+
+for count in `seq 100`; do
+
+mkdir "$BENCHDIR/test"
+cd "$BENCHDIR/test"
+git init
+echo a > a
+echo b > b
+git add a b
+git commit -m 'Commit 1'
+echo c > c
+echo d > d
+git add c d
+git commit -m 'Commit 2'
+git checkout -b branch
+echo e > e
+echo f > f
+git add e f
+git commit -m 'Commit 3'
+git checkout -
+echo g > g
+echo h > h
+git add g h
+git commit -m 'Commit 4'
+git merge branch
+git fsck --full
+cd "$BENCHDIR"
+rm -rf test
+
+done
+
+cd ..
+rm -rf "$BENCHDIR"
-- 
1.7.4.4
