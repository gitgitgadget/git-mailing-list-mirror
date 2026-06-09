Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93E3FD121
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003400; cv=none; b=HL8imc42IsXFofEipEZ5ZKwfkeozmzowDTsMbjImAAjIVgQISrRD9QxpzePPhRklqyKr+Ij5hul/+GvWxilCoMyaCAQ19xOCpOtDRgmpgUecxNlXcBUJ0I4fd2/vCZlOWbolHl7UfTTnJWhlbEIzIWxgipIRCHY2A52uTdwoRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003400; c=relaxed/simple;
	bh=kNbVNwqWxsR4I5YUMKJBtbsm4A3TVIT5vyZV7hJ59ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaHUDkDD6FPbK9YzMTFhFtickyampQbID/P6tn3BzKXr4KfK8SXCOc//K/hzHAI4xxM4Mp3WrwSS/wnJyZPylBE6vjnA9Hj2jmk4Ycg3iKIF80Euu80jGVvpbv81sm4oDyAcw6Wrew528v8v9FboXF5xXjT5vsxEUuTvo280hxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YuHfPYaP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YuHfPYaP"
Received: (qmail 87365 invoked by uid 106); 9 Jun 2026 11:09:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=kNbVNwqWxsR4I5YUMKJBtbsm4A3TVIT5vyZV7hJ59ys=; b=YuHfPYaP5KR0zhHPNqTKzFKiAb0dLQTlv0ENh1t6yBNwHHcmbaCrBLf+wjZNyKj2Mp5cOsuiPVKRsk3eejr+DYZz08M6KUhtJ2HSuw9DfkUehiWysUsyCFflaxQci8AkIqr9rb4hLj9YeBxR0dGq+CVrOzsztbf+4KqN3nE6iu5wcrp06tBLHwMyapgNKfXgbBrX3NgB/XTQAb0qql9+yuztVJ/abK9uZAA/Rw5axh/pY3SS2iJ+oCAXNPT4WlI2vlyZPdPQjaraR2BOR2qIQtJ4clBTFCbsZuVURoMLV4m8QbiujKiu74aFRhK0TQVOsm2AW4b8CLeq+P0WrGz89Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jun 2026 11:09:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 262828 invoked by uid 111); 9 Jun 2026 11:09:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jun 2026 07:09:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jun 2026 07:09:57 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] describe: limit default ref iteration to tags
Message-ID: <20260609110957.GB1509396@coredump.intra.peff.net>
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>

On Mon, Jun 08, 2026 at 07:32:14PM -0700, Tamir Duberstein wrote:

> The benchmark checkout had 120,532 refs, of which 330 were tags. With
> `$repo` naming the checkout, `$commit` an exactly tagged commit, and
> `$parent` and `$this` the two binaries, I ran:
> 
>     hyperfine --warmup 3 --runs 15 \
>         --command-name parent \
>         '$parent -C $repo describe --exact-match $commit' \
>         --command-name 'this commit' \
>         '$this -C $repo describe --exact-match $commit'
> 
> The results were:
> 
>     Benchmark 1: parent
>       Time (mean ± σ):     171.7 ms ±  18.5 ms    [User: 23.9 ms, System: 133.6 ms]
>       Range (min … max):   142.3 ms … 198.3 ms    15 runs
> 
>     Benchmark 2: this commit
>       Time (mean ± σ):       9.9 ms ±   1.1 ms    [User: 3.3 ms, System: 4.7 ms]
>       Range (min … max):     8.8 ms …  13.1 ms    15 runs
> 
>     Summary
>       this commit ran
>        17.35 ± 2.63 times faster than parent
> 
> Both revisions were built with -O3, -mcpu=native, and ThinLTO using
> Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
> (Mac16,6) with a 16-core Apple M4 Max (12 performance and four
> efficiency cores) and 128 GB RAM.

This patch looks fine to me, but let me pick a nit for a minute, because
I think there is a broader conversation to be had.

Given the discussion in earlier rounds and sibling topics, I assume the
commit message here was AI-generated. And it's OK in the sense that it
is describing what happened and I assume is entirely accurate. But as a
human reader, it feels so much more verbose than what I'd expect, as it
is full of semi-irrelevant details. Why set --warmup and --runs? Why
bother with --command-name, which just means you have to show the
commands separately anyway? Is the amount of RAM in the machine
important for this test? Surely it could be if it was absurdly tiny, but
in general, no, I would not expect it to be.

So while it is perhaps reasonable to document every detail in case
somebody later wants to verify or reproduce timings, it is a little
overwhelming when trying to tell a story, the core of which is:

  In a repo with ~120k refs, ~300 of which were tags, running:

    git describe --exact-match $some_tag

  went from ~170ms to ~10ms, since we no longer needed to iterate all of
  those other refs.

That has _way_ less detail, but makes the point succinctly.

I dunno. I am not trying to pick apart your commit in particular, but am
more interested in the broader use of AI commit messages going forward.
This kind of verbosity is quite common in the output (from my limited
experience), and I think creates more work for reviewers. Should we be
expecting contributors to make things more concise before submitting
(either manually or through prompting)? Or do people even agree that the
shorter version is preferable? I could be the only one.

I have a few other comments on the patch itself below.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index 1c47d7c0b7..3532c8ff22 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -740,6 +740,9 @@ int cmd_describe(int argc,
>  		return ret;
>  	}
>  
> +	if (!all)
> +		for_each_ref_opts.prefix = "refs/tags/";
> +
>  	hashmap_init(&names, commit_name_neq, NULL, 0);
>  	refs_for_each_ref_ext(get_main_ref_store(the_repository),
>  			      get_name, NULL, &for_each_ref_opts);

The code change looks fine. It creates a bit of a subtle dependency
between what's happening here, and the filtering inside get_name(). But
I think that's OK for the scope of a single command. It _might_ be
possible to simplify the top of get_name(), since we'd no longer see
non-tag refs in the input. But it also may not, since we have to strip
out the prefix anyway. It can certainly come on top as a cleanup later
if we want.

> diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh

It is a little curious that we add a perf test here, but the commit
message does not even show it off. ;)

I ran it myself here and had trouble showing improvement, simply because
it is already quite fast! I guess that's because I'm on Linux, where
warm-cache filesystem operations are pretty fast. Bumping $ref_count by
a factor of 10 made the "before" case 30ms, and after is still sub-1ms.

> +test_expect_success 'set up many unrelated refs' '
> +	ref_count=10000 &&
> +	git tag -m tip tip HEAD &&
> +	for i in $(test_seq $ref_count)
> +	do
> +		printf "create refs/heads/describe-perf/%05d HEAD\n" $i ||
> +		return 1
> +	done >instructions &&
> +	git update-ref --stdin <instructions
> +'

A few things come to mind on reading this.

I have mixed feelings on sticking synthetic constructions in the t/perf
suite. Part of the original point was that we'd run it against real
repos to see how they perform. But that implies that people running it
have some clue about which tests may be interesting on which repos,
which is hopeful at best. So we've turned to this kind of synthetic
construction at times (and this is certainly not the first). It's
probably a reasonable tactic here.

I suspect the resulting state is not all that realistic, though. If you
have 10,000 refs, you probably didn't make them all at once. And so in
practice the majority of them would be packed. Sticking "git pack-refs
--all" at the end might give more realistic numbers.

Bumping to a larger number of refs shows the effect more clearly, but at
the cost of making the setup take a long time (since we have to take a
lockfile on each ref!). We could sneak around it by generating a
packed-refs file directly, but now the test really would be
backend-specific. Probably better not to go there.

And finally, the loop can be written a bit more succinctly these days
as:

diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh
index ed9f1abe18..b365dc67ee 100755
--- a/t/perf/p6100-describe.sh
+++ b/t/perf/p6100-describe.sh
@@ -30,12 +30,8 @@ test_perf 'describe HEAD with one tag' '
 test_expect_success 'set up many unrelated refs' '
 	ref_count=10000 &&
 	git tag -m tip tip HEAD &&
-	for i in $(test_seq $ref_count)
-	do
-		printf "create refs/heads/describe-perf/%05d HEAD\n" $i ||
-		return 1
-	done >instructions &&
-	git update-ref --stdin <instructions
+	test_seq -f "create refs/heads/describe-perf/%05d HEAD" $ref_count |
+	git update-ref --stdin
 '
 
 test_perf 'describe exact tag with many unrelated refs' '


Probably not worth re-rolling on its own, though.

-Peff
