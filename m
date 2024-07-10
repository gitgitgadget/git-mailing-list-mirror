Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE1127B56
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600760; cv=none; b=qtVpA0a1Fsv3kuXjKcd/agJuWG1842vaY5LJ44E2W/SXpyrcLtEZ6p6Y9DXRkKmDTmWodJa1gN64r4lx/xqbw6cBXX12c3zJN+pNj6LjRT45jYIs22u/EoaXBP93RgufkdAaxGp5hDFXCRjMLeZHAGmKsYFI2ckCDlRCk0X7hFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600760; c=relaxed/simple;
	bh=mZgpRK3vX4gXgRCNZ0JquoXYJpZOaLKNaSWtWs6Atrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNhuziasYUtFlBo5iRCxVIEJcNcMWmRUE0Qaxop+bSQFfsfAXY7hAudPb3Q1BeexU3bu7V7r/3HiheBIEHhhxftniYCYHG6jLOBgA3xqv+tXK6DOE9yiysqdiRHdgKFLWLkwbGazmZk88JwMWcbQUQNunTVe/kPWEYB5h6HkgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1703 invoked by uid 109); 10 Jul 2024 08:39:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 08:39:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10461 invoked by uid 111); 10 Jul 2024 08:39:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 04:39:14 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 04:39:16 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 7/9] chainlint.pl: add tests for test body in heredoc
Message-ID: <20240710083916.GG2060601@coredump.intra.peff.net>
References: <20240710083416.GA2060328@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710083416.GA2060328@coredump.intra.peff.net>

The chainlint.pl script recently learned about the upcoming:

  test_expect_success 'some test' - <<\EOT
	TEST_BODY
  EOT

syntax, where TEST_BODY should be checked in the usual way. Let's make
sure this works by adding a few tests. The "here-doc-body" file tests
the basic syntax, including an embedded here-doc which we should still
be able to recognize.

Likewise the "here-doc-body-indent" checks the same thing, but using the
"<<-" operator. We wouldn't expect this to be used normally, but we
would not want to accidentally miss a body that uses it. The
"pathological" variant checks the opposite: we don't get confused by an
indented tag within the here-doc body.

The "here-doc-double" tests the handling of two here-doc tags on the
same line. This is not something we'd expect anybody to do in practice,
but the code was written defensively to handle this, so let's make sure
it works.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/chainlint/here-doc-body-indent.expect       |  2 ++
 t/chainlint/here-doc-body-indent.test         |  4 ++++
 t/chainlint/here-doc-body-pathological.expect |  7 +++++++
 t/chainlint/here-doc-body-pathological.test   |  9 +++++++++
 t/chainlint/here-doc-body.expect              |  7 +++++++
 t/chainlint/here-doc-body.test                |  9 +++++++++
 t/chainlint/here-doc-double.expect            |  2 ++
 t/chainlint/here-doc-double.test              | 10 ++++++++++
 8 files changed, 50 insertions(+)
 create mode 100644 t/chainlint/here-doc-body-indent.expect
 create mode 100644 t/chainlint/here-doc-body-indent.test
 create mode 100644 t/chainlint/here-doc-body-pathological.expect
 create mode 100644 t/chainlint/here-doc-body-pathological.test
 create mode 100644 t/chainlint/here-doc-body.expect
 create mode 100644 t/chainlint/here-doc-body.test
 create mode 100644 t/chainlint/here-doc-double.expect
 create mode 100644 t/chainlint/here-doc-double.test

diff --git a/t/chainlint/here-doc-body-indent.expect b/t/chainlint/here-doc-body-indent.expect
new file mode 100644
index 0000000000..4323acc93d
--- /dev/null
+++ b/t/chainlint/here-doc-body-indent.expect
@@ -0,0 +1,2 @@
+2 	echo "we should find this" ?!AMP?!
+3 	echo "even though our heredoc has its indent stripped"
diff --git a/t/chainlint/here-doc-body-indent.test b/t/chainlint/here-doc-body-indent.test
new file mode 100644
index 0000000000..39ff970ef3
--- /dev/null
+++ b/t/chainlint/here-doc-body-indent.test
@@ -0,0 +1,4 @@
+test_expect_success 'here-doc-body-indent' - <<-\EOT
+	echo "we should find this"
+	echo "even though our heredoc has its indent stripped"
+EOT
diff --git a/t/chainlint/here-doc-body-pathological.expect b/t/chainlint/here-doc-body-pathological.expect
new file mode 100644
index 0000000000..a93a1fa3aa
--- /dev/null
+++ b/t/chainlint/here-doc-body-pathological.expect
@@ -0,0 +1,7 @@
+2 	echo "outer here-doc does not allow indented end-tag" ?!AMP?!
+3 	cat >file <<-\EOF &&
+4 	but this inner here-doc
+5 	does allow indented EOF
+6 	EOF
+7 	echo "missing chain after" ?!AMP?!
+8 	echo "but this line is OK because it's the end"
diff --git a/t/chainlint/here-doc-body-pathological.test b/t/chainlint/here-doc-body-pathological.test
new file mode 100644
index 0000000000..7d2daa44f9
--- /dev/null
+++ b/t/chainlint/here-doc-body-pathological.test
@@ -0,0 +1,9 @@
+test_expect_success 'here-doc-body-pathological' - <<\EOF
+	echo "outer here-doc does not allow indented end-tag"
+	cat >file <<-\EOF &&
+	but this inner here-doc
+	does allow indented EOF
+	EOF
+	echo "missing chain after"
+	echo "but this line is OK because it's the end"
+EOF
diff --git a/t/chainlint/here-doc-body.expect b/t/chainlint/here-doc-body.expect
new file mode 100644
index 0000000000..ddf1c412af
--- /dev/null
+++ b/t/chainlint/here-doc-body.expect
@@ -0,0 +1,7 @@
+2 	echo "missing chain before" ?!AMP?!
+3 	cat >file <<-\EOF &&
+4 	inside inner here-doc
+5 	these are not shell commands
+6 	EOF
+7 	echo "missing chain after" ?!AMP?!
+8 	echo "but this line is OK because it's the end"
diff --git a/t/chainlint/here-doc-body.test b/t/chainlint/here-doc-body.test
new file mode 100644
index 0000000000..989ac2f4e1
--- /dev/null
+++ b/t/chainlint/here-doc-body.test
@@ -0,0 +1,9 @@
+test_expect_success 'here-doc-body' - <<\EOT
+	echo "missing chain before"
+	cat >file <<-\EOF &&
+	inside inner here-doc
+	these are not shell commands
+	EOF
+	echo "missing chain after"
+	echo "but this line is OK because it's the end"
+EOT
diff --git a/t/chainlint/here-doc-double.expect b/t/chainlint/here-doc-double.expect
new file mode 100644
index 0000000000..20dba4b452
--- /dev/null
+++ b/t/chainlint/here-doc-double.expect
@@ -0,0 +1,2 @@
+8 	echo "actual test commands" ?!AMP?!
+9 	echo "that should be checked"
diff --git a/t/chainlint/here-doc-double.test b/t/chainlint/here-doc-double.test
new file mode 100644
index 0000000000..777389f0d9
--- /dev/null
+++ b/t/chainlint/here-doc-double.test
@@ -0,0 +1,10 @@
+# This is obviously a ridiculous thing to do, but we should be able
+# to handle two here-docs on the same line, and attribute them
+# correctly.
+test_expect_success "$(cat <<END_OF_PREREQS)" 'here-doc-double' - <<\EOT
+SOME
+PREREQS
+END_OF_PREREQS
+	echo "actual test commands"
+	echo "that should be checked"
+EOT
-- 
2.45.2.1249.gb036353db5

