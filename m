Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79A134AD
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710311005; cv=none; b=dPsGVDs+Edw9FDunRd1TZNVycAWca0HmjTYmcj/xM6IRKeHfVAVFkq1pf6FAv5CVf+yDDuCno+vmk5IG3nQ32eOaAvBD6M9x8yE9ecKSBXbYcEun+tuW4EOZ+sOYP0luKr0ZtcqzTGBZvUIjYzdPfEm6gFeDgIytehCIi6J5YZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710311005; c=relaxed/simple;
	bh=oE4YynCd+f99yCvrM0Sjc1oDb9qYOSakxfcCYUUcrsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbDWcFIVDhBppqB/BJjII96dgN4M6CSEK9bUZxpyGq3AeUY4RC+Blr3+nLIhB1XG0y+SaAYWt/mLOsSf+nNz6Yw8eDQa8tPoFyBEjBpRlRYH5WIeJaFyLXFeeouWpO9Gh1cifINmkjAyJ+xDepNycJ3MQtSHCnxrpxTzUD/PkS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30032 invoked by uid 109); 13 Mar 2024 06:23:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Mar 2024 06:23:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4459 invoked by uid 111); 13 Mar 2024 06:23:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Mar 2024 02:23:25 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Mar 2024 02:23:21 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
Message-ID: <20240313062321.GA125150@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
 <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
 <d82e11f2-15c1-4ecb-8c7c-19667d2c5fb4@gmail.com>
 <xmqqfrx0hg01.fsf@gitster.g>
 <66a70346-98e8-44dd-a680-36a21df5f32a@gmail.com>
 <20240312081931.GC47852@coredump.intra.peff.net>
 <9b63eab9-7b6d-4024-9ec4-b58c5ca3b084@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b63eab9-7b6d-4024-9ec4-b58c5ca3b084@gmail.com>

On Tue, Mar 12, 2024 at 02:36:36PM +0000, phillip.wood123@gmail.com wrote:

> > Leading whitespace actually does work, though I think you'd be slightly
> > insane to use it.
> 
> For "git rebase" in only works if you edit the todo list with "git rebase
> --edit-todo" which calls strbuf_stripspace() and therefore parse_insn_line()
> never sees the comments. If you edit the todo list directly then it will
> error out. You can see this with
> 
>     git -c core.commentChar=' ' rebase -x 'echo " this is a comment"
> >>"$(git rev-parse --git-path rebase-merge/git-rebase-todo)"' HEAD^
> 
> which successfully picks HEAD but then gives
> 
>     error: invalid command 'this'
> 
> when it tries to parse the todo list after the exec command is run. Given it
> is broken already I'm not sure we should worry about it here. In any case it
> is not clear how much we should worry about problems caused by users editing
> the todo list without using "git rebase --edit-todo". There is code in
> parse_insn_line() which is clearly there to handle direct editing of the
> file but I don't think it is tested and directly editing the file probably
> bypasses the rebase.missingCommitsCheck checks as well.

Ah, thanks for the example. I guess it's not too surprising that it can
cause confusion. Given that it's an existing issue, I think my
preference would be to leave it out of the series under discussion
(given how long and complicated it is already), but I'd have no
objection to tightening things further on top as a separate series.

-Peff
