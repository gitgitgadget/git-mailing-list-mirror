Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570D36B11
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721971585; cv=none; b=H20pmZrMPaUyNH5zZQ6U5e2TqGfg3krSGS1WZP+lYlxDepZfMsI58XvPmZZpLEc8a13/K6bmc2/k06q+p32RU14i4RonnNhyUnrx21TsaWXOkCdp+tD75jT2X28/5s4/f/37eS2RFCiXhk1oV37TbBjuf2LuRSOLzvyM/JRhORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721971585; c=relaxed/simple;
	bh=RSIS2A/DbCCfDXfXa3wDEoBWpgY+Gz9jeI0b8y6RgB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp0VAbVxDW4eFrSCvCTpPxDqetnk4xTuTkuxbH237pwIZafPwhAxDVRGf61/MsnSC6a9EFGX1StsHhEJtzebtk1cNqV5XUb+KhPf8+mF51ADLlb4NzVJtyGrJcxtr+tZnqv5c+u76MXvx3vVWf+DyeK++/r0mURL21ap2JPDBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16238 invoked by uid 109); 26 Jul 2024 05:26:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jul 2024 05:26:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31101 invoked by uid 111); 26 Jul 2024 05:26:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jul 2024 01:26:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Jul 2024 01:26:21 -0400
From: Jeff King <peff@peff.net>
To: KwonHyun Kim <kwonhyun.kim@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Possible bug in .gitignore
Message-ID: <20240726052621.GA647916@coredump.intra.peff.net>
References: <CADLV-7+fX7jrC8e_nPBHZfg8yXKpjLfPL3MgxS8peUrr8pqQoA@mail.gmail.com>
 <CADLV-7JN-x8+Y+sVO=O-f4Ur7jw8Bs+z0BzQy5y9GbPTJ9eE_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADLV-7JN-x8+Y+sVO=O-f4Ur7jw8Bs+z0BzQy5y9GbPTJ9eE_g@mail.gmail.com>

On Thu, Jul 25, 2024 at 01:01:45PM +0900, KwonHyun Kim wrote:

> I am experimenting with git and I found there is something not working
> as explain in the document
> 
> When I place `text_[가나].txt` in `.gitignore` it does not ignore
> text_가.txt nor text_나.txt
> 
> I experimented with `text_[ab].txt` and it works fine.
> 
> So I thought it might work bytewise so I put
> `text_[\200-\352][\200-\352][\200-\352].txt` with no effect. (가 is
> "\352\260\200" when core.quotepath is set to true)
> 
> So I think it must be a bug that is that pattern [abc] or [a-z] does
> not incorporate non-ascii characters. but I am not sure.

The globbing in git is generally done by wildmatch.c, which was imported
from rsync. Looking in that file, it looks like it does not support
multi-byte characters at all inside brackets.

So I don't see a way to make it work except to place the _literal_ bytes
making up the utf8 sequence, each inside its own single-byte match.
Like:

  printf 'text_[\352\353][\260\202][\200\230].txt\n' >.gitignore

But then your .gitignore file is itself invalid utf8 (not to mention
that this is obviously something a user shouldn't have to do).

So I guess the fix would be to teach wildmatch.c to recognize and match
multi-byte sequences inside []. That probably requires that we assume
the pattern and the path are utf8, which will usually be true, but not
always. So we might need some kind of config switch there.

There are also probably a deep rabbit hole of corner cases there (e.g.,
NFD vs NFC, matching é versus "e" + combining accent). But I suspect
that even recognizing multi-byte sequences as a single char to match
would be big improvement.

-Peff
