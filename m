Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6E2E3716
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160101; cv=none; b=lc61c+xx9F1bPHKxF3EHSUDNihWPRx9Xa3JlodYgzhQ45tBDUkjtdcfSiRd/z1k1QhyeOgfX7CTlf30H9G6BKtmYxWfeNQ+Sulwvi9XZMdUvs0NFclVXNpdlFKuh48hpMrPjgB221DYWE1nP5KVwLhVVIApvSRCOAi9JIIwHsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160101; c=relaxed/simple;
	bh=6d6zv1WJYyGMUykL2vlsHqNZpUsV1TSUAKywhe26thE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvXBJziL6cBtboC77pIbYicDbA/GEytp29PiO6eEYb4Cqt+qnI6Xw5x+qBSfk1YW2wCUF0OhJs1JLqewGWUOAXd2dmBJiJHoepQwGo5R35cpw0Oli3zhlRdNzYEwnMTj1eijt3kTmDH7C4rzDpSnzXVM4LWrXjPtG35hsUUHC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c4yawvOr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c4yawvOr"
Received: (qmail 25607 invoked by uid 109); 22 Jul 2025 04:54:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6d6zv1WJYyGMUykL2vlsHqNZpUsV1TSUAKywhe26thE=; b=c4yawvOrxaD6LDpiYXVQKSSn+ujRcKk/J6zUgcLbxY8c2GoR82sdq7PfClpe7odrs3iq+r3OrDK4tHd7X+vFiS5BWPgSMsISZB8OrEfGIykGej5ojwu8wMh3kXSyp0zZ3ipu7aCAOqTHhyrb1ZmndAlAsAxz+V+AbpQEztd26gZIxtb9PnXiVqxiIfE2fhIlwA5hUapOkKUu6M27Mwm9JK9trSATuIjs+UfMOOQH7me6/nl4Zwyat6IkyCaJ9WLfw/AEUZHfRId9PHoOg9Hge+uOJhItaJbSpYVvWmXcjNtpb5MCY0N4j4M6PejHXrEKBF7kzkeWA+c5kALUqnTt+Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 04:54:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24040 invoked by uid 111); 22 Jul 2025 04:55:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 00:55:01 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 00:54:56 -0400
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] reflog: close leak of reflog expire entry
Message-ID: <20250722045456.GA824456@coredump.intra.peff.net>
References: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>

On Mon, Jul 21, 2025 at 04:39:37PM -0700, Jacob Keller wrote:

> Changes in v3:
> - Remove the incorrect call in reflog_expiry_cleanup()
> - Add a call in reflog_expire_condition()
> - Link to v2: https://lore.kernel.org/r/20250709-jk-fix-leak-reflog-expire-config-v2-1-f9af934be8c1@gmail.com

This looks correct to me except...

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 845876ff0286..37f543736599 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -346,6 +346,7 @@ static int reflog_expire_condition(struct gc_config *cfg UNUSED)
>  				 count_reflog_entries, &data);
>  
>  	reflog_expiry_cleanup(&data.policy);
> +	reflog_clear_expire_config(&data.policy);
>  	return data.count >= data.limit;
>  }
>  

This needs to pass &data.policy.opts, no?

I think we might also want this test on top (or I'd be happy to see it
squashed in). It shows off your fix when built with SANITIZE=leak, and
also catches the bug that v2 of your patch had.

-Peff

-- >8 --
Subject: [PATCH] t1410: add test of gc.<pattern>.reflogExpire config

We have long supported the ability to set reflog expiration config for
individual, going back to 3cb22b8efe (Per-ref reflog expiry
configuration, 2008-06-15). But we have never had any tests.

Let's add a very basic one that checks that we apply the config
correctly to a subset of refs (and not elsewhere). This also
triggers the leaky code fixed by the previous commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1410-reflog.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 42b501f163..362e90d7d6 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -320,6 +320,34 @@ test_expect_success 'git reflog expire unknown reference' '
 	test_grep "error: reflog could not be found: ${SQ}does-not-exist${SQ}" stderr
 '
 
+test_expect_success 'expire with pattern config' '
+	# Split refs/heads/ into two roots so we can apply config to each. Make
+	# two branches per root to verify that config is applied correctly
+	# multiple times.
+	git branch root1/branch1 &&
+	git branch root1/branch2 &&
+	git branch root2/branch1 &&
+	git branch root2/branch2 &&
+
+	test_config "gc.reflogexpire" "never" &&
+	test_config "gc.refs/heads/root2/*.reflogExpire" "now" &&
+	git reflog expire \
+		root1/branch1 root1/branch2 \
+		root2/branch1 root2/branch2 &&
+
+	cat >expect <<-\EOF &&
+	root1/branch1@{0}
+	root1/branch2@{0}
+	EOF
+	git log -g --branches="root*" --format=%gD >actual.raw &&
+	# The sole reflog entry of each branch points to the same commit, so
+	# the order in which they are shown is nondeterministic. We just care
+	# about the what was expired (and what was not), so sort to get a known
+	# order.
+	sort <actual.raw >actual.sorted &&
+	test_cmp expect actual.sorted
+'
+
 test_expect_success 'checkout should not delete log for packed ref' '
 	test $(git reflog main | wc -l) = 4 &&
 	git branch foo &&
-- 
2.50.1.589.g6e88b11be3

