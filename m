Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CE1A08AF
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676189; cv=none; b=Qt7gxhqVbHovOxd9FYUiGIWvj0yQSXNNBUfaJuY+7YrOTPVitiRKT8EfFzX+WsPcD8fDOEINgsiKWKop7ablnhJEfZpKsI1H5azV/7/og2c3kJoSliiwdIBKBN7cV4hNEr9SOreCppHKj2OhgDy7zUHNB+AwpywhFVJLMQb6obw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676189; c=relaxed/simple;
	bh=ukwSrtZbmMkzpJ/jZg9lXjz3tguGuKORdf+k1A4BBwY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGtR2+5jN+jT8cJ0a+68idg0OlY8nkwQ6f+L+fHoGJo+81gjQj+7hkjzLyNbWZCXbd4HC27GZ2i5T28U+rCu6NMWwX3PltT+S7eve8CUaa2vpv4eT1tB7XIUO9CNbSS6IoSKWBdvjQm6JDFqrZpiDfP1QwLd6TVM+KO9+w22yso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fuIN0YxY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fuIN0YxY"
Received: (qmail 10142 invoked by uid 109); 23 Jun 2025 10:56:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ukwSrtZbmMkzpJ/jZg9lXjz3tguGuKORdf+k1A4BBwY=; b=fuIN0YxYY5r4DXAB7+u+3kQ//liXspwU2OoBQsFeU7yjnvuFt7rweqPyJhUoZW7snI5XbAiQhPrv82/rcNtnDB4Z/L+Cf4gG0Qg3JBZwRZ3SiL1v+pBiUa9ntQWIkrt8OIztTsbQ+VxzzqP8uy6vop/YL0fCwGqAb5BQgyW16CqfDdksRwABRRHnZVrgQGALKH6BCnOnQzbvCmU8RKzTj7HYIWKgNPn+sOxN197PlflEr9D3p6C5HWN9PpGMEAxCf5WIqhhvtjulOaY1zEmD1MWsUHwtSU4wbqI/3FB1Qkl6PKm80VI9sK5dKxICrZEthzE+nM8z013L4gJ3CZMc5w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Jun 2025 10:56:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16020 invoked by uid 111); 23 Jun 2025 10:56:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Jun 2025 06:56:25 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Jun 2025 06:56:25 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/2] test-lib: teach test_seq the -f option
Message-ID: <20250623105625.GB654412@coredump.intra.peff.net>
References: <20250623105516.GA654296@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623105516.GA654296@coredump.intra.peff.net>

The "seq" tool has a "-f" option to produce printf-style formatted
lines. Let's teach our test_seq helper the same trick. This lets us get
rid of some shell loops in test snippets (which are particularly verbose
in our test suite because we have to "|| return 1" to keep the &&-chain
going).

This converts a few call-sites I found by grepping around the test
suite. A few notes on these:

  - In "seq", the format specifier is a "%g" float. Since test_seq only
    supports integers, I've kept the more natural "%d" (which is what
    these call sites were using already).

  - Like "seq", test_seq automatically adds a newline to the specified
    format. This is what all callers are doing already except for t0021,
    but there we do not care about the exact format. We are just trying
    to printf a large number of bytes to a file. It's not worth
    complicating other callers or adding an option to avoid the newline
    in that caller.

  - Most conversions are just replacing a shell loop (which does get rid
    of an extra fork, since $() requires a subshell). In t0612 we can
    replace an awk invocation, which I think makes the end result more
    readable, as there's less quoting.

  - In t7422 we can replace one loop, but sadly we have to leave the
    loop directly above it. This is because that earlier loop wants to
    include the seq value twice in the output, which test_seq does not
    support (nor does regular seq). If you run:

      test_seq -f "foo-%d %d" 10

    the second "%d" will always be the empty string. You might naively
    think that test_seq could add some extra arguments, like:

      # 3 ought to be enough for anyone...
      printf "$fmt\n" "$i "$i" $i"

    but that just triggers printf to format multiple lines, one per
    extra set of arguments.

    So we'd have to actually parse the format string, figure out how
    many "%" placeholders are there, and then feed it that many
    instances of the sequence number. The complexity isn't worth it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0021-conversion.sh                  |  4 ++--
 t/t0610-reftable-basics.sh             |  6 +-----
 t/t0612-reftable-jgit-compatibility.sh | 13 +++++--------
 t/t0613-reftable-write-options.sh      | 24 ++++--------------------
 t/t1400-update-ref.sh                  | 10 ++--------
 t/t5004-archive-corner-cases.sh        |  5 +----
 t/t6422-merge-rename-corner-cases.sh   | 10 ++--------
 t/t7422-submodule-output.sh            |  6 +-----
 t/test-lib-functions.sh                |  9 ++++++++-
 9 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index bf10d253ec..f0d50d769e 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -281,7 +281,7 @@ test_expect_success 'required filter with absent smudge field' '
 test_expect_success 'filtering large input to small output should use little memory' '
 	test_config filter.devnull.clean "cat >/dev/null" &&
 	test_config filter.devnull.required true &&
-	for i in $(test_seq 1 30); do printf "%1048576d" 1 || return 1; done >30MB &&
+	test_seq -f "%1048576d" 1 30 >30MB &&
 	echo "30MB filter=devnull" >.gitattributes &&
 	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
 '
@@ -299,7 +299,7 @@ test_expect_success 'filter that does not read is fine' '
 test_expect_success EXPENSIVE 'filter large file' '
 	test_config filter.largefile.smudge cat &&
 	test_config filter.largefile.clean cat &&
-	for i in $(test_seq 1 2048); do printf "%1048576d" 1 || return 1; done >2GB &&
+	test_seq -f "%1048576d" 1 2048 >2GB &&
 	echo "2GB filter=largefile" >.gitattributes &&
 	git add 2GB 2>err &&
 	test_must_be_empty err &&
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 1be534a895..3ea5d51532 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -477,11 +477,7 @@ test_expect_success !CYGWIN 'ref transaction: many concurrent writers' '
 		test_commit --no-tag initial &&
 
 		head=$(git rev-parse HEAD) &&
-		for i in $(test_seq 100)
-		do
-			printf "%s commit\trefs/heads/branch-%s\n" "$head" "$i" ||
-			return 1
-		done >expect &&
+		test_seq -f "$head commit\trefs/heads/branch-%d" 100 >expect &&
 		printf "%s commit\trefs/heads/main\n" "$head" >>expect &&
 
 		for i in $(test_seq 100)
diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit-compatibility.sh
index d0d7e80b49..7df2ad5817 100755
--- a/t/t0612-reftable-jgit-compatibility.sh
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -112,14 +112,11 @@ test_expect_success 'JGit can read multi-level index' '
 		cd repo &&
 
 		test_commit A &&
-		awk "
-		    BEGIN {
-			print \"start\";
-			for (i = 0; i < 10000; i++)
-			    printf \"create refs/heads/branch-%d HEAD\n\", i;
-			print \"commit\";
-		    }
-		" >input &&
+		{
+			echo start &&
+			test_seq -f "create refs/heads/branch-%d HEAD" 10000 &&
+			echo commit
+		} >input &&
 		git update-ref --stdin <input &&
 
 		test_same_refs &&
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index 6447920c9b..d77e601111 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -66,11 +66,7 @@ test_expect_success 'many refs results in multiple blocks' '
 	(
 		cd repo &&
 		test_commit initial &&
-		for i in $(test_seq 200)
-		do
-			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
-			return 1
-		done >input &&
+		test_seq -f "update refs/heads/branch-%d HEAD" 200 >input &&
 		git update-ref --stdin <input &&
 		git pack-refs &&
 
@@ -180,11 +176,7 @@ test_expect_success 'restart interval at every single record' '
 	(
 		cd repo &&
 		test_commit initial &&
-		for i in $(test_seq 10)
-		do
-			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
-			return 1
-		done >input &&
+		test_seq -f "update refs/heads/branch-%d HEAD" 10 >input &&
 		git update-ref --stdin <input &&
 		git -c reftable.restartInterval=1 pack-refs &&
 
@@ -224,11 +216,7 @@ test_expect_success 'object index gets written by default with ref index' '
 	(
 		cd repo &&
 		test_commit initial &&
-		for i in $(test_seq 5)
-		do
-			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
-			return 1
-		done >input &&
+		test_seq -f "update refs/heads/branch-%d HEAD" 5 >input &&
 		git update-ref --stdin <input &&
 		git -c reftable.blockSize=100 pack-refs &&
 
@@ -263,11 +251,7 @@ test_expect_success 'object index can be disabled' '
 	(
 		cd repo &&
 		test_commit initial &&
-		for i in $(test_seq 5)
-		do
-			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
-			return 1
-		done >input &&
+		test_seq -f "update refs/heads/branch-%d HEAD" 5 >input &&
 		git update-ref --stdin <input &&
 		git -c reftable.blockSize=100 -c reftable.indexObjects=false pack-refs &&
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d29d23cb89..e373d9108b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1380,21 +1380,15 @@ test_expect_success 'fails with duplicate ref update via symref' '
 
 test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
 (
-	for i in $(test_seq 33)
-	do
-		echo "create refs/heads/$i HEAD" || exit 1
-	done >large_input &&
+	test_seq -f "create refs/heads/%d HEAD" 33 >large_input &&
 	run_with_limited_open_files git update-ref --stdin <large_input &&
 	git rev-parse --verify -q refs/heads/33
 )
 '
 
 test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
 (
-	for i in $(test_seq 33)
-	do
-		echo "delete refs/heads/$i HEAD" || exit 1
-	done >large_input &&
+	test_seq -f "delete refs/heads/%d HEAD" 33 >large_input &&
 	run_with_limited_open_files git update-ref --stdin <large_input &&
 	test_must_fail git rev-parse --verify -q refs/heads/33
 )
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 5174995191..027dedd976 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -176,10 +176,7 @@ test_expect_success EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT \
 	blob=$(echo $s | git hash-object -w --stdin) &&
 
 	# create tree containing 65500 entries of that blob
-	for i in $(test_seq 1 65500)
-	do
-		echo "100644 blob $blob	$i" || return 1
-	done >tree &&
+	test_seq -f "100644 blob $blob\t%d" 1 65500 >tree &&
 	tree=$(git mktree <tree) &&
 
 	# zip it, creating an archive a bit bigger than 4GB
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 9cbe7ca782..f14c0fb30e 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -1146,10 +1146,7 @@ test_conflicts_with_adds_and_renames() {
 			cd simple_${sideL}_${sideR} &&
 
 			# Create some related files now
-			for i in $(test_seq 1 10)
-			do
-				echo Random base content line $i
-			done >file_v1 &&
+			test_seq -f "Random base content line %d" 1 10 >file_v1 &&
 			cp file_v1 file_v2 &&
 			echo modification >>file_v2 &&
 
@@ -1293,10 +1290,7 @@ test_setup_nested_conflicts_from_rename_rename () {
 		cd nested_conflicts_from_rename_rename &&
 
 		# Create some related files now
-		for i in $(test_seq 1 10)
-		do
-			echo Random base content line $i
-		done >file_v1 &&
+		test_seq -f "Random base content line %d" 1 10 >file_v1 &&
 
 		cp file_v1 file_v2 &&
 		cp file_v1 file_v3 &&
diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index ea67057f1a..aea1ddf117 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -187,11 +187,7 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
 		BLOB=$(git hash-object -w --stdin <gitmodules) &&
 
 		printf "100644 blob $BLOB\t.gitmodules\n" >tree &&
-		for i in $(test_seq 2000)
-		do
-			printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" "$i" ||
-			return 1
-		done >>tree &&
+		test_seq -f "160000 commit $COMMIT\trecursive-submodule-path-%d" 2000 >>tree &&
 		TREE=$(git mktree <tree) &&
 
 		COMMIT=$(git commit-tree "$TREE") &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index bee4a2ca34..8c176f4efc 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1454,6 +1454,13 @@ test_cmp_fspath () {
 # from 1.
 
 test_seq () {
+	local fmt="%d"
+	case "$1" in
+	-f)
+		fmt="$2"
+		shift 2
+		;;
+	esac
 	case $# in
 	1)	set 1 "$@" ;;
 	2)	;;
@@ -1462,7 +1469,7 @@ test_seq () {
 	test_seq_counter__=$1
 	while test "$test_seq_counter__" -le "$2"
 	do
-		echo "$test_seq_counter__"
+		printf "$fmt\n" "$test_seq_counter__"
 		test_seq_counter__=$(( $test_seq_counter__ + 1 ))
 	done
 }
-- 
2.50.0.385.g2a828bf5b7
