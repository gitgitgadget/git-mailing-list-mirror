Received: from mail.luna.gl (mail.luna.gl [141.147.12.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27AF2DF144
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.147.12.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780350038; cv=none; b=LixOJ1Ij4ivSXe3xBP1vZU5GwhBnWGvKlDCZh6ww1bDzpKzPR7KfEnxkIIPF6JjRVY2KUaCawRWdp2PHew2Rq32u8Ae0rVtpSwHxnMXssetnhqMUK+jxzNpvU4F/06I+iYTd0yOhszMwoy0F+svjC9g4VKHALnDeqD1BY96h+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780350038; c=relaxed/simple;
	bh=MY+zc62XKCwJ3MVYTaBd9yyFGXvchOuTVAZybQkP6tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDaMFPNkxWjSnumGtagQu7QOsAt/7Z/Fg/iJb8d7PnOzD01xGoqPGw4MoTgiG7uI8GplLz4gSJiPBy85osEH2vTb+Dn8tP+xqZkvHl1vW04j2m9/2NA5+FrBt4WVgmFJUDSuX1TimAFeDvQjmM511dRhRY5bL5Gb9N8IqQKEsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl; spf=pass smtp.mailfrom=luna.gl; dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b=nJ+a7pIv; dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b=S1npHxMv; arc=none smtp.client-ip=141.147.12.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luna.gl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b="nJ+a7pIv";
	dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b="S1npHxMv"
DKIM-Signature: v=1; a=rsa-sha256; s=202405r; d=luna.gl; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1780350022; bh=6g86uiQ9qiqO6gwwQiOs5Wy
	b7/ie/iZJijZSAWbyuzE=; b=nJ+a7pIvxwcMurccnytsy3aLeomLDYGGCkFIbSMSM7Wf9mqFIo
	pJEKuieKroFE4nVn/v3/Yqf9e7A8aqX3UkU02njuVu5WCoqDmXEZL6pRFZyksNWljaf2G0329kT
	DzSdNMWQeWJExkZXLjfLq+uibXH3beX2IIvD7QIYjF7XgBWix5aNGlQvE6wn1qwtZV11a59NbxS
	cuMVbDC/Vb4s2mGmj/yWkUhQto10nc4JcZw+KAVO7opfBsw0NzVGphj2ytDRiSCeilSw0W+IJmD
	NPOqElfaHYrlT2mlA5wEe/aqTNzCMVQSQB5eURfvplyYKtaMrUVo/7hKgju0nkozJzw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202405e; d=luna.gl; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1780350022; bh=6g86uiQ9qiqO6gwwQiOs5Wy
	b7/ie/iZJijZSAWbyuzE=; b=S1npHxMvcbUoRRj8ZRBUYXbJ33mZHp8B6p63s260VSU24MWT7K
	AYC8o1ytVeubLEBOoly10ZSoF7KLRmdp9TAQ==;
From: Luna Schwalbe <dev@luna.gl>
To: git@vger.kernel.org
Cc: Luna Schwalbe <dev@luna.gl>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: document and test `@` prefix for raw timestamps
Date: Mon,  1 Jun 2026 23:39:45 +0200
Message-ID: <20260601213944.645731-2-dev@luna.gl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Git internal date format `<unix-timestamp> <time-zone-offset>`
fails to parse when the timestamp is less than 100,000,000 (fewer than
9 digits). This happens to avoid potential ambiguity with other date
formats such as `YYYYMMDD`, especially when used with approxidate.

To force the parser to interpret the value as a raw timestamp, it must
be prefixed with `@` (e.g., `@0 +0000`). This behavior was introduced
in 2c733fb24c10a9d7aacc51f956bf9b7881980870 (parse_date(): '@' prefix
forces git-timestamp, 2012-02-02) but was never documented.

Document the `@` prefix in `Documentation/date-formats.adoc` to make
this behavior explicit. Also add test cases to `t/t0006-date.sh` to
verify and demonstrate the difference between prefixed and unprefixed
small timestamps (e.g., `@2000` vs `2000`).

Signed-off-by: Luna Schwalbe <dev@luna.gl>
Co-authored-by: Junio C Hamano <gitster@pobox.com>
---
I switched out the YYYYMMDD tests as that format doesn't appear to be
understood by either parse or approxidate.

 Documentation/date-formats.adoc |  6 ++++++
 t/t0006-date.sh                 | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/date-formats.adoc b/Documentation/date-formats.adoc
index e24517c49..83f676585 100644
--- a/Documentation/date-formats.adoc
+++ b/Documentation/date-formats.adoc
@@ -10,6 +10,12 @@ Git internal format::
 	`<time-zone-offset>` is a positive or negative offset from UTC.
 	For example CET (which is 1 hour ahead of UTC) is `+0100`.
 
+    It is safer to prepend the `<unix-timestamp>` with `@`
+    (e.g., `@0 +0000`), which forces Git to interpret it as a raw
+    timestamp. This is required for values less than 100,000,000
+    (which have fewer than 9 digits) to avoid confusion with other
+    date formats (like `YYYYMMDD`).
+
 RFC 2822::
 	The standard date format as described by RFC 2822, for example
 	`Thu, 07 Apr 2005 22:13:13 +0200`.
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 53ced36df..8b4e1870b 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -138,6 +138,13 @@ check_parse '1969-12-31 23:59:59 Z' bad
 check_parse '1969-12-31 23:59:59 +11' bad
 check_parse '1969-12-31 23:59:59 -11' bad
 
+# pathologically small timestamps requiring `@` prefix
+check_parse '@0 +0000' '1970-01-01 00:00:00 +0000'
+check_parse '@99999999 +0000' '1973-03-03 09:46:39 +0000'
+check_parse '99999999 +0000' bad
+check_parse '@100000000 +0000' '1973-03-03 09:46:40 +0000'
+check_parse '100000000 +0000' '1973-03-03 09:46:40 +0000'
+
 REQUIRE_64BIT_TIME=HAVE_64BIT_TIME
 check_parse '2099-12-31 23:59:59' '2099-12-31 23:59:59 +0000'
 check_parse '2099-12-31 23:59:59 +00' '2099-12-31 23:59:59 +0000'
@@ -195,6 +202,10 @@ check_approxidate '6AM, June 7, 2009' '2009-06-07 06:00:00'
 check_approxidate '2008-12-01' '2008-12-01 19:20:00'
 check_approxidate '2009-12-01' '2009-12-01 19:20:00'
 
+# ambiguous raw timestamp
+check_approxidate '2000 +0000' '2000-08-30 19:20:00'
+check_approxidate '@2000 +0000' '1970-01-01 00:33:20'
+
 check_date_format_human() {
 	t=$(($GIT_TEST_DATE_NOW - $1))
 	echo "$t -> $2" >expect
-- 
2.53.0

