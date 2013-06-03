From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 4/6] send-email: make --suppress-cc=self sanitize input
Date: Mon, 3 Jun 2013 19:32:41 +0300
Message-ID: <20130603163241.GB16841@redhat.com>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
 <1369897638-27299-5-git-send-email-mst@redhat.com>
 <7v38szjhim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 18:32:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjXgE-0007Uh-AN
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 18:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759252Ab3FCQcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 12:32:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41545 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758924Ab3FCQcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 12:32:18 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r53GW9Va030990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 3 Jun 2013 12:32:09 -0400
Received: from redhat.com (vpn1-4-128.ams2.redhat.com [10.36.4.128])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r53GW84n023744;
	Mon, 3 Jun 2013 12:32:08 -0400
Content-Disposition: inline
In-Reply-To: <7v38szjhim.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226232>

On Mon, Jun 03, 2013 at 09:17:21AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > --suppress-cc=self fails to filter sender address in many cases where it
> > needs to be sanitized in some way, for example quoted:
> > "A U. Thor" <author@example.com>
> > To fix, make send-email sanitize both sender and the address it is
> > compared against.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> OK, so you are getting rid of distinctions between sanitized_sender
> and sender, and $sender is now defined to be always "sanitized"
> form.
> 
> That change makes things consistent with respect to the question I
> had on [2/6].
> 
> I however wondered how this would affect those who have configured
> "sendemail.from" with an already "sanitized" address.  That is, you
> may have used:
> 
> 	[sendemail]
>         	from = "Michael S. Tsirkin" <mst@redhat.com>
> 
> with the older and current versions of Git.  I _think_ the safetly
> of this change relies on that it is a no-op to run sanitize_address
> on an already sanitized address (i.e. feeding the above example
> sendemail.from to sanitize_address gives back the same string),
> which holds true for all practical purposes, but it is a bit subtle.

Yes, I think so too. So - what do you suggest?
	Add a test?
	Add a comment?
more?

> >  git-send-email.perl | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index a138615..92df393 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -760,6 +760,8 @@ if (!defined $sender) {
> >  	$sender = $repoauthor || $repocommitter || '';
> >  }
> >  
> > +$sender = sanitize_address($sender);
> > +
> >  my $prompting = 0;
> >  if (!@initial_to && !defined $to_cmd) {
> >  	my $to = ask("Who should the emails be sent to (if any)? ",
> > @@ -1113,10 +1115,9 @@ sub send_message {
> >  	if ($cc ne '') {
> >  		$ccline = "\nCc: $cc";
> >  	}
> > -	my $sanitized_sender = sanitize_address($sender);
> >  	make_message_id() unless defined($message_id);
> >  
> > -	my $header = "From: $sanitized_sender
> > +	my $header = "From: $sender
> >  To: $to${ccline}
> >  Subject: $subject
> >  Date: $date
> > @@ -1133,7 +1134,7 @@ X-Mailer: git-send-email $gitversion
> >  	}
> >  
> >  	my @sendmail_parameters = ('-i', @recipients);
> > -	my $raw_from = $sanitized_sender;
> > +	my $raw_from = $sender;
> >  	if (defined $envelope_sender && $envelope_sender ne "auto") {
> >  		$raw_from = $envelope_sender;
> >  	}
> > @@ -1308,8 +1309,9 @@ foreach my $t (@files) {
> >  			}
> >  			elsif (/^From:\s+(.*)$/i) {
> >  				($author, $author_encoding) = unquote_rfc2047($1);
> > +				my $sauthor = sanitize_address($author);
> >  				next if $suppress_cc{'author'};
> > -				next if $suppress_cc{'self'} and $author eq $sender;
> > +				next if $suppress_cc{'self'} and $sauthor eq $sender;
> >  				printf("(mbox) Adding cc: %s from line '%s'\n",
> >  					$1, $_) unless $quiet;
> >  				push @cc, $1;
> > @@ -1323,7 +1325,9 @@ foreach my $t (@files) {
> >  			}
> >  			elsif (/^Cc:\s+(.*)$/i) {
> >  				foreach my $addr (parse_address_line($1)) {
> > -					if (unquote_rfc2047($addr) eq $sender) {
> > +					my $qaddr = unquote_rfc2047($addr);
> > +					my $saddr = sanitize_address($qaddr);
> > +					if ($saddr eq $sender) {
> >  						next if ($suppress_cc{'self'});
> >  					} else {
> >  						next if ($suppress_cc{'cc'});
> > @@ -1370,7 +1374,8 @@ foreach my $t (@files) {
> >  			chomp;
> >  			my ($what, $c) = ($1, $2);
> >  			chomp $c;
> > -			if ($c eq $sender) {
> > +			my $sc = sanitize_address($c);
> > +			if ($sc eq $sender) {
> >  				next if ($suppress_cc{'self'});
> >  			} else {
> >  				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
> > @@ -1454,7 +1459,6 @@ foreach my $t (@files) {
> >  sub recipients_cmd {
> >  	my ($prefix, $what, $cmd, $file) = @_;
> >  
> > -	my $sanitized_sender = sanitize_address($sender);
> >  	my @addresses = ();
> >  	open my $fh, "-|", "$cmd \Q$file\E"
> >  	    or die "($prefix) Could not execute '$cmd'";
