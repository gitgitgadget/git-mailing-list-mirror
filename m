Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE824252C9
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429837; cv=none; b=mbonskHkPW4ctN3r8fWCMhlxpW7o7RH39NY7TpXpYW82iYOFo+VlyjVFk5csew34VwrKdEZMqYilPiJTI36UMXBQxvP119QTxynH6BV96KynVFzXdfWEtr5G2Jsmw67+dGdQOk9ZWZM2UiHQuLmpmS7kYj2iLcNbntpEfmtUYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429837; c=relaxed/simple;
	bh=UHBMe94+L4jPSut5GiHGc1jGbEFRUWbzd2GDDHSBuqg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mTZE/gz3U5mJDxsmQFclprcE9p7DsXDEu6mkm2arYRnEXUtZCtwRLAl+Vo8mtKQ/E6ERmitylXw0nacnEHV1kun+eFpW21J7dm5rZxsxp2H8ZQ1FltoUrO4CD+Ks8ijjRpgN0f/XiLFQRza0RuX4aewCpRKHKEXztKWtA4YSODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=bHeNM+Ne; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="bHeNM+Ne"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbFYF0pmHzMlH0;
	Thu, 03 Sep 2026 12:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788429825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKxMrAucIekyVmchIeFZ2rY9ZtdERNTRs1IKHb7OZy0=;
	b=bHeNM+NevX3sOq3pxrMnkJW1Y3zfuEwC5oKkHWdU18/AYlRv7ksFRJri78zPUrCIxM626L
	YmLNuHH6do5C4OlfvzBKKMncPY+6WIVio+/P95F+ajBArwTodLS0EcikjJCAjlqkhMudvW
	6t6nAKlEaW68YSB68V2fTsn9v3/hg7ADeJvpjtdJMIHgJsPUKCRqIU9r13s4Rkx5jJKfqn
	B9LH3R/DZ32a8aZ7PFzOfkREyLju88eJuCSq8QnCBouiBehVAuDzbpcST0eMjAvZVYNnCG
	TSmXZQLEdsRewZKX8oc4jgjdoq9KE4Tx79T8WH7LQ4WDLsaZYrMOpubqwUPNhw==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v2 1/2] dir: do not apply prefix to negative pathspecs
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
Date: Thu, 3 Sep 2026 12:03:32 +0200
Cc: Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0617001F-13BB-4548-A10A-89877977CFB5@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
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
--=20
2.55.0

