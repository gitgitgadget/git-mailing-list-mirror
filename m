From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Fix Pine address book parsing
Date: Tue, 25 Nov 2008 20:58:01 -0800
Message-ID: <7vod03hyna.fsf@gitster.siamese.dyndns.org>
References: <1227668100-5563-1-git-send-email-tpiepho@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Trent Piepho <tpiepho@freescale.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 05:59:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5CUz-0003Fd-TD
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 05:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbYKZE6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 23:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbYKZE6W
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 23:58:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbYKZE6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 23:58:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E49581062;
	Tue, 25 Nov 2008 23:58:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3DACA81061; Tue,
 25 Nov 2008 23:58:03 -0500 (EST)
In-Reply-To: <1227668100-5563-1-git-send-email-tpiepho@freescale.com> (Trent
 Piepho's message of "Tue, 25 Nov 2008 18:55:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D84D51EA-BB76-11DD-A0E5-8214C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101702>

Trent Piepho <tpiepho@freescale.com> writes:

> See:  http://www.washington.edu/pine/tech-notes/low-level.html
>
> Entries with a fcc or comment field after the address weren't parsed
> correctly.
>
> Continuation lines, identified by leading spaces, were also not handled.
>
> Distribution lists which had ( ) around a list of addresses did not have
> the parenthesis removed.

> +	pine => sub { my $fh = shift; my $f='\t[^\t]*';
> +	        for (my $x = ''; defined($x); $x = $_) {
> +			chomp $x;
> +		        $x .= $1 while(defined($_ = <$fh>) && /^ +(.*)$/);
> +			$x =~ /^(\S+)$f\t\(?([^\t]+?)\)?(:?$f){0,2}$/ or next;

Hmm, so you chomp each continuation line with /^ +(.*)$/ and concatenate
that to the hold buffer ($x) as long as you see continuation lines,
a non-continuation line that you read ahead is given to the next round
(the third part of for(;;) control), checked if you hit an EOF and then
chomped.  Which means the complicated regexp about the parentheses is
applied to a logical single line in $x that does not have any newline in
it, right?

I wonder what this does:

	$x .= $1 while (defined($_ = <$fh>) && /^ +(.*)$/);

when you have "a b" in $x and feed " c\n d\ne\n" to it.  When it leaves
the loop, you would have "e\n" in $_ for the next round, and "a bcd" (note
that "bcd" becomes one word) in $x, which I suspect may not be what you
want.

But I do not use Pine nor its aliases file.
