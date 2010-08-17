From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/24] t6010 (merge-base): modernize style
Date: Tue, 17 Aug 2010 01:57:12 -0500
Message-ID: <20100817065712.GF22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 08:59:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlG8R-0006nO-UR
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510Ab0HQG6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:58:54 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64451 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab0HQG6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:58:54 -0400
Received: by gwj17 with SMTP id 17so1306513gwj.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6RJblT7/JkFUH0eax51Rh6zGRG3rB7mpcf49fw0QV5A=;
        b=lkMrUeBHeGNnw8RMPekCN6f5nshb1kInrQpQttzTmVpS2zEf01Doo+j1sP4LHEYtlk
         NO8z6jHX+DeklW7y/sHatB/ceOSwaD6mJyREt9oLFkp2GotZ1nwR1v66PGRx+/Zhgier
         HHAuDOvURb1d6LXNvYUmHq5IXfpRDgyWKwgxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oAI9CEGZcGZsBhMLayVGnp4qL9qisFVejy7pWnTU8h2eIzB0YpUSBNF4iu4/VCQCZk
         0oAtcgH67GKAT1/oyllq3yuEN20Fmm2p2xw6z/2EflijAbtr+hwmNRbEjfYjgxLV9E9w
         ne9EQYaFDXp2DmbNFgUMIg3ND8Dtt0jMzpiOw=
Received: by 10.100.121.2 with SMTP id t2mr7079264anc.41.1282028332828;
        Mon, 16 Aug 2010 23:58:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t30sm11752072ann.7.2010.08.16.23.58.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 23:58:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153709>

Guard setup with test_expect_success, put the opening quote
starting each test on the same line as the test_expect_* invocation,
and combine related actions into single tests.

While at it:

 - use test_cmp instead of expr or test $foo = $bar, for more helpful
   output with -v when tests fail;

 - use test_commit for brevity.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6010-merge-base.sh |  317 ++++++++++++++++++++++++++-----------------------
 1 files changed, 167 insertions(+), 150 deletions(-)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 0144d9e..4466e45 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -8,170 +8,187 @@ test_description='Merge base computation.
 
 . ./test-lib.sh
 
-T=$(git write-tree)
-
-M=1130000000
-Z=+0000
-
-GIT_COMMITTER_EMAIL=git@comm.iter.xz
-GIT_COMMITTER_NAME='C O Mmiter'
-GIT_AUTHOR_NAME='A U Thor'
-GIT_AUTHOR_EMAIL=git@au.thor.xz
-export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
-
-doit() {
-	OFFSET=$1; shift
-	NAME=$1; shift
-	PARENTS=
-	for P
-	do
-		PARENTS="${PARENTS}-p $P "
-	done
-	GIT_COMMITTER_DATE="$(($M + $OFFSET)) $Z"
-	GIT_AUTHOR_DATE=$GIT_COMMITTER_DATE
-	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
-	commit=$(echo $NAME | git commit-tree $T $PARENTS)
-	echo $commit >.git/refs/tags/$NAME
-	echo $commit
-}
-
-#  E---D---C---B---A
-#  \'-_         \   \
-#   \  `---------G   \
-#    \                \
-#     F----------------H
-
-# Setup...
-E=$(doit 5 E)
-D=$(doit 4 D $E)
-F=$(doit 6 F $E)
-C=$(doit 3 C $D)
-B=$(doit 2 B $C)
-A=$(doit 1 A $B)
-G=$(doit 7 G $B $E)
-H=$(doit 8 H $A $F)
-
-test_expect_success 'compute merge-base (single)' \
-    'MB=$(git merge-base G H) &&
-     expr "$(git name-rev "$MB")" : "[0-9a-f]* tags/B"'
-
-test_expect_success 'compute merge-base (all)' \
-    'MB=$(git merge-base --all G H) &&
-     expr "$(git name-rev "$MB")" : "[0-9a-f]* tags/B"'
-
-test_expect_success 'compute merge-base with show-branch' \
-    'MB=$(git show-branch --merge-base G H) &&
-     expr "$(git name-rev "$MB")" : "[0-9a-f]* tags/B"'
-
-# Setup for second test to demonstrate that relying on timestamps in a
-# distributed SCM to provide a _consistent_ partial ordering of commits
-# leads to insanity.
-#
-#               Relative
-# Structure     timestamps
-#
-#   PL  PR        +4  +4
-#  /  \/  \      /  \/  \
-# L2  C2  R2    +3  -1  +3
-# |   |   |     |   |   |
-# L1  C1  R1    +2  -2  +2
-# |   |   |     |   |   |
-# L0  C0  R0    +1  -3  +1
-#   \ |  /        \ |  /
-#     S             0
-#
-# The left and right chains of commits can be of any length and complexity as
-# long as all of the timestamps are greater than that of S.
-
-S=$(doit  0 S)
-
-C0=$(doit -3 C0 $S)
-C1=$(doit -2 C1 $C0)
-C2=$(doit -1 C2 $C1)
-
-L0=$(doit  1 L0 $S)
-L1=$(doit  2 L1 $L0)
-L2=$(doit  3 L2 $L1)
-
-R0=$(doit  1 R0 $S)
-R1=$(doit  2 R1 $R0)
-R2=$(doit  3 R2 $R1)
-
-PL=$(doit  4 PL $L2 $C2)
-PR=$(doit  4 PR $C2 $R2)
-
-test_expect_success 'compute merge-base (single)' \
-    'MB=$(git merge-base PL PR) &&
-     expr "$(git name-rev "$MB")" : "[0-9a-f]* tags/C2"'
-
-test_expect_success 'compute merge-base (all)' \
-    'MB=$(git merge-base --all PL PR) &&
-     expr "$(git name-rev "$MB")" : "[0-9a-f]* tags/C2"'
-
-# Another set to demonstrate base between one commit and a merge
-# in the documentation.
-#
-# * C (MMC) * B (MMB) * A  (MMA)
-# * o       * o       * o
-# * o       * o       * o
-# * o       * o       * o
-# * o       | _______/
-# |         |/
-# |         * 1 (MM1)
-# | _______/
-# |/
-# * root (MMR)
-
+test_expect_success 'setup' '
+	T=$(git write-tree) &&
+
+	M=1130000000 &&
+	Z=+0000 &&
+
+	GIT_COMMITTER_EMAIL=git@comm.iter.xz &&
+	GIT_COMMITTER_NAME="C O Mmiter" &&
+	GIT_AUTHOR_NAME="A U Thor" &&
+	GIT_AUTHOR_EMAIL=git@au.thor.xz &&
+	export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
+
+	doit() {
+		OFFSET=$1 &&
+		NAME=$2 &&
+		shift 2 &&
+
+		PARENTS= &&
+		for P
+		do
+			PARENTS="${PARENTS}-p $P "
+		done &&
+
+		GIT_COMMITTER_DATE="$(($M + $OFFSET)) $Z" &&
+		GIT_AUTHOR_DATE=$GIT_COMMITTER_DATE &&
+		export GIT_COMMITTER_DATE GIT_AUTHOR_DATE &&
+
+		commit=$(echo $NAME | git commit-tree $T $PARENTS) &&
+
+		echo $commit >.git/refs/tags/$NAME &&
+		echo $commit
+	}
+'
+
+test_expect_success 'set up G and H' '
+	# E---D---C---B---A
+	# \"-_         \   \
+	#  \  `---------G   \
+	#   \                \
+	#    F----------------H
+	E=$(doit 5 E) &&
+	D=$(doit 4 D $E) &&
+	F=$(doit 6 F $E) &&
+	C=$(doit 3 C $D) &&
+	B=$(doit 2 B $C) &&
+	A=$(doit 1 A $B) &&
+	G=$(doit 7 G $B $E) &&
+	H=$(doit 8 H $A $F)
+'
+
+test_expect_success 'merge-base G H' '
+	git name-rev $B >expected &&
+
+	MB=$(git merge-base G H) &&
+	git name-rev "$MB" >actual.single &&
+
+	MB=$(git merge-base --all G H) &&
+	git name-rev "$MB" >actual.all &&
+
+	MB=$(git show-branch --merge-base G H) &&
+	git name-rev "$MB" >actual.sb &&
+
+	test_cmp expected actual.single &&
+	test_cmp expected actual.all &&
+	test_cmp expected actual.sb
+'
+
+test_expect_success 'unsynchronized clocks' '
+	# This test is to demonstrate that relying on timestamps in a distributed
+	# SCM to provide a _consistent_ partial ordering of commits leads to
+	# insanity.
+	#
+	#               Relative
+	# Structure     timestamps
+	#
+	#   PL  PR        +4  +4
+	#  /  \/  \      /  \/  \
+	# L2  C2  R2    +3  -1  +3
+	# |   |   |     |   |   |
+	# L1  C1  R1    +2  -2  +2
+	# |   |   |     |   |   |
+	# L0  C0  R0    +1  -3  +1
+	#   \ |  /        \ |  /
+	#     S             0
+	#
+	# The left and right chains of commits can be of any length and complexity as
+	# long as all of the timestamps are greater than that of S.
+
+	S=$(doit  0 S) &&
+
+	C0=$(doit -3 C0 $S) &&
+	C1=$(doit -2 C1 $C0) &&
+	C2=$(doit -1 C2 $C1) &&
+
+	L0=$(doit  1 L0 $S) &&
+	L1=$(doit  2 L1 $L0) &&
+	L2=$(doit  3 L2 $L1) &&
+
+	R0=$(doit  1 R0 $S) &&
+	R1=$(doit  2 R1 $R0) &&
+	R2=$(doit  3 R2 $R1) &&
+
+	PL=$(doit  4 PL $L2 $C2) &&
+	PR=$(doit  4 PR $C2 $R2)
+
+	git name-rev $C2 >expected &&
+
+	MB=$(git merge-base PL PR) &&
+	git name-rev "$MB" >actual.single &&
+
+	MB=$(git merge-base --all PL PR) &&
+	git name-rev "$MB" >actual.all &&
+
+	test_cmp expected actual.single &&
+	test_cmp expected actual.all
+'
 
 test_expect_success 'merge-base for octopus-step (setup)' '
-	test_tick && git commit --allow-empty -m root && git tag MMR &&
-	test_tick && git commit --allow-empty -m 1 && git tag MM1 &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m A && git tag MMA &&
+	# Another set to demonstrate base between one commit and a merge
+	# in the documentation.
+	#
+	# * C (MMC) * B (MMB) * A  (MMA)
+	# * o       * o       * o
+	# * o       * o       * o
+	# * o       * o       * o
+	# * o       | _______/
+	# |         |/
+	# |         * 1 (MM1)
+	# | _______/
+	# |/
+	# * root (MMR)
+
+	test_commit MMR &&
+	test_commit MM1 &&
+	test_commit MM-o &&
+	test_commit MM-p &&
+	test_commit MM-q &&
+	test_commit MMA &&
 	git checkout MM1 &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m B && git tag MMB &&
+	test_commit MM-r &&
+	test_commit MM-s &&
+	test_commit MM-t &&
+	test_commit MMB &&
 	git checkout MMR &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m C && git tag MMC
+	test_commit MM-u &&
+	test_commit MM-v &&
+	test_commit MM-w &&
+	test_commit MM-x &&
+	test_commit MMC
 '
 
 test_expect_success 'merge-base A B C' '
-	MB=$(git merge-base --all MMA MMB MMC) &&
-	MM1=$(git rev-parse --verify MM1) &&
-	test "$MM1" = "$MB"
-'
+	git rev-parse --verify MM1 >expected &&
+	git rev-parse --verify MMR >expected.sb &&
+
+	git merge-base --all MMA MMB MMC >actual &&
+	git show-branch --merge-base MMA MMB MMC >actual.sb &&
 
-test_expect_success 'merge-base A B C using show-branch' '
-	MB=$(git show-branch --merge-base MMA MMB MMC) &&
-	MMR=$(git rev-parse --verify MMR) &&
-	test "$MMR" = "$MB"
+	test_cmp expected actual &&
+	test_cmp expected.sb actual.sb
 '
 
-test_expect_success 'criss-cross merge-base for octopus-step (setup)' '
+test_expect_success 'criss-cross merge-base for octopus-step' '
 	git reset --hard MMR &&
-	test_tick && git commit --allow-empty -m 1 && git tag CC1 &&
+	test_commit CC1 &&
 	git reset --hard E &&
-	test_tick && git commit --allow-empty -m 2 && git tag CC2 &&
-	test_tick && git merge -s ours CC1 &&
-	test_tick && git commit --allow-empty -m o &&
-	test_tick && git commit --allow-empty -m B && git tag CCB &&
+	test_commit CC2 &&
+	test_tick &&
+	git merge -s ours CC1 &&
+	test_commit CC-o &&
+	test_commit CCB &&
 	git reset --hard CC1 &&
-	test_tick && git merge -s ours CC2 &&
-	test_tick && git commit --allow-empty -m A && git tag CCA
-'
+	git merge -s ours CC2 &&
+	test_commit CCA &&
 
-test_expect_success 'merge-base B A^^ A^^2' '
-	MB0=$(git merge-base --all CCB CCA^^ CCA^^2 | sort) &&
-	MB1=$(git rev-parse CC1 CC2 | sort) &&
-	test "$MB0" = "$MB1"
+	git rev-parse CC1 CC2 >expected &&
+	git merge-base --all CCB CCA^^ CCA^^2 >actual &&
+
+	sort expected >expected.sorted &&
+	sort actual >actual.sorted &&
+	test_cmp expected.sorted actual.sorted
 '
 
 test_done
-- 
1.7.2.1.544.ga752d.dirty
