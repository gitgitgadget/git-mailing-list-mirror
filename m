Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFD376492
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315535; cv=none; b=LSg4D4k1yXqWeQShKjfyI2ulLoAx7n31o0zuKhCu6qpCl65JBNHRVN6oekSwldLayJRNPxr3ZRRa831BhDgdDMyBK8XbmBMficMHeXY721xoKIOOd0sNkWzJADlh/45xfcggTjuXz1DtkmBflsbldovBmBLY6nPF4msTqwFEOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315535; c=relaxed/simple;
	bh=DwAtjkw9lF3LQgOxa5UC9bAtWTYqatKDaWhFYYT3Syc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mcbvnHGef+Ax4qZpfyA9L2btI5SLY0ZBsBAtwK6GdHkhahOzDY6d0bATNZYcXQY5a6hUukBnOTDbdCURbSt4gOMcr70/LIn5S7hmOWifZz1181vsrnTx6kU5rbKFfISwC3/DfSHsu4A5O3cwdR3/ovXR0WeuTWKp+itmeKu/6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=dvWl9nts; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="dvWl9nts"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784315529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nGvhtegU5g2pudM+FNlF7bvQit/bTHOUWlvOlEUytR8=;
	b=dvWl9ntsYulL1HfTcSBk1sckodr8CyoV+jKc0KmrhFoXzbkwHaowSFVdck8pieW5FVGm08
	kiTFXdxRS4YlcukES27i4L0v6nWLgJsL9m3d1KUWM32/fOf0RcuhGG+IAJ4bUSzRz747kF
	+QvOzvJhg/E0r/Ws0804JYsHM3nL62M=
From: Toon Claes <toon@iotcl.com>
To: Gusted <gusted@codeberg.org>, git@vger.kernel.org, Jeff King
 <peff@peff.net>
Subject: Re: git-last-modified(1) slower than git-log(1)?
In-Reply-To: <87v7afffpa.fsf@emacs.iotcl.com>
References: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>
 <87v7afffpa.fsf@emacs.iotcl.com>
Date: Fri, 17 Jul 2026 21:12:00 +0200
Message-ID: <87fr1h1ldr.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Toon Claes <toon@iotcl.com> writes:

> You're actually not the first to notice this, and I've been aware of
> this.

Hah, wait, ... the previous reporter was ... you[1].

> The thing is, you're testing the difference on a single file.

I was mixing up use-cases, and the problem you're stating here isn't
related to your previous report. Now while I did sent out patches for
the problem in this email, the issue in the other email isn't addressed
with it. Unfortunately.

(nerdsniping Peff :-))


Gusted <gusted@codeberg.org> writes:

> The current implementation of Forgejo (inherited from Gitea) works
> roughly like this:
> 1. Run `git log --name-status -c --format=commit%x00%H %P%x00" --parents
> --no-renames -t -z $OID -- :(literal)some/path`, the output of this is
> quite complex and possible outputs more information than necessary.

That's quite clever actually.

> 2. The output of this is piped to some code to a parser and reconstructs
> what commit ID last modified each file in the directory.

My only worry would be this could end up in a very long list of
(duplicate) commits. But you can probably filter out data as you read in
lines.

> 3. Via `git cat-file --batch` get each unique commits information.

Yes we use git-cat-file(1) in batch mode too.

But, and I learned this from blog post[2] from GitHub about Git v2.55,
git v2.55 now has git-format-rev(1)[3]. You can pipe the output of
git-last-modified(1) into that and get everything you want at once
(maybe).

I haven't tried yet to integrate that into GitLab to see if it would
bring any gains.

[1]: https://lore.kernel.org/git/03f96860-29fc-42a7-a220-c3ec65eb8516@codeberg.org/
[2]: https://github.blog/open-source/git/highlights-from-git-2-55/
[3]: https://git-scm.com/docs/git-format-rev

-- 
Cheers,
Toon
