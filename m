Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E243C0A1F
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370773; cv=none; b=c9RshHb+t+2ZvwQXAUj6YV3BJmwMwKSDjOWxN14dEPU3DTfc5YOePMsqSivENyQSqDfk4svvDD1rBZSmjI1Tl9jsTPG6zZLfgydkGDmFTPcP9n+2ZIDOrfRne3SbHdEfSb7bHgMye2LySCa+PXf/wFnNObVbSF0dCPaYuI7Vo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370773; c=relaxed/simple;
	bh=KKwwOEXuU76rNjXigA9EYQhtJKPx0i+iYLmaxuQrq+o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PeQwm3vOkalTx6Y18vnYAM8jQNYIZ8A6R16HpBoSeIJ358gs+EE0TnMkPcf1fKw5FU1GPuVvmPm5VE68epuDG2QhmAAuY3fa1Vp9k/261q3j0MPvP98XYPxXEmJ5fM3BwHqWwga9djRcHtK54iqu6NqshxRwWyMHQDT4QZpqVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=ObqdGxFi; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="ObqdGxFi"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hjxXC0VKvzKp27;
	Mon, 14 Sep 2026 09:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1789370763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msyMZyTeaKmQO1czRtVEXs44WdeGpflXckySrInv0Ks=;
	b=ObqdGxFimnWrYweDlWs+SclM0AZI4gWmvu1BvQHJcV+EhK+XGfDGMfibTzYqRDZ5r8hTxn
	G+vDl691DcEBdQ6QVpb9GQpoXvjp22RhI7QBRJayGXxf/xeRUG0gdZbXXLxv2iROHXpw1O
	74RtASSkYMjFQicCAz++V1NnauV6Hws9BcqgUwi3/XbVNUptAQlm4VHS1796edmJ1KkrZT
	6bqzl25MONGtpIFnGwIjfu3gNCot5+PAXI2JpdJrGCji59VLjFDqfx9ZOzFUVO4xhquPF8
	Ps6WrlLSIoVH12eeiH6Nb7j1AR/yLFSugR2wTkGbTBnmjc92/Qq8VIJz+g6/Yw==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v4 1/2] dir: do not apply prefix to negative pathspecs
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <7CB757FB-1F2D-4EE6-8C31-8C2CD6D42397@ytausch.de>
Date: Mon, 14 Sep 2026 09:25:51 +0200
Cc: Junio C Hamano <gitster@pobox.com>,
 newren@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6BF8D32-470C-4C54-B4BD-CF9B1E0F191F@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
 <7CB757FB-1F2D-4EE6-8C31-8C2CD6D42397@ytausch.de>
To: git@vger.kernel.org

common_prefix_len() derives the common prefix solely from non-exclude
pathspec items. However, match_pathspec_with_flags() also passes that
prefix when matching exclude items.

This can produce incorrect results because that prefix does not
necessarily match an exclude item. For example, given non-exclude items
"a/b" and "a/c" and an exclude item "x/b", stripping the two-byte
prefix from both the pathname "a/b/m" and pattern "x/b" makes the
remaining strings match and incorrectly excludes the pathname.

If an exclude item is shorter than the prefix, match_pathspec_item()
instead advances item->match beyond its allocation and subtracts the
prefix from item->len, producing a negative matchlen. It then
dereferences the out-of-bounds pointer. If the resulting byte is not
NUL, matchlen is converted to size_t when passed to ps_strncmp(), which
may cause a much larger out-of-bounds read.

The out-of-bounds access can be reproduced with AddressSanitizer:

    make SANITIZE=3Daddress CFLAGS=3D"-g -O0" git
    git init test &&
    cd test &&
    DIR=3D$(printf "a%.0s" {1..150}) &&
    mkdir -p "$DIR" &&
    touch "$DIR/f.txt" &&
    git add -A &&
    git commit -m test &&
    ../git ls-files -- "$DIR/" ":(exclude)xy"

Fix the bug by using a zero prefix when matching exclude items. Add
regression tests for both the deterministic incorrect match and the
shorter exclude item that causes the out-of-bounds access.

Signed-off-by: Yannik Tausch <dev@ytausch.de>
---
 dir.c                       |  2 +-
 t/t6132-pathspec-exclude.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 32430090dc..5f42c992d3 100644
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
index 9fdafeb1e9..e0c3f73ef0 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -183,6 +183,24 @@ EOF
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
+test_expect_success 'exclude is matched against the full path' '
+	git ls-files -- sub/sub/ ":(exclude)zzzzzzz" >actual &&
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

