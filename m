From: Eric Wong <e@80x24.org>
Subject: Re: [WIP-PATCH 1/2] send-email: create email parser subroutine
Date: Sat, 28 May 2016 23:33:29 +0000
Message-ID: <20160528233329.GA1132@dcvr.yhbt.net>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
 <20160527140104.11192-2-samuel.groot@grenoble-inp.org>
 <vpqeg8mi4wm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 29 01:33:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6njh-0003Bt-Uw
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 01:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbcE1Xda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 19:33:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44890 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcE1Xda (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 19:33:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1646C1FCC6;
	Sat, 28 May 2016 23:33:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <vpqeg8mi4wm.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295831>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
> 
> > Parsing and processing in send-email is done in the same loop.
> >
> > To make the code more maintainable, we create two subroutines:
> > - `parse_email` to separate header and body
> > - `parse_header` to retrieve data from header
> 
> These routines are not specific to git send-email, nor to Git.
> 
> Does it make sense to use an external library, like
> http://search.cpan.org/~rjbs/Email-Simple-2.210/lib/Email/Simple.pm ,
> either by depending on it, or by copying it in Git's source tree ?

That might be overkill and increase installation/maintenance
burden.  Bundling it would probably be problematic to distros,
too.

> If not, I think it would be better to introduce an email parsing library
> in a dedicated Perl module in perl/ in our source tree, to keep
> git-send-email.perl more focused on the "send-email" logic.

Sounds good, Git.pm already has parse_mailboxes

> > +sub parse_email {
> > +	my @header = ();
> > +	my @body = ();
> > +	my $fh = shift;
> > +
> > +	# First unfold multiline header fields
> > +	while (<$fh>) {
> > +		last if /^\s*$/;
> > +		if (/^\s+\S/ and @header) {
> > +			chomp($header[$#header]);
> > +			s/^\s+/ /;
> > +			$header[$#header] .= $_;
> > +		} else {
> > +			push(@header, $_);
> > +		}
> > +	}
> > +
> > +	# Now unfold the message body
> 
> Why "unfold"? Don't you mean "split message body into a list of lines"?
> 
> > +	while (<$fh>) {
> > +		push @body, $_;
> > +	}

I'd rather avoid the loops entirely and do this:

	local $/ = "\n"; # in case caller clobbers $/
	@body = (<$fh>);

> > +	return (@header, @body);
> > +}


> > +		if (defined $input_format && $input_format eq 'mbox') {
> > +			if (/^Subject:\s+(.*)$/i) {
> > +				$subject = $1;
> > +			} elsif (/^From:\s+(.*)$/i) {
> > +				$from = $1;
> 
> Not sure we need thes if/elsif/ for generic headers. Email::Simple's API
> seems much simpler and general: $email->header("From");

Right.  Reading this, it would've been easier to parse headers into a
hash (normalized keys to lowercase) up front inside parse_email.
