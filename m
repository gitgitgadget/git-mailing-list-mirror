Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438A2F46
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882835; cv=none; b=iEH0aqDLYUq1ltpeMGvZ1CtXOFv6WFQoWbmYZDtNBOfCE0F6SxHd3nyfh2oDrWCLyT0vj+z4kBDfQ66mXcRryTYBQ1Srmv+n70Q8DHdnht7Z+9H4tor6MabhA2OmYiSX3yRYxxc0To2cSUgv/8P0VVu+8Djyo8FhnX4MCHW9ViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882835; c=relaxed/simple;
	bh=XdsWM33M0CPwf5j152sntkwya7eam30j7l2Ucc8Iabs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgF7zzt7p97+IBhK0KveFNUdc5TasAZzedhNEnkYtEVXIFRrggXC1+1iiaCwOvui0aBsYMSnN1vv7zhfqsVsRqTRrenwTHKEGVuhgwLS9/akIdTxKxE+OT/uqb3VoImS58d47pFxvOezHSHhMFQmVJVQdPFry+YkwiNp4yESdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30472 invoked by uid 109); 2 Jul 2024 01:13:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jul 2024 01:13:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19341 invoked by uid 111); 2 Jul 2024 01:13:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 21:13:49 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 21:13:50 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240702011350.GA31739@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net>
 <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702005144.GA27170@coredump.intra.peff.net>

On Mon, Jul 01, 2024 at 08:51:45PM -0400, Jeff King wrote:

> Hmm. The patch below seems to work on a simple test.
> 
> The lexer stuffs the heredoc into a special variable. Which at first
> glance feels like a hack versus returning it from the token stream, but
> the contents really _aren't_ part of that stream. They're a separate
> magic thing that is found on the stdin of whatever command the tokens
> represent.
> 
> And then ScriptParser::parse_cmd() just has to recognize that any "<<"
> token isn't interesting, and that "-" means "read the here-doc".

BTW, there's one non-obvious thing here about why this works. You'd
think that:

  test_expect_success 'foo' <<\EOT
	cat <<-\EOF
	this is a here-doc
	EOF
	echo ok
  EOT

wouldn't work, because the lexer only has a single here-doc store, and
the inner one is going to overwrite the outer. But we don't lex the
inner contents of the test snippet until we've processed the
test_expect_success line, at which point we've copied it out.

So I dunno. It feels a bit hacky, but I think it's how you have to do it
anyway.

> @@ -648,7 +654,7 @@ sub parse_cmd {
>  	my @tokens = $self->SUPER::parse_cmd();
>  	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
>  	my $n = $#tokens;
> -	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
> +	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\||<<[A-Za-z]+)$/;

One curiosity I noted is that the backslash of my "<<\EOT" seems to be
eaten by the lexer (I guess because it doesn't know the special meaning
of backslash here, and just does the usual "take the next char
literally"). I think that is OK for our purposes here, though we might
in the long run want to raise a linting error if you accidentally used
an interpolating here-doc (it's not strictly wrong to do so, but I think
we generally frown on it as a style thing).

-Peff
