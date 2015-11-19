From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 7/7] modernize t9300: move test preparations into test_expect_success
Date: Thu, 19 Nov 2015 20:09:49 +0100
Message-ID: <6362bf1eb3c11ae379bf4414577de363e8575882.1447959452.git.j6t@kdbg.org>
References: <cover.1447959452.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:11:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzUbz-0007wr-LI
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 20:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbbKSTKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 14:10:30 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:7459 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161150AbbKSTK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 14:10:28 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p1rDx0QKdz5tlM;
	Thu, 19 Nov 2015 20:10:25 +0100 (CET)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id 1E58A536F;
	Thu, 19 Nov 2015 20:10:24 +0100 (CET)
X-Mailer: git-send-email 2.6.2.337.ga235d84
In-Reply-To: <cover.1447959452.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281489>

Our usual style these days is to execute everything inside
test_expect_success. Make it so.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9300-fast-import.sh | 2580 ++++++++++++++++++++++++------------------------
 1 file changed, 1297 insertions(+), 1283 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 7586f41..14a9384 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -51,54 +51,53 @@ echo "$@"'
 ### series A
 ###
 
-test_tick
-
 test_expect_success 'empty stream succeeds' '
 	git fast-import </dev/null
 '
 
-cat >input <<-INPUT_END &&
-blob
-mark :2
-data <<EOF
-$file2_data
-EOF
-
-blob
-mark :3
-data <<END
-$file3_data
-END
-
-blob
-mark :4
-data $file4_len
-$file4_data
-commit refs/heads/master
-mark :5
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-initial
-COMMIT
-
-M 644 :2 file2
-M 644 :3 file3
-M 755 :4 file4
-
-tag series-A
-from :5
-data <<EOF
-An annotated tag without a tagger
-EOF
-
-tag series-A-blob
-from :3
-data <<EOF
-An annotated tag that annotates a blob.
-EOF
-
-INPUT_END
 test_expect_success 'A: create pack from stdin' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	blob
+	mark :2
+	data <<EOF
+	$file2_data
+	EOF
+
+	blob
+	mark :3
+	data <<END
+	$file3_data
+	END
+
+	blob
+	mark :4
+	data $file4_len
+	$file4_data
+	commit refs/heads/master
+	mark :5
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	initial
+	COMMIT
+
+	M 644 :2 file2
+	M 644 :3 file3
+	M 755 :4 file4
+
+	tag series-A
+	from :5
+	data <<EOF
+	An annotated tag without a tagger
+	EOF
+
+	tag series-A-blob
+	from :3
+	data <<EOF
+	An annotated tag that annotates a blob.
+	EOF
+
+	INPUT_END
 	git fast-import --export-marks=marks.out <input &&
 	git whatchanged master
 '
@@ -107,76 +106,76 @@ test_expect_success 'A: verify pack' '
 	verify_packs
 '
 
-cat >expect <<-EOF &&
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-initial
-EOF
 test_expect_success 'A: verify commit' '
+	cat >expect <<-EOF &&
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	initial
+	EOF
 	git cat-file commit master | sed 1d >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-100644 blob file2
-100644 blob file3
-100755 blob file4
-EOF
 test_expect_success 'A: verify tree' '
+	cat >expect <<-EOF &&
+	100644 blob file2
+	100644 blob file3
+	100755 blob file4
+	EOF
 	git cat-file -p master^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
 
-echo "$file2_data" >expect
 test_expect_success 'A: verify file2' '
+	echo "$file2_data" >expect &&
 	git cat-file blob master:file2 >actual &&
 	test_cmp expect actual
 '
 
-echo "$file3_data" >expect
 test_expect_success 'A: verify file3' '
+	echo "$file3_data" >expect &&
 	git cat-file blob master:file3 >actual &&
 	test_cmp expect actual
 '
 
-printf "$file4_data" >expect
 test_expect_success 'A: verify file4' '
+	printf "$file4_data" >expect &&
 	git cat-file blob master:file4 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-object $(git rev-parse refs/heads/master)
-type commit
-tag series-A
-
-An annotated tag without a tagger
-EOF
 test_expect_success 'A: verify tag/series-A' '
+	cat >expect <<-EOF &&
+	object $(git rev-parse refs/heads/master)
+	type commit
+	tag series-A
+
+	An annotated tag without a tagger
+	EOF
 	git cat-file tag tags/series-A >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-object $(git rev-parse refs/heads/master:file3)
-type blob
-tag series-A-blob
-
-An annotated tag that annotates a blob.
-EOF
 test_expect_success 'A: verify tag/series-A-blob' '
+	cat >expect <<-EOF &&
+	object $(git rev-parse refs/heads/master:file3)
+	type blob
+	tag series-A-blob
+
+	An annotated tag that annotates a blob.
+	EOF
 	git cat-file tag tags/series-A-blob >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-:2 `git rev-parse --verify master:file2`
-:3 `git rev-parse --verify master:file3`
-:4 `git rev-parse --verify master:file4`
-:5 `git rev-parse --verify master^0`
-EOF
 test_expect_success 'A: verify marks output' '
+	cat >expect <<-EOF &&
+	:2 `git rev-parse --verify master:file2`
+	:3 `git rev-parse --verify master:file3`
+	:4 `git rev-parse --verify master:file4`
+	:5 `git rev-parse --verify master^0`
+	EOF
 	test_cmp expect marks.out
 '
 
@@ -188,68 +187,69 @@ test_expect_success 'A: verify marks import' '
 	test_cmp expect marks.new
 '
 
-test_tick
-new_blob=$(echo testing | git hash-object --stdin)
-cat >input <<-INPUT_END &&
-tag series-A-blob-2
-from $(git rev-parse refs/heads/master:file3)
-data <<EOF
-Tag blob by sha1.
-EOF
-
-blob
-mark :6
-data <<EOF
-testing
-EOF
-
-commit refs/heads/new_blob
-committer  <> 0 +0000
-data 0
-M 644 :6 new_blob
-#pretend we got sha1 from fast-import
-ls "new_blob"
-
-tag series-A-blob-3
-from $new_blob
-data <<EOF
-Tag new_blob.
-EOF
-INPUT_END
-
-cat >expect <<-EOF &&
-object $(git rev-parse refs/heads/master:file3)
-type blob
-tag series-A-blob-2
-
-Tag blob by sha1.
-object $new_blob
-type blob
-tag series-A-blob-3
-
-Tag new_blob.
-EOF
-
 test_expect_success 'A: tag blob by sha1' '
+	test_tick &&
+	new_blob=$(echo testing | git hash-object --stdin) &&
+	cat >input <<-INPUT_END &&
+	tag series-A-blob-2
+	from $(git rev-parse refs/heads/master:file3)
+	data <<EOF
+	Tag blob by sha1.
+	EOF
+
+	blob
+	mark :6
+	data <<EOF
+	testing
+	EOF
+
+	commit refs/heads/new_blob
+	committer  <> 0 +0000
+	data 0
+	M 644 :6 new_blob
+	#pretend we got sha1 from fast-import
+	ls "new_blob"
+
+	tag series-A-blob-3
+	from $new_blob
+	data <<EOF
+	Tag new_blob.
+	EOF
+	INPUT_END
+
+	cat >expect <<-EOF &&
+	object $(git rev-parse refs/heads/master:file3)
+	type blob
+	tag series-A-blob-2
+
+	Tag blob by sha1.
+	object $new_blob
+	type blob
+	tag series-A-blob-3
+
+	Tag new_blob.
+	EOF
+
 	git fast-import <input &&
 	git cat-file tag tags/series-A-blob-2 >actual &&
 	git cat-file tag tags/series-A-blob-3 >>actual &&
 	test_cmp expect actual
 '
 
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/verify--import-marks
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-recreate from :5
-COMMIT
+test_expect_success 'A: verify marks import does not crash' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/verify--import-marks
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	recreate from :5
+	COMMIT
+
+	from :5
+	M 755 :2 copy-of-file2
 
-from :5
-M 755 :2 copy-of-file2
+	INPUT_END
 
-INPUT_END
-test_expect_success 'A: verify marks import does not crash' '
 	git fast-import --import-marks=marks.out <input &&
 	git whatchanged verify--import-marks
 '
@@ -258,68 +258,66 @@ test_expect_success 'A: verify pack' '
 	verify_packs
 '
 
-cat >expect <<-EOF &&
-:000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
-EOF
-git diff-tree -M -r master verify--import-marks >actual
 test_expect_success 'A: verify diff' '
+	cat >expect <<-EOF &&
+	:000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
+	EOF
+	git diff-tree -M -r master verify--import-marks >actual &&
 	compare_diff_raw expect actual &&
 	test `git rev-parse --verify master:file2` \
 	    = `git rev-parse --verify verify--import-marks:copy-of-file2`
 '
 
-test_tick
-mt=$(git hash-object --stdin < /dev/null)
-: >input.blob
-: >marks.exp
-: >tree.exp
-
-cat >input.commit <<-EOF &&
-commit refs/heads/verify--dump-marks
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-test the sparse array dumping routines with exponentially growing marks
-COMMIT
-EOF
-
-i=0
-l=4
-m=6
-n=7
-while test "$i" -lt 27; do
-    cat >>input.blob <<-EOF &&
-blob
-mark :$l
-data 0
-blob
-mark :$m
-data 0
-blob
-mark :$n
-data 0
-EOF
-    echo "M 100644 :$l l$i" >>input.commit
-    echo "M 100644 :$m m$i" >>input.commit
-    echo "M 100644 :$n n$i" >>input.commit
-
-    echo ":$l $mt" >>marks.exp
-    echo ":$m $mt" >>marks.exp
-    echo ":$n $mt" >>marks.exp
-
-    printf "100644 blob $mt\tl$i\n" >>tree.exp
-    printf "100644 blob $mt\tm$i\n" >>tree.exp
-    printf "100644 blob $mt\tn$i\n" >>tree.exp
-
-    l=$(($l + $l))
-    m=$(($m + $m))
-    n=$(($l + $n))
-
-    i=$((1 + $i))
-done
-
-sort tree.exp > tree.exp_s
-
 test_expect_success 'A: export marks with large values' '
+	test_tick &&
+	mt=$(git hash-object --stdin < /dev/null) &&
+	>input.blob &&
+	>marks.exp &&
+	>tree.exp &&
+
+	cat >input.commit <<-EOF &&
+	commit refs/heads/verify--dump-marks
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	test the sparse array dumping routines with exponentially growing marks
+	COMMIT
+	EOF
+
+	i=0 l=4 m=6 n=7 &&
+	while test "$i" -lt 27
+	do
+		cat >>input.blob <<-EOF &&
+		blob
+		mark :$l
+		data 0
+		blob
+		mark :$m
+		data 0
+		blob
+		mark :$n
+		data 0
+		EOF
+		echo "M 100644 :$l l$i" >>input.commit &&
+		echo "M 100644 :$m m$i" >>input.commit &&
+		echo "M 100644 :$n n$i" >>input.commit &&
+
+		echo ":$l $mt" >>marks.exp &&
+		echo ":$m $mt" >>marks.exp &&
+		echo ":$n $mt" >>marks.exp &&
+
+		printf "100644 blob $mt\tl$i\n" >>tree.exp &&
+		printf "100644 blob $mt\tm$i\n" >>tree.exp &&
+		printf "100644 blob $mt\tn$i\n" >>tree.exp &&
+
+		l=$(($l + $l)) &&
+		m=$(($m + $m)) &&
+		n=$(($l + $n)) &&
+
+		i=$((1 + $i)) || return 1
+	done &&
+
+	sort tree.exp > tree.exp_s &&
+
 	cat input.blob input.commit | git fast-import --export-marks=marks.large &&
 	git ls-tree refs/heads/verify--dump-marks >tree.out &&
 	test_cmp tree.exp_s tree.out &&
@@ -330,35 +328,37 @@ test_expect_success 'A: export marks with large values' '
 ### series B
 ###
 
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/branch
-mark :1
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
+test_expect_success 'B: fail on invalid blob sha1' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	mark :1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	corrupt
+	COMMIT
+
+	from refs/heads/master
+	M 755 0000000000000000000000000000000000000001 zero1
 
-from refs/heads/master
-M 755 0000000000000000000000000000000000000001 zero1
+	INPUT_END
 
-INPUT_END
-test_expect_success 'B: fail on invalid blob sha1' '
 	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&
 	test_must_fail git fast-import <input
 '
 
-cat >input <<-INPUT_END &&
-commit TEMP_TAG
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-tag base
-COMMIT
+test_expect_success 'B: accept branch name "TEMP_TAG"' '
+	cat >input <<-INPUT_END &&
+	commit TEMP_TAG
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	tag base
+	COMMIT
+
+	from refs/heads/master
 
-from refs/heads/master
+	INPUT_END
 
-INPUT_END
-test_expect_success 'B: accept branch name "TEMP_TAG"' '
 	test_when_finished "rm -f .git/TEMP_TAG
 		git gc
 		git prune" &&
@@ -367,14 +367,15 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 	test `git rev-parse master` = `git rev-parse TEMP_TAG^`
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/empty-committer-1
-committer  <> $GIT_COMMITTER_DATE
-data <<COMMIT
-empty commit
-COMMIT
-INPUT_END
 test_expect_success 'B: accept empty committer' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/empty-committer-1
+	committer  <> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	empty commit
+	COMMIT
+	INPUT_END
+
 	test_when_finished "git update-ref -d refs/heads/empty-committer-1
 		git gc
 		git prune" &&
@@ -384,14 +385,15 @@ test_expect_success 'B: accept empty committer' '
 	test -z "$out"
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/empty-committer-2
-committer <a@b.com> $GIT_COMMITTER_DATE
-data <<COMMIT
-empty commit
-COMMIT
-INPUT_END
 test_expect_success 'B: accept and fixup committer with no name' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/empty-committer-2
+	committer <a@b.com> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	empty commit
+	COMMIT
+	INPUT_END
+
 	test_when_finished "git update-ref -d refs/heads/empty-committer-2
 		git gc
 		git prune" &&
@@ -401,62 +403,67 @@ test_expect_success 'B: accept and fixup committer with no name' '
 	test -z "$out"
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/invalid-committer
-committer Name email> $GIT_COMMITTER_DATE
-data <<COMMIT
-empty commit
-COMMIT
-INPUT_END
 test_expect_success 'B: fail on invalid committer (1)' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/invalid-committer
+	committer Name email> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	empty commit
+	COMMIT
+	INPUT_END
+
 	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/invalid-committer
-committer Name <e<mail> $GIT_COMMITTER_DATE
-data <<COMMIT
-empty commit
-COMMIT
-INPUT_END
 test_expect_success 'B: fail on invalid committer (2)' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/invalid-committer
+	committer Name <e<mail> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	empty commit
+	COMMIT
+	INPUT_END
+
 	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/invalid-committer
-committer Name <email>> $GIT_COMMITTER_DATE
-data <<COMMIT
-empty commit
-COMMIT
-INPUT_END
 test_expect_success 'B: fail on invalid committer (3)' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/invalid-committer
+	committer Name <email>> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	empty commit
+	COMMIT
+	INPUT_END
+
 	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/invalid-committer
-committer Name <email $GIT_COMMITTER_DATE
-data <<COMMIT
-empty commit
-COMMIT
-INPUT_END
 test_expect_success 'B: fail on invalid committer (4)' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/invalid-committer
+	committer Name <email $GIT_COMMITTER_DATE
+	data <<COMMIT
+	empty commit
+	COMMIT
+	INPUT_END
+
 	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/invalid-committer
-committer Name<email> $GIT_COMMITTER_DATE
-data <<COMMIT
-empty commit
-COMMIT
-INPUT_END
 test_expect_success 'B: fail on invalid committer (5)' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/invalid-committer
+	committer Name<email> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	empty commit
+	COMMIT
+	INPUT_END
+
 	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
 	test_must_fail git fast-import <input
 '
@@ -465,23 +472,24 @@ test_expect_success 'B: fail on invalid committer (5)' '
 ### series C
 ###
 
-newf=`echo hi newf | git hash-object -w --stdin`
-oldf=`git rev-parse --verify master:file2`
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/branch
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-second
-COMMIT
-
-from refs/heads/master
-M 644 $oldf file2/oldf
-M 755 $newf file2/newf
-D file3
-
-INPUT_END
 test_expect_success 'C: incremental import create pack from stdin' '
+	newf=`echo hi newf | git hash-object -w --stdin` &&
+	oldf=`git rev-parse --verify master:file2` &&
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	second
+	COMMIT
+
+	from refs/heads/master
+	M 644 $oldf file2/oldf
+	M 755 $newf file2/newf
+	D file3
+
+	INPUT_END
+
 	git fast-import <input &&
 	git whatchanged branch
 '
@@ -495,25 +503,26 @@ test_expect_success 'C: validate reuse existing blob' '
 	test $oldf = `git rev-parse --verify branch:file2/oldf`
 '
 
-cat >expect <<-EOF &&
-parent `git rev-parse --verify master^0`
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-second
-EOF
 test_expect_success 'C: verify commit' '
+	cat >expect <<-EOF &&
+	parent `git rev-parse --verify master^0`
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	second
+	EOF
+
 	git cat-file commit branch | sed 1d >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-:000000 100755 0000000000000000000000000000000000000000 f1fb5da718392694d0076d677d6d0e364c79b0bc A	file2/newf
-:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2	file2/oldf
-:100644 000000 0d92e9f3374ae2947c23aa477cbc68ce598135f1 0000000000000000000000000000000000000000 D	file3
-EOF
-git diff-tree -M -r master branch >actual
 test_expect_success 'C: validate rename result' '
+	cat >expect <<-EOF &&
+	:000000 100755 0000000000000000000000000000000000000000 f1fb5da718392694d0076d677d6d0e364c79b0bc A	file2/newf
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2	file2/oldf
+	:100644 000000 0d92e9f3374ae2947c23aa477cbc68ce598135f1 0000000000000000000000000000000000000000 D	file3
+	EOF
+	git diff-tree -M -r master branch >actual &&
 	compare_diff_raw expect actual
 '
 
@@ -521,27 +530,28 @@ test_expect_success 'C: validate rename result' '
 ### series D
 ###
 
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/branch
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-third
-COMMIT
-
-from refs/heads/branch^0
-M 644 inline newdir/interesting
-data <<EOF
-$file5_data
-EOF
-
-M 755 inline newdir/exec.sh
-data <<EOF
-$file6_data
-EOF
-
-INPUT_END
 test_expect_success 'D: inline data in commit' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	third
+	COMMIT
+
+	from refs/heads/branch^0
+	M 644 inline newdir/interesting
+	data <<EOF
+	$file5_data
+	EOF
+
+	M 755 inline newdir/exec.sh
+	data <<EOF
+	$file6_data
+	EOF
+
+	INPUT_END
+
 	git fast-import <input &&
 	git whatchanged branch
 '
@@ -550,23 +560,23 @@ test_expect_success 'D: verify pack' '
 	verify_packs
 '
 
-cat >expect <<-EOF &&
-:000000 100755 0000000000000000000000000000000000000000 e74b7d465e52746be2b4bae983670711e6e66657 A	newdir/exec.sh
-:000000 100644 0000000000000000000000000000000000000000 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 A	newdir/interesting
-EOF
-git diff-tree -M -r branch^ branch >actual
 test_expect_success 'D: validate new files added' '
+	cat >expect <<-EOF &&
+	:000000 100755 0000000000000000000000000000000000000000 e74b7d465e52746be2b4bae983670711e6e66657 A	newdir/exec.sh
+	:000000 100644 0000000000000000000000000000000000000000 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 A	newdir/interesting
+	EOF
+	git diff-tree -M -r branch^ branch >actual &&
 	compare_diff_raw expect actual
 '
 
-echo "$file5_data" >expect
 test_expect_success 'D: verify file5' '
+	echo "$file5_data" >expect &&
 	git cat-file blob branch:newdir/interesting >actual &&
 	test_cmp expect actual
 '
 
-echo "$file6_data" >expect
 test_expect_success 'D: verify file6' '
+	echo "$file6_data" >expect &&
 	git cat-file blob branch:newdir/exec.sh >actual &&
 	test_cmp expect actual
 '
@@ -575,18 +585,19 @@ test_expect_success 'D: verify file6' '
 ### series E
 ###
 
-cat >input <<-INPUT_END &&
-commit refs/heads/branch
-author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Tue Feb 6 11:22:18 2007 -0500
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:02 2007 -0500
-data <<COMMIT
-RFC 2822 type date
-COMMIT
+test_expect_success 'E: rfc2822 date, --date-format=raw' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Tue Feb 6 11:22:18 2007 -0500
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:02 2007 -0500
+	data <<COMMIT
+	RFC 2822 type date
+	COMMIT
+
+	from refs/heads/branch^0
 
-from refs/heads/branch^0
+	INPUT_END
 
-INPUT_END
-test_expect_success 'E: rfc2822 date, --date-format=raw' '
 	test_must_fail git fast-import --date-format=raw <input
 '
 test_expect_success 'E: rfc2822 date, --date-format=rfc2822' '
@@ -597,13 +608,13 @@ test_expect_success 'E: verify pack' '
 	verify_packs
 '
 
-cat >expect <<-EOF &&
-author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1170783302 -0500
-
-RFC 2822 type date
-EOF
 test_expect_success 'E: verify commit' '
+	cat >expect <<-EOF &&
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1170783302 -0500
+
+	RFC 2822 type date
+	EOF
 	git cat-file commit branch | sed 1,2d >actual &&
 	test_cmp expect actual
 '
@@ -612,22 +623,23 @@ test_expect_success 'E: verify commit' '
 ### series F
 ###
 
-old_branch=`git rev-parse --verify branch^0`
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/branch
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-losing things already?
-COMMIT
+test_expect_success 'F: non-fast-forward update skips' '
+	old_branch=`git rev-parse --verify branch^0` &&
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	losing things already?
+	COMMIT
 
-from refs/heads/branch~1
+	from refs/heads/branch~1
 
-reset refs/heads/other
-from refs/heads/branch
+	reset refs/heads/other
+	from refs/heads/branch
+
+	INPUT_END
 
-INPUT_END
-test_expect_success 'F: non-fast-forward update skips' '
 	test_must_fail git fast-import <input &&
 	# branch must remain unaffected
 	test $old_branch = `git rev-parse --verify branch^0`
@@ -637,15 +649,15 @@ test_expect_success 'F: verify pack' '
 	verify_packs
 '
 
-cat >expect <<-EOF &&
-tree `git rev-parse branch~1^{tree}`
-parent `git rev-parse branch~1`
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-losing things already?
-EOF
 test_expect_success 'F: verify other commit' '
+	cat >expect <<-EOF &&
+	tree `git rev-parse branch~1^{tree}`
+	parent `git rev-parse branch~1`
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	losing things already?
+	EOF
 	git cat-file commit other >actual &&
 	test_cmp expect actual
 '
@@ -654,19 +666,19 @@ test_expect_success 'F: verify other commit' '
 ### series G
 ###
 
-old_branch=`git rev-parse --verify branch^0`
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/branch
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-losing things already?
-COMMIT
+test_expect_success 'G: non-fast-forward update forced' '
+	old_branch=`git rev-parse --verify branch^0` &&
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	losing things already?
+	COMMIT
 
-from refs/heads/branch~1
+	from refs/heads/branch~1
 
-INPUT_END
-test_expect_success 'G: non-fast-forward update forced' '
+	INPUT_END
 	git fast-import --force <input
 '
 
@@ -683,28 +695,28 @@ test_expect_success 'G: branch changed, but logged' '
 ### series H
 ###
 
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/H
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-third
-COMMIT
-
-from refs/heads/branch^0
-M 644 inline i-will-die
-data <<EOF
-this file will never exist.
-EOF
-
-deleteall
-M 644 inline h/e/l/lo
-data <<EOF
-$file5_data
-EOF
-
-INPUT_END
 test_expect_success 'H: deletall, add 1' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/H
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	third
+	COMMIT
+
+	from refs/heads/branch^0
+	M 644 inline i-will-die
+	data <<EOF
+	this file will never exist.
+	EOF
+
+	deleteall
+	M 644 inline h/e/l/lo
+	data <<EOF
+	$file5_data
+	EOF
+
+	INPUT_END
 	git fast-import <input &&
 	git whatchanged H
 '
@@ -713,20 +725,20 @@ test_expect_success 'H: verify pack' '
 	verify_packs
 '
 
-cat >expect <<-EOF &&
-:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file2/newf
-:100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file2/oldf
-:100755 000000 85df50785d62d3b05ab03d9cbf7e4a0b49449730 0000000000000000000000000000000000000000 D	file4
-:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	h/e/l/lo
-:100755 000000 e74b7d465e52746be2b4bae983670711e6e66657 0000000000000000000000000000000000000000 D	newdir/exec.sh
-EOF
-git diff-tree -M -r H^ H >actual
 test_expect_success 'H: validate old files removed, new files added' '
+	cat >expect <<-EOF &&
+	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file2/newf
+	:100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file2/oldf
+	:100755 000000 85df50785d62d3b05ab03d9cbf7e4a0b49449730 0000000000000000000000000000000000000000 D	file4
+	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	h/e/l/lo
+	:100755 000000 e74b7d465e52746be2b4bae983670711e6e66657 0000000000000000000000000000000000000000 D	newdir/exec.sh
+	EOF
+	git diff-tree -M -r H^ H >actual &&
 	compare_diff_raw expect actual
 '
 
-echo "$file5_data" >expect
 test_expect_success 'H: verify file' '
+	echo "$file5_data" >expect &&
 	git cat-file blob H:h/e/l/lo >actual &&
 	test_cmp expect actual
 '
@@ -735,24 +747,24 @@ test_expect_success 'H: verify file' '
 ### series I
 ###
 
-cat >input <<-INPUT_END &&
-commit refs/heads/export-boundary
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-we have a border.  its only 40 characters wide.
-COMMIT
+test_expect_success 'I: export-pack-edges' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/export-boundary
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	we have a border.  its only 40 characters wide.
+	COMMIT
 
-from refs/heads/branch
+	from refs/heads/branch
 
-INPUT_END
-test_expect_success 'I: export-pack-edges' '
+	INPUT_END
 	git fast-import --export-pack-edges=edges.list <input
 '
 
-cat >expect <<-EOF &&
-.git/objects/pack/pack-.pack: `git rev-parse --verify export-boundary`
-EOF
 test_expect_success 'I: verify edge list' '
+	cat >expect <<-EOF &&
+	.git/objects/pack/pack-.pack: `git rev-parse --verify export-boundary`
+	EOF
 	sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
 	test_cmp expect actual
 '
@@ -761,25 +773,25 @@ test_expect_success 'I: verify edge list' '
 ### series J
 ###
 
-cat >input <<-INPUT_END &&
-commit refs/heads/J
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-create J
-COMMIT
+test_expect_success 'J: reset existing branch creates empty commit' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/J
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	create J
+	COMMIT
 
-from refs/heads/branch
+	from refs/heads/branch
 
-reset refs/heads/J
+	reset refs/heads/J
 
-commit refs/heads/J
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-initialize J
-COMMIT
+	commit refs/heads/J
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	initialize J
+	COMMIT
 
-INPUT_END
-test_expect_success 'J: reset existing branch creates empty commit' '
+	INPUT_END
 	git fast-import <input
 '
 test_expect_success 'J: branch has 1 commit, empty tree' '
@@ -787,41 +799,42 @@ test_expect_success 'J: branch has 1 commit, empty tree' '
 	test 0 = `git ls-tree J | wc -l`
 '
 
-cat >input <<-INPUT_END &&
-reset refs/heads/J2
-
-tag wrong_tag
-from refs/heads/J2
-data <<EOF
-Tag branch that was reset.
-EOF
-INPUT_END
 test_expect_success 'J: tag must fail on empty branch' '
+	cat >input <<-INPUT_END &&
+	reset refs/heads/J2
+
+	tag wrong_tag
+	from refs/heads/J2
+	data <<EOF
+	Tag branch that was reset.
+	EOF
+	INPUT_END
 	test_must_fail git fast-import <input
 '
+
 ###
 ### series K
 ###
 
-cat >input <<-INPUT_END &&
-commit refs/heads/K
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-create K
-COMMIT
+test_expect_success 'K: reinit branch with from' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/K
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	create K
+	COMMIT
 
-from refs/heads/branch
+	from refs/heads/branch
 
-commit refs/heads/K
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-redo K
-COMMIT
+	commit refs/heads/K
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	redo K
+	COMMIT
 
-from refs/heads/branch^1
+	from refs/heads/branch^1
 
-INPUT_END
-test_expect_success 'K: reinit branch with from' '
+	INPUT_END
 	git fast-import <input
 '
 test_expect_success 'K: verify K^1 = branch^1' '
@@ -833,84 +846,84 @@ test_expect_success 'K: verify K^1 = branch^1' '
 ### series L
 ###
 
-cat >input <<-INPUT_END &&
-blob
-mark :1
-data <<EOF
-some data
-EOF
-
-blob
-mark :2
-data <<EOF
-other data
-EOF
-
-commit refs/heads/L
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-create L
-COMMIT
-
-M 644 :1 b.
-M 644 :1 b/other
-M 644 :1 ba
-
-commit refs/heads/L
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-update L
-COMMIT
-
-M 644 :2 b.
-M 644 :2 b/other
-M 644 :2 ba
-INPUT_END
-
-cat >expect <<-EXPECT_END &&
-:100644 100644 4268632... 55d3a52... M	b.
-:040000 040000 0ae5cac... 443c768... M	b
-:100644 100644 4268632... 55d3a52... M	ba
-EXPECT_END
+test_expect_success 'L: verify internal tree sorting' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	some data
+	EOF
+
+	blob
+	mark :2
+	data <<EOF
+	other data
+	EOF
+
+	commit refs/heads/L
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	create L
+	COMMIT
+
+	M 644 :1 b.
+	M 644 :1 b/other
+	M 644 :1 ba
+
+	commit refs/heads/L
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	update L
+	COMMIT
+
+	M 644 :2 b.
+	M 644 :2 b/other
+	M 644 :2 ba
+	INPUT_END
+
+	cat >expect <<-EXPECT_END &&
+	:100644 100644 4268632... 55d3a52... M	b.
+	:040000 040000 0ae5cac... 443c768... M	b
+	:100644 100644 4268632... 55d3a52... M	ba
+	EXPECT_END
+
+	git fast-import <input &&
+	git diff-tree --abbrev --raw L^ L >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'L: nested tree copy does not corrupt deltas' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	the data
+	EOF
+
+	commit refs/heads/L2
+	committer C O Mitter <committer@example.com> 1112912473 -0700
+	data <<COMMIT
+	init L2
+	COMMIT
+	M 644 :1 a/b/c
+	M 644 :1 a/b/d
+	M 644 :1 a/e/f
 
-test_expect_success 'L: verify internal tree sorting' '
-	git fast-import <input &&
-	git diff-tree --abbrev --raw L^ L >output &&
-	test_cmp expect output
-'
+	commit refs/heads/L2
+	committer C O Mitter <committer@example.com> 1112912473 -0700
+	data <<COMMIT
+	update L2
+	COMMIT
+	C a g
+	C a/e g/b
+	M 644 :1 g/b/h
+	INPUT_END
 
-cat >input <<-INPUT_END &&
-blob
-mark :1
-data <<EOF
-the data
-EOF
-
-commit refs/heads/L2
-committer C O Mitter <committer@example.com> 1112912473 -0700
-data <<COMMIT
-init L2
-COMMIT
-M 644 :1 a/b/c
-M 644 :1 a/b/d
-M 644 :1 a/e/f
-
-commit refs/heads/L2
-committer C O Mitter <committer@example.com> 1112912473 -0700
-data <<COMMIT
-update L2
-COMMIT
-C a g
-C a/e g/b
-M 644 :1 g/b/h
-INPUT_END
-
-cat <<-EOF >expect &&
-g/b/f
-g/b/h
-EOF
+	cat >expect <<-\EOF &&
+	g/b/f
+	g/b/h
+	EOF
 
-test_expect_success 'L: nested tree copy does not corrupt deltas' '
 	test_when_finished "git update-ref -d refs/heads/L2" &&
 	git fast-import <input &&
 	git ls-tree L2 g/b/ >tmp &&
@@ -923,90 +936,90 @@ test_expect_success 'L: nested tree copy does not corrupt deltas' '
 ### series M
 ###
 
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/M1
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-file rename
-COMMIT
+test_expect_success 'M: rename file in same subdirectory' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/M1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	file rename
+	COMMIT
 
-from refs/heads/branch^0
-R file2/newf file2/n.e.w.f
+	from refs/heads/branch^0
+	R file2/newf file2/n.e.w.f
 
-INPUT_END
+	INPUT_END
 
-cat >expect <<-EOF &&
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	file2/n.e.w.f
-EOF
-test_expect_success 'M: rename file in same subdirectory' '
+	cat >expect <<-EOF &&
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	file2/n.e.w.f
+	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M1^ M1 >actual &&
 	compare_diff_raw expect actual
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/M2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-file rename
-COMMIT
+test_expect_success 'M: rename file to new subdirectory' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/M2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	file rename
+	COMMIT
 
-from refs/heads/branch^0
-R file2/newf i/am/new/to/you
+	from refs/heads/branch^0
+	R file2/newf i/am/new/to/you
 
-INPUT_END
+	INPUT_END
 
-cat >expect <<-EOF &&
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	i/am/new/to/you
-EOF
-test_expect_success 'M: rename file to new subdirectory' '
+	cat >expect <<-EOF &&
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	i/am/new/to/you
+	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M2^ M2 >actual &&
 	compare_diff_raw expect actual
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/M3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-file rename
-COMMIT
+test_expect_success 'M: rename subdirectory to new subdirectory' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/M3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	file rename
+	COMMIT
 
-from refs/heads/M2^0
-R i other/sub
+	from refs/heads/M2^0
+	R i other/sub
 
-INPUT_END
+	INPUT_END
 
-cat >expect <<-EOF &&
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	other/sub/am/new/to/you
-EOF
-test_expect_success 'M: rename subdirectory to new subdirectory' '
+	cat >expect <<-EOF &&
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	other/sub/am/new/to/you
+	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M3^ M3 >actual &&
 	compare_diff_raw expect actual
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/M4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-rename root
-COMMIT
+test_expect_success 'M: rename root to subdirectory' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/M4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	rename root
+	COMMIT
 
-from refs/heads/M2^0
-R "" sub
+	from refs/heads/M2^0
+	R "" sub
 
-INPUT_END
+	INPUT_END
 
-cat >expect <<-EOF &&
-:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2/oldf	sub/file2/oldf
-:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 R100	file4	sub/file4
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	sub/i/am/new/to/you
-:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 R100	newdir/exec.sh	sub/newdir/exec.sh
-:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	sub/newdir/interesting
-EOF
-test_expect_success 'M: rename root to subdirectory' '
+	cat >expect <<-EOF &&
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2/oldf	sub/file2/oldf
+	:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 R100	file4	sub/file4
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	sub/i/am/new/to/you
+	:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 R100	newdir/exec.sh	sub/newdir/exec.sh
+	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	sub/newdir/interesting
+	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M4^ M4 >actual &&
 	cat actual &&
@@ -1017,81 +1030,81 @@ test_expect_success 'M: rename root to subdirectory' '
 ### series N
 ###
 
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/N1
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-file copy
-COMMIT
+test_expect_success 'N: copy file in same subdirectory' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/N1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	file copy
+	COMMIT
 
-from refs/heads/branch^0
-C file2/newf file2/n.e.w.f
+	from refs/heads/branch^0
+	C file2/newf file2/n.e.w.f
 
-INPUT_END
+	INPUT_END
 
-cat >expect <<-EOF &&
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file2/n.e.w.f
-EOF
-test_expect_success 'N: copy file in same subdirectory' '
+	cat >expect <<-EOF &&
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file2/n.e.w.f
+	EOF
 	git fast-import <input &&
 	git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
 	compare_diff_raw expect actual
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/N2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-clean directory copy
-COMMIT
+test_expect_success 'N: copy then modify subdirectory' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/N2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	clean directory copy
+	COMMIT
 
-from refs/heads/branch^0
-C file2 file3
+	from refs/heads/branch^0
+	C file2 file3
 
-commit refs/heads/N2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-modify directory copy
-COMMIT
+	commit refs/heads/N2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	modify directory copy
+	COMMIT
 
-M 644 inline file3/file5
-data <<EOF
-$file5_data
-EOF
+	M 644 inline file3/file5
+	data <<EOF
+	$file5_data
+	EOF
 
-INPUT_END
+	INPUT_END
 
-cat >expect <<-EOF &&
-:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
-EOF
-test_expect_success 'N: copy then modify subdirectory' '
+	cat >expect <<-EOF &&
+	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	EOF
 	git fast-import <input &&
 	git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
 	compare_diff_raw expect actual
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/N3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-dirty directory copy
-COMMIT
+test_expect_success 'N: copy dirty subdirectory' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/N3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	dirty directory copy
+	COMMIT
 
-from refs/heads/branch^0
-M 644 inline file2/file5
-data <<EOF
-$file5_data
-EOF
+	from refs/heads/branch^0
+	M 644 inline file2/file5
+	data <<EOF
+	$file5_data
+	EOF
 
-C file2 file3
-D file2/file5
+	C file2 file3
+	D file2/file5
 
-INPUT_END
+	INPUT_END
 
-test_expect_success 'N: copy dirty subdirectory' '
 	git fast-import <input &&
 	test `git rev-parse N2^{tree}` = `git rev-parse N3^{tree}`
 '
@@ -1457,59 +1470,59 @@ test_expect_success 'N: modify subtree, extract it, and modify again' '
 ### series O
 ###
 
-cat >input <<-INPUT_END &&
-#we will
-commit refs/heads/O1
-# -- ignore all of this text
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-# $GIT_COMMITTER_NAME has inserted here for his benefit.
-data <<COMMIT
-dirty directory copy
-COMMIT
-
-# don't forget the import blank line!
-#
-# yes, we started from our usual base of branch^0.
-# i like branch^0.
-from refs/heads/branch^0
-# and we need to reuse file2/file5 from N3 above.
-M 644 inline file2/file5
-# otherwise the tree will be different
-data <<EOF
-$file5_data
-EOF
-
-# don't forget to copy file2 to file3
-C file2 file3
-#
-# or to delete file5 from file2.
-D file2/file5
-# are we done yet?
+test_expect_success 'O: comments are all skipped' '
+	cat >input <<-INPUT_END &&
+	#we will
+	commit refs/heads/O1
+	# -- ignore all of this text
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	# $GIT_COMMITTER_NAME has inserted here for his benefit.
+	data <<COMMIT
+	dirty directory copy
+	COMMIT
+
+	# do not forget the import blank line!
+	#
+	# yes, we started from our usual base of branch^0.
+	# i like branch^0.
+	from refs/heads/branch^0
+	# and we need to reuse file2/file5 from N3 above.
+	M 644 inline file2/file5
+	# otherwise the tree will be different
+	data <<EOF
+	$file5_data
+	EOF
 
-INPUT_END
+	# do not forget to copy file2 to file3
+	C file2 file3
+	#
+	# or to delete file5 from file2.
+	D file2/file5
+	# are we done yet?
+
+	INPUT_END
 
-test_expect_success 'O: comments are all skipped' '
 	git fast-import <input &&
 	test `git rev-parse N3` = `git rev-parse O1`
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/O2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-dirty directory copy
-COMMIT
-from refs/heads/branch^0
-M 644 inline file2/file5
-data <<EOF
-$file5_data
-EOF
-C file2 file3
-D file2/file5
+test_expect_success 'O: blank lines not necessary after data commands' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/O2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	dirty directory copy
+	COMMIT
+	from refs/heads/branch^0
+	M 644 inline file2/file5
+	data <<EOF
+	$file5_data
+	EOF
+	C file2 file3
+	D file2/file5
 
-INPUT_END
+	INPUT_END
 
-test_expect_success 'O: blank lines not necessary after data commands' '
 	git fast-import <input &&
 	test `git rev-parse N3` = `git rev-parse O2`
 '
@@ -1518,43 +1531,44 @@ test_expect_success 'O: repack before next test' '
 	git repack -a -d
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/O3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zstring
-COMMIT
-commit refs/heads/O3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zof
-COMMIT
-checkpoint
-commit refs/heads/O3
-mark :5
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zempty
-COMMIT
-checkpoint
-commit refs/heads/O3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zcommits
-COMMIT
-reset refs/tags/O3-2nd
-from :5
-reset refs/tags/O3-3rd
-from :5
-INPUT_END
-
-cat >expect <<-INPUT_END &&
-string
-of
-empty
-commits
-INPUT_END
 test_expect_success 'O: blank lines not necessary after other commands' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/O3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zstring
+	COMMIT
+	commit refs/heads/O3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zof
+	COMMIT
+	checkpoint
+	commit refs/heads/O3
+	mark :5
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zempty
+	COMMIT
+	checkpoint
+	commit refs/heads/O3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zcommits
+	COMMIT
+	reset refs/tags/O3-2nd
+	from :5
+	reset refs/tags/O3-3rd
+	from :5
+	INPUT_END
+
+	cat >expect <<-INPUT_END &&
+	string
+	of
+	empty
+	commits
+	INPUT_END
+
 	git fast-import <input &&
 	test 8 = `find .git/objects/pack -type f | wc -l` &&
 	test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
@@ -1562,319 +1576,319 @@ test_expect_success 'O: blank lines not necessary after other commands' '
 	test_cmp expect actual
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/O4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zstring
-COMMIT
-commit refs/heads/O4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zof
-COMMIT
-progress Two commits down, 2 to go!
-commit refs/heads/O4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zempty
-COMMIT
-progress Three commits down, 1 to go!
-commit refs/heads/O4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zcommits
-COMMIT
-progress I'm done!
-INPUT_END
 test_expect_success 'O: progress outputs as requested by input' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/O4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zstring
+	COMMIT
+	commit refs/heads/O4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zof
+	COMMIT
+	progress Two commits down, 2 to go!
+	commit refs/heads/O4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zempty
+	COMMIT
+	progress Three commits down, 1 to go!
+	commit refs/heads/O4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zcommits
+	COMMIT
+	progress done!
+	INPUT_END
 	git fast-import <input >actual &&
 	grep "progress " <input >expect &&
 	test_cmp expect actual
 '
 
-###
-### series P (gitlinks)
-###
+###
+### series P (gitlinks)
+###
+
+test_expect_success 'P: superproject & submodule mix' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data 10
+	test file
+
+	reset refs/heads/sub
+	commit refs/heads/sub
+	mark :2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 12
+	sub_initial
+	M 100644 :1 file
+
+	blob
+	mark :3
+	data <<DATAEND
+	[submodule "sub"]
+		path = sub
+		url = "`pwd`/sub"
+	DATAEND
+
+	commit refs/heads/subuse1
+	mark :4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 8
+	initial
+	from refs/heads/master
+	M 100644 :3 .gitmodules
+	M 160000 :2 sub
+
+	blob
+	mark :5
+	data 20
+	test file
+	more data
+
+	commit refs/heads/sub
+	mark :6
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 11
+	sub_second
+	from :2
+	M 100644 :5 file
+
+	commit refs/heads/subuse1
+	mark :7
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	second
+	from :4
+	M 160000 :6 sub
+
+	INPUT_END
+
+	git fast-import <input &&
+	git checkout subuse1 &&
+	rm -rf sub &&
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
+		git checkout master
+	) &&
+	git submodule init &&
+	git submodule update
+'
+
+test_expect_success 'P: verbatim SHA gitlinks' '
+	SUBLAST=$(git rev-parse --verify sub) &&
+	SUBPREV=$(git rev-parse --verify sub^) &&
+
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<DATAEND
+	[submodule "sub"]
+		path = sub
+		url = "`pwd`/sub"
+	DATAEND
+
+	commit refs/heads/subuse2
+	mark :2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 8
+	initial
+	from refs/heads/master
+	M 100644 :1 .gitmodules
+	M 160000 $SUBPREV sub
+
+	commit refs/heads/subuse2
+	mark :3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	second
+	from :2
+	M 160000 $SUBLAST sub
+
+	INPUT_END
+
+	git branch -D sub &&
+	git gc &&
+	git prune &&
+	git fast-import <input &&
+	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
+'
+
+test_expect_success 'P: fail on inline gitlink' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/subuse3
+	mark :1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	corrupt
+	COMMIT
+
+	from refs/heads/subuse2
+	M 160000 inline sub
+	data <<DATA
+	$SUBPREV
+	DATA
+
+	INPUT_END
+
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'P: fail on blob mark in gitlink' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<DATA
+	$SUBPREV
+	DATA
+
+	commit refs/heads/subuse3
+	mark :2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	corrupt
+	COMMIT
+
+	from refs/heads/subuse2
+	M 160000 :1 sub
+
+	INPUT_END
+
+	test_must_fail git fast-import <input
+'
+
+###
+### series Q (notes)
+###
+
+test_expect_success 'Q: commit notes' '
+	note1_data="The first note for the first commit" &&
+	note2_data="The first note for the second commit" &&
+	note3_data="The first note for the third commit" &&
+	note1b_data="The second note for the first commit" &&
+	note1c_data="The third note for the first commit" &&
+	note2b_data="The second note for the second commit" &&
+
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	blob
+	mark :2
+	data <<EOF
+	$file2_data
+	EOF
+
+	commit refs/heads/notes-test
+	mark :3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	first (:3)
+	COMMIT
+
+	M 644 :2 file2
 
-cat >input <<-INPUT_END &&
-blob
-mark :1
-data 10
-test file
-
-reset refs/heads/sub
-commit refs/heads/sub
-mark :2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 12
-sub_initial
-M 100644 :1 file
-
-blob
-mark :3
-data <<DATAEND
-[submodule "sub"]
-	path = sub
-	url = "`pwd`/sub"
-DATAEND
-
-commit refs/heads/subuse1
-mark :4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 8
-initial
-from refs/heads/master
-M 100644 :3 .gitmodules
-M 160000 :2 sub
-
-blob
-mark :5
-data 20
-test file
-more data
-
-commit refs/heads/sub
-mark :6
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 11
-sub_second
-from :2
-M 100644 :5 file
-
-commit refs/heads/subuse1
-mark :7
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 7
-second
-from :4
-M 160000 :6 sub
-
-INPUT_END
+	blob
+	mark :4
+	data $file4_len
+	$file4_data
+	commit refs/heads/notes-test
+	mark :5
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	second (:5)
+	COMMIT
 
-test_expect_success 'P: superproject & submodule mix' '
-	git fast-import <input &&
-	git checkout subuse1 &&
-	rm -rf sub &&
-	mkdir sub &&
-	(
-		cd sub &&
-		git init &&
-		git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
-		git checkout master
-	) &&
-	git submodule init &&
-	git submodule update
-'
+	M 644 :4 file4
 
-SUBLAST=$(git rev-parse --verify sub)
-SUBPREV=$(git rev-parse --verify sub^)
-
-cat >input <<-INPUT_END &&
-blob
-mark :1
-data <<DATAEND
-[submodule "sub"]
-	path = sub
-	url = "`pwd`/sub"
-DATAEND
-
-commit refs/heads/subuse2
-mark :2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 8
-initial
-from refs/heads/master
-M 100644 :1 .gitmodules
-M 160000 $SUBPREV sub
-
-commit refs/heads/subuse2
-mark :3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 7
-second
-from :2
-M 160000 $SUBLAST sub
-
-INPUT_END
+	commit refs/heads/notes-test
+	mark :6
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	third (:6)
+	COMMIT
 
-test_expect_success 'P: verbatim SHA gitlinks' '
-	git branch -D sub &&
-	git gc &&
-	git prune &&
-	git fast-import <input &&
-	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
-'
+	M 644 inline file5
+	data <<EOF
+	$file5_data
+	EOF
 
-test_tick
-cat >input <<-INPUT_END &&
-commit refs/heads/subuse3
-mark :1
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
+	M 755 inline file6
+	data <<EOF
+	$file6_data
+	EOF
 
-from refs/heads/subuse2
-M 160000 inline sub
-data <<DATA
-$SUBPREV
-DATA
+	blob
+	mark :7
+	data <<EOF
+	$note1_data
+	EOF
 
-INPUT_END
+	blob
+	mark :8
+	data <<EOF
+	$note2_data
+	EOF
 
-test_expect_success 'P: fail on inline gitlink' '
-	test_must_fail git fast-import <input
-'
+	commit refs/notes/foobar
+	mark :9
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	notes (:9)
+	COMMIT
 
-test_tick
-cat >input <<-INPUT_END &&
-blob
-mark :1
-data <<DATA
-$SUBPREV
-DATA
+	N :7 :3
+	N :8 :5
+	N inline :6
+	data <<EOF
+	$note3_data
+	EOF
 
-commit refs/heads/subuse3
-mark :2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
+	commit refs/notes/foobar
+	mark :10
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	notes (:10)
+	COMMIT
 
-from refs/heads/subuse2
-M 160000 :1 sub
+	N inline :3
+	data <<EOF
+	$note1b_data
+	EOF
 
-INPUT_END
+	commit refs/notes/foobar2
+	mark :11
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	notes (:11)
+	COMMIT
 
-test_expect_success 'P: fail on blob mark in gitlink' '
-	test_must_fail git fast-import <input
-'
+	N inline :3
+	data <<EOF
+	$note1c_data
+	EOF
 
-###
-### series Q (notes)
-###
+	commit refs/notes/foobar
+	mark :12
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	notes (:12)
+	COMMIT
+
+	deleteall
+	N inline :5
+	data <<EOF
+	$note2b_data
+	EOF
 
-note1_data="The first note for the first commit"
-note2_data="The first note for the second commit"
-note3_data="The first note for the third commit"
-note1b_data="The second note for the first commit"
-note1c_data="The third note for the first commit"
-note2b_data="The second note for the second commit"
-
-test_tick
-cat >input <<-INPUT_END &&
-blob
-mark :2
-data <<EOF
-$file2_data
-EOF
-
-commit refs/heads/notes-test
-mark :3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-first (:3)
-COMMIT
-
-M 644 :2 file2
-
-blob
-mark :4
-data $file4_len
-$file4_data
-commit refs/heads/notes-test
-mark :5
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-second (:5)
-COMMIT
-
-M 644 :4 file4
-
-commit refs/heads/notes-test
-mark :6
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-third (:6)
-COMMIT
-
-M 644 inline file5
-data <<EOF
-$file5_data
-EOF
-
-M 755 inline file6
-data <<EOF
-$file6_data
-EOF
-
-blob
-mark :7
-data <<EOF
-$note1_data
-EOF
-
-blob
-mark :8
-data <<EOF
-$note2_data
-EOF
-
-commit refs/notes/foobar
-mark :9
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-notes (:9)
-COMMIT
-
-N :7 :3
-N :8 :5
-N inline :6
-data <<EOF
-$note3_data
-EOF
-
-commit refs/notes/foobar
-mark :10
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-notes (:10)
-COMMIT
-
-N inline :3
-data <<EOF
-$note1b_data
-EOF
-
-commit refs/notes/foobar2
-mark :11
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-notes (:11)
-COMMIT
-
-N inline :3
-data <<EOF
-$note1c_data
-EOF
-
-commit refs/notes/foobar
-mark :12
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-notes (:12)
-COMMIT
-
-deleteall
-N inline :5
-data <<EOF
-$note2b_data
-EOF
-
-INPUT_END
+	INPUT_END
 
-test_expect_success 'Q: commit notes' '
 	git fast-import <input &&
 	git whatchanged notes-test
 '
@@ -1883,246 +1897,246 @@ test_expect_success 'Q: verify pack' '
 	verify_packs
 '
 
-commit1=$(git rev-parse notes-test~2)
-commit2=$(git rev-parse notes-test^)
-commit3=$(git rev-parse notes-test)
+test_expect_success 'Q: verify first commit' '
+	commit1=$(git rev-parse notes-test~2) &&
+	commit2=$(git rev-parse notes-test^) &&
+	commit3=$(git rev-parse notes-test) &&
 
-cat >expect <<-EOF &&
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	cat >expect <<-EOF &&
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-first (:3)
-EOF
-test_expect_success 'Q: verify first commit' '
+	first (:3)
+	EOF
 	git cat-file commit notes-test~2 | sed 1d >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-parent $commit1
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-second (:5)
-EOF
 test_expect_success 'Q: verify second commit' '
+	cat >expect <<-EOF &&
+	parent $commit1
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	second (:5)
+	EOF
 	git cat-file commit notes-test^ | sed 1d >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-parent $commit2
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-third (:6)
-EOF
 test_expect_success 'Q: verify third commit' '
+	cat >expect <<-EOF &&
+	parent $commit2
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	third (:6)
+	EOF
 	git cat-file commit notes-test | sed 1d >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-notes (:9)
-EOF
 test_expect_success 'Q: verify first notes commit' '
+	cat >expect <<-EOF &&
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	notes (:9)
+	EOF
 	git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
 	test_cmp expect actual
 '
 
-cat >expect.unsorted <<-EOF &&
-100644 blob $commit1
-100644 blob $commit2
-100644 blob $commit3
-EOF
-cat expect.unsorted | sort >expect
 test_expect_success 'Q: verify first notes tree' '
+	cat >expect.unsorted <<-EOF &&
+	100644 blob $commit1
+	100644 blob $commit2
+	100644 blob $commit3
+	EOF
+	cat expect.unsorted | sort >expect &&
 	git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
 
-echo "$note1_data" >expect
 test_expect_success 'Q: verify first note for first commit' '
+	echo "$note1_data" >expect &&
 	git cat-file blob refs/notes/foobar~2:$commit1 >actual &&
 	test_cmp expect actual
 '
 
-echo "$note2_data" >expect
 test_expect_success 'Q: verify first note for second commit' '
+	echo "$note2_data" >expect &&
 	git cat-file blob refs/notes/foobar~2:$commit2 >actual &&
 	test_cmp expect actual
 '
 
-echo "$note3_data" >expect
 test_expect_success 'Q: verify first note for third commit' '
+	echo "$note3_data" >expect &&
 	git cat-file blob refs/notes/foobar~2:$commit3 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-parent `git rev-parse --verify refs/notes/foobar~2`
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-notes (:10)
-EOF
 test_expect_success 'Q: verify second notes commit' '
+	cat >expect <<-EOF &&
+	parent `git rev-parse --verify refs/notes/foobar~2`
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	notes (:10)
+	EOF
 	git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
 	test_cmp expect actual
 '
 
-cat >expect.unsorted <<-EOF &&
-100644 blob $commit1
-100644 blob $commit2
-100644 blob $commit3
-EOF
-cat expect.unsorted | sort >expect
 test_expect_success 'Q: verify second notes tree' '
+	cat >expect.unsorted <<-EOF &&
+	100644 blob $commit1
+	100644 blob $commit2
+	100644 blob $commit3
+	EOF
+	cat expect.unsorted | sort >expect &&
 	git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
 
-echo "$note1b_data" >expect
 test_expect_success 'Q: verify second note for first commit' '
+	echo "$note1b_data" >expect &&
 	git cat-file blob refs/notes/foobar^:$commit1 >actual &&
 	test_cmp expect actual
 '
 
-echo "$note2_data" >expect
 test_expect_success 'Q: verify first note for second commit' '
+	echo "$note2_data" >expect &&
 	git cat-file blob refs/notes/foobar^:$commit2 >actual &&
 	test_cmp expect actual
 '
 
-echo "$note3_data" >expect
 test_expect_success 'Q: verify first note for third commit' '
+	echo "$note3_data" >expect &&
 	git cat-file blob refs/notes/foobar^:$commit3 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-notes (:11)
-EOF
 test_expect_success 'Q: verify third notes commit' '
+	cat >expect <<-EOF &&
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	notes (:11)
+	EOF
 	git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
 	test_cmp expect actual
 '
 
-cat >expect.unsorted <<-EOF &&
-100644 blob $commit1
-EOF
-cat expect.unsorted | sort >expect
 test_expect_success 'Q: verify third notes tree' '
+	cat >expect.unsorted <<-EOF &&
+	100644 blob $commit1
+	EOF
+	cat expect.unsorted | sort >expect &&
 	git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
 
-echo "$note1c_data" >expect
 test_expect_success 'Q: verify third note for first commit' '
+	echo "$note1c_data" >expect &&
 	git cat-file blob refs/notes/foobar2:$commit1 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<-EOF &&
-parent `git rev-parse --verify refs/notes/foobar^`
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-notes (:12)
-EOF
 test_expect_success 'Q: verify fourth notes commit' '
+	cat >expect <<-EOF &&
+	parent `git rev-parse --verify refs/notes/foobar^`
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	notes (:12)
+	EOF
 	git cat-file commit refs/notes/foobar | sed 1d >actual &&
 	test_cmp expect actual
 '
 
-cat >expect.unsorted <<-EOF &&
-100644 blob $commit2
-EOF
-cat expect.unsorted | sort >expect
 test_expect_success 'Q: verify fourth notes tree' '
+	cat >expect.unsorted <<-EOF &&
+	100644 blob $commit2
+	EOF
+	cat expect.unsorted | sort >expect &&
 	git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
 
-echo "$note2b_data" >expect
 test_expect_success 'Q: verify second note for second commit' '
+	echo "$note2b_data" >expect &&
 	git cat-file blob refs/notes/foobar:$commit2 >actual &&
 	test_cmp expect actual
 '
 
-cat >input <<-EOF &&
-reset refs/heads/Q0
+test_expect_success 'Q: deny note on empty branch' '
+	cat >input <<-EOF &&
+	reset refs/heads/Q0
 
-commit refs/heads/note-Q0
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-Note for an empty branch.
-COMMIT
+	commit refs/heads/note-Q0
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Note for an empty branch.
+	COMMIT
 
-N inline refs/heads/Q0
-data <<NOTE
-some note
-NOTE
-EOF
-test_expect_success 'Q: deny note on empty branch' '
+	N inline refs/heads/Q0
+	data <<NOTE
+	some note
+	NOTE
+	EOF
 	test_must_fail git fast-import <input
 '
 ###
 ### series R (feature and option)
 ###
 
-cat >input <<-EOF &&
-feature no-such-feature-exists
-EOF
-
 test_expect_success 'R: abort on unsupported feature' '
+	cat >input <<-EOF &&
+	feature no-such-feature-exists
+	EOF
+
 	test_must_fail git fast-import <input
 '
 
-cat >input <<-EOF &&
-feature date-format=now
-EOF
-
 test_expect_success 'R: supported feature is accepted' '
+	cat >input <<-EOF &&
+	feature date-format=now
+	EOF
+
 	git fast-import <input
 '
 
-cat >input <<-EOF &&
-blob
-data 3
-hi
-feature date-format=now
-EOF
-
 test_expect_success 'R: abort on receiving feature after data command' '
+	cat >input <<-EOF &&
+	blob
+	data 3
+	hi
+	feature date-format=now
+	EOF
+
 	test_must_fail git fast-import <input
 '
 
-cat >input <<-EOF &&
-feature import-marks=git.marks
-feature import-marks=git2.marks
-EOF
-
 test_expect_success 'R: only one import-marks feature allowed per stream' '
+	cat >input <<-EOF &&
+	feature import-marks=git.marks
+	feature import-marks=git2.marks
+	EOF
+
 	test_must_fail git fast-import <input
 '
 
-cat >input <<-EOF &&
-feature export-marks=git.marks
-blob
-mark :1
-data 3
-hi
+test_expect_success 'R: export-marks feature results in a marks file being created' '
+	cat >input <<-EOF &&
+	feature export-marks=git.marks
+	blob
+	mark :1
+	data 3
+	hi
 
-EOF
+	EOF
 
-test_expect_success 'R: export-marks feature results in a marks file being created' '
 	cat input | git fast-import &&
 	grep :1 git.marks
 '
@@ -2234,60 +2248,60 @@ test_expect_success 'R: feature import-marks-if-exists' '
 	test_cmp expect io.marks
 '
 
-cat >input <<-EOF &&
-feature import-marks=marks.out
-feature export-marks=marks.new
-EOF
-
 test_expect_success 'R: import to output marks works without any content' '
+	cat >input <<-EOF &&
+	feature import-marks=marks.out
+	feature export-marks=marks.new
+	EOF
+
 	cat input | git fast-import &&
 	test_cmp marks.out marks.new
 '
 
-cat >input <<-EOF &&
-feature import-marks=nonexistent.marks
-feature export-marks=marks.new
-EOF
-
 test_expect_success 'R: import marks prefers commandline marks file over the stream' '
+	cat >input <<-EOF &&
+	feature import-marks=nonexistent.marks
+	feature export-marks=marks.new
+	EOF
+
 	cat input | git fast-import --import-marks=marks.out &&
 	test_cmp marks.out marks.new
 '
 
 
-cat >input <<-EOF &&
-feature import-marks=nonexistent.marks
-feature export-marks=combined.marks
-EOF
-
 test_expect_success 'R: multiple --import-marks= should be honoured' '
+	cat >input <<-EOF &&
+	feature import-marks=nonexistent.marks
+	feature export-marks=combined.marks
+	EOF
+
 	head -n2 marks.out > one.marks &&
 	tail -n +3 marks.out > two.marks &&
 	git fast-import --import-marks=one.marks --import-marks=two.marks <input &&
 	test_cmp marks.out combined.marks
 '
 
-cat >input <<-EOF &&
-feature relative-marks
-feature import-marks=relative.in
-feature export-marks=relative.out
-EOF
-
 test_expect_success 'R: feature relative-marks should be honoured' '
+	cat >input <<-EOF &&
+	feature relative-marks
+	feature import-marks=relative.in
+	feature export-marks=relative.out
+	EOF
+
 	mkdir -p .git/info/fast-import/ &&
 	cp marks.new .git/info/fast-import/relative.in &&
 	git fast-import <input &&
 	test_cmp marks.new .git/info/fast-import/relative.out
 '
 
-cat >input <<-EOF &&
-feature relative-marks
-feature import-marks=relative.in
-feature no-relative-marks
-feature export-marks=non-relative.out
-EOF
-
 test_expect_success 'R: feature no-relative-marks should be honoured' '
+	cat >input <<-EOF &&
+	feature relative-marks
+	feature import-marks=relative.in
+	feature no-relative-marks
+	feature export-marks=non-relative.out
+	EOF
+
 	git fast-import <input &&
 	test_cmp marks.new non-relative.out
 '
@@ -2549,15 +2563,15 @@ test_expect_success PIPE 'R: print staged blob within commit' '
 	test_cmp expect actual
 '
 
-cat >input <<-EOF &&
-option git quiet
-blob
-data 3
-hi
+test_expect_success 'R: quiet option results in no stats being output' '
+	cat >input <<-EOF &&
+	option git quiet
+	blob
+	data 3
+	hi
 
-EOF
+	EOF
 
-test_expect_success 'R: quiet option results in no stats being output' '
 	cat input | git fast-import 2> output &&
 	test_must_be_empty output
 '
@@ -2604,11 +2618,11 @@ test_expect_success 'R: terminating "done" within commit' '
 	test_cmp expect actual
 '
 
-cat >input <<-EOF &&
-option git non-existing-option
-EOF
-
 test_expect_success 'R: die on unknown option' '
+	cat >input <<-EOF &&
+	option git non-existing-option
+	EOF
+
 	test_must_fail git fast-import <input
 '
 
@@ -2624,38 +2638,38 @@ test_expect_success 'R: die on invalid option argument' '
 	test_must_fail git fast-import --depth="5 elephants" </dev/null
 '
 
-cat >input <<-EOF &&
-option non-existing-vcs non-existing-option
-EOF
-
 test_expect_success 'R: ignore non-git options' '
+	cat >input <<-EOF &&
+	option non-existing-vcs non-existing-option
+	EOF
+
 	git fast-import <input
 '
 
 ##
 ## R: very large blobs
 ##
-blobsize=$((2*1024*1024 + 53))
-test-genrandom bar $blobsize >expect
-cat >input <<-INPUT_END &&
-commit refs/heads/big-file
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-R - big file
-COMMIT
-
-M 644 inline big1
-data $blobsize
-INPUT_END
-cat expect >>input
-cat >>input <<-INPUT_END &&
-M 644 inline big2
-data $blobsize
-INPUT_END
-cat expect >>input
-echo >>input
-
 test_expect_success 'R: blob bigger than threshold' '
+	blobsize=$((2*1024*1024 + 53)) &&
+	test-genrandom bar $blobsize >expect &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/big-file
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	R - big file
+	COMMIT
+
+	M 644 inline big1
+	data $blobsize
+	INPUT_END
+	cat expect >>input &&
+	cat >>input <<-INPUT_END &&
+	M 644 inline big2
+	data $blobsize
+	INPUT_END
+	cat expect >>input &&
+	echo >>input &&
+
 	test_create_repo R &&
 	git --git-dir=R/.git fast-import --big-file-threshold=1 <input
 '
@@ -2711,46 +2725,46 @@ test_expect_success 'R: blob appears only once' '
 #
 #   Invalid dataref ..
 #
-test_tick
-
-cat >input <<-INPUT_END &&
-commit refs/heads/S
-mark :301
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-commit 1
-COMMIT
-M 100644 inline hello.c
-data <<BLOB
-blob 1
-BLOB
-
-commit refs/heads/S
-mark :302
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-commit 2
-COMMIT
-from :301
-M 100644 inline hello.c
-data <<BLOB
-blob 2
-BLOB
-
-blob
-mark :403
-data <<BLOB
-blob 3
-BLOB
-
-blob
-mark :202
-data <<BLOB
-note 2
-BLOB
-INPUT_END
-
 test_expect_success 'S: initialize for S tests' '
+	test_tick &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/S
+	mark :301
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit 1
+	COMMIT
+	M 100644 inline hello.c
+	data <<BLOB
+	blob 1
+	BLOB
+
+	commit refs/heads/S
+	mark :302
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit 2
+	COMMIT
+	from :301
+	M 100644 inline hello.c
+	data <<BLOB
+	blob 2
+	BLOB
+
+	blob
+	mark :403
+	data <<BLOB
+	blob 3
+	BLOB
+
+	blob
+	mark :202
+	data <<BLOB
+	note 2
+	BLOB
+	INPUT_END
+
 	git fast-import --export-marks=marks <input
 '
 
@@ -3002,103 +3016,103 @@ test_expect_success 'T: empty reset doesnt delete branch' '
 ### series U (filedelete)
 ###
 
-cat >input <<-INPUT_END &&
-commit refs/heads/U
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-test setup
-COMMIT
-M 100644 inline hello.c
-data <<BLOB
-blob 1
-BLOB
-M 100644 inline good/night.txt
-data <<BLOB
-sleep well
-BLOB
-M 100644 inline good/bye.txt
-data <<BLOB
-au revoir
-BLOB
-
-INPUT_END
-
 test_expect_success 'U: initialize for U tests' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/U
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	test setup
+	COMMIT
+	M 100644 inline hello.c
+	data <<BLOB
+	blob 1
+	BLOB
+	M 100644 inline good/night.txt
+	data <<BLOB
+	sleep well
+	BLOB
+	M 100644 inline good/bye.txt
+	data <<BLOB
+	au revoir
+	BLOB
+
+	INPUT_END
+
 	git fast-import <input
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/U
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-delete good/night.txt
-COMMIT
-from refs/heads/U^0
-D good/night.txt
+test_expect_success 'U: filedelete file succeeds' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/U
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	delete good/night.txt
+	COMMIT
+	from refs/heads/U^0
+	D good/night.txt
 
-INPUT_END
+	INPUT_END
 
-test_expect_success 'U: filedelete file succeeds' '
 	git fast-import <input
 '
 
-cat >expect <<-EOF &&
-:100644 000000 2907ebb4bf85d91bf0716bb3bd8a68ef48d6da76 0000000000000000000000000000000000000000 D	good/night.txt
-EOF
+test_expect_success 'U: validate file delete result' '
+	cat >expect <<-EOF &&
+	:100644 000000 2907ebb4bf85d91bf0716bb3bd8a68ef48d6da76 0000000000000000000000000000000000000000 D	good/night.txt
+	EOF
 
-git diff-tree -M -r U^1 U >actual
+	git diff-tree -M -r U^1 U >actual &&
 
-test_expect_success 'U: validate file delete result' '
 	compare_diff_raw expect actual
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/U
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-delete good dir
-COMMIT
-from refs/heads/U^0
-D good
+test_expect_success 'U: filedelete directory succeeds' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/U
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	delete good dir
+	COMMIT
+	from refs/heads/U^0
+	D good
 
-INPUT_END
+	INPUT_END
 
-test_expect_success 'U: filedelete directory succeeds' '
 	git fast-import <input
 '
 
-cat >expect <<-EOF &&
-:100644 000000 69cb75792f55123d8389c156b0b41c2ff00ed507 0000000000000000000000000000000000000000 D	good/bye.txt
-EOF
+test_expect_success 'U: validate directory delete result' '
+	cat >expect <<-EOF &&
+	:100644 000000 69cb75792f55123d8389c156b0b41c2ff00ed507 0000000000000000000000000000000000000000 D	good/bye.txt
+	EOF
 
-git diff-tree -M -r U^1 U >actual
+	git diff-tree -M -r U^1 U >actual &&
 
-test_expect_success 'U: validate directory delete result' '
 	compare_diff_raw expect actual
 '
 
-cat >input <<-INPUT_END &&
-commit refs/heads/U
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-must succeed
-COMMIT
-from refs/heads/U^0
-D ""
+test_expect_success 'U: filedelete root succeeds' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/U
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	must succeed
+	COMMIT
+	from refs/heads/U^0
+	D ""
 
-INPUT_END
+	INPUT_END
 
-test_expect_success 'U: filedelete root succeeds' '
 	git fast-import <input
 '
 
-cat >expect <<-EOF &&
-:100644 000000 c18147dc648481eeb65dc5e66628429a64843327 0000000000000000000000000000000000000000 D	hello.c
-EOF
+test_expect_success 'U: validate root delete result' '
+	cat >expect <<-EOF &&
+	:100644 000000 c18147dc648481eeb65dc5e66628429a64843327 0000000000000000000000000000000000000000 D	hello.c
+	EOF
 
-git diff-tree -M -r U^1 U >actual
+	git diff-tree -M -r U^1 U >actual &&
 
-test_expect_success 'U: validate root delete result' '
 	compare_diff_raw expect actual
 '
 
-- 
2.6.2.337.ga235d84
