From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: ssh/login style password requests
Date: Fri, 01 Feb 2008 02:09:54 -0800
Message-ID: <7vodb19edp.fsf@gitster.siamese.dyndns.org>
References: <1201841954-17949-1-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Feb 01 11:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKsr4-0002fE-Vi
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 11:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbYBAKKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 05:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbYBAKKE
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 05:10:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbYBAKKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 05:10:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5AE3C12;
	Fri,  1 Feb 2008 05:09:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 964CA3C11;
	Fri,  1 Feb 2008 05:09:56 -0500 (EST)
In-Reply-To: <1201841954-17949-1-git-send-email-mfwitten@mit.edu> (Michael
	Witten's message of "Thu, 31 Jan 2008 23:59:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72164>

Michael Witten <mfwitten@MIT.EDU> writes:

> +--smtp-pass::
> +	Password for SMTP-AUTH. The default value can be specified
> +	with the configuration variable 'sendemail.smtppass' or
> +	sendemail.<identity>.smtppass (see sendemail.identity).
> +	The argument is optional: If no argument is specified, then
> +	the password is assumed to be the empty string.
> +	If a username has been set, but no password has been set,
> +	the user is prompted for a password with masked input for
> +	privacy; passwords need not be recorded in configuration
> +	files.

I am a bit puzzled about the above description, though.  It is
not clear if there is any difference between "the empty string"
password, and "no password has been set".  It makes me wonder
what the possible cases are.

 (1) no *.smtppass configuration present; no --smtp-pass parameter
     is given on the command line.

 (2) *.smtppass configuration present but is an empty string; no
     --smtp-pass parameter is given on the command line.

 (3) *.smtppass configuration present with a non-empty string; no
     --smtp-pass parameter is given on the command line.

 (4) parameter is given with an empty string (i.e. "--smtp-pass=")
     on the command line.

 (5) parameter is given with a non-empty string (i.e. "--smtp-pass=foo")
     on the command line.

My _guess_ is that command line always trump configuration so
in cases (4) and (5) it does not matter what you have (or do not
have) in *.smtppass configuration.  In other cases, lack of *.smtppass
and having *.smtppass with an empty string as its value are equivalent.
And in any case, an empty string (or lack of specification) results
in prompting.

But you shouldn't make _me_ guess.  You certainly would be
forcing many other people to guess with this.

> +		if (defined $smtp_authuser) {
> +
> +			if (!defined $smtp_authpass) {
> +				
> +				system "stty -echo";
> +
> +				do {
> +					$_ = $term->readline("Password: ");
> +				} while (!defined $_);
> +
> +				system "stty echo";
> +
> +				$smtp_authpass = $_ if ($_);
> +			}
> +

I like what the patch tries to do, but the system() there feels
a tad ugly.  In addition it makes me wonder (1) what happens if
you ^C out from this while loop, and (2) $term->readline()
interface might already have a method to turn echo off.

We luckily have people handy at Perl on the list, so I'll wait
for our resident Perl experts to suggest a better alterantive.

We are not in a hurry, so I expect a polished resubmit after
1.5.4.  Thanks.
