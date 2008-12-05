From: Junio C Hamano <gitster@pobox.com>
Subject: Re: summaries in git add --patch[PATCH 1/2]
Date: Thu, 04 Dec 2008 18:23:49 -0800
Message-ID: <7viqpz1hsa.fsf@gitster.siamese.dyndns.org>
References: <492F0CAD.3010101@gmail.com>
 <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com>
 <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com>
 <7vskp6j95x.fsf@gitster.siamese.dyndns.org> <4936EE63.209@gmail.com>
 <7vd4g8alp7.fsf@gitster.siamese.dyndns.org> <49377ED8.4050905@gmail.com>
 <7vvdu0e38a.fsf@gitster.siamese.dyndns.org> <4937B456.7080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 03:25:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8QNZ-0002eO-Lp
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 03:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbYLECX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 21:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755096AbYLECXz
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 21:23:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbYLECXz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 21:23:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 83FD4846EB;
	Thu,  4 Dec 2008 21:23:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 623FA846E9; Thu,
  4 Dec 2008 21:23:51 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C3573CDE-C273-11DD-BBB0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102395>

William Pursell <bill.pursell@gmail.com> writes:

> Thanks for pointing that out.  Settings changed.  I do appreciate
> you taking the time to essentially hold my hand through this
> process, and hope that I'm not causing you too much extra work.

Heh, I'll be saving extra work I have to do in the future by training you
how to produce patches line the ones I may write myself.  By doing so,
eventually I wouldn't have to code anything myself ;-)

> +# Generate a one line summary of a hunk.
> +sub summarize_hunk {
> +	my $rhunk = shift;
> +	my $summary = $rhunk->{TEXT}[0];
> +
> +	# Keep the line numbers, discard extra context.
> +	$summary =~ s/@@(.*?)@@.*/$1 /s;
> +	$summary .= " " x (20 - length $summary);
> +
> +	# Add some user context.
> +	for my $line (@{$rhunk->{TEXT}}) {
> +		if ($line =~ m/^[+-].*\w/) {
> +			$summary .= $line;
> +			last;
> +		}
> +	}
> +
> +	chomp $summary;
> +	return substr($summary, 0, 80) . "\n";
> +}

I'll queue the patches in this round as-is in 'pu' and merge to 'next', as
we should stop slushing around at some point and start polishing on a
solid ground.  But as you mentioned, these hardcoded 20 and 80 do not look
very nice.

I think the division of labor between the data producer (summarize_hunk)
and presenter (display_hunks) should be shifted somewhat, so that

 * summarize_hunk returns a two-tuple:

	[ $line_number_hint, $first_change ]

 * display_hunks runs summarize_hunk for all 20 hunks and gathers the
   return values before producing a single line of output, and then
   computes the maximum $line_number_hint to decide how many extra SP to
   use to pad it to uniform length (instead of " " x (20 - length)).
   After doing so, it loops over the hunks, using the collected return
   values and formats.

In later round of polishing, you might find out that some callers of
summarize_hunk may want to read the full line, not just the first 80
(perhaps they feed their output to "less -S").  By splitting the
responsibility between these functions in the way outlined above, you do
not have to modify summarize_hunk when that day comes.

> +
> +
> +# Print a one-line summary of each hunk in the array ref in
> +# the first argument, starting wih the index in the 2nd.
> +sub display_hunks {
> +	my ($hunks, $i) = @_;
> +	my $ctr = 0;
> +	$i ||= 0;
> +	for (; $i < @$hunks && $ctr < 20; $i++, $ctr++) {
> +		my $status = " ";
> +		if (defined $hunks->[$i]{USE}) {
> +			$status = $hunks->[$i]{USE} ? "+" : "-";
> +		}
> +		printf "%s%2d: %s",
> +			$status,
> +			$i + 1,
> +			summarize_hunk($hunks->[$i]);
> +	}

By the way, I do not think this will align if you have more than 100
hunks.  That is also a reason why I would suggest not to format/substr
inside the summarize_hunk function.
