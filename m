Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E4EEA6
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498300; cv=none; b=Aj6qf+NZpr5Zc1Wv6n7qEH4IVT+Wz8sjqNg04X6K6Vr26GVLw38z3sE6QtmwpSOB5fU5Uw1/1KI0GUnxi+9J07WRxzXMYyP5O4mYwrVzOxy5cSIQpILC+bTR7tD57svqS1xZbctFQG1ovDW0C+13y+X0F5WpkR5V5EKqRZAWL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498300; c=relaxed/simple;
	bh=vsgxabWRb3QSP3uppd6LuYTB5qRiZxUS6y5f+pfKFYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfcH5h1ngd2n71PTwxzsOGsYCBukYqarsIBP+lGPUpwMJ9SkdS4IbNu8B7ULRlhgSuL4oecIkdANtTTNRwDzaFE51xe7ZnZ7169ZEbih/3pUXA/uXjBIubQkfOL6Kfyqt80ygfouEbnd/pRL0NoHB9ZO73apA+bs9urjsmsfw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27627 invoked by uid 109); 29 Jan 2024 03:18:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jan 2024 03:18:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18045 invoked by uid 111); 29 Jan 2024 03:18:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jan 2024 22:18:19 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jan 2024 22:18:16 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/2] Makefile: use order-only prereq for UNIT_TEST_BIN
Message-ID: <20240129031816.GA2433899@coredump.intra.peff.net>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129031540.GA2433764@coredump.intra.peff.net>

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

We can fix this by using an order-only prereq. This is a GNU-ism that
tells make to only care that the dependency exists at all, and to ignore
its mtime. It was designed for exactly this sort of situation (the
documentation example even uses "mkdir").

We already rely on GNU make, so that's not a problem. This particular
feature was added in GNU make 3.80, released in October 2002. This is
obviously quite old by date, but it's also worth thinking about macOS,
as Apple stopped updating packages that switched to GPLv3 tools. In this
their dev tools ship GNU make 3.81, which is recent enough.

If it is a problem, there are two alternatives:

  - we can just "mkdir -p" in the recipe to build the individual
    binaries. This will mean some redundant "mkdir" calls, but only when
    actually invoking the compiler.

  - we could stop making the directory on the fly, and just add it with
    a .gitignore of "*". This would work fine, but might be awkward when
    moving back and forth in history.

Signed-off-by: Jeff King <peff@peff.net>
---
I may be overly paranoid about the ".gitignore" strategy. I feel like
I've been bitten by this in the past by things switching from source to
build (I think with git-remote-testgit). But that's an actual built
file. Git would probably be OK with the "bin/" directory coming and
going as a tracked entity, because the index really only cares about
the file "bin/.gitignore". Still, this make fix was easy enough.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1a62e48759..958f4cd0bf 100644
--- a/Makefile
+++ b/Makefile
@@ -3866,7 +3866,7 @@ fuzz-all: $(FUZZ_PROGRAMS)
 $(UNIT_TEST_BIN):
 	@mkdir -p $(UNIT_TEST_BIN)
 
-$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS $(UNIT_TEST_BIN)
+$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS | $(UNIT_TEST_BIN)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
-- 
2.43.0.797.g29b680fc68

