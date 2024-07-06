Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A99291E
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720245919; cv=none; b=GH5HJnggisHL6QqyxrmENZzhadXa/Vanry/Z0vIZ5DtMJS3XnRI3GuHmxFZpkaWVvlLbiXH+YAyL7KxqvkPB/RVcrI04TswP9Oj4EgHdIlk78fLzRQ5XHfRx06KiaKdgJguF88ecCpg7cel4gi4zzY2QQVO331IfVCQzEb2xWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720245919; c=relaxed/simple;
	bh=5d6DrvMS0z2xFd2dCkinbgHnfz/Q/X0wSIYWcI+A3rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d037PGo5f8Vwdlx05JXtLMNvGbkuiTTIQ3nAbwmirUCw2rb+eAD22jVUuzkuYsyx9WDh4ysYb2lYiErS1nWT24CKDzKO8moiv6Te35/nChfMBeYW84O3YQqNNa2LZGIfB/+xIGfmwezJb7B9y3/yfQuLRHIiQFZAGF7z+KsKsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23290 invoked by uid 109); 6 Jul 2024 06:05:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:05:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31147 invoked by uid 111); 6 Jul 2024 06:05:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:05:14 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:05:15 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] chainlint.pl: fix line number reporting
Message-ID: <20240706060515.GA700151@coredump.intra.peff.net>
References: <20240706060143.GD698153@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706060143.GD698153@coredump.intra.peff.net>

The previous commit taught chainlint.pl to handle test bodies in
heredocs, but there are two small bugs related to line numbers:

  1. Prior to that commit, we'd leave the title and body untouched in
     @_. So we could later pull the line number out of the $_[1] array
     element. Now we shift off the front of the array, so we have to
     remember that element to grab the line number. This is a regression
     even for regular:

       test_expect_success 'title' '
               test body
       '

     invocations; the lines for ever test started fresh at 0.

  2. For an invocation like the one above, if the test_expect_success
     line is X, then "test body" would correctly start at X+1, since the
     hanging newline at the start of the single-quoted test body
     increments the count. But for a here-doc, there is an implicit
     newline at the end of the token stream before the here-doc starts.
     We have to increment "lineno" to account for this.

     Actually, this is not _quite_ correct, as there could be multiple
     here-docs, like:

       test_expect_success "$(cat <<END_OF_TITLE)" - <<END_OF_TEST
       this is the title
       END_OF_TITLE
       this is the test
       END_OF_TEST

     in which case we'd need to skip past END_OF_TITLE. Given how
     unlikely it is for anybody to do this, and since it would only
     affect line numbers, it's probably not worth caring about too much.
     The solution would probably be to record the starting line number
     of each here-doc section in the lexer/shellparser stage.

Signed-off-by: Jeff King <peff@peff.net>
---
Note to the maintainer: do not worry about applying these yet! The
parent message describes where they'd go in the series, but I'll send a
full series once Eric and I have worked out the details. Review comments
welcome, of course. :)

I actually suspect the "record the heredoc line number" thing would not
be too hard. I.e., turn ShellParser's "heredoc" hash to point to
hashrefs like: "{ content => ..., lineno => ... }". And that would give
us a good spot to stick an "interpolate" boolean later if we want.

 t/chainlint.pl | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index eba509b8e1..c9ab79b6b0 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -620,15 +620,19 @@ sub unwrap {
 sub check_test {
 	my $self = shift @_;
 	my $title = unwrap(shift @_);
-	my $body = unwrap(shift @_);
-	$body = shift @_ if $body eq '-';
+	my $body = shift @_;
+	my $lineno = $body->[3];
+	$body = unwrap($body);
+	if ($body eq '-') {
+		$body = shift @_;
+		$lineno++;
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
-- 
2.45.2.1178.gaaad15bb7b

