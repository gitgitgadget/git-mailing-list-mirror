Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803EC13E88C
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954204; cv=none; b=DgzWROZ9DBB1vs8krpcOpCIBCEFA3oiczacs2Zjx3fzUxkz62CF9eL5lTpbMOtXgrnuCnfpH+E2AhF70nrADTvUl63fU0z8LsS4aRL6KxmfPNtqdAutC6T+cLjJFEwjb5cW6hxUESMhF56u0HBGHqjHQqbMbgPdURv5C2U7w+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954204; c=relaxed/simple;
	bh=9XoCppsMQySyQjkHvYK3yfqgJb1eUr/M/0T0SAJctPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuWSZktV5sr4e/xxiH/z8qcEjxPXxdYC8S9IXb3E4jqX1NRB8e2r7dtdXa1rOebZaIRqARQKFC8jwD6OrjvErOrn2QuSXtcFc7ssayV/SfXHWJaYbS3UtfhITJqFjn78FUDdN/SyYn2HpBk+6+fRJSnKVer8EJZzMeFjfIrffM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27609 invoked by uid 109); 21 Jun 2024 07:16:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Jun 2024 07:16:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6768 invoked by uid 111); 21 Jun 2024 07:16:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Jun 2024 03:16:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Jun 2024 03:16:40 -0400
From: Jeff King <peff@peff.net>
To: Eric Wong <e@80x24.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t1006: ensure cat-file info isn't buffered by
 default
Message-ID: <20240621071640.GD2105230@coredump.intra.peff.net>
References: <20240617104326.3522535-1-e@80x24.org>
 <20240617104326.3522535-3-e@80x24.org>
 <xmqq1q4v5m5a.fsf@gitster.g>
 <20240618213041.M462972@dcvr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618213041.M462972@dcvr>

On Tue, Jun 18, 2024 at 09:30:41PM +0000, Eric Wong wrote:

> +script='
> +use warnings;
> +use strict;
> +use IPC::Open2;
> +my ($opt, $oid, $expect, @pfx) = @ARGV;
> +my @cmd = (qw(git cat-file), $opt);
> +my $pid = open2(my $out, my $in, @cmd) or die "open2: @cmd";
> +print $in @pfx, $oid, "\n" or die "print $!";
> +my $rvec = "";
> +vec($rvec, fileno($out), 1) = 1;
> +select($rvec, undef, undef, 30) or die "no response to `@pfx $oid` from @cmd";
> +my $info = <$out>;
> +chop($info) eq "\n" or die "no LF";
> +$info eq $expect or die "`$info` != `$expect`";
> +close $in or die "close in $!";
> +close $out or die "close out $!";
> +waitpid $pid, 0;
> +$? == 0 or die "\$?=$?";
> +'
> +
> +expect="$hello_oid blob $hello_size"
> +
> +test_expect_success PERL '--batch-check is unbuffered by default' '
> +	perl -e "$script" -- --batch-check $hello_oid "$expect"
> +'

We often use "perl -e" for one-liners, etc, but this is pretty big.
Maybe:

  cat >foo.pl <<-\EOF
  ...
  EOF
  perl foo.pl -- ...

would be more readable? To be clear I don't think there's anything
incorrect about your usage, but it would match the style of our suite a
bit better.

Likewise, it would be usual in our suite for the helper to do the
minimum that needs to be in perl, and use our normal functions for
things like comparing output (rather than taking its own "expect"
argument).

So maybe:

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index e12b221972..929d7a7579 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1294,4 +1294,33 @@ test_expect_success 'batch-command flush without --buffer' '
 	grep "^fatal:.*flush is only for --buffer mode.*" err
 '
 
+# Copy a single line from stdin to the program specified
+# by @ARGV, and then wait for a response _without_ closing
+# the pipe.
+cat >run-and-wait.pl <<-\EOF
+use IPC::Open2;
+open2(my $out, my $in, @ARGV) or die "open2: @ARGV";
+print $in scalar(<STDIN>) or die "print $!";
+
+my $rvec = "";
+vec($rvec, fileno($out), 1) = 1;
+select($rvec, undef, undef, 30) or die "no response after 30 seconds";
+
+print scalar(<$out>);
+EOF
+
+test_expect_success PERL '--batch-check is unbuffered by default' '
+	echo "$hello_oid" |
+	perl run-and-wait.pl git cat-file --batch-check >out &&
+	echo "$hello_oid blob $hello_size" >expect &&
+	test_cmp expect out
+'
+
+test_expect_success PERL '--batch-command info is unbuffered by default' '
+	echo "info $hello_oid" |
+	perl run-and-wait.pl git cat-file --batch-command >out &&
+	echo "$hello_oid blob $hello_size" >expect &&
+	test_cmp expect out
+'
+
 test_done

I went for brevity above. Notably missing are:

  - the use of strict/warnings. I think we've shied away from these in
    the test suite because we want to run on any version of perl. In my
    experience most strict/warnings output is actually telling you about
    obvious garbage, but not always. IIRC perl got more strict about
    "()" around lists in some contexts a few years back, and code which
    used to be OK started generating warnings. OTOH, those warnings were
    probably a sign of problems-to-come, anyway. Without "FATAL",
    though, I think "use warnings" is not doing much good (nobody is
    ever going to see its output if the test isn't failing).

  - I dropped the close/waitpid. I guess maybe it is valuable to confirm
    that cat-file did not barf, but IMHO the important thing here is
    testing that it produced the single line of output we expected.

-Peff
