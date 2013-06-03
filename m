From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] send-email: make --suppress-cc=self sanitize input
Date: Mon, 03 Jun 2013 11:02:35 -0700
Message-ID: <7vk3mbf4xw.fsf@alter.siamese.dyndns.org>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
	<1369897638-27299-5-git-send-email-mst@redhat.com>
	<7v38szjhim.fsf@alter.siamese.dyndns.org>
	<20130603163241.GB16841@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:02:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZ5f-00075g-Cr
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab3FCSCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:02:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430Ab3FCSCi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:02:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C28A2497F;
	Mon,  3 Jun 2013 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9BXobgZCpQ5HKRlZj+nyqgwBAyY=; b=Ub28sz
	A+2bPZ67FbBfO7L3G6sTDwkifkoSJVbZEIQFjC8+J5ajqcFzleIeUOPuhHgLeKtD
	iqH7v2yFA8SYRoCbMZm+JbP2uy5wsJw18cXPlXW3c0BZNM26wSZsIYnzRRsSbMI7
	75waHSdZdNqCSTgEtskILFUYu25+IRbir6u1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=stk9+8HdMGBgdFtOqFUOxgVmth7Voj+4
	AviQPRV+xZ0s5lrvRGYvgFInanUsdsgMT44QwdowmaShYm76UpzviCRoJsmFNomD
	0yyblk0gW3PW9fYSuoenI8VEC1q5gZ2+Jd5KH2+0IMpDgZuyVG9ksZWx2idrcfST
	BRg7b5Asw/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00A1B2497E;
	Mon,  3 Jun 2013 18:02:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 187B62497C;
	Mon,  3 Jun 2013 18:02:37 +0000 (UTC)
In-Reply-To: <20130603163241.GB16841@redhat.com> (Michael S. Tsirkin's message
	of "Mon, 3 Jun 2013 19:32:41 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C616CB98-CC77-11E2-AAE5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226253>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Yes, I think so too. So - what do you suggest?
> 	Add a test?
> 	Add a comment?
> more?

Nothing major comes to my mind at this moment.

I guess it would be good to add a test or two to use "A U. Thor"
example with and without end-user added quotes, but that can be done
as a follow-up patch on top of this series (i.e. [PATCH 7/6]).

Thanks.

>> >  git-send-email.perl | 18 +++++++++++-------
>> >  1 file changed, 11 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/git-send-email.perl b/git-send-email.perl
>> > index a138615..92df393 100755
>> > --- a/git-send-email.perl
>> > +++ b/git-send-email.perl
>> > @@ -760,6 +760,8 @@ if (!defined $sender) {
>> >  	$sender = $repoauthor || $repocommitter || '';
>> >  }
>> >  
>> > +$sender = sanitize_address($sender);
>> > +
>> >  my $prompting = 0;
>> >  if (!@initial_to && !defined $to_cmd) {
>> >  	my $to = ask("Who should the emails be sent to (if any)? ",
>> > @@ -1113,10 +1115,9 @@ sub send_message {
>> >  	if ($cc ne '') {
>> >  		$ccline = "\nCc: $cc";
>> >  	}
>> > -	my $sanitized_sender = sanitize_address($sender);
>> >  	make_message_id() unless defined($message_id);
>> >  
>> > -	my $header = "From: $sanitized_sender
>> > +	my $header = "From: $sender
>> >  To: $to${ccline}
>> >  Subject: $subject
>> >  Date: $date
>> > @@ -1133,7 +1134,7 @@ X-Mailer: git-send-email $gitversion
>> >  	}
>> >  
>> >  	my @sendmail_parameters = ('-i', @recipients);
>> > -	my $raw_from = $sanitized_sender;
>> > +	my $raw_from = $sender;
>> >  	if (defined $envelope_sender && $envelope_sender ne "auto") {
>> >  		$raw_from = $envelope_sender;
>> >  	}
>> > @@ -1308,8 +1309,9 @@ foreach my $t (@files) {
>> >  			}
>> >  			elsif (/^From:\s+(.*)$/i) {
>> >  				($author, $author_encoding) = unquote_rfc2047($1);
>> > +				my $sauthor = sanitize_address($author);
>> >  				next if $suppress_cc{'author'};
>> > -				next if $suppress_cc{'self'} and $author eq $sender;
>> > +				next if $suppress_cc{'self'} and $sauthor eq $sender;
>> >  				printf("(mbox) Adding cc: %s from line '%s'\n",
>> >  					$1, $_) unless $quiet;
>> >  				push @cc, $1;
>> > @@ -1323,7 +1325,9 @@ foreach my $t (@files) {
>> >  			}
>> >  			elsif (/^Cc:\s+(.*)$/i) {
>> >  				foreach my $addr (parse_address_line($1)) {
>> > -					if (unquote_rfc2047($addr) eq $sender) {
>> > +					my $qaddr = unquote_rfc2047($addr);
>> > +					my $saddr = sanitize_address($qaddr);
>> > +					if ($saddr eq $sender) {
>> >  						next if ($suppress_cc{'self'});
>> >  					} else {
>> >  						next if ($suppress_cc{'cc'});
>> > @@ -1370,7 +1374,8 @@ foreach my $t (@files) {
>> >  			chomp;
>> >  			my ($what, $c) = ($1, $2);
>> >  			chomp $c;
>> > -			if ($c eq $sender) {
>> > +			my $sc = sanitize_address($c);
>> > +			if ($sc eq $sender) {
>> >  				next if ($suppress_cc{'self'});
>> >  			} else {
>> >  				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
>> > @@ -1454,7 +1459,6 @@ foreach my $t (@files) {
>> >  sub recipients_cmd {
>> >  	my ($prefix, $what, $cmd, $file) = @_;
>> >  
>> > -	my $sanitized_sender = sanitize_address($sender);
>> >  	my @addresses = ();
>> >  	open my $fh, "-|", "$cmd \Q$file\E"
>> >  	    or die "($prefix) Could not execute '$cmd'";
