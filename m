Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC08C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B14C610CF
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhDIW2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:28:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:47246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234951AbhDIW2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:28:54 -0400
Received: (qmail 3340 invoked by uid 109); 9 Apr 2021 22:28:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 22:28:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17437 invoked by uid 111); 9 Apr 2021 22:28:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 18:28:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 18:28:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] t1404: convert to here-doc test bodies
Message-ID: <YHDVF+oJ6kPje8Vh@coredump.intra.peff.net>
References: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The t1404 script checks a lot of output from Git which contains single
quotes. Because the test snippets are themselves wrapped in the same
single-quotes, we have to resort to using $SQ to match them. This is
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

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1404-update-ref-errors.sh | 274 +++++++++++++++++------------------
 1 file changed, 137 insertions(+), 137 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 8b51c4efc1..16ada22148 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -91,7 +91,7 @@ df_test() {
 		delname="$delref"
 	fi &&
 	cat >expected-err <<-EOF &&
-	fatal: cannot lock ref $SQ$addname$SQ: $SQ$delref$SQ exists; cannot create $SQ$addref$SQ
+	fatal: cannot lock ref '$addname': '$delref' exists; cannot create '$addref'
 	EOF
 	$pack &&
 	if $add_del
@@ -107,443 +107,443 @@ df_test() {
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
 
-test_expect_success 'empty directory should not fool rev-parse' '
+test_expect_success 'empty directory should not fool rev-parse' - <<\EOT
 	prefix=refs/e-rev-parse &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
 	mkdir -p .git/$prefix/foo/bar/baz &&
 	echo "$C" >expected &&
 	git rev-parse $prefix/foo >actual &&
 	test_cmp expected actual
-'
+EOT
 
-test_expect_success 'empty directory should not fool for-each-ref' '
+test_expect_success 'empty directory should not fool for-each-ref' - <<\EOT
 	prefix=refs/e-for-each-ref &&
 	git update-ref $prefix/foo $C &&
 	git for-each-ref $prefix >expected &&
 	git pack-refs --all &&
 	mkdir -p .git/$prefix/foo/bar/baz &&
 	git for-each-ref $prefix >actual &&
 	test_cmp expected actual
-'
+EOT
 
-test_expect_success 'empty directory should not fool create' '
+test_expect_success 'empty directory should not fool create' - <<\EOT
 	prefix=refs/e-create &&
 	mkdir -p .git/$prefix/foo/bar/baz &&
 	printf "create %s $C\n" $prefix/foo |
 	git update-ref --stdin
-'
+EOT
 
-test_expect_success 'empty directory should not fool verify' '
+test_expect_success 'empty directory should not fool verify' - <<\EOT
 	prefix=refs/e-verify &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
 	mkdir -p .git/$prefix/foo/bar/baz &&
 	printf "verify %s $C\n" $prefix/foo |
 	git update-ref --stdin
-'
+EOT
 
-test_expect_success 'empty directory should not fool 1-arg update' '
+test_expect_success 'empty directory should not fool 1-arg update' - <<\EOT
 	prefix=refs/e-update-1 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
 	mkdir -p .git/$prefix/foo/bar/baz &&
 	printf "update %s $D\n" $prefix/foo |
 	git update-ref --stdin
-'
+EOT
 
-test_expect_success 'empty directory should not fool 2-arg update' '
+test_expect_success 'empty directory should not fool 2-arg update' - <<\EOT
 	prefix=refs/e-update-2 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
 	mkdir -p .git/$prefix/foo/bar/baz &&
 	printf "update %s $D $C\n" $prefix/foo |
 	git update-ref --stdin
-'
+EOT
 
-test_expect_success 'empty directory should not fool 0-arg delete' '
+test_expect_success 'empty directory should not fool 0-arg delete' - <<\EOT
 	prefix=refs/e-delete-0 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
 	mkdir -p .git/$prefix/foo/bar/baz &&
 	printf "delete %s\n" $prefix/foo |
 	git update-ref --stdin
-'
+EOT
 
-test_expect_success 'empty directory should not fool 1-arg delete' '
+test_expect_success 'empty directory should not fool 1-arg delete' - <<\EOT
 	prefix=refs/e-delete-1 &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
 	mkdir -p .git/$prefix/foo/bar/baz &&
 	printf "delete %s $C\n" $prefix/foo |
 	git update-ref --stdin
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
 
-test_expect_success 'no bogus intermediate values during delete' '
+test_expect_success 'no bogus intermediate values during delete' - <<\EOT
 	prefix=refs/slow-transaction &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
@@ -598,9 +598,9 @@ test_expect_success 'no bogus intermediate values during delete' '
 	wait $pid2 &&
 	test_must_be_empty out &&
 	test_must_fail git rev-parse --verify --quiet $prefix/foo
-'
+EOT
 
-test_expect_success 'delete fails cleanly if packed-refs file is locked' '
+test_expect_success 'delete fails cleanly if packed-refs file is locked' - <<\EOT
 	prefix=refs/locked-packed-refs &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
@@ -612,11 +612,11 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	test_when_finished "rm -f .git/packed-refs.lock" &&
 	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
 	git for-each-ref $prefix >actual &&
-	test_i18ngrep "Unable to create $SQ.*packed-refs.lock$SQ: " err &&
+	test_i18ngrep "Unable to create '.*packed-refs.lock': " err &&
 	test_cmp unchanged actual
-'
+EOT
 
-test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
+test_expect_success 'delete fails cleanly if packed-refs.new write fails' - <<\EOT
 	# Setup and expectations are similar to the test above.
 	prefix=refs/failed-packed-refs &&
 	git update-ref $prefix/foo $C &&
@@ -630,6 +630,6 @@ test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
 	test_must_fail git update-ref -d $prefix/foo &&
 	git for-each-ref $prefix >actual &&
 	test_cmp unchanged actual
-'
+EOT
 
 test_done
-- 
2.31.1.629.gb61be4ec8d
