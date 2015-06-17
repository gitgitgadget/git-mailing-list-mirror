From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on parse_address_line
Date: Wed, 17 Jun 2015 17:45:47 +0200
Message-ID: <vpqoakejq38.fsf@anie.imag.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5FXI-0002Mx-UB
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 17:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596AbbFQPpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 11:45:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59406 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755488AbbFQPpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 11:45:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5HFjj8p023315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2015 17:45:45 +0200
Received: from anie.imag.fr (ensi-vpn-247.imag.fr [129.88.57.247])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5HFjlIE013039;
	Wed, 17 Jun 2015 17:45:47 +0200
In-Reply-To: <1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Wed, 17 Jun 2015 16:18:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 17 Jun 2015 17:45:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5HFjj8p023315
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435160746.39956@iPj/C6ZNvV+GlHslaDGWrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271859>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> ---
>  git-send-email.perl | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a0cd7ff..a1f6c18 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -477,9 +477,59 @@ foreach my $entry (@bcclist) {
>  sub parse_address_line {
>  	if ($have_mail_address) {
>  		return map { $_->format } Mail::Address->parse($_[0]);
> -	} else {
> -		return split_addrs($_[0]);
>  	}
> +
> +	my $commentrgx=qr/\((?:[^)]*)\)/;
> +	my $quotergx=qr/"(?:[^\"\\]|\\.)*"/;
> +	my $wordrgx=qr/(?:[^]["\s()<>:;@\\,.]|\\.)+/;

Spaces around = please.

The code below is a bit hard to read (I'm neither fluent in Perl nor in
the RFC ...). A few more comments would help. A few examples below (it's
up to you to integrate them or not).

> +	my $tokenrgx = qr/(?:$quotergx|$wordrgx|$commentrgx|\S)/;
> +
> +	my @tokens = map { $_ =~ /\s*($tokenrgx)\s*/g } @_;
> +	push @tokens, ",";


        # parse a full address like
        # "Phrase" (comment) <address@example.com>

(to clarify the wording)

> +	my (@addr_list, @phrase, @address, @comment, @buffer) = ();
> +	foreach my $token (@tokens) {
> +	    if ($token =~ /^[,;]$/) {

Here and below: you're indenting with a 4-column offset, it should be 8.

> +		if (@address) {
> +		    push @address, @buffer;
> +		} else {
> +		    push @phrase, @buffer;
> +		}
> +
> +		my $str_phrase = join ' ', @phrase;
> +		my $str_address = join '', @address;
> +		my $str_comment = join ' ', @comment;

                # Escape special-characters with backslash
> +		if ($str_phrase =~ /[][()<>:;@\\,.\000-\037\177]/) {
> +		    $str_phrase =~ s/(^|[^\\])"/$1/g;
> +		    $str_phrase = qq["$str_phrase"];
> +		}
> +
> +		if ($str_address ne "" && $str_phrase ne "") {
> +		    $str_address = qq[<$str_address>];
> +		}
> +
> +		my $str_mailbox = "$str_phrase $str_address $str_comment";
> +		$str_mailbox =~ s/^\s*|\s*$//g;
> +		push @addr_list, $str_mailbox if ($str_mailbox);
> +
> +		@phrase = @address = @comment = @buffer = ();
> +	    } elsif ($token =~ /^\(/) {
> +		push @comment, $token;
> +	    } elsif ($token eq "<") {
> +		push @phrase, (splice @address), (splice @buffer);
> +	    } elsif ($token eq ">") {
> +		push @address, (splice @buffer);
> +	    } elsif ($token eq "@") {
> +		push @address, (splice @buffer), "@";
> +	    } elsif ($token eq ".") {
> +		push @address, (splice @buffer), ".";
> +	    } else {

                # We don't know what the token belongs to yet. We'll
                # decide where to append @buffer later.
> +		push @buffer, $token;
> +	    }
> +	}
> +
> +	return @addr_list;

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
