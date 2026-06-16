Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473340FDB6
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608361; cv=none; b=l2yLbj8gm/bG6XHc4U4496lVFFIZUogQoiPJASBUOc94mq5eufXow1/iXLjoHhY3hw28+lUxOArTotbk6qg1vyC6V+VAB+R+osCXE5LaFGV2fHciD4Qm1DByhXqW0VgRmbXLfzsqihWct8Us+wMgCJs2ORqywoSoUnBR/rzf0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608361; c=relaxed/simple;
	bh=mIG6hEWWE6HyuxAczl+j8s/tKYT8M5FlMMAaBK7Y6Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8sPZ1yNzlrAe2T5d7TIrnUOmVOOnLt3KemKAkP9aFBhsNmJ2wBcGCRwsH8ir2OK1yryAODdRdhKv+mceg+Xq2lMxGvH/KIJUcQ+V65GUSFBxz+tyjHEWSavhPbfyGNapY0AmzyUsraubEOyXsa2GQQknnRgYKnGwHKnv7lbvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CxCyFlSk; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CxCyFlSk"
Received: (qmail 149153 invoked by uid 106); 16 Jun 2026 11:12:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=mIG6hEWWE6HyuxAczl+j8s/tKYT8M5FlMMAaBK7Y6Kk=; b=CxCyFlSkJCsolUrGmFlJDXtm9TAg5aHoj7cYOjHgt8zR+7wLECel2r8PIZBuC2beabvsvRu0DOAldJFcMUaOYDGOPW0g3eNlyr7Uu6E3MWDM1Cmji5YcDZ8nLck6M+aiRKdWUltPTkksIhJjtU7G3F7YcFlLb05UH6CUmo2PAYLs44NjxQ24fpe27Dao6f38h4adBuT0tZprKxMddLvG39dsPzavYWF0IgDzaSiZEn5jvSmq6JgmKVQux5E97GHz4QTSd6w5uAqCg5tza5KLJzFUWW1zNogkoBUPuKXexE/vEZL7g9aQQGdQHzHTJyKwlJRJ2wpigMiZME/TxAawAA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2026 11:12:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 407726 invoked by uid 111); 16 Jun 2026 11:12:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2026 07:12:37 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jun 2026 07:12:37 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] cat-file: speed up default format
Message-ID: <20260616111237.GA687438@coredump.intra.peff.net>
References: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
 <20260615165326.GA91269@coredump.intra.peff.net>
 <20260615170652.GB91269@coredump.intra.peff.net>
 <10a33614-837f-4166-aa30-6de28b052692@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10a33614-837f-4166-aa30-6de28b052692@web.de>

On Mon, Jun 15, 2026 at 11:53:07PM +0200, René Scharfe wrote:

> > IMHO that is probably not worth it for a custom parsing system just for
> > cat-file.  But if we were to finally unify ref-filter and cat-file (and
> > even --pretty=format) then it would probably worth doing this kind of
> > pre-parsing.
> It could be worth it for cat-file alone if we find the right balance, as
> it already does do a separate parsing step, but that is awkward with its
> mark_query checks all over the place and remembers only object property
> requirements and no other format string details.

Yeah, getting rid of the mark_query pass was a nice side effect of
having a true parse step.

> Making the opcodes small should be beneficial.  We need only a handful
> of them, so a byte each should suffice.  We can use a strbuf for that.
> 
> We can also store literal characters in there.  An opcode plus with a
> payload char incurs an overhead of 50%, which sounds high, but at least
> the default format only has two of them and it's much better than
> storing pointer plus size for an overhead of more than 90% in case of a
> single char.

True, and it's a size win if the literal portions tend to be small
(fewer than 15 bytes). You do lose out on the ability to strbuf_add()
them in one go, though. So lots more strbuf_grow() checks, etc. If you
really wanted to get fancy, you could follow the opcode with a length
represented as a variable-sized integer, followed by the literal bytes.

I'm not sure that Git's formatting code needs to squeeze out quite that
much performance, though.

> That gets us closer to native speed, at least on an Apple M1:
> 
> Benchmark 1: ./git_fp cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'
>   Time (mean ± σ):     992.7 ms ±   3.2 ms    [User: 967.5 ms, System: 23.8 ms]
>   Range (min … max):   990.1 ms … 1000.7 ms    10 runs
> 
> Benchmark 2: ./git_switch cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'
>   Time (mean ± σ):     991.8 ms ±   1.6 ms    [User: 967.0 ms, System: 23.3 ms]
>   Range (min … max):   989.3 ms … 994.4 ms    10 runs
> 
> Benchmark 3: ./git cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'
>   Time (mean ± σ):     985.8 ms ±   2.9 ms    [User: 960.5 ms, System: 23.6 ms]
>   Range (min … max):   982.9 ms … 993.0 ms    10 runs
> 
> Benchmark 4: ./git cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)'
>   Time (mean ± σ):     982.1 ms ±   3.2 ms    [User: 956.7 ms, System: 23.6 ms]
>   Range (min … max):   979.2 ms … 989.2 ms    10 runs

OK, so we managed another 1%. But I'm skeptical that this linear opcode
technique is where we want to go in the long run, if we're ever going to
unify formatters.

One, for more advanced features like %(if) we'd want to support some
notion of hierarchy and recursion. We have to speculatively format the
inner part and see if it is empty.

Though I guess that is possible with a linearized set of opcodes. If you
turn "%(if)%(HEAD)%(then)*%(end)" into:

  FMT_IF
  FMT_HEAD
  FMT_THEN
  FMT_LITERAL
  *
  FMT_END

then I guess you just start a sub-execution of the opcodes after FMT_IF
and tell it to stop when it sees FMT_THEN. It does mean that the opcodes
themselves need to control the program counter, rather than the executor
blindly walking along the opcodes and asking them to put stuff in the
output. Whereas I think if the parser builds a tree of structs then this
falls out pretty naturally.

The second thing is that many of the ref-filter atoms have options, and
those options have to be represented in the opcodes. That works
naturally if each opcode gets its own struct (either with a big union,
or true polymorphism). But representing "%(describe:match=versions/v*)"
in opcodes sounds gross. Now you need opcodes to represent the options
(and maybe "no more options"), and some way of encoding arbitrary input
for those option arguments.

-Peff
