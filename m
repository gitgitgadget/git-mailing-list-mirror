From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support
Date: Mon, 4 Feb 2013 16:17:26 -0500
Message-ID: <20130204211726.GB13186@sigill.intra.peff.net>
References: <87ehgvua6h.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:17:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2TQG-0004Ri-Dc
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 22:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab3BDVRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 16:17:30 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60659 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303Ab3BDVR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 16:17:29 -0500
Received: (qmail 22472 invoked by uid 107); 4 Feb 2013 21:18:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Feb 2013 16:18:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2013 16:17:26 -0500
Content-Disposition: inline
In-Reply-To: <87ehgvua6h.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215421>

On Mon, Feb 04, 2013 at 02:54:30PM -0500, Ted Zlatanov wrote:

> +	print <<EOHIPPUS;
> +
> +$0 [-f AUTHFILE] [-d] get
> +
> +Version $VERSION by tzz\@lifelogs.com.  License: BSD.

This here-doc is interpolated so you can use $0 and $VERSION, and
therefore have to quote the @-sign. But later in the here-doc...

> +Thus, when we get "protocol=https\nusername=tzz", this credential
> +helper will look for lines in AUTHFILE that match

Do you need to quote "\n" here?

> +die "Sorry, you need to specify an existing netrc file (with or without a .gpg extension) with -f AUTHFILE"
> + unless defined $file;
> +
> +unless (-f $file) {
> +	print STDERR "Sorry, the specified netrc $file is not accessible\n" if $debug;
> +	exit 0;
> +}

Hmm, so it's not an error (just a warning) to say:

  git credential-netrc -f /does/not/exist

but it is an error to say:

  git credential-netrc

and have it fail to find any netrc files. Shouldn't the latter be a
lesser error than the former?

> +while (<STDIN>) {
> +	next unless m/([^=]+)=(.+)/;
> +
> +	my ($token, $value) = ($1, $2);
> +	die "Unknown search token $1" unless exists $q{$token};
> +	$q{$token} = $value;
> +}

Should this regex be anchored at the start of the string? I think the
left-to-right matching means we will correctly match:

  key=value with=in it

so it may be OK.

> +if ($debug) {
> +	printf STDERR "searching for %s = %s\n", $_, $q{$_} || '(any value)'
> +	 foreach sort keys %q;
> +}

Leftover one-char indent.

> [...]

The rest looks OK to me.
