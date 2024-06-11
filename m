Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F6383A5
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091098; cv=none; b=VuyAvsDtfmv5IOARoKXlgDmRqu1f8HTRXoFk7YgzEwfSG3FrBUp+HYQM0QZtEI+gqazH8AMg8yA+7KZYpDkOiUxAFYnAm3SA4P32f/QtZETbiv17blj4DmvfPEsmUfBVtC1VLiPdIyX0FqGYVwDlNuxh6EiGIVDT2mDQbEGqYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091098; c=relaxed/simple;
	bh=q6IWHrmYKH5X2TQmaFHoZzCl5Rv8JpqRptVzAgLVcrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3/Xw7GgXxbmJTW4nxmJPQax9910mLZIKzRxR2y7LaPSh5pPUICOtWL6z79R2YgRhnL5a45wroJ/f0BzFasV5zYMMthik0Dol98oU3MlzVFLqcINTmvVMqMmEJiJyxLv98bHFIUoo7YcGQNEtzzHIRCocS/7jkvpYdaQj6Ue38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18080 invoked by uid 109); 11 Jun 2024 07:31:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 07:31:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24366 invoked by uid 111); 11 Jun 2024 07:31:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 03:31:33 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 03:31:34 -0400
From: Jeff King <peff@peff.net>
To: Fred Long <fred_long@fastmail.fm>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org
Subject: Re: git fetch --prune fails with "fatal: bad object"
Message-ID: <20240611073134.GE3248245@coredump.intra.peff.net>
References: <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
 <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>
 <20240605084718.GD2345232@coredump.intra.peff.net>
 <c2a02982-40a9-6629-05c2-c8de3335f35b@fastmail.fm>
 <20240606011453.GA623737@coredump.intra.peff.net>
 <5469592f-69eb-b1da-1218-abeae88f7303@fastmail.fm>
 <20240608112033.GB2966571@coredump.intra.peff.net>
 <5247e0cc-ef0e-558a-7e06-5a7425a52329@fastmail.fm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5247e0cc-ef0e-558a-7e06-5a7425a52329@fastmail.fm>

On Sat, Jun 08, 2024 at 02:02:52PM -0700, Fred Long wrote:

> >    git for-each-ref --format='%(refname)' refs/remotes/ |
> >    git cat-file --batch-check='%(objectname)' |
> >    perl -alne 'print "delete $F[0]" if $F[1] eq "missing"' |
> >    tee /dev/stderr |
> >    git update-ref --stdin
> > 
> Thanks. Here's what I have been using:
> 
> git fsck |& grep "invalid sha1 pointer" | (
>     while read err ref rest
>     do
>         ref=${ref%:}
>         echo got $ref, removing .git/$ref
>         rm .git/$ref
>     done
> )

Parsing fsck's errors should be OK, I think, but your "rm" won't be
reliable. If the ref is packed, then it needs to be removed from
.git/packed-refs, too. Calling "git update-ref -d $ref" should work,
even for a broken ref.

-Peff
