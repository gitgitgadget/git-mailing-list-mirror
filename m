From: Junio C Hamano <gitster@pobox.com>
Subject: Re: summaries in git add --patch
Date: Thu, 27 Nov 2008 23:24:35 -0800
Message-ID: <7v8wr48g98.fsf@gitster.siamese.dyndns.org>
References: <492F0CAD.3010101@gmail.com>
 <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 08:28:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5xmM-0001Vt-94
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 08:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbYK1HYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 02:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbYK1HYy
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 02:24:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbYK1HYy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 02:24:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AED11821CA;
	Fri, 28 Nov 2008 02:24:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 05467821C4; Fri,
 28 Nov 2008 02:24:37 -0500 (EST)
In-Reply-To: <492F92C9.7030301@gmail.com> (William Pursell's message of "Fri,
 28 Nov 2008 06:42:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5F5B310-BD1D-11DD-A33B-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101867>

William Pursell <bill.pursell@gmail.com> writes:

> Here's a new patch.  Instead of displaying the summary and then
> the current hunk, it implements a 'goto' command.

I take it that this is for discussion not for immediate inclusion.

> @@ -799,6 +801,7 @@ sub help_patch_cmd {
>  y - stage this hunk
>  n - do not stage this hunk
>  a - stage this and all the remaining hunks in the file
> +g - select a hunk to jump to
>  d - do not stage this hunk nor any of the remaining hunks in the file
>  j - leave this hunk undecided, see next undecided hunk
>  J - leave this hunk undecided, see next hunk

Since you took 'g' after "go to", help text should also say "go to",
instead of "jump to" for the mnemonics value, iow, to help people
remember.

> @@ -836,6 +839,27 @@ sub patch_update_cmd {
>  	}
>  }
>
> +sub select_new_hunk {
> +	my $ri = shift;
> +	my @hunk = @_;
> +	my ($i, $response);
> +	print "   '+' stage, '-' don't stage\n";
> +	for ( $i = 0; $i < @hunk; $i++ ) {
> +		my $status = " ";
> +		if( defined $hunk[$i]{USE} ) {
> +			$status = $hunk[$i]{USE} ? "+" : "-";
> +		}

Style.

    (1) SP between language construct and open parenthesis, as opposed to
        no extra SP between function name and open parenthesis;

    (2) No extra SP around what is enclosed in parentheses.

> +		printf "%s%3d: %s",
> +			$status,
> +			$i + 1,
> +			$hunk[$i]{SUMMARY};
> +	}

I think this "for ()" loop part, including the comment about +/- notation,
should be separated into a function so that you can implement a separate
"l"ist command like you did in the other patch, using the same function.

> +	printf "goto which hunk? ";
> +	$response = <STDIN>;
> +	chomp $response;
> +	$$ri = $response - 1;

What happens when $response is (1) a non number, (2) outside range (both
negative and positive), or (3) EOF?

Sending ref to scalar and returning the value by assigning is a bad taste.
Why shouldn't this function just return an integer to be assigned to $ix
by the caller?  If you want to use pass-by-ref to show off your Perl-fu, I
think \@hunk would be what you would want to for performance reasons.

> @@ -919,7 +943,7 @@ sub patch_update_file {
>  		for (@{$hunk[$ix]{DISPLAY}}) {
>  			print;
>  		}
> -		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
> +		print colored $prompt_color, "Stage this hunk [y/n/a/d/g$other/?]? ";

When there is only one hunk, we do not give j nor k.  Should we give g in
such a case?  Why?

> @@ -937,6 +961,16 @@ sub patch_update_file {
>  				}
>  				next;
>  			}
> +			elsif ($line =~ /^g/) {
> +				chomp ($line);
> +				if ($line =~ /^g$/) {
> +					select_new_hunk (\$ix, @hunk);
> +				}
> +				else {
> +					$ix = (substr $line, 1) - 1;
> +				}

The same "input validation" issue exists here.  it would make sense to:

 - Make choose_hunk(@hunk) that calls list_hunks(@hunk) that gives the
   summary, reads one line, and returns that line;

 - Make the caller here to look like this:

	elsif ($line =~ s/^g//) {
        	chomp($line);
                if ($line eq '') {
                	$line = choose_hunk(@hunk);
		}
		if ($line !~ /^\d+$/) {
			print STDERR "Eh '$line', what number is that?\n";
                        next;
		} elsif (0 < $line && $line <= $num) {
			$ix = $line - 1;
                } else {
                	print STDERR "Sorry, you have only $num hunks\n";
                }
	}

> +				next;
> +			}
>  			elsif ($line =~ /^d/i) {
>  				while ($ix < $num) {
>  					if (!defined $hunk[$ix]{USE}) {
>
>
> -- 
> William Pursell
