From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Mon, 02 Mar 2009 18:47:22 -0800
Message-ID: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 03:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeKh6-0003vu-A5
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 03:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912AbZCCCre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 21:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbZCCCre
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 21:47:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbZCCCrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 21:47:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 422EC33CC;
	Mon,  2 Mar 2009 21:47:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2CFFA33CA; Mon, 
 2 Mar 2009 21:47:24 -0500 (EST)
In-Reply-To: <1235924234-16923-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Sun, 1 Mar 2009 11:17:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A4218184-079D-11DE-9D0B-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111988>

Jay Soffian <jaysoffian@gmail.com> writes:

>  - When the user specifies "all" in response to a confirm prompt, we
>    hint them about how to use "sendemail.confirm" config setting.

I think the logic is wrong.  Even when you have configured to usually ask,
you may want to say "I know Cc settings for this particular series is all
good, but I still want the safety in my future invocations.".

How about doing it this way instead?

> @@ -346,6 +350,13 @@ if ($suppress_cc{'body'}) {
>  	delete $suppress_cc{'body'};
>  }
>  
> +# Set confirm
> +if (!defined $confirm) {
> +	$confirm = scalar %suppress_cc ? 'compose' : 'auto';

This is not "Set confirm" but "set the default value to $confirm".  Also
set $confirm_unconfigured = "true" here.

> @@ -837,6 +836,27 @@ X-Mailer: git-send-email $gitversion
>  	unshift (@sendmail_parameters,
>  			'-f', $raw_from) if(defined $envelope_sender);
> +	if ($needs_confirm && !$dry_run) {

And use it here; give some help for people who haven't seen this new
message and haven't decided:

	    if (!$confirm_unconfigured) {
		print "By default the command asks if you are sure about\n";
		print "the CC list computed from various places.  If you\n";
                print "do not want this confirmation step, you can say\n";
                print "    $ git config --global sendemail.confirm never\n";
                print "to squelch it.\n";
		print "A good setting might be:\n";
                print "    $ git config --global sendemail.confirm auto\n";
		print "to squelch this help text that is given until you\n";
		print "configure the variable to some value.\n";
	    }

> +		print "\n$header\n";
> +		while (1) {
> +			chomp ($_ = $term->readline(
> +				"Send this email? ([y]es|[n]o|[q]uit|[a]ll): "
> +			));
> +			last if /^(?:yes|y|no|n|quit|q|all|a)/i;
> +			print "\n";
> +		}
> +		if (/^n/i) {
> +			return;
> +		} elsif (/^q/i) {
> +			cleanup_compose_files();
> +			exit(0);
> +		} elsif (/^a/i) {
> +			$confirm = 'never';

And drop the following two:

> +			print "You may disable all future prompting via sendemail.confirm;\n";
> +			print "Run 'git send-email --help' for details.\n";
> +		}
> +	}
