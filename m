Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2E19B
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705717905; cv=none; b=ji7PmgKBCNDRA6Sj1Y9EJiMiSHW3pCbWYMw+cLVbrtQQ03N6a5XrM360dw63L5oHpJFqezj83iDFC3qmeJTctjLy5kKYR/khr5jEEE2A6ImeuMQOlhE1Vd4jxfVXXrkdheO+Q9L951RYe45UX42cS28KmlidCjnxKYcRDzzHXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705717905; c=relaxed/simple;
	bh=2BDdn1U2DJCCkMxpSwhQUkqkwgf1iHXsdAp67hAiWIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+3fbx+Oi2CNSNy6gYzHp2B/g3tyTPtUQtqzufbVNow5CXoFFVvVfWbXWyfobZG1g923MyPktn4MgTPqsQqLczhe3q81KCQUex+8RGRVKuhQFm1RnUzELMOiAB8OQre2bJkpHz902EsWFCnrYfB6C97QBjVBimTCxvtdBUpWjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1184 invoked by uid 109); 20 Jan 2024 02:31:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Jan 2024 02:31:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7576 invoked by uid 111); 20 Jan 2024 02:31:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jan 2024 21:31:43 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Jan 2024 21:31:41 -0500
From: Jeff King <peff@peff.net>
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap3519@gmail.com>,
	Chandra Pratap <chandrapratap376@gmail.com>
Subject: Re: [PATCH v3] tests: move t0009-prio-queue.sh to the new unit
 testing framework
Message-ID: <20240120023141.GA610247@coredump.intra.peff.net>
References: <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>
 <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>

On Wed, Jan 17, 2024 at 02:38:23PM +0000, Chandra Pratap via GitGitGadget wrote:

> +#define TEST_INPUT(INPUT, EXPECTED, name)			\
> +  static void test_##name(void)				\
> +{								\
> +	int input[] = {INPUT};					\
> +	int expected[] = {EXPECTED};				\
> +	int result[ARRAY_SIZE(expected)];			\
> +	test_prio_queue(input, result);				\
> +	check(!memcmp(expected, result, sizeof(expected)));	\
> +}

It is somewhat unfortunate that a failing test here gives a fairly
uninformative message like:

  # check "!memcmp(expected, result, sizeof(expected))" failed at t/unit-tests/t-prio-queue.c:89
  not ok 5 - prio-queue works when LIFO stack is reversed

whereas the original t0009 you get a nice diff between expected and
actual output. I guess this is a place where the test framework could
help us more with a specialized check_memequal() or something that
showed the differing bytes on failure (of course being C, it has no type
info so it wouldn't even know these are ints!).

Another solution would be to have the test function check the result as
it is computed rather than storing it in an array. That would also solve
another potential problem: undefined behavior if the result is not the
expected size. If there is a bug that causes too much output we'd
overflow our buffer. If too few, we'll end up comparing uninitialized
memory (which could even accidentally have the correct values,
especially if it's recycled from a previous test!). Neither of those
should happen in practice, but then the whole point of this exercise is
to test the code.

I admit I find myself a little skeptical in general of this whole "let's
do tests in C" framework.

-Peff
