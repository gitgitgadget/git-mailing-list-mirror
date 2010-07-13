From: Raja R Harinath <harinath@hurrynot.org>
Subject: [PATCH] fast-import: export correctly marks larger than 2^20-1
Date: Tue, 13 Jul 2010 17:21:48 +0530
Message-ID: <1279021908-21291-1-git-send-email-harinath@hurrynot.org>
Cc: Raja R Harinath <harinath@hurrynot.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 14:02:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYeBx-00006i-Bu
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 14:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab0GMMCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 08:02:15 -0400
Received: from [117.192.154.99] ([117.192.154.99]:50532 "EHLO
	hariville.hurrynot.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751400Ab0GMMCO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 08:02:14 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2010 08:02:14 EDT
Received: by hariville.hurrynot.org (Postfix, from userid 1000)
	id 6EE841E80FBA; Tue, 13 Jul 2010 17:22:04 +0530 (IST)
X-Mailer: git-send-email 1.7.2.rc2.11.g03e33
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150898>

dump_marks_helper() has a bug when dumping marks larger than 2^20-1,
i.e., when the sparse array has more than two levels.  The bug was
that the 'base' counter was being shifted by 20 bits at level 3, and
then again by 10 bits at level 2, rather than a total shift of 20 bits
in this argument to the recursive call:

  (base + k) << m->shift

There are two ways to fix this correctly, the elegant:

  (base + k) << 10

and the one I chose due to edit distance:

  base + (k << m->shift)

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Raja R Harinath <harinath@hurrynot.org>
---
 fast-import.c          |    2 +-
 t/t9300-fast-import.sh |   57 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 309f2c5..0c79289 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1666,7 +1666,7 @@ static void dump_marks_helper(FILE *f,
 	if (m->shift) {
 		for (k = 0; k < 1024; k++) {
 			if (m->data.sets[k])
-				dump_marks_helper(f, (base + k) << m->shift,
+				dump_marks_helper(f, base + (k << m->shift),
 					m->data.sets[k]);
 		}
 	} else {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 131f032..2aeed7b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -166,6 +166,63 @@ test_expect_success \
 	 test `git rev-parse --verify master:file2` \
 	    = `git rev-parse --verify verify--import-marks:copy-of-file2`'
 
+test_tick
+mt=$(git hash-object --stdin < /dev/null)
+: >input.blob
+: >marks.exp
+: >tree.exp
+
+cat >input.commit <<EOF
+commit refs/heads/verify--dump-marks
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+test the sparse array dumping routines with exponentially growing marks
+COMMIT
+EOF
+
+i=0
+l=4
+m=6
+n=7
+while test "$i" -lt 27; do
+    cat >>input.blob <<EOF
+blob
+mark :$l
+data 0
+blob
+mark :$m
+data 0
+blob
+mark :$n
+data 0
+EOF
+    echo "M 100644 :$l l$i" >>input.commit
+    echo "M 100644 :$m m$i" >>input.commit
+    echo "M 100644 :$n n$i" >>input.commit
+
+    echo ":$l $mt" >>marks.exp
+    echo ":$m $mt" >>marks.exp
+    echo ":$n $mt" >>marks.exp
+
+    printf "100644 blob $mt\tl$i\n" >>tree.exp
+    printf "100644 blob $mt\tm$i\n" >>tree.exp
+    printf "100644 blob $mt\tn$i\n" >>tree.exp
+
+    l=$(($l + $l))
+    m=$(($m + $m))
+    n=$(($l + $n))
+
+    i=$((1 + $i))
+done
+
+sort tree.exp > tree.exp_s
+
+test_expect_success 'A: export marks with large values' '
+	cat input.blob input.commit | git fast-import --export-marks=marks.large &&
+	git ls-tree refs/heads/verify--dump-marks >tree.out &&
+	test_cmp tree.exp_s tree.out &&
+	test_cmp marks.exp marks.large'
+
 ###
 ### series B
 ###
-- 
1.7.2.rc2.11.g03e33
