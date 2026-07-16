Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCF3B42FD
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193998; cv=none; b=iM9lzU+sP2Yyb+qxGLscYwSADJo2dn196BsGPDma1/PzH7UTTi2FwzEXDAvAq3GIV6QNakN8yiMSBHrNvJhAZqRJswFXJ0gLS5lxmw5MpcURB7IKERbhwKHvLdEHHhNy5rznqB9KQYDT/W/4QAnWopPWg3gQh26kLKtZQBvxExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193998; c=relaxed/simple;
	bh=bxe/A/V0DrkJg0+TneFCgim3jM7MRMGvhh0GDcFMPMQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M6w7P0S7yl7BHGRToNpKWQ93ypL2WnLWYLaZwfC2epKuKlCbZzVSxeWkkTyNr2z22ANjr4ZyScujIiXSEnavmTdJhGpJSnSMdI6B+uIHxp7WPUZPeAIWsLPFCRAD8y6U1Bx3AqjEJV9wO7Z9Yz0uphScDs7A/1RN/Sd0GKhW/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=OJrHFCjs; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OJrHFCjs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784193990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkQMkSFZA8BKr4mR5hOi3npdNHzszoIJbiT+eA4H+Wg=;
	b=OJrHFCjsbd8nt/FDC2Czios5L6QoXX3QpMuIJhf0zMqXzcxP30tP/pIIjf0X0LppMWlhYM
	QyNM31ViSidrehmx6UK+s3fgIGBX9xdOpiWJOtYxIN6UyFPjG6ExPK5t0c8y/OgBInTAT2
	p243jr8c8DLnO6rzSNU3amShFaTl00Q=
From: Toon Claes <toon@iotcl.com>
To: Gusted <gusted@codeberg.org>, git@vger.kernel.org, Jeff King
 <peff@peff.net>
Subject: Re: git-last-modified(1) slower than git-log(1)?
In-Reply-To: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>
References: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>
Date: Thu, 16 Jul 2026 11:26:25 +0200
Message-ID: <87v7afffpa.fsf@emacs.iotcl.com>
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
> I'm working at switching Forgejo's implementation of getting the last
> modified commits in a directory to git-last-modified(1). I'd expected
> equal or better performance than the current implementation, but have
> not yet been able to get this and I'm a bit puzzled as to why.
>
> The current implementation of Forgejo (inherited from Gitea) works
> roughly like this:
> 1. Run `git log --name-status -c --format=3Dcommit%x00%H %P%x00" --parents
> --no-renames -t -z $OID -- :(literal)some/path`, the output of this is
> quite complex and possible outputs more information than necessary.
> 2. The output of this is piped to some code to a parser and reconstructs
> what commit ID last modified each file in the directory.
> 3. Via `git cat-file --batch` get each unique commits information.
>
> With git-last-modified(1) (-z --show-trees --max-depth=3D0) this replaces
> step 1-2, but is slower. I've isolated the degraded performance to the
> fact that git-last-changed(1) takes more time to finish. So from my
> perspective it does not seem worth it to replace the current
> implementation with git-last-modified(1), and I would like to know if
> I'm missing something here or if git-last-modified(1) possibly could see
> a speedup?
>
> The repository I'm currently using to evaluate the performance is
> https://codeberg.org/ziglang/zig
>
> Reproduction steps:
> 1. `git clone https://codeberg.org/ziglang/zig $(mktemp -d)`
> 2. cd to tmp directory.
> 3. `git commit-graph write --changed-paths`. As git-last-modified(1)
> makes good use of the bloom filters.
> 4. `hyperfine 'git last-modified -z -t --max-depth=3D0
> 80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- doc/langref/' 'git log
> --name-status -c "--format=3Dcommit%x00%H %P%x00" --parents --no-renames
> -t -z 80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- ":(literal)doc/langref"=
'`
>
> With as output:
> Benchmark 1: git last-modified -z -t --max-depth=3D0
> 80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- doc/langref/
>  Time (mean =C2=B1 =CF=83): 66.5 ms =C2=B1 0.6 ms [User: 60.6 ms, System:=
 5.2 ms]
>  Range (min =E2=80=A6 max): 65.3 ms =E2=80=A6 67.7 ms 44 runs
>
> Benchmark 2: git log --name-status -c "--format=3Dcommit%x00%H %P%x00"
> --parents --no-renames -t -z 80d06578ac66bce3aa0a21e9610cdb782b9a0593 --
> ":(literal)doc/langref"
>  Time (mean =C2=B1 =CF=83): 26.2 ms =C2=B1 1.0 ms [User: 17.3 ms, System:=
 8.4 ms]
>  Range (min =E2=80=A6 max): 24.3 ms =E2=80=A6 30.1 ms 110 runs
>
> Summary
>  git log --name-status -c "--format=3Dcommit%x00%H %P%x00" --parents
> --no-renames -t -z 80d06578ac66bce3aa0a21e9610cdb782b9a0593 --
> ":(literal)doc/langref" ran
>  2.54 =C2=B1 0.10 times faster than git last-modified -z -t --max-depth=
=3D0
> 80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- doc/langref/

Hi Gusted,

Thanks for reaching out.

You're actually not the first to notice this, and I've been aware of
this.

The thing is, you're testing the difference on a single file. For us at
GitLab, it wasn't very useful to optimize that use-case, because usually
we want to see the last commit for a bunch of files at once.
So the use-case for git-last-modified(1) for us has been to replace
(pseudo code):

$ FILES=3D$(git ls-tree $COMMIT $PATH)
$ foreach $FILE in $FILES; do git log -1 $COMMIT -- $FILE; end

GitLab is batching files 25 at once, and in my benchmarking, it was
shown git-last-modified(1) is faster:

$ git last-modified $COMMIT -- <files

(I did this benchmarking in our Gitaly component to have a real-world
experience and you can visit the results at:
https://gitlab.com/gitlab-org/gitaly/-/merge_requests/7999#note_2850505479
)

So we left the door open for future improvement, although I never have
gotten to it. At some point I was trying to chase down when git-log(1)
was doing differently, but I never figured it out.

But this email challenged me already. And with some help of AI, I
managed to work on some improvements. You can expect a patch series
soon.

(Right before sending out this mail I noticed Peff sent out some changes
as well. I'll coordinate how to combine.)

--=20
Cheers,
Toon
