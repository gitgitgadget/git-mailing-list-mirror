Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8C197A7B
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657446; cv=none; b=U8sGYykY0uJa7uqy0FTWihrg7WoQXEQnFGd7R2ZKMC6gZbYKa5op7vaCtySyowheXr8YrkmV110cwmFLTWLzsrlH2Jt2hb6GOHXLXOByrfkH9V6hldBlBKq9nqfJ5nB71Dk7WMlmV7/v+1/dTG5IRCL/t4QTPdRPY3y9zCp8K08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657446; c=relaxed/simple;
	bh=C+eo+rOQQWbMe07awj2r6CzWIAq1Xh8I+AuMkWW/ejw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WukCJfvMuGg+tqeix2lip3MhbHnJEFCPwr8hh7B0AzquAWAT/ngggDBVcoWGH9cYxXbUsgOqaed+uYs9Tc+KRTlIaDLLiQ/xHjSu0tFx0j18ZMMC1Fhsv/nD4AAsn3xLDmzNsZXiPTwTGCPBN6dxdJ8cSwH1/0fJdsJ/zbI/3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y52Ycv8j; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y52Ycv8j"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D807242A0;
	Mon, 17 Jun 2024 16:50:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=C+eo+rOQQWbMe07awj2r6CzWIAq1Xh8I+AuMkW
	W/ejw=; b=Y52Ycv8jai/rMwBHrvP2imbkDUdocLnU4RIFOk6ktGyiw+OIwTX1tr
	6PsQY0sUyg2RJRN3XfmFNRDT19GJ/v/YsV2TzjHbEzyPlWdxIe+auuqGS5/b4lXl
	EBURZF7wH96vy6uae79R0ZoVwUWtNCgqKtC4wcoxSTw/b1lehVv2U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84FEB2429F;
	Mon, 17 Jun 2024 16:50:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F10FA2429E;
	Mon, 17 Jun 2024 16:50:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] t9700: ensure cat-file info isn't buffered by default
In-Reply-To: <20240617104326.3522535-3-e@80x24.org> (Eric Wong's message of
	"Mon, 17 Jun 2024 10:43:26 +0000")
References: <20240617104326.3522535-1-e@80x24.org>
	<20240617104326.3522535-3-e@80x24.org>
Date: Mon, 17 Jun 2024 13:50:41 -0700
Message-ID: <xmqq1q4v5m5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 43500DCE-2CEB-11EF-9D19-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Eric Wong <e@80x24.org> writes:

> Buffering by default breaks some 3rd-party Perl scripts using
> cat-file, but this breakage was not detected anywhere in our
> test suite.  The easiest place to test this behavior is with
> Git.pm, since (AFAIK) other equivalent way to test this behavior
> from Bourne shell and/or awk would require racy sleeps,
> non-portable FIFOs or tedious C code.

Yes, using Perl is a good substitute for writing it in C in this
case.  I however question the choice to use t9700/test.pl here,
which is clearly stated that its purpose is to "test perl interface
which is Git.pm", and added tests are not testing anything in Git.pm
at all.

Using t9700/test.pl only because it happens to use "perl -MTest::More"
sounds a bit eh, suboptimal.

It seems that there are Perl snippets in other tests (including
t1006 that is specifically about cat-file).  How involved would it
be to implement these new tests without modifying unrelated test
scripts?

> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  t/t9700/test.pl | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t9700/test.pl b/t/t9700/test.pl
> index d8e85482ab..94a2e2c09d 100755
> --- a/t/t9700/test.pl
> +++ b/t/t9700/test.pl
> @@ -154,6 +154,20 @@ sub adjust_dirsep {
>  		     "abc\"\\ \x07\x08\x09\x0a\x0b\x0c\x0d\x01 ",
>  		     'unquote escape sequences');
>  
> +# ensure --batch-check is unbuffered by default
> +my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-check));
> +print $out $file1hash, "\n" or die $!;
> +my $info = <$in>;
> +is $info, "$file1hash blob 15\n", 'command_bidi_pipe w/ --batch-check';
> +$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
> +
> +# ditto with `info' with --batch-command
> +($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-command));
> +print $out 'info ', $file1hash, "\n" or die $!;
> +$info = <$in>;
> +is $info, "$file1hash blob 15\n", 'command_bidi_pipe w/ --batch-command=info';
> +$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
> +
>  printf "1..%d\n", Test::More->builder->current_test;
>  
>  my $is_passing = eval { Test::More->is_passing };
