From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] write_index: optionally allow broken null sha1s
Date: Mon, 26 Aug 2013 20:46:22 -0700
Message-ID: <xmqqy57nhk35.fsf@gitster.dls.corp.google.com>
References: <20130824013310.GA9343@sigill.intra.peff.net>
	<20130825061500.GR2882@elie.Belkin>
	<20130825095818.GA12556@sigill.intra.peff.net>
	<20130825195412.GA2752@elie.Belkin>
	<20130826142704.GA14858@sigill.intra.peff.net>
	<20130826173501.GS4110@google.com>
	<20130826212053.GA25452@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 05:46:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAEg-0005ql-2F
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 05:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab3H0Dq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 23:46:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341Ab3H0DqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 23:46:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 059EF37153;
	Tue, 27 Aug 2013 03:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1fQbdT1wW4Go+F8vhZgLYLLN6Ys=; b=UzwIzs
	xMNw6mHaB2Ta/Y67fqe/ZGjez4fSp3LatKDNhsmdf7Yo6MlNHnG6GM67WXDyR0Pf
	src9THj/my/KezeCF4bEUS61U9euLQtLSfCXTGGacegvZ71h/IQPjK4PjNbJ21R6
	2mSbJ7XT6MkafpZvXl1kBDjUnn89KDc70MLJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SPjMGJtXQhyQuTz1FMronJIYJZrMMfbz
	sNGhXvTVCxLNPqfpnGcXktAotNM1u9n84mgatyQtzmuJFSqe+TVmYR3f6huR0aeE
	6Q8RbHT7wp+OMV66s5cRJYhN2xinNk/jqNIa5LbvUAQG2paQhKVirLoFWB8PGp1k
	sljhWhYFJwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F043F37152;
	Tue, 27 Aug 2013 03:46:24 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E5053714E;
	Tue, 27 Aug 2013 03:46:24 +0000 (UTC)
In-Reply-To: <20130826212053.GA25452@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 26 Aug 2013 17:20:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3EA39E84-0ECB-11E3-93BE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233044>

Jeff King <peff@peff.net> writes:

> I'd be very surprised if this works in practice on most of our current
> test scripts. There are often subtle dependencies on the state left over
> from previous tests. Running the script below up through t3800 (at which
> point I lost patience) reveals 37 test scripts that are broken. Which is
> only about 17%, but we're clearly not quite there yet.
> ...

Yes, I agree that in an ideal world with infinite amount of time, we
should strive to make sure that each test is independent from
previous steps, and if we do not have infinite amount of time, we
should make sure we find some (say 5%) time to various code clean-up
effort, in both writing and reviewing such, including tests.

The attached is cute.  Thanks for a food for thought.

> -- >8 --
> #!/usr/bin/perl
> #
> # Run as "perl foo.pl t0000-basic.sh" (or whatever script you want to
> # check).
>
> my $script = shift;
> my ($script_num) = $script =~ /^(t\d+)/;
>
> # run once to get the list of tests
> my @tests = run_tests($script);
>
> # mark some tests as "setup" tests that will always be run
> foreach my $test (@tests) {
> 	if ($test->{desc} =~ /set.?up/i) {
> 		print STDERR "marking $test->{num} - $test->{desc} as setup\n";
> 		$test->{setup} = 1;
> 	}
> }
>
> # now try each test in isolation, but including setup tests
> foreach my $test (@tests) {
> 	$ENV{GIT_SKIP_TESTS} = skip_all_except($script_num, $test, @tests);
> 	run_tests($script) or die "failed $test->{num} ($test->{desc})\n";
> }
>
> sub run_tests {
> 	my @r;
> 	open(my $fh, '-|', qw(sh), $script);
> 	while (<$fh>) {
> 		/^ok (\d+) - (.*)/ and push @r, { num => $1, desc => $2 };
> 	}
> 	$? and return ();
> 	return @r;
> }
>
> sub skip_all_except {
> 	my $prefix = shift;
> 	my $want = shift;
>
> 	return join(' ',
> 		map { "$prefix.$_->{num}" }
> 		grep { !$_->{setup} && $_->{num} != $want->{num} }
> 		@_);
> }
