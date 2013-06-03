From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] send-email: make --suppress-cc=self sanitize input
Date: Mon, 03 Jun 2013 09:17:21 -0700
Message-ID: <7v38szjhim.fsf@alter.siamese.dyndns.org>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
	<1369897638-27299-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 18:17:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjXRq-0006Sx-0m
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 18:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759315Ab3FCQR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 12:17:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759251Ab3FCQRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 12:17:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 527A32414C;
	Mon,  3 Jun 2013 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IbdiCvz9Wz+x+Ql6mcJ+UDrviVg=; b=MIgy+6
	sJlY5RQ6Fl9dtsgD7Ds8Dpa3kzM/U+lJIvvOiZPZa8Yia5vgb1/4JJPgTfqZGge7
	xuIcUDzpw4+pZkfzy+a/Tm4J5+mtyBuREMvPQVIvuDYpWRt+uxHCrX4MV8w6TGOx
	EXiOuHSFikotnxxhwt/ij6J0AYdGOIhbrCGLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YRE4mmF/CHf9hAjONlVL2eiW5YNLMeVn
	TWm10UqWpBTigK5Be24Pdv69q6P/+VOOfJHY0iHja8WzH6aKhXWFbCQR2tDOi0rK
	KuytLfMRsLv+K3RCo17wWIz4oXtTRBrlB+ZIifhWEy5uWVPmc2nGgUr13kMMuaP8
	uvX0MeJiy2U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 411E52414B;
	Mon,  3 Jun 2013 16:17:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 511152414A;
	Mon,  3 Jun 2013 16:17:23 +0000 (UTC)
In-Reply-To: <1369897638-27299-5-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 30 May 2013 10:11:21 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12CA4D48-CC69-11E2-999F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226229>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> --suppress-cc=self fails to filter sender address in many cases where it
> needs to be sanitized in some way, for example quoted:
> "A U. Thor" <author@example.com>
> To fix, make send-email sanitize both sender and the address it is
> compared against.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

OK, so you are getting rid of distinctions between sanitized_sender
and sender, and $sender is now defined to be always "sanitized"
form.

That change makes things consistent with respect to the question I
had on [2/6].

I however wondered how this would affect those who have configured
"sendemail.from" with an already "sanitized" address.  That is, you
may have used:

	[sendemail]
        	from = "Michael S. Tsirkin" <mst@redhat.com>

with the older and current versions of Git.  I _think_ the safetly
of this change relies on that it is a no-op to run sanitize_address
on an already sanitized address (i.e. feeding the above example
sendemail.from to sanitize_address gives back the same string),
which holds true for all practical purposes, but it is a bit subtle.

>  git-send-email.perl | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a138615..92df393 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -760,6 +760,8 @@ if (!defined $sender) {
>  	$sender = $repoauthor || $repocommitter || '';
>  }
>  
> +$sender = sanitize_address($sender);
> +
>  my $prompting = 0;
>  if (!@initial_to && !defined $to_cmd) {
>  	my $to = ask("Who should the emails be sent to (if any)? ",
> @@ -1113,10 +1115,9 @@ sub send_message {
>  	if ($cc ne '') {
>  		$ccline = "\nCc: $cc";
>  	}
> -	my $sanitized_sender = sanitize_address($sender);
>  	make_message_id() unless defined($message_id);
>  
> -	my $header = "From: $sanitized_sender
> +	my $header = "From: $sender
>  To: $to${ccline}
>  Subject: $subject
>  Date: $date
> @@ -1133,7 +1134,7 @@ X-Mailer: git-send-email $gitversion
>  	}
>  
>  	my @sendmail_parameters = ('-i', @recipients);
> -	my $raw_from = $sanitized_sender;
> +	my $raw_from = $sender;
>  	if (defined $envelope_sender && $envelope_sender ne "auto") {
>  		$raw_from = $envelope_sender;
>  	}
> @@ -1308,8 +1309,9 @@ foreach my $t (@files) {
>  			}
>  			elsif (/^From:\s+(.*)$/i) {
>  				($author, $author_encoding) = unquote_rfc2047($1);
> +				my $sauthor = sanitize_address($author);
>  				next if $suppress_cc{'author'};
> -				next if $suppress_cc{'self'} and $author eq $sender;
> +				next if $suppress_cc{'self'} and $sauthor eq $sender;
>  				printf("(mbox) Adding cc: %s from line '%s'\n",
>  					$1, $_) unless $quiet;
>  				push @cc, $1;
> @@ -1323,7 +1325,9 @@ foreach my $t (@files) {
>  			}
>  			elsif (/^Cc:\s+(.*)$/i) {
>  				foreach my $addr (parse_address_line($1)) {
> -					if (unquote_rfc2047($addr) eq $sender) {
> +					my $qaddr = unquote_rfc2047($addr);
> +					my $saddr = sanitize_address($qaddr);
> +					if ($saddr eq $sender) {
>  						next if ($suppress_cc{'self'});
>  					} else {
>  						next if ($suppress_cc{'cc'});
> @@ -1370,7 +1374,8 @@ foreach my $t (@files) {
>  			chomp;
>  			my ($what, $c) = ($1, $2);
>  			chomp $c;
> -			if ($c eq $sender) {
> +			my $sc = sanitize_address($c);
> +			if ($sc eq $sender) {
>  				next if ($suppress_cc{'self'});
>  			} else {
>  				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
> @@ -1454,7 +1459,6 @@ foreach my $t (@files) {
>  sub recipients_cmd {
>  	my ($prefix, $what, $cmd, $file) = @_;
>  
> -	my $sanitized_sender = sanitize_address($sender);
>  	my @addresses = ();
>  	open my $fh, "-|", "$cmd \Q$file\E"
>  	    or die "($prefix) Could not execute '$cmd'";
