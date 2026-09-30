Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37E4AD4C7
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811832; cv=none; b=dR8PT9Vup1lHcS9pCmIpNIhh6Xqi2vtNBTrLCa+AZyXOnwG+wgDs45kWMdSBpkhrGM9quz6IJ5siACiT0LnrFM/jlHfDFsr+1jVofDMMIYHy4Ej3QrCIxkIn3Pcth3IBprshEgrZXv9jIu3Q6ewtk9F6Pd7/I2UXk+8RPVSh7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811832; c=relaxed/simple;
	bh=TnCNMQptSKzJGryRCZDUic8GeuguLR85X7ycbhEqzzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ/jw5Ig1in6mHKLaep+Dls0CvVoyjzH5r+ibpUk+WgMM4R0jRzTCMvvONW5orjxRATJc8IjigXu5k3AlevojZmfDDZa+xTHdN833lR69/UiXxdbP+xmmFPFotvRQf2fFRzS2XPZam0IbqRa2ouzZLdbtjUB1d8hJX8x0urJcck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=acI4htH5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="acI4htH5"
Received: (qmail 8143 invoked by uid 106); 30 Sep 2026 23:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TnCNMQptSKzJGryRCZDUic8GeuguLR85X7ycbhEqzzo=; b=acI4htH519oFSZGCxdNi3LCur4LCg7N5U4JEjdQ7gZfPmA3PL4webVfHgVk26n4FAi0Bm2UkkcSqUAbz3ssdXoeWv5VIdAR2ns/xCGfLWcSKsCLTfyCX2EJTGggklO2xbaG/7kYoIVP0QSIY3t86QLiwKTC51ZeyqVTMIB9EtiM8OMhXTQ2OmJFUJ+ElN4ErjCp89LY9j/t8m2EMcsf5CnpYDyCbzzcxpu5RjTfIMtXQgs1Ke8nzFAma6RcN0oztX6g1Bk0ekYLsnpxbRRtZP06iP7cz5CrduK3m63HpIkVRjFcn1dn6rcmnQGALey8ldb3TQHJ/4OCt/4MjTZk3jQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 23:43:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20804 invoked by uid 111); 30 Sep 2026 23:43:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 19:43:52 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 19:43:48 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/7] use size_t for xdiff mmfile_t
Message-ID: <20260930234348.GA1340390@coredump.intra.peff.net>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929064935.GA1276867@coredump.intra.peff.net>

On Tue, Sep 29, 2026 at 02:49:36AM -0400, Jeff King wrote:

> An earlier series tried to simplify ll_ext_merge()'s code to read back
> the merge result from a temporary file, but Elijah pointed out some
> subtle integer overflow confusion:
> 
>   https://lore.kernel.org/git/CABPp-BG9Hkc7i_JxAbYfyzu+b4Mc_pZUr0jJF=vY0jHSARpHzw@mail.gmail.com/
> 
> I dug a little bit and found that similar problems exist elsewhere. So
> here's an attempt to make things at least incrementally better. And
> patch 4 is the original cleanup I set out to do. ;)

Here's a v2 that addresses review so far. The end state is the same
(plus the two bonus patches sent earlier), but it moves the xmallocz()
patch earlier, and fills in a few bits in the commit messages.

Range-diff is below.

  [1/7]: xdiff: clean up read_mmfile() allocations on error
  [2/7]: xdiff: replace mmbuffer_t with mmfile_t
  [3/7]: xdiff: use size_t for buffer sizes
  [4/7]: xdiff: NUL-terminate buffers read by read_mmfile()
  [5/7]: merge-ll: use read_mmfile() to read external merge results
  [6/7]: merge-ll: handle external driver status before reading result
  [7/7]: merge-ll: report an error when reading external merge results fails

 Documentation/technical/api-merge.adoc |  7 ++--
 apply.c                                |  2 +-
 builtin/checkout.c                     |  2 +-
 builtin/merge-file.c                   |  2 +-
 builtin/merge-tree.c                   |  2 +-
 builtin/rerere.c                       |  8 +++-
 diff.c                                 |  2 +-
 merge-blobs.c                          |  2 +-
 merge-ll.c                             | 39 +++++++-------------
 merge-ll.h                             |  4 +-
 merge-ort.c                            |  4 +-
 notes-merge.c                          |  2 +-
 rerere.c                               | 11 +++---
 t/t4200-rerere.sh                      | 51 ++++++++++++++++++++++++++
 xdiff-interface.c                      |  5 ++-
 xdiff/xdiff.h                          | 11 ++----
 xdiff/xmerge.c                         |  4 +-
 xdiff/xutils.c                         |  4 +-
 18 files changed, 100 insertions(+), 62 deletions(-)

1:  985905950f = 1:  985905950f xdiff: clean up read_mmfile() allocations on error
2:  ddcae336eb = 2:  ddcae336eb xdiff: replace mmbuffer_t with mmfile_t
3:  36d932e0ee = 3:  36d932e0ee xdiff: use size_t for buffer sizes
5:  f25902e825 ! 4:  c9cd3c7c3c xdiff: NUL-terminate buffers read by read_mmfile()
    @@ Commit message
         I don't know of any path that would benefit from this, but I noticed it
         while converting ll_ext_merge() to use read_mmfile(), since its original
         code did add a NUL byte (even though I cannot find any case where it
    -    would have mattered). Let's teach read_mmfile() to add this defensive
    -    NUL; it probably doesn't help anything, but nor should it hurt.
    +    would have mattered). Let's add the same defensive NUL in read_mmfile()
    +    by using xmallocz() instead of xmalloc().
     
         Note that the matching read_mmblob() doesn't need the same treatment.
         Its buffers already have a NUL from the object-reading code (which uses
4:  6ac0d54bda ! 5:  86fa283e00 merge-ll: use read_mmfile() to read external merge results
    @@ Commit message
         back from a temporary file. We can do the same thing with much less code
         by using read_mmfile().
     
    -    As a bonus, note that read_mmfile() correctly uses xsize_t() to detect
    -    the case when we'd truncate the result.
    +    There are also two behavior improvements.
    +
    +    One, read_mmfile() correctly uses xsize_t() to detect the case when we'd
    +    truncate the result.
    +
    +    And two, read_mmfile() will report errors to stderr if it can't read the
    +    file (whereas the existing code silently returned NULL). I think most
    +    callers would have said _something_ in this case like "failed to execute
    +    merge" (from merge-ort), but more specifics are probably helpful (e.g.,
    +    to distinguish a random system error from a badly configured merge
    +    driver).
     
         Signed-off-by: Jeff King <peff@peff.net>
     
6:  3e5f090284 = 6:  8ad0b774bf merge-ll: handle external driver status before reading result
7:  30357e6e9a = 7:  896031317b merge-ll: report an error when reading external merge results fails
