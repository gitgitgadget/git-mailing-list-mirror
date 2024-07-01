Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BE4F602
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871736; cv=none; b=m1tsJ0Qsd276hbwyrOcmp4TKP4ErAMmbAvMaYAuFrlHXlLaNKX6bJUPsE+TrHLKq/09BG6AGL33kXWs+nbrSH29u5FzcJOGcifwe/P0Z8OpzRYAzDs2XGIgmL+a41zMu7eN5AFqMYaadc8esQ+UppVoIbHul9CKfgJOVdru3k7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871736; c=relaxed/simple;
	bh=YAOXDJqWPmO/MLwNzLSyvJRDB0x8j+KWnrB6rJZK79w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNTervDUHiIugfcNCRqfIQVLEzIl9kBiPogdLIHMNAnwTptC0/wJ4ZFVTXll1SPfHIebKSRMR2QfAF8JXbrLbbwS93NhahY+J39kfqH19eiwV9jTIP1f3yPm8wqXyAoILxQq9ccfXWlp5BPAyNUDCvZSAhuWq3srKJSZlZQIisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29157 invoked by uid 109); 1 Jul 2024 22:08:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 22:08:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18049 invoked by uid 111); 1 Jul 2024 22:08:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 18:08:52 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 18:08:52 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 2/2] t: convert some here-doc test bodies
Message-ID: <20240701220852.GB20631@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701220815.GA20293@coredump.intra.peff.net>

The t1404 script checks a lot of output from Git which contains single
quotes. Because the test snippets are themselves wrapped in the same
single-quotes, we have to resort to using $SQ to match them.  This is
error-prone and makes the tests harder to read.

Instead, let's use the new here-doc feature added in the previous
commit, which lets us write anything in the test body we want (except
the here-doc end marker on a line by itself, of course).

Note that we do use "\" in our marker to avoid interpolation (which is
the whole point). But we don't use "<<-", as we want to preserve
whitespace in the snippet (and running with "-v" before and after shows
that we produce the exact same output, except with the ugly $SQ
references fixed).

I just converted every test here, even though only some of them use
$SQ. But it would be equally correct to mix-and-match styles if we don't
mind the inconsistency.

I've also converted a few tests in t0600 which were moved from t1404 (I
had written this patch before they were moved, but it seemed worth
porting over the changes rather than losing them).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0600-reffiles-backend.sh  |  38 +++----
 t/t1404-update-ref-errors.sh | 196 +++++++++++++++++------------------
 2 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index b2a771ff2b..20df336cc3 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -91,82 +91,82 @@ test_expect_success 'empty directory should not fool 1-arg delete' '
 	git update-ref --stdin
 '
 
-test_expect_success 'non-empty directory blocks create' '
+test_expect_success 'non-empty directory blocks create' - <<\EOT
 	prefix=refs/ne-create &&
 	mkdir -p .git/$prefix/foo/bar &&
 	: >.git/$prefix/foo/bar/baz.lock &&
 	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
+	fatal: cannot lock ref '$prefix/foo': there is a non-empty directory '.git/$prefix/foo' blocking reference '$prefix/foo'
 	EOF
 	printf "%s\n" "update $prefix/foo $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ
+	fatal: cannot lock ref '$prefix/foo': unable to resolve reference '$prefix/foo'
 	EOF
 	printf "%s\n" "update $prefix/foo $D $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'broken reference blocks create' '
+test_expect_success 'broken reference blocks create' - <<\EOT
 	prefix=refs/broken-create &&
 	mkdir -p .git/$prefix &&
 	echo "gobbledigook" >.git/$prefix/foo &&
 	test_when_finished "rm -f .git/$prefix/foo" &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	fatal: cannot lock ref '$prefix/foo': unable to resolve reference '$prefix/foo': reference broken
 	EOF
 	printf "%s\n" "update $prefix/foo $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	fatal: cannot lock ref '$prefix/foo': unable to resolve reference '$prefix/foo': reference broken
 	EOF
 	printf "%s\n" "update $prefix/foo $D $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'non-empty directory blocks indirect create' '
+test_expect_success 'non-empty directory blocks indirect create' - <<\EOT
 	prefix=refs/ne-indirect-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	mkdir -p .git/$prefix/foo/bar &&
 	: >.git/$prefix/foo/bar/baz.lock &&
 	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
+	fatal: cannot lock ref '$prefix/symref': there is a non-empty directory '.git/$prefix/foo' blocking reference '$prefix/foo'
 	EOF
 	printf "%s\n" "update $prefix/symref $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ
+	fatal: cannot lock ref '$prefix/symref': unable to resolve reference '$prefix/foo'
 	EOF
 	printf "%s\n" "update $prefix/symref $D $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'broken reference blocks indirect create' '
+test_expect_success 'broken reference blocks indirect create' - <<\EOT
 	prefix=refs/broken-indirect-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	echo "gobbledigook" >.git/$prefix/foo &&
 	test_when_finished "rm -f .git/$prefix/foo" &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	fatal: cannot lock ref '$prefix/symref': unable to resolve reference '$prefix/foo': reference broken
 	EOF
 	printf "%s\n" "update $prefix/symref $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	fatal: cannot lock ref '$prefix/symref': unable to resolve reference '$prefix/foo': reference broken
 	EOF
 	printf "%s\n" "update $prefix/symref $D $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
 test_expect_success 'no bogus intermediate values during delete' '
 	prefix=refs/slow-transaction &&
@@ -224,7 +224,7 @@ test_expect_success 'no bogus intermediate values during delete' '
 	test_must_fail git rev-parse --verify --quiet $prefix/foo
 '
 
-test_expect_success 'delete fails cleanly if packed-refs file is locked' '
+test_expect_success 'delete fails cleanly if packed-refs file is locked' - <<\EOT
 	prefix=refs/locked-packed-refs &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
@@ -236,9 +236,9 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	test_when_finished "rm -f .git/packed-refs.lock" &&
 	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
 	git for-each-ref $prefix >actual &&
-	test_grep "Unable to create $SQ.*packed-refs.lock$SQ: " err &&
+	test_grep "Unable to create '.*packed-refs.lock': " err &&
 	test_cmp unchanged actual
-'
+EOT
 
 test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
 	# Setup and expectations are similar to the test above.
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 67ebd81a4c..df90112618 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -100,297 +100,297 @@ df_test() {
 		printf "%s\n" "delete $delname" "create $addname $D"
 	fi >commands &&
 	test_must_fail git update-ref --stdin <commands 2>output.err &&
-	grep -E "fatal:( cannot lock ref $SQ$addname$SQ:)? $SQ$delref$SQ exists; cannot create $SQ$addref$SQ" output.err &&
+	grep -E "fatal:( cannot lock ref '$addname':)? '$delref' exists; cannot create '$addref'" output.err &&
 	printf "%s\n" "$C $delref" >expected-refs &&
 	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
 	test_cmp expected-refs actual-refs
 }
 
-test_expect_success 'setup' '
+test_expect_success 'setup' - <<\EOT
 
 	git commit --allow-empty -m Initial &&
 	C=$(git rev-parse HEAD) &&
 	git commit --allow-empty -m Second &&
 	D=$(git rev-parse HEAD) &&
 	git commit --allow-empty -m Third &&
 	E=$(git rev-parse HEAD)
-'
+EOT
 
-test_expect_success 'existing loose ref is a simple prefix of new' '
+test_expect_success 'existing loose ref is a simple prefix of new' - <<\EOT
 
 	prefix=refs/1l &&
 	test_update_rejected "a c e" false "b c/x d" \
-		"$SQ$prefix/c$SQ exists; cannot create $SQ$prefix/c/x$SQ"
+		"'$prefix/c' exists; cannot create '$prefix/c/x'"
 
-'
+EOT
 
-test_expect_success 'existing packed ref is a simple prefix of new' '
+test_expect_success 'existing packed ref is a simple prefix of new' - <<\EOT
 
 	prefix=refs/1p &&
 	test_update_rejected "a c e" true "b c/x d" \
-		"$SQ$prefix/c$SQ exists; cannot create $SQ$prefix/c/x$SQ"
+		"'$prefix/c' exists; cannot create '$prefix/c/x'"
 
-'
+EOT
 
-test_expect_success 'existing loose ref is a deeper prefix of new' '
+test_expect_success 'existing loose ref is a deeper prefix of new' - <<\EOT
 
 	prefix=refs/2l &&
 	test_update_rejected "a c e" false "b c/x/y d" \
-		"$SQ$prefix/c$SQ exists; cannot create $SQ$prefix/c/x/y$SQ"
+		"'$prefix/c' exists; cannot create '$prefix/c/x/y'"
 
-'
+EOT
 
-test_expect_success 'existing packed ref is a deeper prefix of new' '
+test_expect_success 'existing packed ref is a deeper prefix of new' - <<\EOT
 
 	prefix=refs/2p &&
 	test_update_rejected "a c e" true "b c/x/y d" \
-		"$SQ$prefix/c$SQ exists; cannot create $SQ$prefix/c/x/y$SQ"
+		"'$prefix/c' exists; cannot create '$prefix/c/x/y'"
 
-'
+EOT
 
-test_expect_success 'new ref is a simple prefix of existing loose' '
+test_expect_success 'new ref is a simple prefix of existing loose' - <<\EOT
 
 	prefix=refs/3l &&
 	test_update_rejected "a c/x e" false "b c d" \
-		"$SQ$prefix/c/x$SQ exists; cannot create $SQ$prefix/c$SQ"
+		"'$prefix/c/x' exists; cannot create '$prefix/c'"
 
-'
+EOT
 
-test_expect_success 'new ref is a simple prefix of existing packed' '
+test_expect_success 'new ref is a simple prefix of existing packed' - <<\EOT
 
 	prefix=refs/3p &&
 	test_update_rejected "a c/x e" true "b c d" \
-		"$SQ$prefix/c/x$SQ exists; cannot create $SQ$prefix/c$SQ"
+		"'$prefix/c/x' exists; cannot create '$prefix/c'"
 
-'
+EOT
 
-test_expect_success 'new ref is a deeper prefix of existing loose' '
+test_expect_success 'new ref is a deeper prefix of existing loose' - <<\EOT
 
 	prefix=refs/4l &&
 	test_update_rejected "a c/x/y e" false "b c d" \
-		"$SQ$prefix/c/x/y$SQ exists; cannot create $SQ$prefix/c$SQ"
+		"'$prefix/c/x/y' exists; cannot create '$prefix/c'"
 
-'
+EOT
 
-test_expect_success 'new ref is a deeper prefix of existing packed' '
+test_expect_success 'new ref is a deeper prefix of existing packed' - <<\EOT
 
 	prefix=refs/4p &&
 	test_update_rejected "a c/x/y e" true "b c d" \
-		"$SQ$prefix/c/x/y$SQ exists; cannot create $SQ$prefix/c$SQ"
+		"'$prefix/c/x/y' exists; cannot create '$prefix/c'"
 
-'
+EOT
 
-test_expect_success 'one new ref is a simple prefix of another' '
+test_expect_success 'one new ref is a simple prefix of another' - <<\EOT
 
 	prefix=refs/5 &&
 	test_update_rejected "a e" false "b c c/x d" \
-		"cannot process $SQ$prefix/c$SQ and $SQ$prefix/c/x$SQ at the same time"
+		"cannot process '$prefix/c' and '$prefix/c/x' at the same time"
 
-'
+EOT
 
-test_expect_success 'D/F conflict prevents add long + delete short' '
+test_expect_success 'D/F conflict prevents add long + delete short' - <<\EOT
 	df_test refs/df-al-ds --add-del foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents add short + delete long' '
+test_expect_success 'D/F conflict prevents add short + delete long' - <<\EOT
 	df_test refs/df-as-dl --add-del foo foo/bar
-'
+EOT
 
-test_expect_success 'D/F conflict prevents delete long + add short' '
+test_expect_success 'D/F conflict prevents delete long + add short' - <<\EOT
 	df_test refs/df-dl-as --del-add foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents delete short + add long' '
+test_expect_success 'D/F conflict prevents delete short + add long' - <<\EOT
 	df_test refs/df-ds-al --del-add foo foo/bar
-'
+EOT
 
-test_expect_success 'D/F conflict prevents add long + delete short packed' '
+test_expect_success 'D/F conflict prevents add long + delete short packed' - <<\EOT
 	df_test refs/df-al-dsp --pack --add-del foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents add short + delete long packed' '
+test_expect_success 'D/F conflict prevents add short + delete long packed' - <<\EOT
 	df_test refs/df-as-dlp --pack --add-del foo foo/bar
-'
+EOT
 
-test_expect_success 'D/F conflict prevents delete long packed + add short' '
+test_expect_success 'D/F conflict prevents delete long packed + add short' - <<\EOT
 	df_test refs/df-dlp-as --pack --del-add foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents delete short packed + add long' '
+test_expect_success 'D/F conflict prevents delete short packed + add long' - <<\EOT
 	df_test refs/df-dsp-al --pack --del-add foo foo/bar
-'
+EOT
 
 # Try some combinations involving symbolic refs...
 
-test_expect_success 'D/F conflict prevents indirect add long + delete short' '
+test_expect_success 'D/F conflict prevents indirect add long + delete short' - <<\EOT
 	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents indirect add long + indirect delete short' '
+test_expect_success 'D/F conflict prevents indirect add long + indirect delete short' - <<\EOT
 	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents indirect add short + indirect delete long' '
+test_expect_success 'D/F conflict prevents indirect add short + indirect delete long' - <<\EOT
 	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
-'
+EOT
 
-test_expect_success 'D/F conflict prevents indirect delete long + indirect add short' '
+test_expect_success 'D/F conflict prevents indirect delete long + indirect add short' - <<\EOT
 	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents indirect add long + delete short packed' '
+test_expect_success 'D/F conflict prevents indirect add long + delete short packed' - <<\EOT
 	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents indirect add long + indirect delete short packed' '
+test_expect_success 'D/F conflict prevents indirect add long + indirect delete short packed' - <<\EOT
 	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents add long + indirect delete short packed' '
+test_expect_success 'D/F conflict prevents add long + indirect delete short packed' - <<\EOT
 	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
-'
+EOT
 
-test_expect_success 'D/F conflict prevents indirect delete long packed + indirect add short' '
+test_expect_success 'D/F conflict prevents indirect delete long packed + indirect add short' - <<\EOT
 	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
-'
+EOT
 
 # Test various errors when reading the old values of references...
 
-test_expect_success 'missing old value blocks update' '
+test_expect_success 'missing old value blocks update' - <<\EOT
 	prefix=refs/missing-update &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ
+	fatal: cannot lock ref '$prefix/foo': unable to resolve reference '$prefix/foo'
 	EOF
 	printf "%s\n" "update $prefix/foo $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'incorrect old value blocks update' '
+test_expect_success 'incorrect old value blocks update' - <<\EOT
 	prefix=refs/incorrect-update &&
 	git update-ref $prefix/foo $C &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: is at $C but expected $D
+	fatal: cannot lock ref '$prefix/foo': is at $C but expected $D
 	EOF
 	printf "%s\n" "update $prefix/foo $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'existing old value blocks create' '
+test_expect_success 'existing old value blocks create' - <<\EOT
 	prefix=refs/existing-create &&
 	git update-ref $prefix/foo $C &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: reference already exists
+	fatal: cannot lock ref '$prefix/foo': reference already exists
 	EOF
 	printf "%s\n" "create $prefix/foo $E" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'incorrect old value blocks delete' '
+test_expect_success 'incorrect old value blocks delete' - <<\EOT
 	prefix=refs/incorrect-delete &&
 	git update-ref $prefix/foo $C &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: is at $C but expected $D
+	fatal: cannot lock ref '$prefix/foo': is at $C but expected $D
 	EOF
 	printf "%s\n" "delete $prefix/foo $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'missing old value blocks indirect update' '
+test_expect_success 'missing old value blocks indirect update' - <<\EOT
 	prefix=refs/missing-indirect-update &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ
+	fatal: cannot lock ref '$prefix/symref': unable to resolve reference '$prefix/foo'
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'incorrect old value blocks indirect update' '
+test_expect_success 'incorrect old value blocks indirect update' - <<\EOT
 	prefix=refs/incorrect-indirect-update &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	git update-ref $prefix/foo $C &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: is at $C but expected $D
+	fatal: cannot lock ref '$prefix/symref': is at $C but expected $D
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'existing old value blocks indirect create' '
+test_expect_success 'existing old value blocks indirect create' - <<\EOT
 	prefix=refs/existing-indirect-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	git update-ref $prefix/foo $C &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: reference already exists
+	fatal: cannot lock ref '$prefix/symref': reference already exists
 	EOF
 	printf "%s\n" "create $prefix/symref $E" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'incorrect old value blocks indirect delete' '
+test_expect_success 'incorrect old value blocks indirect delete' - <<\EOT
 	prefix=refs/incorrect-indirect-delete &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	git update-ref $prefix/foo $C &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: is at $C but expected $D
+	fatal: cannot lock ref '$prefix/symref': is at $C but expected $D
 	EOF
 	printf "%s\n" "delete $prefix/symref $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'missing old value blocks indirect no-deref update' '
+test_expect_success 'missing old value blocks indirect no-deref update' - <<\EOT
 	prefix=refs/missing-noderef-update &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: reference is missing but expected $D
+	fatal: cannot lock ref '$prefix/symref': reference is missing but expected $D
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'incorrect old value blocks indirect no-deref update' '
+test_expect_success 'incorrect old value blocks indirect no-deref update' - <<\EOT
 	prefix=refs/incorrect-noderef-update &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	git update-ref $prefix/foo $C &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: is at $C but expected $D
+	fatal: cannot lock ref '$prefix/symref': is at $C but expected $D
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'existing old value blocks indirect no-deref create' '
+test_expect_success 'existing old value blocks indirect no-deref create' - <<\EOT
 	prefix=refs/existing-noderef-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	git update-ref $prefix/foo $C &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: reference already exists
+	fatal: cannot lock ref '$prefix/symref': reference already exists
 	EOF
 	printf "%s\n" "option no-deref" "create $prefix/symref $E" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
-test_expect_success 'incorrect old value blocks indirect no-deref delete' '
+test_expect_success 'incorrect old value blocks indirect no-deref delete' - <<\EOT
 	prefix=refs/incorrect-noderef-delete &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	git update-ref $prefix/foo $C &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: is at $C but expected $D
+	fatal: cannot lock ref '$prefix/symref': is at $C but expected $D
 	EOF
 	printf "%s\n" "option no-deref" "delete $prefix/symref $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err
-'
+EOT
 
 test_done
-- 
2.45.2.1165.ga18b536d12
