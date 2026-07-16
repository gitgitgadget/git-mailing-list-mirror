Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326EC369D68
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202142; cv=none; b=fODoyj0tTQ9nH4MNIiN8xf1ypKfg0xgsDE6Y5s5nXtgV7SM8FU0WZ/BH07Xxpeh5bR3d7oFmjp2UuKcZYg6Z8K1Cw6OIks+LxrAk92vEXKJAJAJMHngqR2omgFMq7Y5mnzJmazgYZPWR9fv4zJE8tFompCwDMU/YGZuVnTHYfHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202142; c=relaxed/simple;
	bh=83bSLEjf52Ue6Rgq5+VZE4fk4L9VJo+UsycgQ0OwifU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NjclDsDxPW+rdaXdqTFJ52tIlK0KcI8xAjnHjxwJlSnAUVcUGTxOsDbt+HqzRA+VTL9o7Rjo0RD61DFgqHV9976W1RZUzFeyaDWj0q8zRGFbP/JFSTfJV+U0V68G8wBqAVNJnYcpwdUBc1/yV1WlzGaJSBUmcbTBhTYKatTF4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=UPwliEBW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="UPwliEBW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784202134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DC6WRzwobtMB80POoBfA4VAajdOMJe24vdBsFWaxcGE=;
	b=UPwliEBW23OautNY2A6tai+GoeJLeOGV1dtP/mVSMonVDoqnKOOfI0yWsKO+A8o71Q6I49
	Sz3y+yyRc3BKVDhWHJ65jdk63DiPc7wnApD5bG0DanhmxBxEdlRarIO/wL2bC9RgO0KZbO
	A/y2fO9UiFVue1qDBzAVOu54TA0e7IA=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>, Gusted <gusted@codeberg.org>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: git-last-modified(1) slower than git-log(1)?
In-Reply-To: <20260716042808.GA1151612@coredump.intra.peff.net>
References: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>
 <20260716042808.GA1151612@coredump.intra.peff.net>
Date: Thu, 16 Jul 2026 13:42:04 +0200
Message-ID: <87se5jf9f7.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> On Tue, Jul 14, 2026 at 08:33:59PM +0200, Gusted wrote:
>
>> The repository I'm currently using to evaluate the performance is
>> https://codeberg.org/ziglang/zig
>>=20
>> Reproduction steps:
>> 1. `git clone https://codeberg.org/ziglang/zig $(mktemp -d)`
>> 2. cd to tmp directory.
>> 3. `git commit-graph write --changed-paths`. As git-last-modified(1)
>> makes good use of the bloom filters.
>> 4. `hyperfine 'git last-modified -z -t --max-depth=3D0
>> 80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- doc/langref/' 'git log
>> --name-status -c "--format=3Dcommit%x00%H %P%x00" --parents --no-renames
>> -t -z 80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- ":(literal)doc/langref=
"'`
>
> Thanks for this concrete reproduction. I can see the same problem
> here.

As I mentioned, I was aware of that issue, but never felt the need (and
didn't have the deep Bloom filter knowledge) to fix it.

> Interestingly, if we turn off changed-paths, we get very different
> results.
>
> Without a commit graph at all, last-modified wins (this is using the zig
> repo and the commands above):
>
>   - log: 150ms
>   - last-modified: 79ms
>
> But with a graph and no changed-paths, they're about equal:
>
>   - log: 61ms
>   - last-modified: 61ms
>
> And then with changed-paths, the log command gets much faster but
> last-modified gets slower!
>
>   - log: 20ms
>   - last-modified: 64ms
>
> I think there's a tradeoff in the way that last-modified uses the bloom
> filters. It makes a key for every path we're interested in, and then for
> each commit, we check each key to say "is this in the commit's filter?".
>
> So if you have a subdirectory with a non-trivial number of entries (like
> doc/langref here which has 290), but most commits don't touch that path
> at all (only 120 out of ~39k in this case), we'll spend a lot of time
> checking each key against each filter. We save ourselves opening the
> trees, but at the cost of 290*39k filter comparisons).
>
> Whereas in the git-log case, we make a filter key out of the single
> pathspec we're given, and then check each commit against that. So we
> only do a single filter check for each commit to narrow it down to those
> 120 that matter (modulo a few filter false positives).

Oh, that's very useful of you to explain this. Thank you.

> But I don't see any reason that last-modified couldn't _also_ do that:
> pre-filter the commits with a commit matching the original pathspec, and
> discard most commits with a single filter check.
>
> The hacky patch below does this, and brings my last-modified runtime
> down to 16ms (a 4x improvement, and just a bit faster than git-log).

Funny, I was toying around with my AI agent, and they came with a
similar solution, but I'm working on a cleaner solution.

> It tries to reuse the logic from revision.c, so it's doing the exact
> same filtering that git-log would do. I think there are other ways to do
> it. E.g., we could make our own "root" bloom key that contains all of
> the paths and pre-filter with that. But it seemed to be a little slower
> when I tried it (~24ms). I'd guess that the problem is that because the
> bloom filter is probabilistic, if you shove too many items into a single
> key you'll end getting more and more false positives. So putting all 290
> entries into one key is too much, and we are better off just considering
> the shared prefix.
>
> Anyway, here's the patch. Toon, I'm not planning to take it further
> immediately, but you may be interested in poking at it. It probably
> needs at least:
>
>   - some light refactoring of revision.c

Agreed.

>   - tests? We don't seem to cover last-modified with changed-paths at
>     all, and just rely on the test-vars CI job which sets
>     GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS. It did pass for me with that
>     flag, so surely I didn't introduce any bugs. :)

Fair of you calling that out. Thanks for checking.

>   - more timing exploration; e.g., might it make things worse if
>     doc/langref were touched in 99% of the commits? Probably not, but it
>     might be nice to check timings against a few repo shapes and request
>     depths.

Maybe, I tried a few things.

On gitlab-org/gitlab (our Rails monolith), there seems to be a noticable
improvement when running for `app/`:

    Benchmark 1: old
      Time (mean =C2=B1 =CF=83):     435.5 ms =C2=B1   9.8 ms    [User: 369=
.5 ms, System: 64.4 ms]
      Range (min =E2=80=A6 max):   425.3 ms =E2=80=A6 450.9 ms    5 runs
=20=20=20=20=20
    Benchmark 2: new
      Time (mean =C2=B1 =CF=83):     278.5 ms =C2=B1  32.3 ms    [User: 208=
.0 ms, System: 69.3 ms]
      Range (min =E2=80=A6 max):   246.2 ms =E2=80=A6 314.8 ms    5 runs
=20=20=20=20=20
    Summary
      new ran
        1.56 =C2=B1 0.18 times faster than old

The app/ directory is touched by roughly 35% of the commits.

In gitlab-org/gitaly, I ran a benchmark on `internal/`, which is touched
in about 58% of the commits:

    Benchmark 1: old
      Time (mean =C2=B1 =CF=83):      13.2 ms =C2=B1   1.3 ms    [User: 10.=
4 ms, System: 2.5 ms]
      Range (min =E2=80=A6 max):    11.3 ms =E2=80=A6  14.8 ms    10 runs
=20=20=20=20=20
    Benchmark 2: new
      Time (mean =C2=B1 =CF=83):       9.9 ms =C2=B1   0.4 ms    [User: 7.3=
 ms, System: 2.4 ms]
      Range (min =E2=80=A6 max):     9.6 ms =E2=80=A6  10.8 ms    10 runs
=20=20=20=20=20
    Summary
      new ran
        1.33 =C2=B1 0.14 times faster than old

(although Gitaly a lot less commits, ~23k commits vs ~530k in our Rails
monolith)

And also --recursive it's faster:

    Benchmark 1: old
      Time (mean =C2=B1 =CF=83):     204.6 ms =C2=B1   4.4 ms    [User: 193=
.2 ms, System: 10.5 ms]
      Range (min =E2=80=A6 max):   199.9 ms =E2=80=A6 213.2 ms    10 runs
=20=20=20=20=20
    Benchmark 2: new
      Time (mean =C2=B1 =CF=83):     181.5 ms =C2=B1   2.7 ms    [User: 170=
.9 ms, System: 9.7 ms]
      Range (min =E2=80=A6 max):   177.0 ms =E2=80=A6 187.1 ms    10 runs
=20=20=20=20=20
    Summary
      new ran
        1.13 =C2=B1 0.03 times faster than old

Personally I'm not too worried any use-case would be at least equally
fast.

>   - Not all pathspecs can support bloom filters (e.g., "*.c" would not).
>     So in theory:
>
>        git last-modified HEAD -- "*.c"
>
>     could work, but wouldn't be optimized. I don't think it _does_ work
>     now, because last-modified's max-depth logic complains. So it might
>     be a non-issue.
>
>     But I think it is solvable if we really wanted. Rather than
>     traversing looking for "*.c", we actually expand the pathspec in the
>     tip commit to a set of literal paths, and then as we traverse we
>     look for those paths. So we could collect all of "*.c" and then
>     add bloom keys for the shared prefixes. I think this does get tricky
>     in the general case, though. If you have "a/b/c" and "a/b/d",
>     looking for "a/b" is reasonable. But what if you also have "a/e"?
>     Should you just have a key for "a/", or both "a/b" and "a/e"?
>     There are some tradeoffs between how often uninteresting things in
>     "a/" will give us a false positive, versus the cost of checking
>     extra keys.
>
>     So maybe an interesting area, but given that in practice most people
>     will feed a single pathspec to last-modified, it's a lot easier to
>     just use that.

Yeah, I rather not deal with that right now.

>   - I know that last-modified was derived from GitHub's blame-tree
>     implementation (which I originally wrote, but stopped paying
>     attention to well before it learned about changed-path filters). I
>     don't know if the problem was solved separately there, but it would
>     be worth checking. +cc Taylor
>
> -Peff
>
> ---
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 5478182f2e..c07169258f 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -254,6 +254,29 @@ static void pass_to_parent(struct bitmap *c,
>  	bitmap_set(p, pos);
>  }
>=20=20
> +/*
> + * revision.c already has this functionality, but it is not public
> + * and it looks up the filter itself. But probably some refactoring
> + * could make it available at the right level?

I assume you're talking about check_maybe_different_in_bloom_filter()?

I was working on a fix to simply make it public and call it, but that's
a very valid point you're making. I'll change my plans.

> + */
> +static bool filter_contains_keyvec(const struct bloom_filter *filter,
> +				   struct rev_info *rev)
> +{
> ... [snip]

--=20
Cheers,
Toon
