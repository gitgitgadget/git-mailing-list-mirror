From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/5] Git.pm: add interface for git credential command
Date: Fri, 8 Feb 2013 00:11:20 -0500
Message-ID: <20130208051120.GD4157@sigill.intra.peff.net>
References: <cover.1360242782.git.mina86@mina86.com>
 <78516627e893e54d5aafe0694d1face9a37893de.1360242782.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 06:11:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3gFc-0003yy-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 06:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620Ab3BHFLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 00:11:24 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39115 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab3BHFLW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 00:11:22 -0500
Received: (qmail 26222 invoked by uid 107); 8 Feb 2013 05:12:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 00:12:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 00:11:20 -0500
Content-Disposition: inline
In-Reply-To: <78516627e893e54d5aafe0694d1face9a37893de.1360242782.git.mina86@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215752>

On Thu, Feb 07, 2013 at 03:01:20PM +0100, Michal Nazarewicz wrote:

>  > There are a few disallowed characters, like "\n" in key or value, and
>  > "=" in a key. They should never happen unless the caller is buggy, but
>  > should we check and catch them here?
> 
>  I left it as is for now since it's not entairly clear to me what to
>  do in all cases.  In particular:
>  
>  - when reading, what to do if the line is " foo = bar ",

According to the spec, whitespace (except for the final newline) is not
significant, and that parses key=" foo ", value=" bar ". The spec could
ignore whitespace on the key side, but I intentionally did not in an
attempt to keep the protocol simple. Your original implementation did
the right thing already.

>  - when reading, what to do if the line is "foo=" (ie. empty value),

The empty string is a valid value.

>  - when writing, what to do if value is a single space,

Then it's a single space. It's the caller's problem whether that is an
issue or not.

>  - when writing, what to do if value ends with a new line,

That's bogus. We cannot represent that value. I'd suggest to simply die,
as it is a bug in the caller (we _could_ try to be nice and assume the
caller accidentally forgot to chomp, but I'd rather be careful than
nice).

>  - when writing, what to do if value is empty (currently not printed at all),

I think you should still print it. It's unlikely to matter, but
technically a helper response may override keys (or set them to blank),
and the intermediate state gets sent on to the next helper, if there are
multiple.

>  On Thu, Feb 07 2013, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>  > I think you should credit git-remote-mediawiki for the code in the
>  > commit message. Perhaps have a first "copy/paste" commit, and then an
>  > "adaptation" commit to add sort, ^ anchor in regexp, doc and your
>  > callback mechanism, but I won't insist on that.
> 
>  Good point.  Creating additional commit is a bit too much for my
>  licking, but added note in commit message.

I think that's fine.

> +sub _credential_read {
> +	my %credential;
> +	my ($reader, $op) = (@_);
> +	while (<$reader>) {
> +		if (!/^([^=\s]+)=(.*?)\s*$/) {
> +			throw Error::Simple("unable to parse git credential $op response:\n$_");
> +		}
> +		$credential{$1} = $2;

I think this is worse than your previous version. The spec really is as
simple as:

  while (<$reader>) {
          last if /^$/; # blank line is OK as end-of-credential
          /^([^=]+)=(.*)/
                  or throw Error::Simple(...);
          $credential{$1} = {$2};
  }

(actually, the spec as written does not explicitly forbid an empty key,
but it is nonsensical, and it might be worth updating the docs).

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

When I mentioned error-checking the format, I really just meant
something like:

        $key =~ /[=\n\0]/
                and die "BUG: credential key contains invalid characters: $key";
        if (defined $credential->{$key}) {
                $credential->{$key} =~ /[\n\0]/
                        and die "BUG: credential value contains invalid characters: $credential->{key}";
                print $writer $key, '=', $credential->{$key}, "\n";
        }

Those dies should never happen, and are indicative of a bug in the
caller. We can't even represent them in the protocol, so we might as
well alert the user and die rather than trying to guess what the caller
intended.

-Peff
