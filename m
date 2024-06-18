Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C415099C
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746249; cv=none; b=Bf83Xw4l8GArM+wzwVJ/nprnLu+OYoQN8QTTaUkPWdGxQt9nl7UAr1RjgCrVQkp46dkaaGzIIntfu/XgwT2zATPUl4Jp1Iu4UtFcQ88OzJxDJuTn9dce2DKxhQ88LQ9ZMh//ESSeQJ7sQoLeqY8LPTtGcCwNqyFm1xtcNAsjCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746249; c=relaxed/simple;
	bh=uIxIAr0j/JblKAhoHwkbHj0i5QLVqD9I6fXJeQMYwYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqBZMli5nW88hzGpdgZgjZ4f1OgYc7eEVZ3uKXVVgoC6IkM4I1uI0GD3edfTyaT9SQROjDPwURJJL6v9JnbfluP50gNGYjipMwL47BVrT7z7iqU6HCK0hPFc9lR8MQnCj1IMtnYaHJWxprIRGhvmJBHgwWQhcbPwE7IMMweY7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=VCC/xT7j; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="VCC/xT7j"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D4A1FB11;
	Tue, 18 Jun 2024 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1718746241;
	bh=uIxIAr0j/JblKAhoHwkbHj0i5QLVqD9I6fXJeQMYwYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCC/xT7j3E/tVFE0uSmE4FmPGhXu4sCru01YgbIJMOPrdpUcLe8cLqsyt0Zz7N3hC
	 WRPhaRCs2pmhS1QIuKGo/KG+N9qMXtd0TxrSfH6dgrJHyGHtd/s6i+3OMAIY3oAjZc
	 hufa137MRl3IPxtEb55Q7Jk1u8z3JrzjEkMwAxeY=
Date: Tue, 18 Jun 2024 21:30:41 +0000
From: Eric Wong <e@80x24.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH v2 2/2] t1006: ensure cat-file info isn't buffered by default
Message-ID: <20240618213041.M462972@dcvr>
References: <20240617104326.3522535-1-e@80x24.org>
 <20240617104326.3522535-3-e@80x24.org>
 <xmqq1q4v5m5a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q4v5m5a.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > Buffering by default breaks some 3rd-party Perl scripts using
> > cat-file, but this breakage was not detected anywhere in our
> > test suite.  The easiest place to test this behavior is with
> > Git.pm, since (AFAIK) other equivalent way to test this behavior
> > from Bourne shell and/or awk would require racy sleeps,
> > non-portable FIFOs or tedious C code.
> 
> Yes, using Perl is a good substitute for writing it in C in this
> case.  I however question the choice to use t9700/test.pl here,
> which is clearly stated that its purpose is to "test perl interface
> which is Git.pm", and added tests are not testing anything in Git.pm
> at all.
> 
> Using t9700/test.pl only because it happens to use "perl -MTest::More"
> sounds a bit eh, suboptimal.

*shrug*  I figure Test::More is common enough since it's part of
the Perl standard library; but I consider Perl a better scripting
language than sh by far and wish our whole test suite were Perl :>

> It seems that there are Perl snippets in other tests (including
> t1006 that is specifically about cat-file).  How involved would it
> be to implement these new tests without modifying unrelated test
> scripts?

> >  t/t9700/test.pl | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)

More code than that.  At least IPC::Open2 takes care of the nasty
portability bits, but getting the Perl quoting nested properly
inside sh was confusing :x

v2: moved test to t1006 to avoid Test::More,
    add select timeout in case a buffering bug does get introduced,
    updated commit message and clarified the bug it's supposed
    to guard against
    (I initially tried stdio buffering, but moved away from it for the
    patch I'm testing...)

----8<----
Subject: [PATCH] t1006: ensure cat-file info isn't buffered by default

While working on buffering changes to `git cat-file' in a
separate patch, I inadvertently made the output of --batch-check
and the `info' command of --batch-command buffered as if
opt->buffer_output is turned on by default.

Buffering by default breaks some 3rd-party Perl scripts using
cat-file, but this breakage was not detected anywhere in our
test suite.  Add a small Perl snippet to test this problem since
(AFAIK) other equivalent ways to test this behavior from Bourne
shell and/or awk would require racy sleeps, non-portable FIFOs
or tedious C code.

Signed-off-by: Eric Wong <e@80x24.org>
---
 t/t1006-cat-file.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index e12b221972..ff9bf213aa 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1294,4 +1294,34 @@ test_expect_success 'batch-command flush without --buffer' '
 	grep "^fatal:.*flush is only for --buffer mode.*" err
 '
 
+script='
+use warnings;
+use strict;
+use IPC::Open2;
+my ($opt, $oid, $expect, @pfx) = @ARGV;
+my @cmd = (qw(git cat-file), $opt);
+my $pid = open2(my $out, my $in, @cmd) or die "open2: @cmd";
+print $in @pfx, $oid, "\n" or die "print $!";
+my $rvec = "";
+vec($rvec, fileno($out), 1) = 1;
+select($rvec, undef, undef, 30) or die "no response to `@pfx $oid` from @cmd";
+my $info = <$out>;
+chop($info) eq "\n" or die "no LF";
+$info eq $expect or die "`$info` != `$expect`";
+close $in or die "close in $!";
+close $out or die "close out $!";
+waitpid $pid, 0;
+$? == 0 or die "\$?=$?";
+'
+
+expect="$hello_oid blob $hello_size"
+
+test_expect_success PERL '--batch-check is unbuffered by default' '
+	perl -e "$script" -- --batch-check $hello_oid "$expect"
+'
+
+test_expect_success PERL '--batch-command info is unbuffered by default' '
+	perl -e "$script" -- --batch-command $hello_oid "$expect" "info "
+'
+
 test_done
