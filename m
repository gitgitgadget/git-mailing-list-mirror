From: Jeff King <peff@peff.net>
Subject: Re: [PATCH_v1] add git credential login to remote mediawiki
Date: Sun, 10 Jun 2012 08:18:28 -0400
Message-ID: <20120610121827.GB6453@sigill.intra.peff.net>
References: <1339268028-13991-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 14:18:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdh6K-0001EJ-Im
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 14:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab2FJMSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 08:18:31 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:49004
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755446Ab2FJMSa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 08:18:30 -0400
Received: (qmail 22559 invoked by uid 107); 10 Jun 2012 12:18:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Jun 2012 08:18:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Jun 2012 08:18:28 -0400
Content-Disposition: inline
In-Reply-To: <1339268028-13991-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199593>

On Sat, Jun 09, 2012 at 08:53:48PM +0200, Javier.Roucher-Iglesias@ensimag.imag.fr wrote:

> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
> index c18bfa1..4b14d78 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -152,28 +152,111 @@ while (<STDIN>) {
>  ########################## Functions ##############################
>  
>  # MediaWiki API instance, created lazily.
> +sub run_credential {

Is there any reason not to add this to perl/Git.pm? I suspect that other
scripts will want to use it, too (for example, send-email could probably
use it for SMTP credentials).

> +	if (scalar(@_) == 2) {
> +		if ($_[1] eq ("store" || "cache")) {
> +			run_git("config credential.helper \'$_[1]\'");
> +		} else {
> +			print STDERR "ERROR: run_credential (fill|approve|reject) [store|cache]\n";
> +			exit 1;
> +		}
> +	}

This hunk looks wrong. You should never be setting the credential.helper
config; that is the responsibility of the user to set, as they want to
select whatever helper is appropriate. Nor do you need to care about
which helpers are in use; the point of git-credential is that it will do
that for you.

> +	my $parsed = URI->new($url);
> +	$cre_protocol = $parsed->scheme;
> +	$cre_host = $parsed->host;
> +	$cre_path = $parsed->path;
> +
> +        if ($wiki_login ne "") {
> +                $msg .= "username=$wiki_login\n";
> +        }
> +        if ($wiki_passwd ne "") {
> +                $msg .= "password=$wiki_passwd\n";
> +        }
> +        if ($cre_protocol ne "") {
> +                $msg .= "protocol=$cre_protocol\n";
> +        }
> +        if ($cre_host ne "") {
> +                $msg .= "host=$cre_host\n";
> +        }
> +        if ($cre_path ne "") {
> +                $msg .= "path=$cre_path\n";
> +        }
> +
> +        $msg .= "\n";

All of this could just go away for the "fill" case if we allow URLs on
the command line (see my previous email if you haven't already). And for
the "approve" and "reject" cases, we could just save the result from
"fill" and feed it back verbatim, as I described in the earlier email.

Then it would be as simple as:

  sub fill_credential {
          my $quoted_url = quotemeta(shift);

          my $verbatim = `git credential fill $quoted_url`;
          $? and die "git-credential failed";

          $verbatim =~ /^username=(.*)$/m
                  or die "git-credential did not give us a username";
          my $username = $1;
          $verbatim =~ /^password=(.*)$/m
                  or die "git-credential did not give us a password";

          return ($username, $password, $verbatim);
  }

  sub report_credential {
          my ($type, $verbatim) = @_;
          open(my $fh, '|-', "git credential $type");
          print $fh $verbatim;
  }

> +	my $key;
> +	my $value;
> +	my $Prog = "git credential $op";
> +	open2(*Reader, *Writer, $Prog);
> +	print Writer $msg;
> +	close (Writer);
> +
> +	if ($op eq "fill") {
> +		while (<Reader>) {
> +			my ($key, $value) = /([^=]*)=(.*)/;
> +			# error if key undef
> +			if (not defined $key) {
> +				print STDERR "ERROR reciving reponse git credential fill\n";
> +				exit 1;
> +			}
> +			if ($key eq "username") {
> +				$wiki_login = $value;
> +			}
> +			if ($key eq "password") {
> +				$wiki_passwd = $value;
> +			}
> +		}
> +	} else {
> +		while (<Reader>) {
> +			print STDERR "\nERROR while running git credential $op:\n$_";
> +		}
> +	}
> +}

This isn't a good way to check for errors. The non-fill actions will
never produce output on stdout, and you are not intercepting their
stderr. Besides which, checking for errors by reading stderr is not a
good practice; you should check the return value of the command in $?
after it finishes.

-Peff
