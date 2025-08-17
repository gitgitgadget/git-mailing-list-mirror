Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C695A945
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755395423; cv=none; b=BpjA85wCdIcwXpX7LYbwWDpoMA+iMZd8wOMcQ6r49oy3i7gMGqI4ccQWE7iWnv/G1ZV2vlxsNf+qxKIUy1z9okyChlkkXWmYQXiY8MYunkJnNQ8OGTbvtFhZflxlISFUdv+vf1s/jimojdRzpBaKHw2O2xN+wBFD0YZ48cxXpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755395423; c=relaxed/simple;
	bh=6adRuYcGg93KR4P3mNG44vm+r74cwM9jBO450At7mIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afKj/sCh6WAaq3TzQcECA9eLHNZobRYDYFN7OcKoSYRIgEA3bMMGG8tnWoKcGS3mFx79uZMqjy7+Pn+cBOU9cCplFFSQs7R4QN2MHlZU64k5shyEEhSN8Zwh8PcumSZaRpkPRBXIhm0pLNkt3hFpMot+pXhvqdw3jL4zfnjRY8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eGNOWNJq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eGNOWNJq"
Received: (qmail 7752 invoked by uid 109); 17 Aug 2025 01:50:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6adRuYcGg93KR4P3mNG44vm+r74cwM9jBO450At7mIM=; b=eGNOWNJqbP9kaMvyChmg6YEqD6gnqKSnlBqVuGyB3BkjNykbX/z7vHeiI5slSfoAuJANRODhDK9kOQARlEYqLCId3bOMhn5CL6bX9V99Z9GN8hoJ1xoLHzsbISfRrC1/sy4jU9cyhoaWhNjnW+v/Kye26hLOrmkZqpRIG/n3UsgCSTNkaK0UIpMWAhnFpG4pWNBNNPHkszvfTnO078mFAq3viQ8jcKoR6dZOxzkbRkokN083aWF+CvgIajiEQZ8TlAEnFZ1X57dRjaU3gKCHclo8sE/Ru0jirn0xif/zppGSXuAjMNyz3kx9Yg/mvcE8aTo8RbBvAQ/K1IuG9rjHDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Aug 2025 01:50:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15410 invoked by uid 111); 17 Aug 2025 01:50:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Aug 2025 21:50:16 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 16 Aug 2025 21:50:13 -0400
From: Jeff King <peff@peff.net>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: How To See Index File Checksum?
Message-ID: <20250817015013.GA6012@coredump.intra.peff.net>
References: <76ee89b3-39cf-4218-bbb6-1cc3c6e16ddf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76ee89b3-39cf-4218-bbb6-1cc3c6e16ddf@gmail.com>

On Sat, Aug 16, 2025 at 06:32:30PM -0700, Jon Forrest wrote:

> I know how to see the checksums of the files in an index
> file. But, I can't find a git command that shows the
> checksum at the end of an index file.

I don't think that there's a command to do so (likewise for other
checksum'd files like pack idx, etc). We'd usually check those during
fsck but I don't know of any specific command to print them. I'd usually
do something like:

   fn=.git/index
   size=$(stat --format=%s $fn)
   # offset of hash; use 32 in a sha256 repo!
   hash=$((size - 20))
   # the computed hash
   dd if=$fn bs=1 count=$hash | sha1sum
   # what the file records
   dd if=$fn bs=1 skip=$hash | od -A none -t x1 | tr -d ' \n'

Which admittedly is kind of horrible, but this isn't generally needed
much outside of debugging.

-Peff
