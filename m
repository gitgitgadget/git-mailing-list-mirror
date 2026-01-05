Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175512F361F
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610696; cv=none; b=qkphyEpVL61VnKzz/bt548604eraof3YOyLPhELx7Ke/jJqmtTgOkd23ungOxkeQgVqoFTD6BOt7x7KWBI3UI5PPGRWFS5wQlhmZ4gTYaZ07pZb38WRLbci9nledu104RIlr6loopQc0b7T650k70nsA+ScPCToqtM1knN24mfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610696; c=relaxed/simple;
	bh=5VSGNMG9jUxmAtrpQx30+rZWVHQ7XjZcV0hydaFs8x8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8FbwH+UbnOFRJ8gbrWSSmozHUmTvpMF+WxW6AK90BHPVy3KDQAGDOZ72m/qtVqFzCyNaBKhjLTBQvOp9dzC1eKxG6g+SA0HtLnwStd6VeSrI3FJnpKFjmu1yLKeh8fvjBSmOyUlMReZJA37pIX627QMUvW1rrdBQodzfNLxlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=z5IJJLxY; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="z5IJJLxY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1767610685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+icQmStp7kJ0N4wVr1cEgF77v2Ka5ud3wlMGUy0gH8=;
	b=z5IJJLxY3h1Xzzt0c/ZlKe7POzhHu6QGccI3pRs3qaREPcxgDmQ0zLWprnAyhMYINO6NZT
	yHGeXmW6sQ1ullNw+imYSSGoKY7gUy/u0XtYWAiKNflyF/4JbUxSAAfudraAe+tPDIKMcp
	r/+8o23R6V/DHueiHKSbVYnAq+z72K8=
From: Toon Claes <toon@iotcl.com>
To: Gusted <gusted@codeberg.org>, git@vger.kernel.org
Subject: Re: git-last-modified weirdness
In-Reply-To: <03f96860-29fc-42a7-a220-c3ec65eb8516@codeberg.org>
References: <406222e6-d10b-47d8-a177-de5912db4512@codeberg.org>
 <03f96860-29fc-42a7-a220-c3ec65eb8516@codeberg.org>
Date: Mon, 05 Jan 2026 11:57:51 +0100
Message-ID: <87v7hgpbrk.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Gusted <gusted@codeberg.org> writes:

> Hi,
>
> Resending this mail as it looks like it might not have arrived (couldn't=
=20
> find it in the mailing list archive).

Thanks for following up. I didn't see it yet.

> For Forgejo, I wanted to look into using git-last-modified to gain extra
> performance for larger repositories where this can often result in being=
=20
> (one of) the slowest git operation. However I noticed some problems that=
=20
> looks to be bugs.
>
> I've ran all the following commands on the following Git repository, on G=
it
> v2.52.0 (Arch Linux) and my git config does not enable or disable any=20
> feature that should've impacted the any of the following observations.
>
> $ tmp=3D$(mktemp -d)
> $ git clone https://codeberg.org/forgejo/forgejo $tmp
> $ cd tmp
>
> During some experiments I noticed it being slower for some files. An=20
> example:
>
> $ hyperfine --warmup 5 'git log --max-count=3D1 DCO' 'git last-modified D=
CO'
> Benchmark 1: git log --max-count=3D1 DCO
>  =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0 =C2=A0 =C2=A0 86.9 ms =C2=B1=C2=
=A0 =C2=A00.8 ms=C2=A0 =C2=A0 [User: 70.1 ms, System: 15.6 ms]
>  =C2=A0 Range (min =E2=80=A6 max):=C2=A0 =C2=A0 85.5 ms =E2=80=A6=C2=A0 8=
8.3 ms=C2=A0 =C2=A0 34 runs
>
> Benchmark 2: git last-modified DCO
>  =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0 =C2=A0 =C2=A0151.3 ms =C2=B1=C2=
=A0 =C2=A04.3 ms=C2=A0 =C2=A0 [User: 133.4 ms, System: 15.9 ms]
>  =C2=A0 Range (min =E2=80=A6 max):=C2=A0 =C2=A0145.4 ms =E2=80=A6 167.1 m=
s=C2=A0 =C2=A0 19 runs

In my local benchmarks I see similar results.

I agree this isn't great, but git-log(1) is just very good at logging a
single path. git-last-modified(1) is mostly designed to give commits
for a bunch of paths. For example:

    $ hyperfine --warmup 5 'git ls-tree HEAD --name-only | xargs --max-args=
=3D1 git log --max-count=3D1 --format=3Doneline --' 'git last-modified'
    Benchmark 1: git ls-tree HEAD --name-only | xargs --max-args=3D1 git lo=
g --max-count=3D1 --format=3Doneline --
      Time (mean =C2=B1 =CF=83):     852.5 ms =C2=B1   9.2 ms    [User: 703=
.8 ms, System: 141.9 ms]
      Range (min =E2=80=A6 max):   841.9 ms =E2=80=A6 869.4 ms    10 runs

    Benchmark 2: git last-modified
      Time (mean =C2=B1 =CF=83):     141.2 ms =C2=B1   2.0 ms    [User: 133=
.0 ms, System: 7.9 ms]
      Range (min =E2=80=A6 max):   137.7 ms =E2=80=A6 146.0 ms    21 runs

    Summary
      git last-modified ran
        6.04 =C2=B1 0.11 times faster than git ls-tree HEAD --name-only | x=
args --max-args=3D1 git log --max-count=3D1 --format=3Doneline --

> This might be me misunderstanding the feature, but it looks to me this=20
> cannot be used for paths that is inside a directory. The following two co=
mmands=20
> yield the same output:
>
> $ git last-modified -- web_src
> 24019ef5e83fd7bed7f31ad09dd8d5f26b4bdc69=C2=A0 =C2=A0 =C2=A0 =C2=A0 web_s=
rc
> $ git last-modified -- web_src/svg
> 24019ef5e83fd7bed7f31ad09dd8d5f26b4bdc69=C2=A0 =C2=A0 =C2=A0 =C2=A0 web_s=
rc
>
> Where I expected the latter command to return the last commit of=20
> web_src/svg.

I agree this is confusing. And I plan to propose a change to this
behavior. But at the moment what you're supposed to do in this
situation:

    $ git last-modified -- web_src
    28e0af23faf6c8e8f353ba2ae818ee0f83fd3e5c        web_src
    $ git last-modified -r --max-depth=3D0 -- web_src/svg
    b8f15e4ea09c6571872607874ae099269ea4b201        web_src/svg

I plan to change the default behavior to basically behave like `-r
--max-depth=3D0`. But I'm happy to hear your input if you think it should
be something else?
There's some context here[1], but as said, I might shift direction a bit
toward making the default more intuitive.

[1]: https://lore.kernel.org/git/20251126-toon-last-modified-zzzz-v1-0-6083=
50df0caa@iotcl.com/

> I'm not sure why I tried this, but I can trigger a BUG when giving it some
> nonsense input:
>
> $ git last-modified fb06ce04173d47aaaa498385621cba8b8dfd7584
> BUG: builtin/last-modified.c:456: paths remaining beyond boundary in
> last-modified
> [1]=C2=A0 =C2=A0 690163 IOT instruction (core dumped)=C2=A0 git last-modi=
fied
>
> `fb06ce04173d47aaaa498385621cba8b8dfd7584` is the tree commit id of=20
> web_src. I
> suppose this should've returned a nice error message or blank output. It=
=20
> does
> give a blank output when you specify a valid path:
>
> $ git last-modified fb06ce04173d47aaaa498385621cba8b8dfd7584 web_src
>

Hah, that sounds like a real bug. Thanks for reporting, I will look into
it.

> Kind regards,
> Gusted
>
>

--=20
Cheers,
Toon
