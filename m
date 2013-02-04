From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Mon, 4 Feb 2013 18:23:17 -0500
Message-ID: <20130204232317.GA17705@sigill.intra.peff.net>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com>
 <7vd2wf1yex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Zlatanov <tzz@lifelogs.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:23:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2VO3-0003Mq-IK
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 00:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab3BDXXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 18:23:21 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60762 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594Ab3BDXXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 18:23:20 -0500
Received: (qmail 23877 invoked by uid 107); 4 Feb 2013 23:24:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Feb 2013 18:24:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2013 18:23:17 -0500
Content-Disposition: inline
In-Reply-To: <7vd2wf1yex.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215429>

On Mon, Feb 04, 2013 at 02:56:06PM -0800, Junio C Hamano wrote:

> > +my $mode = shift @ARGV;
> > +
> > +# credentials may get 'get', 'store', or 'erase' as parameters but
> > +# only acknowledge 'get'
> > +die "Syntax: $0 [-f AUTHFILE] [-d] get" unless defined $mode;
> > +
> > +# only support 'get' mode
> > +exit unless $mode eq 'get';
> 
> The above looks strange.  Why does the invoker get the error message
> only when it runs this without arguments?  Did you mean to say more
> like this?
> 
> 	unless (defined $mode && $mode eq 'get') {
> 		die "...";
> 	}

Not having a mode is an invocation error; the credential-helper
documentation indicates that the helper will always be invoked with an
action. The likely culprit for not having one is the user invoking it
manually, and showing the usage there is a sensible action.

Whereas invoking it with a mode other than "get" is not an error at all.
Git will run it with the "store" and "erase" actions, too. Those happen
to be no-ops for this helper, so it exits silently. The credential docs
specify that any other actions should be ignored, too, to allow for
future expansion.

> > +my $debug = $options{debug};
> > +my $file = $options{file};
> > +
> > +unless (defined $file) {
> > +	print STDERR "Please specify an existing netrc file (with or without a .gpg extension) with -f AUTHFILE\n" if $debug;
> > +	exit 0;
> > +}
> > +
> > +unless (-f $file) {
> > +	print STDERR "Sorry, the specified netrc $file is not accessible\n" if $debug;
> > +	exit 0;
> > +}
> 
> Perhaps "-r $file", if you say "is not accessible"?

Even better: look at whether opening the file was successful. Though I
guess that is complicated by the use of gpg, who will probably not
distinguish ENOENT from other failures for us.

> Is it sensible to squelch the error message by default and force
> user to specify --debug?  You could argue that the option is to
> debug the user's configuration, but the name of the option sounds
> more like it is for debugging this script itself.
> 
> I saw Peff already pointed out error conditions, but I am not sure
> why all of these exit with 0.  If the user has configured

It was from my suggestion to ignore missing files, which is that the
user might have the helper configured (e.g., via /etc/gitconfig, or by a
shared ~/.gitconfig) but not actually have a netrc.

It gets confusing because the contents of $file may have been
auto-detected, or it may have come from the command-line, and we do not
remember which at this point.

I was trying not to be too nit-picky with my review, but here is how I
would have written the outer logic of the script:

  my $tokens = read_credential_data_from_stdin();
  if ($options{file}) {
          my @entries = load_netrc($options{file})
                  or die "unable to open $options{file}: $!";
          check_netrc($tokens, @entries);
  }
  else {
          foreach my $ext ('.gpg', '') {
                  foreach my $base (qw(authinfo netrc)) {
                          my @entries = load_netrc("$base$ext")
                                  or next;
                          if (check_netrc($tokens, @entries)) {
                                  last;
                          }
                  }
          }
  }

I.e., to fail on "-f", but otherwise treat unreadable auto-selected
files as a no-op, for whatever reason. I'd also consider checking all
files if they are available, in case the user has multiple (e.g., they
keep low-quality junk unencrypted but some high-security passwords in a
.gpg file). Not that likely, but not any harder to implement.

-Peff
