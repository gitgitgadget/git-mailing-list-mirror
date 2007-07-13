From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make git-send-email.perl handle email addresses with no names when Email::Valid is present
Date: Thu, 12 Jul 2007 22:47:17 -0700
Message-ID: <7vr6ncrh22.fsf@assigned-by-dhcp.cox.net>
References: <20070713041749.GA28824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 07:47:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9E02-0003JV-Ui
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 07:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933957AbXGMFrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 01:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933794AbXGMFrV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 01:47:21 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39286 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933668AbXGMFrT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 01:47:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713054718.GDIY1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Jul 2007 01:47:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NtnJ1X0011kojtg0000000; Fri, 13 Jul 2007 01:47:19 -0400
In-Reply-To: <20070713041749.GA28824@kroah.com> (Greg KH's message of "Thu, 12
	Jul 2007 21:17:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52361>

Greg KH <greg@kroah.com> writes:

> When using git-send-email.perl on a changeset that has:
> 	Cc: <stable@kernel.org>
> in the body of the description, and the Email::Valid perl module is
> installed on the system, the email address will be deemed "invalid" for
> some reason (Email::Valid isn't smart enough to handle this?) and
> complain and not send the address the email.

That appears to be the case.

        bad foo
        bad <foo@bar.baz>
        ok  foo@bar.baz
        ok  Foo <foo@bar.baz>

> Anyway, this tiny patch fixes this problem for me.  Note, my perl-foo is
> quite week, so this could probably be easily done in one line for those
> with better reg-ex skills.

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -410,6 +410,9 @@ sub extract_valid_address {
>  	return $address if ($address =~ /^($local_part_regexp)$/);
>  
>  	if ($have_email_valid) {
> +		if ($address =~ s/^<//) {
> +			$address =~ s/>$//;
> +		}
>  		return scalar Email::Valid->address($address);
>  	} else {

I'd probably do:

	if ($have_email_valid) {
		$address =~ s/^<(.*)>$/$1/;
		return scalar Email::Valid->address($address);
	} else {

instead, but they are moral equivalents.

Thanks for a fix.
