Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2878F2E
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973081; cv=none; b=TQZLnXFI3YkbwkusMfAonK8TPQhsovuKjKA5+vWdhQbNgDBLfn+DMV1n3Q7LjoKo5PWdg++7akuERb9WdxGQvuqyXj0cCq+z7aJrZPQZgPc/WZBGaNuG2w3eEEI9u1pYvf4v+7YD/hk9h25Sv/PeDEXTTNlsbH/QrgRPzoxJE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973081; c=relaxed/simple;
	bh=YYfMYY/o5sBcQfRPTgraAC010oosOweNMBkbCP4Xfac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es52vWgC/Iy796PsBiUdvTm+v8v8VnEib7unmx5luhAwToMUTiWH8cBYzRIq3HO3A+3/g8yJVT193Mb5pBOGjDOKNWIQ7i/PDV2kbBO/9Tdp0izr1wPABoXoONPXhIgyZC16+QU6PUHGveLhHH9ExWksu/2VzTw+Ud4nUU7KoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ULZMFtWL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ULZMFtWL"
Received: (qmail 20321 invoked by uid 109); 14 Mar 2025 17:24:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YYfMYY/o5sBcQfRPTgraAC010oosOweNMBkbCP4Xfac=; b=ULZMFtWL9MI6nq5Qliyyniv88z07rPC2GJEdMKaLhVxTWWLB/1YIhdj3EHnxlnuCklnamf2YMMPkONSHrY7p+j/plNTAue8KUQ5Dz2lhpUVPEq/KQBXgBFF7JNDuMrK6hgLGZaWsAS2FW71pOULy61EQAWAociFZgxizrpwLkzNzw2AHidn3n2LNV5j4imWIF7XCc/NHuUmo6UQiFUef18KQ0qfefZFickvcQO0jNSg5q9knrAvndTuAEny27l+60sSDdp+gVC0ilKufcUWOOrBmTcOMWCR/Ks5TcriZoLNFXs2Yak1Tn03Vul5qKourJaTDs54ofnwKwtI0aDpSJg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 17:24:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6511 invoked by uid 111); 14 Mar 2025 17:24:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Mar 2025 13:24:37 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Mar 2025 13:24:37 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] diffcore-rename: fix BUG when break detection and
 --follow used together
Message-ID: <20250314172437.GA16311@coredump.intra.peff.net>
References: <pull.1876.git.1741395615315.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1876.git.1741395615315.gitgitgadget@gmail.com>

On Sat, Mar 08, 2025 at 01:00:15AM +0000, Elijah Newren via GitGitGadget wrote:

> It turns out that making a testcase to trigger this is a bit challenging
> too.  I added a simple testcase which tickles the necessary area, but
> running it normally actually passes for me.  However, running it under
> valgrind shows that it is depending upon uninitialized memory.  I
> suspect that to get a reliable reproduction case, I might need to have
> several more paths involved, but that might make the testcase more
> difficult to understand.  So, I instead just embedded a warning within
> the testname that the test triggered uninitialized memory use.

I think it's OK for a test case to require extra memory checks to fail;
after all, these kinds of bugs are usually non-deterministic without
those checks anyway.

I did verify that it reproduces for me with "--valgrind". I was
surprised (and a little disappointed) that it doesn't seem to trigger
with ASan/UBSan. We do run those routinely in CI, but I doubt that
--valgrind gets used regularly for the whole test suite by anyone these
days, just because it's so much slower.

I'm puzzled, though, why the test case at the beginning of this
thread[1] yields the BUG() so readily, but your test case doesn't.

So maybe this is the best we can do, but it feels like we should be able
to at least trigger the existing BUG() reliably. I couldn't seem to
figure it out, though. :(

> In short, when these two rare options are used together, fix the
> accidental find of the wrong dst entry (which would often be
> uninitialized memory just past the end of the array), by adding a little
> more care around the recorded indices for break_idx.

Your description of the problem and the solution both seemed sensible to
me (though I'm not all that familiar with the ins and outs of the rename
code these days).

-Peff

[1] The simplest I came up with is:

      git clone --bare https://github.com/intel/linux-sgx.git tmp.git
      cd tmp.git
      git --no-pager log -B --follow 63d0e65cfa49bb46a8dbe8745bb15aaf226faa97 -- external/ippcp_internal/inc

    Curiously, that pathspec is actually a directory, but it only has a
    single file in it. Feeding the actual file in it _doesn't_ trigger
    the bug:

      git --no-pager log -B --follow 63d0e65cfa49bb46a8dbe8745bb15aaf226faa97 -- external/ippcp_internal/inc/ippcp20u3.patch

    That just shows the single commit (even though there is a single
    file before and after that commit, it is not similar enough to find
    a rename).

    The file that hits the break detection is unrelated. It looks like
    it's psw/ae/data/prebuilt/le_prod_css.bin.

    I tried variants with break files, subdirs, etc, but I couldn't seem
    to make anything work.
