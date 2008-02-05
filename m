From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: Detect cvs without support for server mode
Date: Tue, 05 Feb 2008 01:08:26 -0800
Message-ID: <7vsl07epo5.fsf@gitster.siamese.dyndns.org>
References: <47A5DD98.6000606@gmx.ch>
	<200802031908.28115.robin.rosenberg.lists@dewire.com>
	<47A72EE5.2080904@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Tue Feb 05 10:09:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMJo9-0008Pj-Gs
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 10:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbYBEJIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 04:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbYBEJIk
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 04:08:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYBEJIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 04:08:38 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AA223117;
	Tue,  5 Feb 2008 04:08:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9780B3116;
	Tue,  5 Feb 2008 04:08:28 -0500 (EST)
In-Reply-To: <47A72EE5.2080904@gmx.ch> (Jean-Luc Herren's message of "Mon, 04
	Feb 2008 16:27:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72634>

Jean-Luc Herren <jlh@gmx.ch> writes:

> Note that if cvs misses the server subcommand, it will spit out
> the list of available commands to stderr, which is not useful in
> this situation.  It seemed to me that redirecting stderr to
> /dev/null is a bad idea, as cvs (when it works properly) might
> potentially print out useful informations to stderr.  Maybe
> someone has an idea about how to eliminate the help message
> properly.
> ...
> @@ -340,7 +343,11 @@ sub conn {
>  	$self->{'socketo'}->write("valid-requests\n");
>  	$self->{'socketo'}->flush();
>  
> -	chomp(my $rep=$self->readline());
> +	my $rep=$self->readline();
> +	if (!defined $rep) {
> +		die $ownserver ? "'cvs server' failed; make sure you have a cvs with server support" : "Remote end hung up unexpectedly";
> +	}
> +	chomp $rep;

I guess this is probably the best we can do without bending
backwards too much.

If we do not have cvs with server support, is there a fallback
method we can still use to run cvsps?

> diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
> index 7706430..d8cbfd0 100755
> --- a/t/t9600-cvsimport.sh
> +++ b/t/t9600-cvsimport.sh
> @@ -10,6 +10,13 @@ then
>  	exit
>  fi
>  
> +if echo -n | cvs server 2>&1 | grep 'Unknown command' > /dev/null
> +then
> +	say 'skipping cvsimport tests, cvs has support for server mode'
> +	test_done
> +	exit
> +fi

Do you mean "has to support server" or "does not have support for"?
