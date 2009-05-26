From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] t5500: Modernize test style
Date: Mon, 25 May 2009 23:17:14 -0700
Message-ID: <1243318634-20108-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 08:17:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8pyZ-00048F-PD
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 08:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbZEZGRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 02:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbZEZGRS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 02:17:18 -0400
Received: from mail-pz0-f109.google.com ([209.85.222.109]:35362 "EHLO
	mail-pz0-f109.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbZEZGRR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 02:17:17 -0400
Received: by pzk7 with SMTP id 7so2828512pzk.33
        for <git@vger.kernel.org>; Mon, 25 May 2009 23:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=U/fwWD6twLBTDOgl+H/Ta5nHcwX8vfpOT0m/qwvZKvw=;
        b=mtwdSkYS7g5C21sOZaFd42xpx2tNRNZWTNAq8G2RynKOsGYolcDVVstNO22jhKR6nX
         lyeZu6afMOc4Gso8pZiOvotlNcB3e0qLb7j5BcD4ifi5QMQFsy/nJmnPLrelu1rVzUZI
         DIp9+T6v5b6a5XjufF1Lu/IDxuhueCjQbrlDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=P6OHEwekt8NiV1E6jFflamsLi54u/idaUxNDxfgaHX0F7S4xDM8MOvwhPBkhIyKX98
         Ktr8TUHq0XsNJp3t8MNYF/dIMBdCWES88NHoeWG1vOH1GKjelb71JAiDZJ5LdUO7L0gF
         KQ5EhLM343Sby18zDI1nUE5JxIzoN/dboq0js=
Received: by 10.142.82.6 with SMTP id f6mr2925542wfb.282.1243318638459;
        Mon, 25 May 2009 23:17:18 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id b39sm12669508rvf.1.2009.05.25.23.17.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 23:17:17 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 25 May 2009 23:17:14 -0700
X-Mailer: git-send-email 1.6.3.1.152.g9619f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119999>

Code outside of the test harness was emitting "Initializing..." from
git-init. Fixup this test to be more modern:

    - test_expect_object_count() and count_objects() are unused

    - use grep directly instead of test "..." = $(grep ...)

    - end the test_expect_success line with a single-quote and put the
      test on a new line

    - put as much code inside the test harness as possible

    - no_strict_count_check is unused and duplicates the test
      "new object count"

    - use && whenever possible to catch errors early

    - use test_tick instead of GIT_AUTHOR_DATE=$sec

    - remove debugging aid log.txt

    - use subshells instead of cd-ing around

Also merge the pull test into one large test.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This is a major rewrite, and probably code churn.

 t/t5500-fetch-pack.sh |  276 ++++++++++++++++++++++++++----------------------
 1 files changed, 149 insertions(+), 127 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index c450f33..a8c2ca2 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -3,9 +3,8 @@
 # Copyright (c) 2005 Johannes Schindelin
 #
 
-test_description='Testing multi_ack pack fetching
+test_description='Testing multi_ack pack fetching'
 
-'
 . ./test-lib.sh
 
 # Test fetch-pack/upload-pack pair.
@@ -13,77 +12,60 @@ test_description='Testing multi_ack pack fetching
 # Some convenience functions
 
 add () {
-	name=$1
-	text="$@"
-	branch=`echo $name | sed -e 's/^\(.\).*$/\1/'`
-	parents=""
+	name=$1 &&
+	text="$@" &&
+	branch=`echo $name | sed -e 's/^\(.\).*$/\1/'` &&
+	parents="" &&
 
-	shift
+	shift &&
 	while test $1; do
-		parents="$parents -p $1"
+		parents="$parents -p $1" &&
 		shift
-	done
+	done &&
 
-	echo "$text" > test.txt
-	git update-index --add test.txt
-	tree=$(git write-tree)
+	echo "$text" > test.txt &&
+	git update-index --add test.txt &&
+	tree=$(git write-tree) &&
 	# make sure timestamps are in correct order
-	sec=$(($sec+1))
-	commit=$(echo "$text" | GIT_AUTHOR_DATE=$sec \
-		git commit-tree $tree $parents 2>>log2.txt)
-	eval "$name=$commit; export $name"
-	echo $commit > .git/refs/heads/$branch
+	test_tick &&
+	commit=$(echo "$text" | git commit-tree $tree $parents) &&
+	eval "$name=$commit; export $name" &&
+	echo $commit > .git/refs/heads/$branch &&
 	eval ${branch}TIP=$commit
 }
 
-count_objects () {
-	ls .git/objects/??/* 2>>log2.txt | wc -l | tr -d " "
-}
-
-test_expect_object_count () {
-	message=$1
-	count=$2
-
-	output="$(count_objects)"
-	test_expect_success \
-		"new object count $message" \
-		"test $count = $output"
-}
-
 pull_to_client () {
-	number=$1
-	heads=$2
-	count=$3
-	no_strict_count_check=$4
-
-	cd client
-	test_expect_success "$number pull" \
-		"git fetch-pack -k -v .. $heads"
-	case "$heads" in *A*) echo $ATIP > .git/refs/heads/A;; esac
-	case "$heads" in *B*) echo $BTIP > .git/refs/heads/B;; esac
-	git symbolic-ref HEAD refs/heads/`echo $heads | sed -e 's/^\(.\).*$/\1/'`
-
-	test_expect_success "fsck" 'git fsck --full > fsck.txt 2>&1'
-
-	test_expect_success 'check downloaded results' \
-	'mv .git/objects/pack/pack-* . &&
-	 p=`ls -1 pack-*.pack` &&
-	 git unpack-objects <$p &&
-	 git fsck --full'
-
-	test_expect_success "new object count after $number pull" \
-	'idx=`echo pack-*.idx` &&
-	 pack_count=`git show-index <$idx | wc -l` &&
-	 test $pack_count = $count'
-	test -z "$pack_count" && pack_count=0
-	if [ -z "$no_strict_count_check" ]; then
-		test_expect_success "minimal count" "test $count = $pack_count"
-	else
-		test $count != $pack_count && \
-			echo "WARNING: $pack_count objects transmitted, only $count of which were needed"
-	fi
-	rm -f pack-*
-	cd ..
+	number=$1 &&
+	heads=$2 &&
+	count=$3 &&
+	test_expect_success "$number pull" '
+		(
+			cd client &&
+			git fetch-pack -k -v .. $heads &&
+
+			case "$heads" in
+			    *A*)
+				    echo $ATIP > .git/refs/heads/A;;
+			esac &&
+			case "$heads" in *B*)
+			    echo $BTIP > .git/refs/heads/B;;
+			esac &&
+			git symbolic-ref HEAD refs/heads/`echo $heads \
+				| sed -e "s/^\(.\).*$/\1/"` &&
+
+			git fsck --full &&
+
+			mv .git/objects/pack/pack-* . &&
+			p=`ls -1 pack-*.pack` &&
+			git unpack-objects <$p &&
+			git fsck --full &&
+
+			idx=`echo pack-*.idx` &&
+			pack_count=`git show-index <$idx | wc -l` &&
+			test $pack_count = $count &&
+			rm -f pack-*
+		)
+	'
 }
 
 # Here begins the actual testing
@@ -94,89 +76,129 @@ pull_to_client () {
 
 # client pulls A20, B1. Then tracks only B. Then pulls A.
 
-(
+test_expect_success 'setup' '
 	mkdir client &&
-	cd client &&
-	git init 2>> log2.txt &&
-	git config transfer.unpacklimit 0
-)
-
-add A1
-
-prev=1; cur=2; while [ $cur -le 10 ]; do
-	add A$cur $(eval echo \$A$prev)
-	prev=$cur
-	cur=$(($cur+1))
-done
-
-add B1 $A1
-
-echo $ATIP > .git/refs/heads/A
-echo $BTIP > .git/refs/heads/B
-git symbolic-ref HEAD refs/heads/B
+	(
+		cd client &&
+		git init &&
+		git config transfer.unpacklimit 0
+	) &&
+	add A1 &&
+	prev=1 &&
+	cur=2 &&
+	while [ $cur -le 10 ]; do
+		add A$cur $(eval echo \$A$prev) &&
+		prev=$cur &&
+		cur=$(($cur+1))
+	done &&
+	add B1 $A1
+	echo $ATIP > .git/refs/heads/A &&
+	echo $BTIP > .git/refs/heads/B &&
+	git symbolic-ref HEAD refs/heads/B
+'
 
 pull_to_client 1st "B A" $((11*3))
 
-add A11 $A10
-
-prev=1; cur=2; while [ $cur -le 65 ]; do
-	add B$cur $(eval echo \$B$prev)
-	prev=$cur
-	cur=$(($cur+1))
-done
+test_expect_success 'post 1st pull setup' '
+	add A11 $A10 &&
+	prev=1 &&
+	cur=2 &&
+	while [ $cur -le 65 ]; do
+		add B$cur $(eval echo \$B$prev) &&
+		prev=$cur &&
+		cur=$(($cur+1))
+	done
+'
 
 pull_to_client 2nd "B" $((64*3))
 
-pull_to_client 3rd "A" $((1*3)) # old fails
-
-test_expect_success "clone shallow" 'git clone --depth 2 "file://$(pwd)/." shallow'
+pull_to_client 3rd "A" $((1*3))
 
-(cd shallow; git count-objects -v) > count.shallow
-
-test_expect_success "clone shallow object count" \
-	"test \"in-pack: 18\" = \"$(grep in-pack count.shallow)\""
-
-count_output () {
-	sed -e '/^in-pack:/d' -e '/^packs:/d' -e '/^size-pack:/d' -e '/: 0$/d' "$1"
-}
+test_expect_success 'clone shallow' '
+	git clone --depth 2 "file://$(pwd)/." shallow
+'
 
-test_expect_success "clone shallow object count (part 2)" '
-	test -z "$(count_output count.shallow)"
+test_expect_success 'clone shallow object count' '
+	(
+		cd shallow &&
+		git count-objects -v
+	) > count.shallow &&
+	grep "^in-pack: 18" count.shallow
 '
 
-test_expect_success "fsck in shallow repo" \
-	"(cd shallow; git fsck --full)"
+test_expect_success 'clone shallow object count (part 2)' '
+	sed -e "/^in-pack:/d" -e "/^packs:/d" -e "/^size-pack:/d" \
+	    -e "/: 0$/d" count.shallow > count_output &&
+	! test -s count_output
+'
 
-#test_done; exit
+test_expect_success 'fsck in shallow repo' '
+	(
+		cd shallow &&
+		git fsck --full
+	)
+'
 
-add B66 $B65
-add B67 $B66
+test_expect_success 'add two more' '
+	add B66 $B65 &&
+	add B67 $B66
+'
 
-test_expect_success "pull in shallow repo" \
-	"(cd shallow; git pull .. B)"
+test_expect_success 'pull in shallow repo' '
+	(
+		cd shallow &&
+		git pull .. B
+	)
+'
 
-(cd shallow; git count-objects -v) > count.shallow
-test_expect_success "clone shallow object count" \
-	"test \"count: 6\" = \"$(grep count count.shallow)\""
+test_expect_success 'clone shallow object count' '
+	(
+		cd shallow &&
+		git count-objects -v
+	) > count.shallow &&
+	grep "^count: 6" count.shallow
+'
 
-add B68 $B67
-add B69 $B68
+test_expect_success 'add two more (part 2)' '
+	add B68 $B67 &&
+	add B69 $B68
+'
 
-test_expect_success "deepening pull in shallow repo" \
-	"(cd shallow; git pull --depth 4 .. B)"
+test_expect_success 'deepening pull in shallow repo' '
+	(
+		cd shallow &&
+		git pull --depth 4 .. B
+	)
+'
 
-(cd shallow; git count-objects -v) > count.shallow
-test_expect_success "clone shallow object count" \
-	"test \"count: 12\" = \"$(grep count count.shallow)\""
+test_expect_success 'clone shallow object count' '
+	(
+		cd shallow &&
+		git count-objects -v
+	) > count.shallow &&
+	grep "^count: 12" count.shallow
+'
 
-test_expect_success "deepening fetch in shallow repo" \
-	"(cd shallow; git fetch --depth 4 .. A:A)"
+test_expect_success 'deepening fetch in shallow repo' '
+	(
+		cd shallow &&
+		git fetch --depth 4 .. A:A
+	)
+'
 
-(cd shallow; git count-objects -v) > count.shallow
-test_expect_success "clone shallow object count" \
-	"test \"count: 18\" = \"$(grep count count.shallow)\""
+test_expect_success 'clone shallow object count' '
+	(
+		cd shallow &&
+		git count-objects -v
+	) > count.shallow &&
+	grep "^count: 18" count.shallow
+'
 
-test_expect_success "pull in shallow repo with missing merge base" \
-	"(cd shallow && test_must_fail git pull --depth 4 .. A)"
+test_expect_success 'pull in shallow repo with missing merge base' '
+	(
+		cd shallow &&
+		test_must_fail git pull --depth 4 .. A
+	)
+'
 
 test_done
-- 
1.6.3.1.152.g9619f
