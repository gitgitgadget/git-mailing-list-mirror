From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] write_index: optionally allow broken null sha1s
Date: Mon, 26 Aug 2013 17:20:53 -0400
Message-ID: <20130826212053.GA25452@sigill.intra.peff.net>
References: <20130824013310.GA9343@sigill.intra.peff.net>
 <20130825061500.GR2882@elie.Belkin>
 <20130825095818.GA12556@sigill.intra.peff.net>
 <20130825195412.GA2752@elie.Belkin>
 <20130826142704.GA14858@sigill.intra.peff.net>
 <20130826173501.GS4110@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 23:21:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE4Dd-0001C4-CI
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 23:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab3HZVU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 17:20:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:40127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712Ab3HZVU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 17:20:56 -0400
Received: (qmail 32604 invoked by uid 102); 26 Aug 2013 21:20:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 16:20:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 17:20:53 -0400
Content-Disposition: inline
In-Reply-To: <20130826173501.GS4110@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233033>

On Mon, Aug 26, 2013 at 10:35:01AM -0700, Jonathan Nieder wrote:

> > I don't see that splitting it up more hurts this. If we wanted more
> > automatic rearranging or skipping of tests, we would need tests to
> > declare dependencies on their setup. And we would need to be able to
> > declare dependencies on multiple tests, since having a single setup test
> > does not work in all cases (e.g., sometimes you are testing each step,
> > and the final step relies on earlier steps).
> 
> Actually dependencies can already be inferred for most test scripts
> using the following rule:
> 
> 	Each test depends on all tests with the word "setup" or the
> 	phrase "set up" in their title that precede it.

I'd be very surprised if this works in practice on most of our current
test scripts. There are often subtle dependencies on the state left over
from previous tests. Running the script below up through t3800 (at which
point I lost patience) reveals 37 test scripts that are broken. Which is
only about 17%, but we're clearly not quite there yet.

But sure, I agree that is something to strive for. But I think my point
stands; splitting up the setup doesn't hurt as long as you note all of
the tests as dependencies. And by your rule above, the advice would be
"each of these tests should say "setup" in the description". That makes
sense to me, and I don't mind doing it here.

> Of course splitting up the setup into 3 steps neither helps nor hurts
> that.  What I was complaining about is splitting the filter-branch
> from the verification that filter-branch had the right result.

I totally missed your original point, then. I don't mind combining the
last two into a single test. That makes sense to me (I only split them
at all because I added the second one much later during the
development).

-Peff

-- >8 --
#!/usr/bin/perl
#
# Run as "perl foo.pl t0000-basic.sh" (or whatever script you want to
# check).

my $script = shift;
my ($script_num) = $script =~ /^(t\d+)/;

# run once to get the list of tests
my @tests = run_tests($script);

# mark some tests as "setup" tests that will always be run
foreach my $test (@tests) {
	if ($test->{desc} =~ /set.?up/i) {
		print STDERR "marking $test->{num} - $test->{desc} as setup\n";
		$test->{setup} = 1;
	}
}

# now try each test in isolation, but including setup tests
foreach my $test (@tests) {
	$ENV{GIT_SKIP_TESTS} = skip_all_except($script_num, $test, @tests);
	run_tests($script) or die "failed $test->{num} ($test->{desc})\n";
}

sub run_tests {
	my @r;
	open(my $fh, '-|', qw(sh), $script);
	while (<$fh>) {
		/^ok (\d+) - (.*)/ and push @r, { num => $1, desc => $2 };
	}
	$? and return ();
	return @r;
}

sub skip_all_except {
	my $prefix = shift;
	my $want = shift;

	return join(' ',
		map { "$prefix.$_->{num}" }
		grep { !$_->{setup} && $_->{num} != $want->{num} }
		@_);
}
