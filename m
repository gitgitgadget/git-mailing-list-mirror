From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP-PATCH 1/2] send-email: create email parser subroutine
Date: Sat, 28 May 2016 17:22:17 +0200
Message-ID: <vpqeg8mi4wm.fsf@anie.imag.fr>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
	<20160527140104.11192-2-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, e@80x24.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Sat May 28 17:22:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6g4U-0003yr-7O
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 17:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbcE1PWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 11:22:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36365 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220AbcE1PWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 11:22:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4SFMFY4013820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 28 May 2016 17:22:15 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4SFMHZ2031363;
	Sat, 28 May 2016 17:22:17 +0200
In-Reply-To: <20160527140104.11192-2-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Fri, 27 May 2016 16:01:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sat, 28 May 2016 17:22:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4SFMFY4013820
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465053740.91655@cra2P4ER6i/uUtRSKXLhgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295827>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> Parsing and processing in send-email is done in the same loop.
>
> To make the code more maintainable, we create two subroutines:
> - `parse_email` to separate header and body
> - `parse_header` to retrieve data from header

These routines are not specific to git send-email, nor to Git.

Does it make sense to use an external library, like
http://search.cpan.org/~rjbs/Email-Simple-2.210/lib/Email/Simple.pm ,
either by depending on it, or by copying it in Git's source tree ?

If not, I think it would be better to introduce an email parsing library
in a dedicated Perl module in perl/ in our source tree, to keep
git-send-email.perl more focused on the "send-email" logic.

> +sub parse_email {
> +	my @header = ();
> +	my @body = ();
> +	my $fh = shift;
> +
> +	# First unfold multiline header fields
> +	while (<$fh>) {
> +		last if /^\s*$/;
> +		if (/^\s+\S/ and @header) {
> +			chomp($header[$#header]);
> +			s/^\s+/ /;
> +			$header[$#header] .= $_;
> +		} else {
> +			push(@header, $_);
> +		}
> +	}
> +
> +	# Now unfold the message body

Why "unfold"? Don't you mean "split message body into a list of lines"?

> +	while (<$fh>) {
> +		push @body, $_;
> +	}
> +
> +	return (@header, @body);
> +}

Please document your functions. See e.g. perl/Git.pm for an example of
what perldoc allows you to do.

This also lacks tests. One advantage of having a clean API is that it
also makes it simpler to do unit-testing. Grep "Test::More" in t/ to see
some existing unit-tests in Perl.

> +	foreach(@_) {

Style: space before (.

> +		if (defined $input_format && $input_format eq 'mbox') {
> +			if (/^Subject:\s+(.*)$/i) {
> +				$subject = $1;
> +			} elsif (/^From:\s+(.*)$/i) {
> +				$from = $1;

Not sure we need thes if/elsif/ for generic headers. Email::Simple's API
seems much simpler and general: $email->header("From");

> +				foreach my $addr (parse_address_line($1)) {
> +					push @to, $addr;
> +				}

3 lines for an array concatenation in a high-level language. It looks
like 2 more than needed ;-).

> +			}
> +
> +		} else {

Useless blank line.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
