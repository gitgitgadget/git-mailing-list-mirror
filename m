From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: [PATCH 2/3] t9151: Add two new svn:mergeinfo test cases
Date: Mon, 22 Feb 2010 09:57:21 +0200
Message-ID: <1266825442-32107-3-git-send-email-tuomas.suutari@gmail.com>
References: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com>
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>,
	Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 09:49:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjTBK-00051w-JT
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 08:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab0BVH6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 02:58:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:2644 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab0BVH56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 02:57:58 -0500
Received: by fg-out-1718.google.com with SMTP id e21so243662fga.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 23:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iOslbinjxxmjLLxMpczXJXPyg70p357EquD36j4CwP4=;
        b=j/qbFhZ6xkIxeJt2DYTHEBdT9Di92Uk5MkocHlcEVCzGbKjCJ08wUMX30FWOvBhEOC
         oe0Y92vlK7sU2BVigXEGGS2NBLJyjq3198gWP/1ey6NDKlJZyXCM9FikcoM7HLNa0tBz
         SiraMPRkmb0yQLRq6aQ7otKDizR01bRIBUaQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vCm/zxSZDhB0VF/4WfnpRqqshGT6MVhY0FjvNk0GosORxp3+Wyc6gSFZArHoY1inNh
         vOl47EKfFFcQlhh6ExdftluepKxAB1UTx1PVIlNrTDCScXGPMlhv1fa06ErbSal3s8h3
         8DZXduJ1etogAyA0pLpPovFevbldzK751M4Fw=
Received: by 10.87.65.9 with SMTP id s9mr1269281fgk.48.1266825476923;
        Sun, 21 Feb 2010 23:57:56 -0800 (PST)
Received: from localhost.localdomain (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id e3sm4952313fga.16.2010.02.21.23.57.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 23:57:56 -0800 (PST)
X-Mailer: git-send-email 1.7.0.86.g7501
In-Reply-To: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140644>

When svn:mergeinfo contains two new parents in a specific order and
one is ancestor of the other, it is possible that git-svn discards the
wrong one. The first test case ("commit made to merged branch is
reachable from the merge") proves this.

The second test case ("merging two branches in one commit is detected
correctly") is just for completeness, since there was no test for
merging two (feature) branches to trunk in one commit.

Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
---
 t/t9151-svn-mergeinfo.sh   |   15 ++
 t/t9151/make-svnmerge-dump |   83 +++++++
 t/t9151/svn-mergeinfo.dump |  536 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 581 insertions(+), 53 deletions(-)

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 3569c62..353f543 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -33,6 +33,21 @@ test_expect_success 'svn non-merge merge commits did not become git merge commit
 	[ -z "$bad_non_merges" ]
 	'
 
+test_expect_failure 'commit made to merged branch is reachable from the merge' '
+	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2")
+	merge_commit=$(git rev-list --all --grep="Merge trunk to b2")
+	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit)
+	[ -z "$not_reachable" ]
+	'
+
+test_expect_success 'merging two branches in one commit is detected correctly' '
+	f1_commit=$(git rev-list --all --grep="make f1 branch from trunk")
+	f2_commit=$(git rev-list --all --grep="make f2 branch from trunk")
+	merge_commit=$(git rev-list --all --grep="Merge f1 and f2 to trunk")
+	not_reachable=$(git rev-list -1 $f1_commit $f2_commit --not $merge_commit)
+	[ -z "$not_reachable" ]
+	'
+
 test_expect_failure 'everything got merged in the end' '
 	unmerged=$(git rev-list --all --not master)
 	[ -z "$unmerged" ]
diff --git a/t/t9151/make-svnmerge-dump b/t/t9151/make-svnmerge-dump
index 3168c7c..e1e138c 100644
--- a/t/t9151/make-svnmerge-dump
+++ b/t/t9151/make-svnmerge-dump
@@ -156,6 +156,89 @@ svn merge ../branches/right --accept postpone
 i=$(commit $i "non-merge right to trunk 2")
 cd ..
 
+say "Branching b1 from trunk"
+svn update
+svn cp trunk branches/b1
+i=$(commit $i "make b1 branch from trunk")
+
+say "Branching b2 from trunk"
+svn update
+svn cp trunk branches/b2
+i=$(commit $i "make b2 branch from trunk")
+
+say "Make a commit to b2"
+svn update
+cd branches/b2
+echo "b2" > b2file
+svn add b2file
+i=$(commit $i "b2 update 1")
+cd ../..
+
+say "Make a commit to b1"
+svn update
+cd branches/b1
+echo "b1" > b1file
+svn add b1file
+i=$(commit $i "b1 update 1")
+cd ../..
+
+say "Merge b1 to trunk"
+svn update
+cd trunk
+svn merge ../branches/b1/ --accept postpone
+i=$(commit $i "Merge b1 to trunk")
+cd ..
+
+say "Make a commit to trunk before merging trunk to b2"
+svn update
+cd trunk
+echo "trunk" > trunkfile
+svn add trunkfile
+i=$(commit $i "trunk commit before merging trunk to b2")
+cd ..
+
+say "Merge trunk to b2"
+svn update
+cd branches/b2
+svn merge ../../trunk/ --accept postpone
+i=$(commit $i "Merge trunk to b2")
+cd ../..
+
+say "Merge b2 to trunk"
+svn update
+cd trunk
+svn merge ../branches/b2/ --accept postpone
+svn resolved b1file
+svn resolved trunkfile
+i=$(commit $i "Merge b2 to trunk")
+cd ..
+
+say "Creating f1 from trunk with a new file"
+svn update
+svn cp trunk branches/f1
+cd branches/f1
+echo "f1" > f1file
+svn add f1file
+cd ../..
+i=$(commit $i "make f1 branch from trunk with a new file")
+
+say "Creating f2 from trunk with a new file"
+svn update
+svn cp trunk branches/f2
+cd branches/f2
+echo "f2" > f2file
+svn add f2file
+cd ../..
+i=$(commit $i "make f2 branch from trunk with a new file")
+
+say "Merge f1 and f2 to trunk in one go"
+svn update
+cd trunk
+svn merge ../branches/f1/ --accept postpone
+svn merge ../branches/f2/ --accept postpone
+i=$(commit $i "Merge f1 and f2 to trunk")
+cd ..
+
 say "Adding subdirectory to LEFT"
 svn update
 cd branches/left
diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
index f228958..47cafcf 100644
--- a/t/t9151/svn-mergeinfo.dump
+++ b/t/t9151/svn-mergeinfo.dump
@@ -1633,13 +1633,427 @@ PROPS-END
 
 
 Revision-number: 25
+Prop-content-length: 129
+Content-length: 129
+
+K 7
+svn:log
+V 31
+(r25) make b1 branch from trunk
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:18:56.084589Z
+PROPS-END
+
+Node-path: branches/b1
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 24
+Node-copyfrom-path: trunk
+
+
+Revision-number: 26
+Prop-content-length: 129
+Content-length: 129
+
+K 7
+svn:log
+V 31
+(r26) make b2 branch from trunk
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:18:59.076940Z
+PROPS-END
+
+Node-path: branches/b2
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 25
+Node-copyfrom-path: trunk
+
+
+Revision-number: 27
+Prop-content-length: 115
+Content-length: 115
+
+K 7
+svn:log
+V 17
+(r27) b2 update 1
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:19:01.095762Z
+PROPS-END
+
+Node-path: branches/b2/b2file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 3
+Text-content-md5: 5edbdd57cba621eb3c6e601bf563b4dc
+Text-content-sha1: 9d4b38049776bd0a2074d67cad23f8eaed35a3b3
+Content-length: 13
+
+PROPS-END
+b2
+
+
+Revision-number: 28
+Prop-content-length: 115
+Content-length: 115
+
+K 7
+svn:log
+V 17
+(r28) b1 update 1
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:19:03.097465Z
+PROPS-END
+
+Node-path: branches/b1/b1file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 3
+Text-content-md5: 08778dfd9ac4f603231896aba7aad523
+Text-content-sha1: b551771aa4ad5b14123fc3bd98d89db2bc0edd4f
+Content-length: 13
+
+PROPS-END
+b1
+
+
+Revision-number: 29
+Prop-content-length: 121
+Content-length: 121
+
+K 7
+svn:log
+V 23
+(r29) Merge b1 to trunk
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:19:06.073175Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 118
+Content-length: 118
+
+K 13
+svn:mergeinfo
+V 83
+/branches/b1:25-28
+/branches/left:2-22
+/branches/left-sub:4-19
+/branches/right:2-22
+PROPS-END
+
+
+Node-path: trunk/b1file
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 28
+Node-copyfrom-path: branches/b1/b1file
+Text-copy-source-md5: 08778dfd9ac4f603231896aba7aad523
+Text-copy-source-sha1: b551771aa4ad5b14123fc3bd98d89db2bc0edd4f
+
+
+Revision-number: 30
+Prop-content-length: 143
+Content-length: 143
+
+K 7
+svn:log
+V 45
+(r30) trunk commit before merging trunk to b2
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:19:08.096353Z
+PROPS-END
+
+Node-path: trunk/trunkfile
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 6
+Text-content-md5: edf45fe5c98c5367733b39bbb2bb20d9
+Text-content-sha1: 7361d1685e5c86dfc523620cfaf598f196f86239
+Content-length: 16
+
+PROPS-END
+trunk
+
+
+Revision-number: 31
+Prop-content-length: 121
+Content-length: 121
+
+K 7
+svn:log
+V 23
+(r31) Merge trunk to b2
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:19:11.081541Z
+PROPS-END
+
+Node-path: branches/b2
+Node-kind: dir
+Node-action: change
+Prop-content-length: 131
+Content-length: 131
+
+K 13
+svn:mergeinfo
+V 96
+/branches/b1:25-28
+/branches/left:2-22
+/branches/left-sub:4-19
+/branches/right:2-22
+/trunk:26-30
+PROPS-END
+
+
+Node-path: branches/b2/b1file
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 30
+Node-copyfrom-path: trunk/b1file
+Text-copy-source-md5: 08778dfd9ac4f603231896aba7aad523
+Text-copy-source-sha1: b551771aa4ad5b14123fc3bd98d89db2bc0edd4f
+
+
+Node-path: branches/b2/trunkfile
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 30
+Node-copyfrom-path: trunk/trunkfile
+Text-copy-source-md5: edf45fe5c98c5367733b39bbb2bb20d9
+Text-copy-source-sha1: 7361d1685e5c86dfc523620cfaf598f196f86239
+
+
+Revision-number: 32
+Prop-content-length: 121
+Content-length: 121
+
+K 7
+svn:log
+V 23
+(r32) Merge b2 to trunk
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:19:14.117939Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 138
+Content-length: 138
+
+K 13
+svn:mergeinfo
+V 102
+/branches/b1:25-28
+/branches/b2:26-31
+/branches/left:2-22
+/branches/left-sub:4-19
+/branches/right:2-22
+PROPS-END
+
+
+Node-path: trunk/b2file
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 31
+Node-copyfrom-path: branches/b2/b2file
+Text-copy-source-md5: 5edbdd57cba621eb3c6e601bf563b4dc
+Text-copy-source-sha1: 9d4b38049776bd0a2074d67cad23f8eaed35a3b3
+
+
+Revision-number: 33
+Prop-content-length: 145
+Content-length: 145
+
+K 7
+svn:log
+V 47
+(r33) make f1 branch from trunk with a new file
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:19:17.105832Z
+PROPS-END
+
+Node-path: branches/f1
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 32
+Node-copyfrom-path: trunk
+
+
+Node-path: branches/f1/f1file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 3
+Text-content-md5: 2b1abc6b6c5c0018851f9f8e6475563b
+Text-content-sha1: aece6dfba588900e00d95601d22b4408d49580af
+Content-length: 13
+
+PROPS-END
+f1
+
+
+Revision-number: 34
+Prop-content-length: 145
+Content-length: 145
+
+K 7
+svn:log
+V 47
+(r34) make f2 branch from trunk with a new file
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:19:20.110057Z
+PROPS-END
+
+Node-path: branches/f2
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 33
+Node-copyfrom-path: trunk
+
+
+Node-path: branches/f2/f2file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 3
+Text-content-md5: 575c5638d60271457e54ab7d07309502
+Text-content-sha1: 1c49a440c352f3473efa9512255033b94dc7def0
+Content-length: 13
+
+PROPS-END
+f2
+
+
+Revision-number: 35
+Prop-content-length: 128
+Content-length: 128
+
+K 7
+svn:log
+V 30
+(r35) Merge f1 and f2 to trunk
+K 10
+svn:author
+V 3
+adm
+K 8
+svn:date
+V 27
+2010-02-22T06:19:24.081490Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 173
+Content-length: 173
+
+K 13
+svn:mergeinfo
+V 137
+/branches/b1:25-28
+/branches/b2:26-31
+/branches/f1:33-34
+/branches/f2:34
+/branches/left:2-22
+/branches/left-sub:4-19
+/branches/right:2-22
+PROPS-END
+
+
+Node-path: trunk/f1file
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 34
+Node-copyfrom-path: branches/f1/f1file
+Text-copy-source-md5: 2b1abc6b6c5c0018851f9f8e6475563b
+Text-copy-source-sha1: aece6dfba588900e00d95601d22b4408d49580af
+
+
+Node-path: trunk/f2file
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 34
+Node-copyfrom-path: branches/f2/f2file
+Text-copy-source-md5: 575c5638d60271457e54ab7d07309502
+Text-copy-source-sha1: 1c49a440c352f3473efa9512255033b94dc7def0
+
+
+Revision-number: 36
 Prop-content-length: 135
 Content-length: 135
 
 K 7
 svn:log
 V 37
-(r25) add subdirectory to left branch
+(r36) add subdirectory to left branch
 K 10
 svn:author
 V 3
@@ -1647,7 +2061,7 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:14:46.052649Z
+2010-02-22T06:19:26.113516Z
 PROPS-END
 
 Node-path: branches/left/subdir
@@ -1672,14 +2086,14 @@ PROPS-END
 Yeehaw
 
 
-Revision-number: 26
+Revision-number: 37
 Prop-content-length: 123
 Content-length: 123
 
 K 7
 svn:log
 V 25
-(r26) merge left to trunk
+(r37) merge left to trunk
 K 10
 svn:author
 V 3
@@ -1687,19 +2101,23 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:14:49.040783Z
+2010-02-22T06:19:29.073699Z
 PROPS-END
 
 Node-path: trunk
 Node-kind: dir
 Node-action: change
-Prop-content-length: 99
-Content-length: 99
+Prop-content-length: 173
+Content-length: 173
 
 K 13
 svn:mergeinfo
-V 64
-/branches/left:2-25
+V 137
+/branches/b1:25-28
+/branches/b2:26-31
+/branches/f1:33-34
+/branches/f2:34
+/branches/left:2-36
 /branches/left-sub:4-19
 /branches/right:2-22
 PROPS-END
@@ -1708,18 +2126,18 @@ PROPS-END
 Node-path: trunk/subdir
 Node-kind: dir
 Node-action: add
-Node-copyfrom-rev: 25
+Node-copyfrom-rev: 36
 Node-copyfrom-path: branches/left/subdir
 
 
-Revision-number: 27
+Revision-number: 38
 Prop-content-length: 123
 Content-length: 123
 
 K 7
 svn:log
 V 25
-(r27) make partial branch
+(r38) make partial branch
 K 10
 svn:author
 V 3
@@ -1727,24 +2145,24 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:14:53.049037Z
+2010-02-22T06:19:32.072243Z
 PROPS-END
 
 Node-path: branches/partial
 Node-kind: dir
 Node-action: add
-Node-copyfrom-rev: 26
+Node-copyfrom-rev: 37
 Node-copyfrom-path: trunk/subdir
 
 
-Revision-number: 28
+Revision-number: 39
 Prop-content-length: 118
 Content-length: 118
 
 K 7
 svn:log
 V 20
-(r28) partial update
+(r39) partial update
 K 10
 svn:author
 V 3
@@ -1752,7 +2170,7 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:14:54.000000Z
+2010-02-22T06:19:34.097961Z
 PROPS-END
 
 Node-path: branches/partial/palindromes
@@ -1768,14 +2186,14 @@ PROPS-END
 racecar
 
 
-Revision-number: 29
+Revision-number: 40
 Prop-content-length: 126
 Content-length: 126
 
 K 7
 svn:log
 V 28
-(r29) merge partial to trunk
+(r40) merge partial to trunk
 K 10
 svn:author
 V 3
@@ -1783,21 +2201,25 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:14:56.041526Z
+2010-02-22T06:19:37.080211Z
 PROPS-END
 
 Node-path: trunk/subdir
 Node-kind: dir
 Node-action: change
-Prop-content-length: 145
-Content-length: 145
+Prop-content-length: 246
+Content-length: 246
 
 K 13
 svn:mergeinfo
-V 109
-/branches/left/subdir:2-25
+V 210
+/branches/b1/subdir:25-28
+/branches/b2/subdir:26-31
+/branches/f1/subdir:33-34
+/branches/f2/subdir:34
+/branches/left/subdir:2-36
 /branches/left-sub/subdir:4-19
-/branches/partial:27-28
+/branches/partial:38-39
 /branches/right/subdir:2-22
 PROPS-END
 
@@ -1805,20 +2227,20 @@ PROPS-END
 Node-path: trunk/subdir/palindromes
 Node-kind: file
 Node-action: add
-Node-copyfrom-rev: 28
+Node-copyfrom-rev: 39
 Node-copyfrom-path: branches/partial/palindromes
 Text-copy-source-md5: 5d1c2024fb5efc4eef812856df1b080c
 Text-copy-source-sha1: 5f8509ddd14c91a52864dd1447344e706f9bbc69
 
 
-Revision-number: 30
+Revision-number: 41
 Prop-content-length: 116
 Content-length: 116
 
 K 7
 svn:log
 V 18
-(r30) tagging v1.0
+(r41) tagging v1.0
 K 10
 svn:author
 V 3
@@ -1826,24 +2248,24 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:15:00.039761Z
+2010-02-22T06:19:40.083460Z
 PROPS-END
 
 Node-path: tags/v1.0
 Node-kind: dir
 Node-action: add
-Node-copyfrom-rev: 29
+Node-copyfrom-rev: 40
 Node-copyfrom-path: trunk
 
 
-Revision-number: 31
+Revision-number: 42
 Prop-content-length: 131
 Content-length: 131
 
 K 7
 svn:log
 V 33
-(r31) make bugfix branch from tag
+(r42) make bugfix branch from tag
 K 10
 svn:author
 V 3
@@ -1851,24 +2273,24 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:15:01.000000Z
+2010-02-22T06:19:43.118075Z
 PROPS-END
 
 Node-path: branches/bugfix
 Node-kind: dir
 Node-action: add
-Node-copyfrom-rev: 30
+Node-copyfrom-rev: 41
 Node-copyfrom-path: tags/v1.0
 
 
-Revision-number: 32
+Revision-number: 43
 Prop-content-length: 120
 Content-length: 120
 
 K 7
 svn:log
 V 22
-(r32) commit to bugfix
+(r43) commit to bugfix
 K 10
 svn:author
 V 3
@@ -1876,7 +2298,7 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:15:02.000000Z
+2010-02-22T06:19:45.079536Z
 PROPS-END
 
 Node-path: branches/bugfix/subdir/palindromes
@@ -1891,14 +2313,14 @@ racecar
 kayak
 
 
-Revision-number: 33
+Revision-number: 44
 Prop-content-length: 125
 Content-length: 125
 
 K 7
 svn:log
 V 27
-(r33) Merge BUGFIX to TRUNK
+(r44) Merge BUGFIX to TRUNK
 K 10
 svn:author
 V 3
@@ -1906,41 +2328,49 @@ adm
 K 8
 svn:date
 V 27
-2010-01-19T04:15:06.043723Z
+2010-02-22T06:19:48.078914Z
 PROPS-END
 
 Node-path: trunk
 Node-kind: dir
 Node-action: change
-Prop-content-length: 137
-Content-length: 137
+Prop-content-length: 210
+Content-length: 210
 
 K 13
 svn:mergeinfo
-V 101
-/branches/bugfix:31-32
-/branches/left:2-25
+V 174
+/branches/b1:25-28
+/branches/b2:26-31
+/branches/bugfix:42-43
+/branches/f1:33-34
+/branches/f2:34
+/branches/left:2-36
 /branches/left-sub:4-19
 /branches/right:2-22
-/tags/v1.0:30
+/tags/v1.0:41
 PROPS-END
 
 
 Node-path: trunk/subdir
 Node-kind: dir
 Node-action: change
-Prop-content-length: 196
-Content-length: 196
+Prop-content-length: 297
+Content-length: 297
 
 K 13
 svn:mergeinfo
-V 160
-/branches/bugfix/subdir:31-32
-/branches/left/subdir:2-25
+V 261
+/branches/b1/subdir:25-28
+/branches/b2/subdir:26-31
+/branches/bugfix/subdir:42-43
+/branches/f1/subdir:33-34
+/branches/f2/subdir:34
+/branches/left/subdir:2-36
 /branches/left-sub/subdir:4-19
-/branches/partial:27-28
+/branches/partial:38-39
 /branches/right/subdir:2-22
-/tags/v1.0/subdir:30
+/tags/v1.0/subdir:41
 PROPS-END
 
 
-- 
1.7.0.86.g7501
