Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565B20126E
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955157; cv=none; b=S0l7HYUDr1ACmC7LMc02PHN1/sYSOSPMot76O2b3M36K8YPM+hnVluVRL8N6wCc9oZc8W9PsmS8rigpeXjTKn+gMhQlM1OgCDDvFJuQCPXTmZ6BStHk4Bs0uCjM7/xx2VQneW+e1OF0cKkcCsQ/ivzxhnga3BT52UDOLLBRxw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955157; c=relaxed/simple;
	bh=QD8GiOujyg2airh7KD9prxAGAX4ItL88OqqO9sWW0HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lif1xx3mq5+ubjxhWboaOU5K0Ymkk3rodAqvgga9cHifkRQkCUe9Fpd7CDXddJHHcNVjTZKiCsf+3Sogayo9hkEoxe0NTs/nnarOsXWSbgDZMUV4fMAerFQuAM9aUYcrlHXQ+WfU/agki2NSvZZp5PLhnLd5iP6FUD61OlB90d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8659 invoked by uid 109); 2 Jul 2024 21:19:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jul 2024 21:19:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28895 invoked by uid 111); 2 Jul 2024 21:19:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jul 2024 17:19:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jul 2024 17:19:13 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240702211913.GB120950@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net>
 <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702005144.GA27170@coredump.intra.peff.net>

On Mon, Jul 01, 2024 at 08:51:44PM -0400, Jeff King wrote:

> Obviously we'd want to add to the chainlint tests here. It looks like
> the current test infrastructure is focused on evaluating snippets, with
> the test_expect_success part already handled.

So doing this (with the patch I showed earlier):

diff --git a/t/Makefile b/t/Makefile
index b2eb9f770b..7c97aa3673 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -106,18 +106,28 @@ clean: clean-except-prove-cache
 clean-chainlint:
 	$(RM) -r '$(CHAINLINTTMP_SQ)'
 
+CHAINLINTTESTS_SRC = $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS))
 check-chainlint:
 	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
 	for i in $(CHAINLINTTESTS); do \
 		echo "test_expect_success '$$i' '" && \
 		sed -e '/^# LINT: /d' chainlint/$$i.test && \
 		echo "'"; \
 	done >'$(CHAINLINTTMP_SQ)'/tests && \
+	for i in $$(grep -L "'" $(CHAINLINTTESTS_SRC)); do \
+		echo "test_expect_success '$$i' - <<\\\\EOT" && \
+		sed -e '/^# LINT: /d' $$i && \
+		echo "EOT"; \
+	done >>'$(CHAINLINTTMP_SQ)'/tests && \
 	{ \
 		echo "# chainlint: $(CHAINLINTTMP_SQ)/tests" && \
 		for i in $(CHAINLINTTESTS); do \
 			echo "# chainlint: $$i" && \
 			cat chainlint/$$i.expect; \
+		done && \
+		for i in $$(grep -L "'" $(CHAINLINTTESTS_SRC)); do \
+			echo "# chainlint: $$i" && \
+			cat $${i%.test}.expect; \
 		done \
 	} >'$(CHAINLINTTMP_SQ)'/expect && \
 	$(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \

does pass. It's just running all of the tests inside an "EOT" block. But
we have to omit ones that have single quotes in them, because they are
making the implicit assumption that they're inside a single-quoted block
(so they do things like '"$foo"', or '\'', etc, which behave differently
in a here-doc).

It was a nice check that the output is the same in both cases, but it's
a bit limiting as a test suite, as there's no room to introduce test
cases that vary the test_expect_success lines. I'm thinking the path
forward may be:

  1. Move the test_expect_success wrapping lines into each
     chainlint/*.test file. It's a little bit of extra boilerplate, but
     it makes them a bit easier to reason about on their own.

  2. Add a few new tests that use here-docs with a few variations
     ("<<EOT", "<<\EOT", probably a here-doc inside the test here-doc).

Does that sound OK to you?

-Peff
