Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60929463B91
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351777; cv=none; b=EDgn5le+WLITIFI3QywKO6isxhmEa8CJHmLC+eKLDvnSgVZL6Xkp6j0PDyH9qkik09A1i7Hiy/62CeSdCuZtvR1w4LgHIceoALoEypuCOcM9yw0BQygQDHiP5tG92BnQrwLYz36utzwZ/KLaHyCeXpcFE5uf00QQIJrIKgweCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351777; c=relaxed/simple;
	bh=Hgo0UKJg7x+shhQyePuQ+EN+R6xmdcboBrIuLcZgyJA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=rLLkbqJlzncGddrd3Fnno7YkvmH0KZ9mm3l1cRTaUh75KQh5LhgOi1qfQYXMXXOGrYClnCB+3noRb2qwmLttAfyU+b057nPg3E9wE8RzUgdC8wBhTO+Is5CUmyqIyv3u0J4pYXzNnC4aGp1IydLNJoUM+SSoyovpR7T2V9dE2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=kn4AWfug; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="kn4AWfug"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hZhhC0shgz8tyL
	for <git@vger.kernel.org>; Wed, 02 Sep 2026 14:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788351771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1gv3TolJ/emY0nfjcWvi6KsfmvKTF8gWxgJ98vVGVXY=;
	b=kn4AWfug+LfNqTxqD6z/1pNXmqx+BfTVuT7dUd6AWHNfYseQz2uRt/URIJzXpK2GXDTLxP
	a3WpLincYjiPwWgEiGjEL6mcj4gs+VntpO1xUW2PijfoOLwT11fsrJKq8pRdzjSENdHRMQ
	uUOQ4IQhoYvzew2v8YXza2qickWnsiBFOg5O3syiApS7qVeo5Vv3C9dKAiiDlJfZl/P9cu
	u0O+m/gdQTz5u/rQumf009jN3Njl3rgj78aNgnWeaX3gSK1RrhhG+jg8qZZj2Da9CVK50v
	5YoD/qJNjYkoLIWEqBjJbn9pb5VvRr/X3rBHwaUshzUHOiT9/JxFO2c5cDLdMQ==
From: Yannik Tausch <dev@ytausch.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] dir: do not apply prefix to negative pathspecs
Message-Id: <0CA8678D-0540-4A2E-B314-B9BEB04E2BF5@ytausch.de>
Date: Wed, 2 Sep 2026 14:22:39 +0200
To: git@vger.kernel.org

common_prefix_len() derives the common prefix solely from positive
pathspecs, skipping those marked with PATHSPEC_EXCLUDE. However,
match_pathspec_with_flags() also passes that prefix when matching the
negative pathspecs.

A negative pathspec may be shorter than the prefix. In that case,
match_pathspec_item() advances item->match beyond its allocation and
subtracts the prefix from item->len, producing a negative matchlen. It
then dereferences the out-of-bounds pointer. If the resulting byte is
not NUL, matchlen is converted to size_t when passed to ps_strncmp(),
which may cause a much larger out-of-bounds read.

The problem can be reproduced with AddressSanitizer:

    make SANITIZE=3Daddress CFLAGS=3D"-g -O0" git
    git init test &&
    cd test &&
    DIR=3D$(printf "a%.0s" {1..150}) &&
    mkdir -p "$DIR" &&
    touch "$DIR/f.txt" &&
    git add -A &&
    git commit -m test &&
    ../git ls-files -- "$DIR/" ":(exclude)xy"

This reports a heap-buffer-overflow. Without AddressSanitizer, the
output may depend on the contents of memory following the negative
pathspec.

Fix the bug by using a zero prefix when matching negative pathspecs.
Add a regression test that combines a positive pathspec with a longer
common prefix and a shorter, unrelated negative pathspec.

Signed-off-by: Yannik Tausch <dev@ytausch.de>
---

Note that I already sent information about this issue to the git =
security
mailing list on July 31, where I was informed that a fix of this kind =
does
not require an embargo.

 dir.c                       | 2 +-
 t/t6132-pathspec-exclude.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 95d8a1cce9..7072715389 100644
--- a/dir.c
+++ b/dir.c
@@ -593,7 +593,7 @@ static int match_pathspec_with_flags(struct =
index_state *istate,
 	if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
 		return positive;
 	negative =3D do_match_pathspec(istate, ps, name, namelen,
-				     prefix, seen,
+				     0, seen,
 				     flags | DO_MATCH_EXCLUDE);
 	return negative ? 0 : positive;
 }
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 9fdafeb1e9..ad919cc739 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -183,6 +183,15 @@ EOF
 	test_cmp expect actual
 '
=20
+test_expect_success 'negative pathspec shorter than positive pathspec =
prefix' '
+	git ls-files -- sub/sub/ ":(exclude)sub2" >actual &&
+	cat <<-\EOF >expect &&
+	sub/sub/file
+	sub/sub/sub/file
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'multiple exclusions' '
 	git ls-files -- ":^*/file2" ":^sub2" >actual &&
 	cat <<-\EOF >expect &&

