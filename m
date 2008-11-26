From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] In add --patch, Handle K,k,J,j slightly more
 gracefully.
Date: Wed, 26 Nov 2008 13:55:47 -0800
Message-ID: <7vej0ydue4.fsf@gitster.siamese.dyndns.org>
References: <492DB6CE.3010409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:57:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5SNu-0004Md-Gq
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 22:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbYKZV4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 16:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbYKZV4F
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 16:56:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYKZV4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 16:56:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 70BAF178AF;
	Wed, 26 Nov 2008 16:56:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 85711176F0; Wed,
 26 Nov 2008 16:55:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0585C050-BC05-11DD-A410-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101775>

William Pursell <bill.pursell@gmail.com> writes:

> Instead of printing the help menu, this will print
> "No next hunk" and then process the given hunk again.
> ---

Missing sign-off.

> -			elsif ($other =~ /K/ && $line =~ /^K/) {
> -				$ix--;
> +			elsif ( $line =~ /^K/) {
> +				$other =~ /K/ ?  $ix-- : print STDERR "No previous hunk\n";

This may be cute but I think it is harder to read than necessary.

	if ($other =~ /K/) {
        	$ix--;
        } else {
		print STDERR "No previous hunk\n";
        }

> +			elsif ($line =~ /^k/) {
> +				if ($other =~ /k/) {
> +					while (1) {
> +						$ix--;
> +						last if (!$ix ||
> +							 !defined $hunk[$ix]{USE});
> +					}
> +					next;
> +				}
> +				else {
> +					print STDERR "No previous hunk\n";
>  				}
> -				next;
>  			}
> +			elsif ($line =~ /^j/) {
> +				if ($other !~ /j/) {
> +					print STDERR "No next hunk\n";
> +					next;
>  				}
>  			}

Doesn't this behave differently against an unavailable 'k' and 'j'?  When
the user says 'j' when no next hunk is available, it will ask again about
that hunk, but when the user says 'k' at the first hunk, because you
discarded 'next', it will ask about the next hunk, no?  Shouldn't it ask
again about the same hunk, against which the user gave an erroneous input?
