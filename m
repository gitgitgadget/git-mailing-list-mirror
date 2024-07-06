Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178C1C687
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246077; cv=none; b=mxMdWNi2n6Rugm4xePsweVpjABiEqQ+YNB5zHlFsjHrB0UMU8XyqyFKobopty+4MOlLl5Bv9vycAlGmna4WpcqjyUtR0mCPxOkRBtU0Su1ADoc1F2ldOK1+ztoNwmw2ACexCfkyXZePUghZgCtRSeFOCY3++c1vA6lDXw08yJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246077; c=relaxed/simple;
	bh=+UTQxaJaU3JdW5h66QD7aa/4oVPLHvDmA+MWaC31rG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3Lf+4+IbTuAwZBnCkCPGRCzaxTagZz/kRbGWwz19PiJq/bs6FXSEUSaSxTa2pyWWvgGIqm6xkrN1wWNXaHTx43865kfCTIVfWBQotZx0ItM1UsYRkjUGl2hzSQjitTPYJ9S0Px3lUnjmBuiX+TQuxMuq8Jrz/Pu/YFPYszxFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23365 invoked by uid 109); 6 Jul 2024 06:07:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:07:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31174 invoked by uid 111); 6 Jul 2024 06:07:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:07:53 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:07:54 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] t/chainlint: add tests for test body in heredoc
Message-ID: <20240706060754.GC700151@coredump.intra.peff.net>
References: <20240706060143.GD698153@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706060143.GD698153@coredump.intra.peff.net>

The chainlint.pl script recently learned about our new:

  test_expect_success 'some test' - <<\EOT
	TEST_BODY
  EOT

syntax, where TEST_BODY should be checked in the usual way. Let's make
sure this works by adding a few tests. The "here-doc-body" file tests
the basic syntax, including an embedded here-doc which we should still
be able to recognize.

Likewise the "here-doc-body-indent" checks the same thing, but using the
"<<-" operator. We wouldn't expect this to be used normally, but we
would not want to accidentally miss a body that uses it.

The "here-doc-double" tests the handling of two here-doc tags on the
same line. This is not something we'd expect anybody to do in practice,
but the code was written defensively to handle this, so let's make sure
it works.

Signed-off-by: Jeff King <peff@peff.net>
---
These could also be squashed into Eric's patch which introduces the new
functionality.

 t/chainlint/here-doc-body-indent.expect |  2 ++
 t/chainlint/here-doc-body-indent.test   |  4 ++++
 t/chainlint/here-doc-body.expect        |  7 +++++++
 t/chainlint/here-doc-body.test          |  9 +++++++++
 t/chainlint/here-doc-double.expect      |  2 ++
 t/chainlint/here-doc-double.test        | 10 ++++++++++
 6 files changed, 34 insertions(+)
 create mode 100644 t/chainlint/here-doc-body-indent.expect
 create mode 100644 t/chainlint/here-doc-body-indent.test
 create mode 100644 t/chainlint/here-doc-body.expect
 create mode 100644 t/chainlint/here-doc-body.test
 create mode 100644 t/chainlint/here-doc-double.expect
 create mode 100644 t/chainlint/here-doc-double.test

diff --git a/t/chainlint/here-doc-body-indent.expect b/t/chainlint/here-doc-body-indent.expect
new file mode 100644
index 0000000000..ba280af56e
--- /dev/null
+++ b/t/chainlint/here-doc-body-indent.expect
@@ -0,0 +1,2 @@
+	echo "we should find this" ?!AMP?!
+	echo "even though our heredoc has its indent stripped"
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
diff --git a/t/chainlint/here-doc-body.expect b/t/chainlint/here-doc-body.expect
new file mode 100644
index 0000000000..3d21ad2fd6
--- /dev/null
+++ b/t/chainlint/here-doc-body.expect
@@ -0,0 +1,7 @@
+	echo "missing chain before" ?!AMP?!
+	cat >file <<-\EOF &&
+	inside inner here-doc
+	these are not shell commands
+	EOF
+	echo "missing chain after" ?!AMP?!
+	echo "but this line is OK because it's the end"
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
index 0000000000..e164050d06
--- /dev/null
+++ b/t/chainlint/here-doc-double.expect
@@ -0,0 +1,2 @@
+	echo "actual test commands" ?!AMP?!
+	echo "that should be checked"
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
2.45.2.1178.gaaad15bb7b
