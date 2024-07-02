Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B25BA27
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719881509; cv=none; b=tqvFHT+w/zGvY/b/emj4Of8gztASrNKydQU4IJbhpPeI0Ozp9WWV1fYjWj77UTGEZlNTm1IUzVHRTWI7HbNJ/vtiKNyBzHwFDutrKr59IRM0nensBRgSa7Ij0VUlmEWWLbrDE/w54mljZRzKz5xL+pDf1/v58mMvGJTT6H9SVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719881509; c=relaxed/simple;
	bh=0lVyi/jMPgH3Gnf8XBrrtVzq2UJV+BTKTHqQCieAnDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/0wJj4htoV1NcGxRUIFQyj96I1uuDHKnt6LvFrmqTw9DtsF4K9s+V5FKRD8RpdboKCGCJrycPc/u8x/x+sraOW9mf+OTDjSMrQcNRFQcPi2b4arGtvxEaSWFD/sy5r5WckH3jr7InU403vMRyp8Ke5qwzZPMdkUIBms21e8be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30419 invoked by uid 109); 2 Jul 2024 00:51:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jul 2024 00:51:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19208 invoked by uid 111); 2 Jul 2024 00:51:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 20:51:43 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 20:51:44 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240702005144.GA27170@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net>
 <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>

On Mon, Jul 01, 2024 at 06:45:19PM -0400, Eric Sunshine wrote:

> > @@ -906,6 +906,14 @@ see test-lib-functions.sh for the full list and their options.
> > +   If <script> is `-` (a single dash), then the script to run is read
> > +   from stdin. This lets you more easily use single quotes within the
> > +   script by using a here-doc. For example:
> > +
> > +       test_expect_success 'output contains expected string' - <<\EOT
> > +               grep "this string has 'quotes' in it" output
> > +       EOT
> 
> We lose `chainlint` functionality for test bodies specified in this manner.
> 
> Restoring such functionality will require some (possibly)
> not-so-subtle changes. There are at least a couple issues which need
> to be addressed:
> 
> (1) chainlint.pl:ScriptParser::parse_cmd() only currently recognizes
> `test_expect_* [prereq] 'title' 'body'` but will now also need to
> recognize `test_expect_success [prereq] 'title' - <body-as-here-doc>`.
> 
> (2) Until now, chainlint.pl has never had to concern itself with the
> body of a here-doc; it just throws them away. With this new calling
> convention, here-doc bodies become relevant and must be returned by
> the lexer. This may involve some not-so-minor surgery.

Hmm. The patch below seems to work on a simple test.

The lexer stuffs the heredoc into a special variable. Which at first
glance feels like a hack versus returning it from the token stream, but
the contents really _aren't_ part of that stream. They're a separate
magic thing that is found on the stdin of whatever command the tokens
represent.

And then ScriptParser::parse_cmd() just has to recognize that any "<<"
token isn't interesting, and that "-" means "read the here-doc".

Obviously we'd want to add to the chainlint tests here. It looks like
the current test infrastructure is focused on evaluating snippets, with
the test_expect_success part already handled.

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 1bbd985b78..7eb904afaa 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -168,12 +168,15 @@ sub swallow_heredocs {
 	my $self = shift @_;
 	my $b = $self->{buff};
 	my $tags = $self->{heretags};
+	$self->{parser}->{heredoc} = '';
 	while (my $tag = shift @$tags) {
 		my $start = pos($$b);
 		my $indent = $$tag[0] =~ s/^\t// ? '\\s*' : '';
 		$$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
 		if (pos($$b) > $start) {
 			my $body = substr($$b, $start, pos($$b) - $start);
+			$self->{parser}->{heredoc} .=
+				substr($body, 0, length($body) - length($&));
 			$self->{lineno} += () = $body =~ /\n/sg;
 			next;
 		}
@@ -618,6 +621,9 @@ sub check_test {
 	my $self = shift @_;
 	my ($title, $body) = map(unwrap, @_);
 	$self->{ntests}++;
+	if ($body eq '-') {
+		$body = $self->{heredoc};
+	}
 	my $parser = TestParser->new(\$body);
 	my @tokens = $parser->parse();
 	my $problems = $parser->{problems};
@@ -648,7 +654,7 @@ sub parse_cmd {
 	my @tokens = $self->SUPER::parse_cmd();
 	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
 	my $n = $#tokens;
-	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
+	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\||<<[A-Za-z]+)$/;
 	$self->check_test($tokens[1], $tokens[2]) if $n == 2; # title body
 	$self->check_test($tokens[2], $tokens[3]) if $n > 2;  # prereq title body
 	return @tokens;

-Peff
