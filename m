From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Git.pm: Add interface for git credential command.
Date: Wed, 6 Feb 2013 18:16:25 -0500
Message-ID: <20130206231625.GL27507@sigill.intra.peff.net>
References: <cover.1360183427.git.mina86@mina86.com>
 <f4b5413b0a55474346daa7b0866c7a4fed55778d.1360183427.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 00:16:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3EEX-0003vp-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 00:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758185Ab3BFXQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 18:16:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37236 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757638Ab3BFXQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 18:16:28 -0500
Received: (qmail 12014 invoked by uid 107); 6 Feb 2013 23:17:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 18:17:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 18:16:25 -0500
Content-Disposition: inline
In-Reply-To: <f4b5413b0a55474346daa7b0866c7a4fed55778d.1360183427.git.mina86@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215662>

On Wed, Feb 06, 2013 at 09:47:05PM +0100, Michal Nazarewicz wrote:

> +sub _credential_read {
> +	my %credential;
> +	my ($reader, $op) = (@_);
> +	while (<$reader>) {
> +		chomp;
> +		my ($key, $value) = /([^=]*)=(.*)/;

Empty keys are not valid. Can we make this:

  /^([^=]+)=(.*)/

to fail the regex? Otherwise, I think this check:

> +		if (not defined $key) {
> +			throw Error::Simple("unable to parse git credential $op response:\n$_\n");
> +		}

would not pass because $key would be the empty string.

> +sub _credential_write {
> +	my ($credential, $writer) = @_;
> +
> +	for my $key (sort {
> +		# url overwrites other fields, so it must come first
> +		return -1 if $a eq 'url';
> +		return  1 if $b eq 'url';
> +		return $a cmp $b;
> +	} keys %$credential) {
> +		if (defined $credential->{$key} && length $credential->{$key}) {
> +			print $writer $key, '=', $credential->{$key}, "\n";
> +		}
> +	}

There are a few disallowed characters, like "\n" in key or value, and
"=" in a key. They should never happen unless the caller is buggy, but
should we check and catch them here?

> +In the second form, C<CODE> needs to be a reference to a subroutine.
> +The function will execute C<git credential fill> to fill provided
> +credential hash, than call C<CODE> with C<CREDENTIAL> as the sole
> +argument, and finally depending on C<CODE>'s return value execute
> +C<git credential approve> (if return value yields true) or C<git
> +credential reject> (otherwise).  The return value is the same as what
> +C<CODE> returned.  With this form, the usage might look as follows:

This is a nice touch. It makes the normal calling code a lot simpler.

-Peff
