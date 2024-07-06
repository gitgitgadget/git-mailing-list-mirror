Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA06291E
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720245707; cv=none; b=MQuMQySuB0xZtbAMAyN+24DpnXHG4II4fvDMbS65bhoVAdxKi4lFUYHU8N5KrwPo6oXjhpUFgT71oyvmcGTteOdh4zS9b02ztWlN2fSjDPgdyieIAqa9Xo3ooK87MXSxk6xWF//Ftu3UaBcc74JU4ne1/xsK56pQxXLfpQff0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720245707; c=relaxed/simple;
	bh=gs195MXwWfi+HBQ+NaXgEcdq+maeceK0DP+QUXh5pho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfHY2mL6FBrCpB6/tf8/FsRJYu51UST4XClbkNwavxyGQHtDPMdN3RrU+AoozEoZDojDLxkzh+DB9KNo5Hr8xfrCAcYnruiOltImOWEBTMcXEnkmgOnr1Afo92euX/WWj3zLzW7C9G6rI2GG3ge1rqICbT3f/Q1LO36qYJTymMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23206 invoked by uid 109); 6 Jul 2024 06:01:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:01:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31108 invoked by uid 111); 6 Jul 2024 06:01:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:01:41 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:01:43 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
Message-ID: <20240706060143.GD698153@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702235034.88219-1-ericsunshine@charter.net>

On Tue, Jul 02, 2024 at 07:50:34PM -0400, Eric Sunshine wrote:

> This is a clean-room implementation which serves the same purpose as a
> change proposed[1] by Peff; it was created before I looked at Peff's
> proposal. The two independent implementations turned out quite similar,
> but the one implemented by this patch takes a more formal and paranoid
> stance. In particular, unlike Peff's patch, it doesn't trust that the
> most-recently-seen heredoc body is one associated with the
> `test_expect_success` invocation.

Thanks for working on this! I think this is better than the patch I
showed earlier. But I am still glad to have worked on that one, because
there is no way I'd be able to intelligently review that one without
having poked at the code so much myself.

> This patch can sit either at the top or bottom of Peff's series[2].
> 
> There was also related discussion of improving the chainlint self-test
> infrastructure[3], however, such proposed changes needn't hold up Peff's
> series[2]; such improvements can be applied after the dust settles. On
> the other hand, Peff, if you plan to reroll for some reason, feel free
> to incorporate this patch into your series.

IMHO we want it all to come together. We should not allow "<<\EOT"
without making sure we can chainlint the test bodies, and we should not
make such a big change to chainlint.pl without tests to make sure it
works.

I'll post some patches in a moment:

  [1/3]: chainlint.pl: fix line number reporting
  [2/3]: t/chainlint: add test_expect_success call to test snippets
  [3/3]: t/chainlint: add tests for test body in heredoc

with the idea that we'd apply your patch here on top of what Junio has
queued in jk/test-body-in-here-doc, and then these three on top. For
Junio's sanity, I'll roll it all up into one series. But I wanted to
show it to you incrementally first, especially because I think the fixes
from patch 1/3 above should probably just get squashed in (or even
rewritten). I'll discuss the bugs they fix below.

> diff --git a/t/chainlint.pl b/t/chainlint.pl
> index 1bbd985b78..eba509b8e1 100755
> --- a/t/chainlint.pl
> +++ b/t/chainlint.pl
> @@ -174,6 +174,8 @@ sub swallow_heredocs {
>  		$$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
>  		if (pos($$b) > $start) {
>  			my $body = substr($$b, $start, pos($$b) - $start);
> +			$self->{parser}->{heredocs}->{$$tag[0]} =
> +			    substr($body, 0, length($body) - length($&));
>  			$self->{lineno} += () = $body =~ /\n/sg;
>  			next;
>  		}

OK, this part looks familiar. :)

> @@ -232,7 +234,8 @@ sub new {
>  	my $self = bless {
>  		buff => [],
>  		stop => [],
> -		output => []
> +		output => [],
> +		heredocs => {},
>  	} => $class;
>  	$self->{lexer} = Lexer->new($self, $s);
>  	return $self;

I think initializing is not strictly necessary here, since we'd only try
to read tags if we saw a here-doc. But there might be some invalid cases
where we could convince higher-level code to look for tags even though
there were none (and generate a perl warning about trying to dereference
undef as a hashref).

On the flip side, what about cleaning up? The "heretags" array is
emptied as we parse the heredocs in swallow_heredocs(). But I think once
a ShellParser's $self->{heredocs}->{FOO} is written, it will hang around
forever (even though it's valid only for that one command). Probably not
a big deal, but there's probably some correct spot to reset it.

> @@ -616,7 +619,9 @@ sub unwrap {
>  
>  sub check_test {
>  	my $self = shift @_;
> -	my ($title, $body) = map(unwrap, @_);
> +	my $title = unwrap(shift @_);
> +	my $body = unwrap(shift @_);
> +	$body = shift @_ if $body eq '-';
>  	$self->{ntests}++;
>  	my $parser = TestParser->new(\$body);
>  	my @tokens = $parser->parse();

This has two problems related to line numbers. You can't see it in the
context, but we later do:

  my $lineno = $_[1]->[3];

Now that we're shifting @_, that array item is gone.

The second is that the line number for the here-doc is actually one past
the initial line number of the test_expect_success. That works
automatically for hanging single-quotes, since the newline from that
line is inside the quoted area. But for a here-doc, we have to account
for it manually. In my original patch I prepended "\n", but you can also
just increment $lineno (which is what I did in the fix I'm about to
send).

> @@ -649,8 +654,13 @@ sub parse_cmd {
>  	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
>  	my $n = $#tokens;
>  	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
> -	$self->check_test($tokens[1], $tokens[2]) if $n == 2; # title body
> -	$self->check_test($tokens[2], $tokens[3]) if $n > 2;  # prereq title body
> +	my $herebody;
> +	if ($n >= 2 && $tokens[$n-1]->[0] eq '-' && $tokens[$n]->[0] =~ /^<<-?(.+)$/) {
> +		$herebody = $self->{heredocs}->{$1};
> +		$n--;
> +	}
> +	$self->check_test($tokens[1], $tokens[2], $herebody) if $n == 2; # title body
> +	$self->check_test($tokens[2], $tokens[3], $herebody) if $n > 2;  # prereq title body
>  	return @tokens;
>  }

OK, mostly as expected. I think the check for "-" here is redundant with
what's in check_test(). We could just feed the heredoc body either way,
and in the nonsense case of:

  test_expect_success 'title' 'test body' <<EOT
  nobody reads this!
  EOT

the heredoc data would just be ignored.

Requiring "<<" at the end is somewhat limiting. E.g. this is valid:

  test_expect_success <<EOT 'title' -
  the test body
  EOT

I don't expect anybody to do that, but it would be nice to be more
robust if we can. I think the tokens are still wrapped at this point, so
we could read through all of them looking for "<<" anywhere, without
getting confused by "$(cat <<INNER_HEREDOC)". I think, anyway (I didn't
test).

I didn't address either of those comments in the patches I'm about to
send.

-Peff
