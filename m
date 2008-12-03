From: Junio C Hamano <gitster@pobox.com>
Subject: Re: summaries in git add --patch[PATCH 2/2]
Date: Wed, 03 Dec 2008 15:23:07 -0800
Message-ID: <7v4p1kalno.fsf@gitster.siamese.dyndns.org>
References: <492F0CAD.3010101@gmail.com>
 <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com>
 <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com>
 <7vskp6j95x.fsf@gitster.siamese.dyndns.org> <4936EE68.6030009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:24:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L815G-0006bZ-El
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 00:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbYLCXXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 18:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbYLCXXP
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 18:23:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655AbYLCXXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 18:23:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D73F1180B8;
	Wed,  3 Dec 2008 18:23:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6E29F1808C; Wed, 
 3 Dec 2008 18:23:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5ACB9F30-C191-11DD-8846-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102306>

William Pursell <bill.pursell@gmail.com> writes:

> From 57b5eab3f64a40ebe9aca122b5c6db1ab5c26116 Mon Sep 17 00:00:00 2001
> From: William Pursell <bill.pursell@gmail.com>
> Date: Wed, 3 Dec 2008 20:26:36 +0000
> Subject: [PATCH 2/2] Implemented 'g' command to goto a hunk.

s/ted/t/; or s/Implemented/Add/;
s/goto/go to/;

> When a minor change is made while the working directory is in a bit of a
> mess (and the user should have done a stash before making the minor
> edit, but didn't) it is somewhat difficult to wade through all of the
> hunks using git add --patch.  This allows one to jump to the hunk that
> needs to be staged without having to respond 'n' to each preceding hunk.

Yeah, even without forgotten stashing, you can be in a situation where you
simply have many many changes all over in a file, and know exactly how the
one you need to add to the index urgently looks like.

> @@ -976,6 +980,27 @@ sub patch_update_file {
>  				}
>  				next;
>  			}
> +			elsif ($other =~ 'g' && $line =~ /^g(.*)/) {
> +				my $response = $1;
> +				my $i = 0;
> +				chomp $response;
> +				while (not $response) {

Did you mean "while ($response eq '')"?  I do not think you want "g0<ret>"
to fall into the loop.

> +					my $extra = "";
> +					$i = display_hunks (\@hunk, $i);

s/_hunks /_hunks/;

> +					$extra = "(<ret> to see more): " if ($i != $num);

This is probably just a matter of taste, but (1) Statement Modifiers are
much harder to read than straightforward conditional blocks, and (2) loop
termination condition is better written with magnitude comparison not with
unequality test, when the variable approaches to the limit always from a
known direction, so:

	if ($i < $num) {
        	$extra = "(<ret> to see more): ";
	}

> +					print "goto which hunk? $extra";

This placement of $extra looks a bit odd.

	goto which hunk? (<ret> to see more): *cursor blinking here*
        goto which hunk? *cursor blinking here*

Shouldn't it be like this?

	goto which hunk (<ret> to see more)? *cursor blinking here*

> +					$response = <STDIN>;
> +					chomp $response;
> +				}
> +				if ($response !~ /^\s*\d+$/) {

Why is " 1<ret>" allowed but not "1 <ret>"?

> +					print STDERR "Invalid number: '$response'\n";
> +				} elsif (0 < $response && $response <= $num) {
> +					$ix = $response - 1;
> +				} else {
> +					print STDERR "Sorry, only $num hunks available.\n";
> +				}
> +				next;
> +			}
>  			elsif ($line =~ /^d/i) {
>  				while ($ix < $num) {
>  					if (!defined $hunk[$ix]{USE}) {
