From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] tests: eliminate unnecessary setup test assertions
Date: Fri, 6 May 2011 15:58:52 -0500
Message-ID: <20110506205851.GB20182@elie>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
 <20110506205441.GA20182@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 22:59:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIS74-00023Y-UV
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 22:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab1EFU66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 16:58:58 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63630 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247Ab1EFU65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 16:58:57 -0400
Received: by yxs7 with SMTP id 7so1331408yxs.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kYyRkPMVllpZiE/U7Y1x40gruSG+xwgtLfKha0R/Rxg=;
        b=cvN1pMzkz6uKMglx16flaa/D0uwpAlyFcObfe3uMQYFdjqoo5lQ2f207Zz+/VDlY4+
         tNplBiD5xWxNpSdN/OtB4X1TWx4MkMT/b00T1o4y90jBnknENgxsfbXPFQ9WBWB9Fyvz
         kodFGd5OwURud2VgnCLB6wqkSzmPjbAUiQlvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hqZkKuhFmP/7NAzVQHGdP4fwtTW5Ht8votS/QLAeic6kpuQdhHxXN7HZ6TJXjYPrGb
         yGeTInYI60Qsgrmid1PFVHiEoMJOoXIeoaE6KokBFz6DnWTofGljH5jVNp8zYJ/saZ8W
         xBPAilc+OmqerUqQK8H1OuG6uRqunbI+tX4EI=
Received: by 10.236.176.129 with SMTP id b1mr5037174yhm.508.1304715537161;
        Fri, 06 May 2011 13:58:57 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id j2sm1660896yhm.13.2011.05.06.13.58.55
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 13:58:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110506205441.GA20182@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173009>

Most of git's tests write files and define shell functions and
variables that will last throughout a test script at the top of
the script, before all test assertions:

	. ./test-lib.sh

	VAR='some value'
	export VAR

	>empty

	fn () {
		do something
	}

	test_expect_success 'setup' '
		... nontrivial commands go here ...
	'

Two scripts use a different style with this kind of trivial code
enclosed by a test assertion; fix them.  The usual style is easier to
read since there is less indentation to keep track of and no need to
worry about nested quotes; and on the other hand, because the commands
in question are trivial, it should not make the test suite any worse
at catching future bugs in git.

While at it, make some other small tweaks:

 - spell function definitions with a space before () for consistency
   with other scripts;

 - use the self-contained command "git mktree </dev/null" in
   preference to "git write-tree" which looks at the index when
   writing an empty tree.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I should have done this long ago.  Sorry for the eyesore.

 t/t6010-merge-base.sh |   62 +++++++++++-----------
 t/t7600-merge.sh      |  134 ++++++++++++++++++++++++-------------------------
 2 files changed, 97 insertions(+), 99 deletions(-)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 082032e..f80bba8 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -8,38 +8,38 @@ test_description='Merge base and parent list computation.
 
 . ./test-lib.sh
 
+M=1130000000
+Z=+0000
+
+GIT_COMMITTER_EMAIL=git@comm.iter.xz
+GIT_COMMITTER_NAME='C O Mmiter'
+GIT_AUTHOR_NAME='A U Thor'
+GIT_AUTHOR_EMAIL=git@au.thor.xz
+export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+
+doit () {
+	OFFSET=$1 &&
+	NAME=$2 &&
+	shift 2 &&
+
+	PARENTS= &&
+	for P
+	do
+		PARENTS="${PARENTS}-p $P "
+	done &&
+
+	GIT_COMMITTER_DATE="$(($M + $OFFSET)) $Z" &&
+	GIT_AUTHOR_DATE=$GIT_COMMITTER_DATE &&
+	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE &&
+
+	commit=$(echo $NAME | git commit-tree $T $PARENTS) &&
+
+	echo $commit >.git/refs/tags/$NAME &&
+	echo $commit
+}
+
 test_expect_success 'setup' '
-	T=$(git write-tree) &&
-
-	M=1130000000 &&
-	Z=+0000 &&
-
-	GIT_COMMITTER_EMAIL=git@comm.iter.xz &&
-	GIT_COMMITTER_NAME="C O Mmiter" &&
-	GIT_AUTHOR_NAME="A U Thor" &&
-	GIT_AUTHOR_EMAIL=git@au.thor.xz &&
-	export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
-
-	doit() {
-		OFFSET=$1 &&
-		NAME=$2 &&
-		shift 2 &&
-
-		PARENTS= &&
-		for P
-		do
-			PARENTS="${PARENTS}-p $P "
-		done &&
-
-		GIT_COMMITTER_DATE="$(($M + $OFFSET)) $Z" &&
-		GIT_AUTHOR_DATE=$GIT_COMMITTER_DATE &&
-		export GIT_COMMITTER_DATE GIT_AUTHOR_DATE &&
-
-		commit=$(echo $NAME | git commit-tree $T $PARENTS) &&
-
-		echo $commit >.git/refs/tags/$NAME &&
-		echo $commit
-	}
+	T=$(git mktree </dev/null)
 '
 
 test_expect_success 'set up G and H' '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 87d5d78..c665acd 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -28,80 +28,78 @@ Testing basic merge operations/option parsing.
 
 . ./test-lib.sh
 
-test_expect_success 'set up test data and helpers' '
-	printf "%s\n" 1 2 3 4 5 6 7 8 9 >file &&
-	printf "%s\n" "1 X" 2 3 4 5 6 7 8 9 >file.1 &&
-	printf "%s\n" 1 2 3 4 "5 X" 6 7 8 9 >file.5 &&
-	printf "%s\n" 1 2 3 4 5 6 7 8 "9 X" >file.9 &&
-	printf "%s\n" "1 X" 2 3 4 5 6 7 8 9 >result.1 &&
-	printf "%s\n" "1 X" 2 3 4 "5 X" 6 7 8 9 >result.1-5 &&
-	printf "%s\n" "1 X" 2 3 4 "5 X" 6 7 8 "9 X" >result.1-5-9 &&
+printf '%s\n' 1 2 3 4 5 6 7 8 9 >file
+printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >file.1
+printf '%s\n' 1 2 3 4 '5 X' 6 7 8 9 >file.5
+printf '%s\n' 1 2 3 4 5 6 7 8 '9 X' >file.9
+printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >result.1
+printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 9 >result.1-5
+printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
 
-	create_merge_msgs() {
-		echo "Merge commit '\''c2'\''" >msg.1-5 &&
-		echo "Merge commit '\''c2'\''; commit '\''c3'\''" >msg.1-5-9 &&
-		{
-			echo "Squashed commit of the following:" &&
-			echo &&
-			git log --no-merges ^HEAD c1
-		} >squash.1 &&
-		{
-			echo "Squashed commit of the following:" &&
-			echo &&
-			git log --no-merges ^HEAD c2
-		} >squash.1-5 &&
-		{
-			echo "Squashed commit of the following:" &&
-			echo &&
-			git log --no-merges ^HEAD c2 c3
-		} >squash.1-5-9 &&
-		echo >msg.nolog &&
-		{
-			echo "* commit '\''c3'\'':" &&
-			echo "  commit 3" &&
-			echo
-		} >msg.log
-	} &&
+create_merge_msgs () {
+	echo "Merge commit 'c2'" >msg.1-5 &&
+	echo "Merge commit 'c2'; commit 'c3'" >msg.1-5-9 &&
+	{
+		echo "Squashed commit of the following:" &&
+		echo &&
+		git log --no-merges ^HEAD c1
+	} >squash.1 &&
+	{
+		echo "Squashed commit of the following:" &&
+		echo &&
+		git log --no-merges ^HEAD c2
+	} >squash.1-5 &&
+	{
+		echo "Squashed commit of the following:" &&
+		echo &&
+		git log --no-merges ^HEAD c2 c3
+	} >squash.1-5-9 &&
+	echo >msg.nolog &&
+	{
+		echo "* commit 'c3':" &&
+		echo "  commit 3" &&
+		echo
+	} >msg.log
+}
 
-	verify_merge() {
-		test_cmp "$2" "$1" &&
-		git update-index --refresh &&
-		git diff --exit-code &&
-		if test -n "$3"
-		then
-			git show -s --pretty=format:%s HEAD >msg.act &&
-			test_cmp "$3" msg.act
-		fi
-	} &&
+verify_merge () {
+	test_cmp "$2" "$1" &&
+	git update-index --refresh &&
+	git diff --exit-code &&
+	if test -n "$3"
+	then
+		git show -s --pretty=format:%s HEAD >msg.act &&
+		test_cmp "$3" msg.act
+	fi
+}
 
-	verify_head() {
-		echo "$1" >head.expected &&
-		git rev-parse HEAD >head.actual &&
-		test_cmp head.expected head.actual
-	} &&
+verify_head () {
+	echo "$1" >head.expected &&
+	git rev-parse HEAD >head.actual &&
+	test_cmp head.expected head.actual
+}
 
-	verify_parents() {
-		printf "%s\n" "$@" >parents.expected &&
-		>parents.actual &&
-		i=1 &&
-		while test $i -le $#
-		do
-			git rev-parse HEAD^$i >>parents.actual &&
-			i=$(expr $i + 1) ||
-			return 1
-		done &&
-		test_cmp parents.expected parents.actual
-	} &&
+verify_parents () {
+	printf '%s\n' "$@" >parents.expected &&
+	>parents.actual &&
+	i=1 &&
+	while test $i -le $#
+	do
+		git rev-parse HEAD^$i >>parents.actual &&
+		i=$(expr $i + 1) ||
+		return 1
+	done &&
+	test_cmp parents.expected parents.actual
+}
 
-	verify_mergeheads() {
-		printf "%s\n" "$@" >mergehead.expected &&
-		test_cmp mergehead.expected .git/MERGE_HEAD
-	} &&
+verify_mergeheads () {
+	printf '%s\n' "$@" >mergehead.expected &&
+	test_cmp mergehead.expected .git/MERGE_HEAD
+}
 
-	verify_no_mergehead() {
-		! test -e .git/MERGE_HEAD
-	}
-'
+verify_no_mergehead () {
+	! test -e .git/MERGE_HEAD
+}
 
 test_expect_success 'setup' '
 	git add file &&
-- 
1.7.5.1
