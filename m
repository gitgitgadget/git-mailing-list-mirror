Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D3143736
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600715; cv=none; b=TfrGQze4lfugBzgW9UegKsjJIAi/5Hz0SnHYZbxpre9mUu/1PMH2qqEtxslfmOpmvfcESH6D0fKc4j7sFGFhgjDAbQavcf7CZoNmvXwJ2ZwzKkgNk6uXwGj7Lrsi7K91jLRPkEiL1bptLm+oDqWhCuZiU556/NH+vFi8k1BY/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600715; c=relaxed/simple;
	bh=/ezaTmo4X6o57PXFXiSQTCZdlH/IWbHGqkZPlRhfV/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAcG6jZHvsxQk3i8r8v6eH/QZeGFjd99patbZFCX82ljx7eiWC9P4/FBneoCWX4L9OQ+7+BSPP7APZPiNUEdTROtmSFm1T+5GG8NcJhaHqDMDQp0UzbLd7c2S9WWPTveVbpqD8WkCkSGujd3+VH9py8Epjcb3V8k1/fnOxB88Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1688 invoked by uid 109); 10 Jul 2024 08:38:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 08:38:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10452 invoked by uid 111); 10 Jul 2024 08:38:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 04:38:30 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 04:38:31 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 6/9] chainlint.pl: recognize test bodies defined via
 heredoc
Message-ID: <20240710083831.GF2060601@coredump.intra.peff.net>
References: <20240710083416.GA2060328@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710083416.GA2060328@coredump.intra.peff.net>

From: Eric Sunshine <sunshine@sunshineco.com>

In order to check tests for semantic problems, chainlint.pl scans test
scripts, looking for tests defined as:

    test_expect_success [prereq] title '
        body
    '

where `body` is a single string which is then treated as a standalone
chunk of code and "linted" to detect semantic issues. (The same happens
for `test_expect_failure` definitions.)

The introduction of test definitions in which the test body is instead
presented via a heredoc rather than as a single string creates a blind
spot in the linting process since such invocations are not recognized by
chainlint.pl.

Prepare for this new style by also recognizing tests defined as:

    test_expect_success [prereq] title - <<\EOT
        body
    EOT

A minor complication is that chainlint.pl has never considered heredoc
bodies significant since it doesn't scan them for semantic problems,
thus it has always simply thrown them away. However, with the new
`test_expect_success` calling sequence, heredoc bodies become
meaningful, thus need to be captured.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/chainlint.pl | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index fb749d3d5c..5361f23b1d 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -174,6 +174,10 @@ sub swallow_heredocs {
 		$$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
 		if (pos($$b) > $start) {
 			my $body = substr($$b, $start, pos($$b) - $start);
+			$self->{parser}->{heredocs}->{$$tag[0]} = {
+				content => substr($body, 0, length($body) - length($&)),
+				start_line => $self->{lineno},
+		        };
 			$self->{lineno} += () = $body =~ /\n/sg;
 			next;
 		}
@@ -232,7 +236,8 @@ sub new {
 	my $self = bless {
 		buff => [],
 		stop => [],
-		output => []
+		output => [],
+		heredocs => {},
 	} => $class;
 	$self->{lexer} = Lexer->new($self, $s);
 	return $self;
@@ -616,14 +621,21 @@ sub unwrap {
 
 sub check_test {
 	my $self = shift @_;
-	my ($title, $body) = map(unwrap, @_);
+	my $title = unwrap(shift @_);
+	my $body = shift @_;
+	my $lineno = $body->[3];
+	$body = unwrap($body);
+	if ($body eq '-') {
+		my $herebody = shift @_;
+		$body = $herebody->{content};
+		$lineno = $herebody->{start_line};
+	}
 	$self->{ntests}++;
 	my $parser = TestParser->new(\$body);
 	my @tokens = $parser->parse();
 	my $problems = $parser->{problems};
 	return unless $emit_all || @$problems;
 	my $c = main::fd_colors(1);
-	my $lineno = $_[1]->[3];
 	my $start = 0;
 	my $checked = '';
 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
@@ -649,8 +661,13 @@ sub parse_cmd {
 	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
 	my $n = $#tokens;
 	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
-	$self->check_test($tokens[1], $tokens[2]) if $n == 2; # title body
-	$self->check_test($tokens[2], $tokens[3]) if $n > 2;  # prereq title body
+	my $herebody;
+	if ($n >= 2 && $tokens[$n-1]->[0] eq '-' && $tokens[$n]->[0] =~ /^<<-?(.+)$/) {
+		$herebody = $self->{heredocs}->{$1};
+		$n--;
+	}
+	$self->check_test($tokens[1], $tokens[2], $herebody) if $n == 2; # title body
+	$self->check_test($tokens[2], $tokens[3], $herebody) if $n > 2;  # prereq title body
 	return @tokens;
 }
 
-- 
2.45.2.1249.gb036353db5

