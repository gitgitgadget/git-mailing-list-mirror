Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE2381D9
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706593064; cv=none; b=U9swAeDKNnDxNTgZNmkQhHHM1rblZvKBnFc9bGXkiWswISw7XeVcTjhmpfYqdCVXqurIDMxvNWWq4KEpZ/XqS1XfMUdY5eHOrCwzYWkNuWEAMZOlWryPORO8pMfW6fgEYpOhz6G1u+AazjrgaWX/SJNl+FLf/YN+OTiPTbKRCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706593064; c=relaxed/simple;
	bh=IIkPo5cFfoSCYjgULsx1zjpikU+iw0tBDEtsA9brO3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhDIA/C1invww5vgMvJUoPZGQD/YxwpGJYPDZKf4QS0J/UJQjv5yyUUUPK9jGVWLujcDFXxAKox2qT2Kj2kt773veFtqg0p9BnZ++TNQW7UNm/SlcFNTGPHqP6WgEm4zejuyOzkmbfhEyqtEvtrYCj7pjZRHAYN6lB2RnRk4Oas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8647 invoked by uid 109); 30 Jan 2024 05:37:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:37:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29088 invoked by uid 111); 30 Jan 2024 05:37:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:37:43 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:37:40 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <adam@dinwoodie.org>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: [PATCH v2 1/3] Makefile: use mkdir_p_parent_template for
 UNIT_TEST_BIN
Message-ID: <20240130053740.GA166699@coredump.intra.peff.net>
References: <20240130053714.GA165967@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130053714.GA165967@coredump.intra.peff.net>

We build the UNIT_TEST_BIN directory (t/unit-tests/bin) on the fly with
"mkdir -p". And so the recipe for UNIT_TEST_PROGS, which put their
output in that directory, depend on UNIT_TEST_BIN to make sure it's
there.

But using a normal dependency leads to weird outcomes, because the
timestamp of the directory is important. For example, try this:

  $ make
  [...builds everything...]

  [now re-build one unit test]
  $ touch t/unit-tests/t-ctype.c
  $ make
      SUBDIR templates
      CC t/unit-tests/t-ctype.o
      LINK t/unit-tests/bin/t-ctype

So far so good. Now running make again should build nothing. But it
doesn't!

  $ make
      SUBDIR templates
      LINK t/unit-tests/bin/t-basic
      LINK t/unit-tests/bin/t-mem-pool
      LINK t/unit-tests/bin/t-strbuf

Er, what? Let's rebuild again:

  $ make
      SUBDIR templates
      LINK t/unit-tests/bin/t-ctype

Weird. And now we ping-pong back and forth forever:

  $ make
      SUBDIR templates
      LINK t/unit-tests/bin/t-basic
      LINK t/unit-tests/bin/t-mem-pool
      LINK t/unit-tests/bin/t-strbuf
  $ make
      SUBDIR templates
      LINK t/unit-tests/bin/t-ctype

What happens is that writing t/unit-tests/bin/t-ctype updates the mtime
of the directory t/unit-tests/bin. And then on the next invocation of
make, all of those other tests are now older and so get rebuilt. And
back and forth forever.

We can fix this by making the directory as part of the build recipe for
the programs, using the template from 0b6d0bc924 (Makefiles: add and use
wildcard "mkdir -p" template, 2022-03-03).

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 0f748a52e6..228f34a3fe 100644
--- a/Makefile
+++ b/Makefile
@@ -3868,10 +3868,8 @@ $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
 
 fuzz-all: $(FUZZ_PROGRAMS)
 
-$(UNIT_TEST_BIN):
-	@mkdir -p $(UNIT_TEST_BIN)
-
-$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS $(UNIT_TEST_BIN)
+$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS
+	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
-- 
2.43.0.797.g29b680fc68

