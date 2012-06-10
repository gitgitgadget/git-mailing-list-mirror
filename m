From: Jeff King <peff@peff.net>
Subject: Re: [PATCH_v1] add git credential login to remote mediawiki
Date: Sun, 10 Jun 2012 14:39:21 -0400
Message-ID: <20120610183921.GA8614@sigill.intra.peff.net>
References: <1339268028-13991-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <20120610121827.GB6453@sigill.intra.peff.net>
 <vpqaa0bmgnt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:40:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdn3V-0002OI-WD
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 20:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab2FJSjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 14:39:25 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:49302
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889Ab2FJSjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 14:39:24 -0400
Received: (qmail 26006 invoked by uid 107); 10 Jun 2012 18:39:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Jun 2012 14:39:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Jun 2012 14:39:21 -0400
Content-Disposition: inline
In-Reply-To: <vpqaa0bmgnt.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199618>

On Sun, Jun 10, 2012 at 03:37:42PM +0200, Matthieu Moy wrote:

> > Is there any reason not to add this to perl/Git.pm? I suspect that other
> > scripts will want to use it, too (for example, send-email could probably
> > use it for SMTP credentials).
> 
> Currently, git-remote-mediawiki is a standalone script (doesn't use
> Git.pm). This is good because it makes it trivial to install, but bad in
> the sense that it may force us (or others) to reinvent the wheel.
> 
> Until now, the wheels we reinvented were very simple (run_git
> essentially), but we may be reaching the point where it makes sense to
> use and contribute to Git.pm.

Yeah, I noticed that. But hopefully since they are at least in the same
distribution, it is just a matter of getting the Makefiles right, and
will not be an extra burden on the user.

> Unfortunately, from a non-technical point of view, Javier is
> contributing this as part of a student project, which ends this week,
> and it's probably not reasonable to introduce such change so late. So,
> I'd keep it here at least for now, and a move to Git.pm could be a
> separate future topic.

Totally understood. I review from git's perspective, but it is up to you
to manage your students' workload. We can migrate the code to Git.pm
later (probably as part of a series which actually introduces a second
caller).

> >   sub fill_credential {
> >           my $quoted_url = quotemeta(shift);
> >
> >           my $verbatim = `git credential fill $quoted_url`;
> >           $? and die "git-credential failed";
> >
> >           $verbatim =~ /^username=(.*)$/m
> >                   or die "git-credential did not give us a username";
> >           my $username = $1;
> >           $verbatim =~ /^password=(.*)$/m
> >                   or die "git-credential did not give us a password";
> >
> >           return ($username, $password, $verbatim);
> >   }
> >
> >   sub report_credential {
> >           my ($type, $verbatim) = @_;
> >           open(my $fh, '|-', "git credential $type");
> >           print $fh $verbatim;
> >   }
> 
> That sounds sensible too. We should be careful not to give a password as
> argument (or users of the same machine will be able to find it with e.g.
> "ps u"), but your proposal is OK with that.

Yes, that was intentional (and is the reason why helpers do so much over
stdin, even though it would reduce their parsing load if they could use
command-line arguments). Unfortunately, there is still one case that
reveals a password on the command-line: if a caller has a URL that
contains an embedded password like:

  https://bob:secret@example.com/foo.git

It's tempting to say "well, then they don't need to ask git-credential
at all!". But the point of handing the whole URL to git-credential is so
that the caller doesn't _have_ to do the parsing. So how would it know
that the URL contains a password? :)

So instead of a URL on the command-line, it might make sense to simply
let the caller send an extra "url=" parameter on stdin (in addition to
any broken-down parameters, if it also wishes). It's way less convenient
(you are stuck with open2 from perl, rather than simple backticks), but
I think we should be cautious due to the security implications.

> >> +			# error if key undef
> >> +			if (not defined $key) {
> >> +				print STDERR "ERROR reciving reponse git credential fill\n";
> >> +				exit 1;
> >> +			}
> [...]
> >> +	} else {
> >> +		while (<Reader>) {
> >> +			print STDERR "\nERROR while running git credential $op:\n$_";
> >> +		}
> >> +	}
> >> +}
> >
> > This isn't a good way to check for errors. The non-fill actions will
> > never produce output on stdout, and you are not intercepting their
> > stderr. Besides which, checking for errors by reading stderr is not a
> > good practice; you should check the return value of the command in $?
> > after it finishes.
> 
> I think it should do both. In case "git credential fill" returns
> something that doesn't match the regexp, we don't want perl to error
> with "use of undefined value", but that's just being defensive because
> it shouldn't happen.

Sorry, I just meant the latter block. It is checking for non-fill
actions to send any output, which they will never do (yes, it would be
an error for them to do so, but it is a very unlikely bug, and IMHO not
really worth checking).

-Peff
