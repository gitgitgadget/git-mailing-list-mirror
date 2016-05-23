From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Mon, 23 May 2016 22:00:17 +0200
Message-ID: <vpq60u4bl4e.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, samuel.groot@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon May 23 22:00:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4w1a-0006hX-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 22:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbcEWUAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 16:00:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34623 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbcEWUAW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 16:00:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4NK0Fp8011335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 23 May 2016 22:00:16 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4NK0HrX002347;
	Mon, 23 May 2016 22:00:17 +0200
In-Reply-To: <1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
	(Tom Russello's message of "Mon, 23 May 2016 21:30:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 23 May 2016 22:00:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4NK0Fp8011335
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464638416.40653@zuq/y6QwfikShQeK/QGYZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295385>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> This option involves the `--compose` mode to edit the cover letter quoting the

s/involves/implies/

?

I don't think this is right: I often reply to an email with a single
patch, for which it would clearly be overkill to have a cover-letter.

Your --quote-mail does two things:

1) Populate the To and Cc field

2) Include the original message body with quotation prefix.

When not using --compose, 1) clearly makes sense already, and there's no
reason to prevent this use-case. When sending a single patch, 2) also
makes sense as "below-tripple-dash comment", like

  This is the commit message for feature A.
  ---
  John Smith wrote:
  > You should implement feature A.

  Indeed, here's a patch.

  modified-file.c   | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-

When sending multiple patches without --compose, 2) may not make sense,
but I think a sane behavior would be:

* If --compose is given, cite the message there.

* If --compose is not given, don't send a cover-letter but cite the body
  as comment in the first patch.

As a first step, the second point can be changed to "if --compose is not
given, don't cite the message, just populate the To: and Cc: fields".

> ---
>
> diff --git a/git-send-email.perl b/git-send-email.perl

No diffstat?

> @@ -638,6 +640,98 @@ if (@files) {
>  	print STDERR "\nNo patch files specified!\n\n";
>  	usage();
>  }
> +my $message_quoted;
> +if ($quote_mail) {

Style: The code you're adding doesn't look related to the code right
before => separate them with a blank line.

> +	while(<$fh>) {

Style: space before (.

> +			push(@header, $_);

I think the code would be clearer if @header was a list of pairs
(header-name, header-content). Then you'd need much less regex magic
when going through it.

> +		#for files containing crlf line endings

Sytle: space after #.

> +	foreach(@header) {

Space before (.

> +			elsif (/^From:\s+(.*)$/i) {
> +				push @initial_to, $1;
> +			}
> +			elsif (/^To:\s+(.*)$/i) {
> +				foreach my $addr (parse_address_line($1)) {
> +					if (!($addr eq $initial_sender)) {
> +						push @initial_to, $addr;
> +					}
> +				}

This adds the content of the To: field in the original email to the Cc:
field in the new message, right? If so, this is a weird behavior: when
following up to an email, one usually addresses to the person s/he's
replying, keeping the others Cc-ed, hence the original From: becomes the
To header, and the original To: and Cc: become Cc:.

> +			} elsif (/^Cc:\s+(.*)$/i) {

Style: IIRC, there's no consensus on whether "elsif" should be on the
same line as the closing }, but please follow the same convention inside
a single if/elsif/ chain.

> +	#Message body

Style: space after # (more below). And while you're there, the comment
could be "Quote the message body" or so, to give a hint to the user
about what's going on.

> +	while (<$fh>) {
> +		#for files containing crlf line endings
> +		$_=~ s/\r//g;
> +		my $space="";

Style: spaces around =.

> @@ -676,6 +771,8 @@ From: $tpl_sender
>  Subject: $tpl_subject
>  In-Reply-To: $tpl_reply_to
>  
> +$tpl_quote
> +
>  EOT

Doesn't this add two extra useless blank lines if $tpl_quote is empty?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
