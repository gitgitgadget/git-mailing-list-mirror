From: Andrew Myrick <amyrick@apple.com>
Subject: [PATCH] git-svn: update svn mergeinfo test suite
Date: Thu, 21 Jan 2010 21:55:48 +0000
Message-ID: <1264110948-627-1-git-send-email-amyrick@apple.com>
References: <E10FB265-0C47-44C7-9347-687A9F447603@apple.com>
Content-Transfer-Encoding: 7BIT
Cc: normalperson@yhbt.net, sam@vilain.net,
	Andrew Myrick <amyrick@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 22:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY515-00035K-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 22:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab0AUV4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 16:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860Ab0AUV4e
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 16:56:34 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:56936 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab0AUV4e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 16:56:34 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id E8498879DF10
	for <git@vger.kernel.org>; Thu, 21 Jan 2010 13:56:32 -0800 (PST)
X-AuditID: 11807130-b7b0aae00000102c-68-4b58cd90c403
Received: from gertie.apple.com (gertie.apple.com [17.151.62.15])
	by relay11.apple.com (Apple SCV relay) with SMTP id 5B.EB.04140.09DC85B4; Thu, 21 Jan 2010 13:56:32 -0800 (PST)
Received: from localhost.localdomain (agility.apple.com [17.201.24.116])
 by gertie.apple.com
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPSA id <0KWM00K6XAA59620@gertie.apple.com> for git@vger.kernel.org;
 Thu, 21 Jan 2010 13:56:32 -0800 (PST)
X-Mailer: git-send-email 1.6.6.2.g1fc48.dirty
In-reply-to: <E10FB265-0C47-44C7-9347-687A9F447603@apple.com>
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137694>

Add a partial branch (e.g., a branch from a project subdirectory) to the
git-svn mergeinfo test repository.

Add a tag and a branch from that tag to the git-svn mergeinfo test repository.

Update the test script to expect a known failure in git-svn exposed by these
additions where merge info for partial branches is not preserved.

Signed-off-by: Andrew Myrick <amyrick@apple.com>
---
 t/t9151-svn-mergeinfo.sh   |    2 +-
 t/t9151/make-svnmerge-dump |   65 +++++-
 t/t9151/svn-mergeinfo.dump |  545 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 485 insertions(+), 127 deletions(-)

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 359eeaa..3569c62 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -33,7 +33,7 @@ test_expect_success 'svn non-merge merge commits did not become git merge commit
 	[ -z "$bad_non_merges" ]
 	'
 
-test_expect_success 'everything got merged in the end' '
+test_expect_failure 'everything got merged in the end' '
 	unmerged=$(git rev-list --all --not master)
 	[ -z "$unmerged" ]
 	'
diff --git a/t/t9151/make-svnmerge-dump b/t/t9151/make-svnmerge-dump
index d917717..3d73f14 100644
--- a/t/t9151/make-svnmerge-dump
+++ b/t/t9151/make-svnmerge-dump
@@ -26,8 +26,9 @@ i=0
 cd foo
 mkdir trunk
 mkdir branches
-svn add trunk branches
-i=$(commit $i "Setup trunk and branches")
+mkdir tags
+svn add trunk branches tags
+i=$(commit $i "Setup trunk, branches, and tags")
 
 git cat-file blob 6683463e:Makefile > trunk/Makefile
 svn add trunk/Makefile 
@@ -155,6 +156,66 @@ svn merge ../branches/right --accept postpone
 i=$(commit $i "non-merge right to trunk 2")
 cd ..
 
+say "Adding subdirectory to LEFT"
+svn update
+cd branches/left
+mkdir subdir
+echo "Yeehaw" > subdir/cowboy
+svn add subdir
+i=$(commit $i "add subdirectory to left branch")
+cd ../../
+
+say "Merging LEFT to TRUNK"
+svn update
+cd trunk
+svn merge ../branches/left --accept postpone
+i=$(commit $i "merge left to trunk")
+cd ..
+
+say "Make PARTIAL branch"
+svn update
+i=$(commit $i "make partial branch")
+svn cp trunk/subdir branches/partial
+
+say "Make a commit to PARTIAL"
+svn update
+cd branches/partial
+echo "racecar" > palindromes
+svn add palindromes
+i=$(commit $i "partial update")
+cd ../../
+
+say "Merge PARTIAL to TRUNK"
+svn update
+cd trunk/subdir
+svn merge ../../branches/partial --accept postpone
+i=$(commit $i "merge partial to trunk")
+cd ../../
+
+say "Tagging trunk"
+svn update
+i=$(commit $i "tagging v1.0")
+svn cp trunk tags/v1.0
+
+say "Branching BUGFIX from v1.0"
+svn update
+i=$(commit $i "make bugfix branch from tag")
+svn cp tags/v1.0 branches/bugfix
+
+say "Make a commit to BUGFIX"
+svn update
+cd branches/bugfix/
+echo "kayak" >> subdir/palindromes
+i=$(commit $i "commit to bugfix")
+cd ../../
+
+say "Merge BUGFIX to TRUNK"
+svn update
+cd trunk
+svn merge ../branches/bugfix/ --accept postpone
+i=$(commit $i "Merge BUGFIX to TRUNK")
+cd ..
+
 cd ..
 svnadmin dump foo.svn > svn-mergeinfo.dump
 
diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
index 9543e31..ebf386e 100644
--- a/t/t9151/svn-mergeinfo.dump
+++ b/t/t9151/svn-mergeinfo.dump
@@ -1,6 +1,6 @@
 SVN-fs-dump-format-version: 2
 
-UUID: 64142547-0943-4db2-836a-d1e1eb2f9924
+UUID: d6191530-2693-4a8e-98e7-b194d4c3edd8
 
 Revision-number: 0
 Prop-content-length: 56
@@ -9,25 +9,25 @@ Content-length: 56
 K 8
 svn:date
 V 27
-2009-12-19T16:17:51.232640Z
+2010-01-19T04:14:02.832406Z
 PROPS-END
 
 Revision-number: 1
-Prop-content-length: 128
-Content-length: 128
+Prop-content-length: 134
+Content-length: 134
 
 K 7
 svn:log
-V 29
-(r1) Setup trunk and branches
+V 36
+(r1) Setup trunk, branches, and tags
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:51.831965Z
+2010-01-19T04:14:03.055172Z
 PROPS-END
 
 Node-path: branches
@@ -39,6 +39,15 @@ Content-length: 10
 PROPS-END
 
 
+Node-path: tags
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
 Node-path: trunk
 Node-kind: dir
 Node-action: add
@@ -49,8 +58,8 @@ PROPS-END
 
 
 Revision-number: 2
-Prop-content-length: 112
-Content-length: 112
+Prop-content-length: 111
+Content-length: 111
 
 K 7
 svn:log
@@ -58,12 +67,12 @@ V 13
 (r2) ancestor
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:52.300075Z
+2010-01-19T04:14:04.064506Z
 PROPS-END
 
 Node-path: trunk/Makefile
@@ -156,8 +165,8 @@ backup: clean
 
 
 Revision-number: 3
-Prop-content-length: 120
-Content-length: 120
+Prop-content-length: 119
+Content-length: 119
 
 K 7
 svn:log
@@ -165,12 +174,12 @@ V 21
 (r3) make left branch
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:52.768800Z
+2010-01-19T04:14:06.040389Z
 PROPS-END
 
 Node-path: branches/left
@@ -190,8 +199,8 @@ Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
 
 
 Revision-number: 4
-Prop-content-length: 121
-Content-length: 121
+Prop-content-length: 120
+Content-length: 120
 
 K 7
 svn:log
@@ -199,12 +208,12 @@ V 22
 (r4) make right branch
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:53.177879Z
+2010-01-19T04:14:08.040905Z
 PROPS-END
 
 Node-path: branches/right
@@ -224,8 +233,8 @@ Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
 
 
 Revision-number: 5
-Prop-content-length: 117
-Content-length: 117
+Prop-content-length: 116
+Content-length: 116
 
 K 7
 svn:log
@@ -233,12 +242,12 @@ V 18
 (r5) left update 1
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:53.604691Z
+2010-01-19T04:14:09.049169Z
 PROPS-END
 
 Node-path: branches/left/Makefile
@@ -329,8 +338,8 @@ backup: clean
 
 
 Revision-number: 6
-Prop-content-length: 118
-Content-length: 118
+Prop-content-length: 117
+Content-length: 117
 
 K 7
 svn:log
@@ -338,12 +347,12 @@ V 19
 (r6) right update 1
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:54.063555Z
+2010-01-19T04:14:10.049350Z
 PROPS-END
 
 Node-path: branches/right/Makefile
@@ -437,8 +446,8 @@ backup: clean
 
 
 Revision-number: 7
-Prop-content-length: 117
-Content-length: 117
+Prop-content-length: 116
+Content-length: 116
 
 K 7
 svn:log
@@ -446,12 +455,12 @@ V 18
 (r7) left update 2
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:54.523904Z
+2010-01-19T04:14:11.049209Z
 PROPS-END
 
 Node-path: branches/left/Makefile
@@ -542,8 +551,8 @@ backup: clean
 
 
 Revision-number: 8
-Prop-content-length: 117
-Content-length: 117
+Prop-content-length: 116
+Content-length: 116
 
 K 7
 svn:log
@@ -551,12 +560,12 @@ V 18
 (r8) left update 3
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:54.975970Z
+2010-01-19T04:14:12.049234Z
 PROPS-END
 
 Node-path: branches/left/Makefile
@@ -647,8 +656,8 @@ backup: clean
 
 
 Revision-number: 9
-Prop-content-length: 124
-Content-length: 124
+Prop-content-length: 123
+Content-length: 123
 
 K 7
 svn:log
@@ -656,12 +665,12 @@ V 25
 (r9) make left sub-branch
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:55.459904Z
+2010-01-19T04:14:14.040894Z
 PROPS-END
 
 Node-path: branches/left-sub
@@ -687,8 +696,8 @@ Text-copy-source-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
 
 
 Revision-number: 10
-Prop-content-length: 129
-Content-length: 129
+Prop-content-length: 128
+Content-length: 128
 
 K 7
 svn:log
@@ -696,12 +705,12 @@ V 30
 (r10) left sub-branch update 1
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:55.862113Z
+2010-01-19T04:14:15.049935Z
 PROPS-END
 
 Node-path: branches/left-sub/README
@@ -718,8 +727,8 @@ crunch
 
 
 Revision-number: 11
-Prop-content-length: 126
-Content-length: 126
+Prop-content-length: 125
+Content-length: 125
 
 K 7
 svn:log
@@ -727,12 +736,12 @@ V 27
 (r11) Merge left to trunk 1
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:56.413416Z
+2010-01-19T04:14:18.056594Z
 PROPS-END
 
 Node-path: trunk
@@ -836,8 +845,8 @@ backup: clean
 
 
 Revision-number: 12
-Prop-content-length: 118
-Content-length: 118
+Prop-content-length: 117
+Content-length: 117
 
 K 7
 svn:log
@@ -845,12 +854,12 @@ V 19
 (r12) left update 4
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:56.831014Z
+2010-01-19T04:14:19.049620Z
 PROPS-END
 
 Node-path: branches/left/zlonk
@@ -867,8 +876,8 @@ touche
 
 
 Revision-number: 13
-Prop-content-length: 119
-Content-length: 119
+Prop-content-length: 118
+Content-length: 118
 
 K 7
 svn:log
@@ -876,12 +885,12 @@ V 20
 (r13) right update 2
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:57.341143Z
+2010-01-19T04:14:20.049659Z
 PROPS-END
 
 Node-path: branches/right/bang
@@ -898,8 +907,8 @@ thwacke
 
 
 Revision-number: 14
-Prop-content-length: 141
-Content-length: 141
+Prop-content-length: 140
+Content-length: 140
 
 K 7
 svn:log
@@ -907,12 +916,12 @@ V 42
 (r14) Cherry-pick right 2 commits to trunk
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:57.841851Z
+2010-01-19T04:14:23.041991Z
 PROPS-END
 
 Node-path: trunk
@@ -1029,8 +1038,8 @@ Text-copy-source-sha1: 0bc5bb345c0e71d28f784f12e0bd2d384c283062
 
 
 Revision-number: 15
-Prop-content-length: 127
-Content-length: 127
+Prop-content-length: 126
+Content-length: 126
 
 K 7
 svn:log
@@ -1038,12 +1047,12 @@ V 28
 (r15) Merge right to trunk 1
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:58.368520Z
+2010-01-19T04:14:26.054456Z
 PROPS-END
 
 Node-path: trunk
@@ -1061,8 +1070,8 @@ PROPS-END
 
 
 Revision-number: 16
-Prop-content-length: 119
-Content-length: 119
+Prop-content-length: 118
+Content-length: 118
 
 K 7
 svn:log
@@ -1070,12 +1079,12 @@ V 20
 (r16) right update 3
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:58.779056Z
+2010-01-19T04:14:27.049955Z
 PROPS-END
 
 Node-path: branches/right/urkkk
@@ -1092,8 +1101,8 @@ whamm
 
 
 Revision-number: 17
-Prop-content-length: 119
-Content-length: 119
+Prop-content-length: 118
+Content-length: 118
 
 K 7
 svn:log
@@ -1101,12 +1110,12 @@ V 20
 (r17) trunk update 1
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:59.221851Z
+2010-01-19T04:14:28.049615Z
 PROPS-END
 
 Node-path: trunk/vronk
@@ -1123,8 +1132,8 @@ pow
 
 
 Revision-number: 18
-Prop-content-length: 135
-Content-length: 135
+Prop-content-length: 134
+Content-length: 134
 
 K 7
 svn:log
@@ -1132,12 +1141,12 @@ V 36
 (r18) Merge right to left sub-branch
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:17:59.781666Z
+2010-01-19T04:14:31.061460Z
 PROPS-END
 
 Node-path: branches/left-sub
@@ -1262,8 +1271,8 @@ Text-copy-source-sha1: 3934264d277a0cf886b6b1c7f2b9e56da2525302
 
 
 Revision-number: 19
-Prop-content-length: 129
-Content-length: 129
+Prop-content-length: 128
+Content-length: 128
 
 K 7
 svn:log
@@ -1271,12 +1280,12 @@ V 30
 (r19) left sub-branch update 2
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:18:00.200531Z
+2010-01-19T04:14:32.049244Z
 PROPS-END
 
 Node-path: branches/left-sub/wham_eth
@@ -1293,8 +1302,8 @@ zowie
 
 
 Revision-number: 20
-Prop-content-length: 118
-Content-length: 118
+Prop-content-length: 117
+Content-length: 117
 
 K 7
 svn:log
@@ -1302,12 +1311,12 @@ V 19
 (r20) left update 5
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:18:00.659636Z
+2010-01-19T04:14:33.049332Z
 PROPS-END
 
 Node-path: branches/left/glurpp
@@ -1324,8 +1333,8 @@ eee_yow
 
 
 Revision-number: 21
-Prop-content-length: 147
-Content-length: 147
+Prop-content-length: 146
+Content-length: 146
 
 K 7
 svn:log
@@ -1333,12 +1342,12 @@ V 48
 (r21) Cherry-pick left sub-branch commit to left
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:18:01.194402Z
+2010-01-19T04:14:36.041839Z
 PROPS-END
 
 Node-path: branches/left
@@ -1364,8 +1373,8 @@ Text-copy-source-sha1: b165019b005c199237ba822c4404e771e93b654a
 
 
 Revision-number: 22
-Prop-content-length: 134
-Content-length: 134
+Prop-content-length: 133
+Content-length: 133
 
 K 7
 svn:log
@@ -1373,12 +1382,12 @@ V 35
 (r22) Merge left sub-branch to left
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:18:01.679218Z
+2010-01-19T04:14:39.045014Z
 PROPS-END
 
 Node-path: branches/left
@@ -1513,8 +1522,8 @@ Text-copy-source-sha1: 3934264d277a0cf886b6b1c7f2b9e56da2525302
 
 
 Revision-number: 23
-Prop-content-length: 126
-Content-length: 126
+Prop-content-length: 125
+Content-length: 125
 
 K 7
 svn:log
@@ -1522,12 +1531,12 @@ V 27
 (r23) Merge left to trunk 2
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:18:02.212349Z
+2010-01-19T04:14:42.052798Z
 PROPS-END
 
 Node-path: trunk
@@ -1591,8 +1600,8 @@ Text-copy-source-sha1: 9716527ebd70a75c27625cacbeb2d897c6e86178
 
 
 Revision-number: 24
-Prop-content-length: 131
-Content-length: 131
+Prop-content-length: 130
+Content-length: 130
 
 K 7
 svn:log
@@ -1600,12 +1609,12 @@ V 32
 (r24) non-merge right to trunk 2
 K 10
 svn:author
-V 4
-samv
+V 3
+adm
 K 8
 svn:date
 V 27
-2009-12-19T16:18:02.672148Z
+2010-01-19T04:14:44.038434Z
 PROPS-END
 
 Node-path: trunk
@@ -1623,3 +1632,291 @@ V 64
 PROPS-END
 
 
+Revision-number: 25
+Prop-content-length: 135
+Content-length: 135
+
+K 7
+svn:log
+V 37
+(r25) add subdirectory to left branch
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-01-19T04:14:46.052649Z
+PROPS-END
+
+Node-path: branches/left/subdir
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: branches/left/subdir/cowboy
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 7
+Text-content-md5: f1d6530278ad409e68cc675476ad995f
+Text-content-sha1: 732d9e3e5c391ffd767a98b45ddcc848de778cea
+Content-length: 17
+
+PROPS-END
+Yeehaw
+
+
+Revision-number: 26
+Prop-content-length: 123
+Content-length: 123
+
+K 7
+svn:log
+V 25
+(r26) merge left to trunk
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-01-19T04:14:49.040783Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 99
+Content-length: 99
+
+K 13
+svn:mergeinfo
+V 64
+/branches/left:2-25
+/branches/left-sub:4-19
+/branches/right:2-22
+PROPS-END
+
+
+Node-path: trunk/subdir
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 25
+Node-copyfrom-path: branches/left/subdir
+
+
+Revision-number: 27
+Prop-content-length: 118
+Content-length: 118
+
+K 7
+svn:log
+V 20
+(r28) partial update
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-01-19T04:14:53.049037Z
+PROPS-END
+
+Node-path: branches/partial
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 26
+Node-copyfrom-path: trunk/subdir
+
+
+Node-path: branches/partial/palindromes
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 8
+Text-content-md5: 5d1c2024fb5efc4eef812856df1b080c
+Text-content-sha1: 5f8509ddd14c91a52864dd1447344e706f9bbc69
+Content-length: 18
+
+PROPS-END
+racecar
+
+
+Revision-number: 28
+Prop-content-length: 126
+Content-length: 126
+
+K 7
+svn:log
+V 28
+(r29) merge partial to trunk
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-01-19T04:14:56.041526Z
+PROPS-END
+
+Node-path: trunk/subdir
+Node-kind: dir
+Node-action: change
+Prop-content-length: 142
+Content-length: 142
+
+K 13
+svn:mergeinfo
+V 106
+/branches/left/subdir:2-25
+/branches/left-sub/subdir:4-19
+/branches/partial:27
+/branches/right/subdir:2-22
+PROPS-END
+
+
+Node-path: trunk/subdir/palindromes
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 27
+Node-copyfrom-path: branches/partial/palindromes
+Text-copy-source-md5: 5d1c2024fb5efc4eef812856df1b080c
+Text-copy-source-sha1: 5f8509ddd14c91a52864dd1447344e706f9bbc69
+
+
+Revision-number: 29
+Prop-content-length: 131
+Content-length: 131
+
+K 7
+svn:log
+V 33
+(r31) make bugfix branch from tag
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-01-19T04:15:00.039761Z
+PROPS-END
+
+Node-path: tags/v1.0
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 28
+Node-copyfrom-path: trunk
+
+
+Revision-number: 30
+Prop-content-length: 120
+Content-length: 120
+
+K 7
+svn:log
+V 22
+(r32) commit to bugfix
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-01-19T04:15:03.043218Z
+PROPS-END
+
+Node-path: branches/bugfix
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 29
+Node-copyfrom-path: tags/v1.0
+
+
+Node-path: branches/bugfix/subdir/palindromes
+Node-kind: file
+Node-action: change
+Text-content-length: 14
+Text-content-md5: 3b12d98578a3f4320ba97e66da54fe5f
+Text-content-sha1: 672931c9e8ac2c408209efab2f015638b6d64042
+Content-length: 14
+
+racecar
+kayak
+
+
+Revision-number: 31
+Prop-content-length: 125
+Content-length: 125
+
+K 7
+svn:log
+V 27
+(r33) Merge BUGFIX to TRUNK
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-01-19T04:15:06.043723Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 133
+Content-length: 133
+
+K 13
+svn:mergeinfo
+V 98
+/branches/bugfix:30
+/branches/left:2-25
+/branches/left-sub:4-19
+/branches/right:2-22
+/tags/v1.0:29
+PROPS-END
+
+
+Node-path: trunk/subdir
+Node-kind: dir
+Node-action: change
+Prop-content-length: 190
+Content-length: 190
+
+K 13
+svn:mergeinfo
+V 154
+/branches/bugfix/subdir:30
+/branches/left/subdir:2-25
+/branches/left-sub/subdir:4-19
+/branches/partial:27
+/branches/right/subdir:2-22
+/tags/v1.0/subdir:29
+PROPS-END
+
+
+Node-path: trunk/subdir/palindromes
+Node-kind: file
+Node-action: change
+Text-content-length: 14
+Text-content-md5: 3b12d98578a3f4320ba97e66da54fe5f
+Text-content-sha1: 672931c9e8ac2c408209efab2f015638b6d64042
+Content-length: 14
+
+racecar
+kayak
+
+
-- 
1.6.6.2.g1fc48.dirty
