From: Junio C Hamano <gitster@pobox.com>
Subject: Re: summaries in git add --patch[PATCH 1/2]
Date: Wed, 03 Dec 2008 15:22:12 -0800
Message-ID: <7vd4g8alp7.fsf@gitster.siamese.dyndns.org>
References: <492F0CAD.3010101@gmail.com>
 <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com>
 <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com>
 <7vskp6j95x.fsf@gitster.siamese.dyndns.org> <4936EE63.209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:23:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L814C-0006Fm-G5
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 00:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbYLCXWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 18:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYLCXWT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 18:22:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbYLCXWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 18:22:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 982DA83BB0;
	Wed,  3 Dec 2008 18:22:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9C8A083BAF; Wed,
  3 Dec 2008 18:22:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 39DBDE98-C191-11DD-AEEE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102305>

William Pursell <bill.pursell@gmail.com> writes:

> Junio C Hamano wrote:
>
>> One thing I will not do after such a discussion, unless I am really really
>> interested in having the new feature personally myself, is to go back to
>> the discussion thread and assemble the pieces together to make the final
>> series of patches for inclusion.  The responsibility for doing that lies
>> on the original contributor.
>>
>
> That is a perfectly reasonable policy, and I did not intend
> to suggest that you should do that work.

Heh, that is not a policy but just the way I work (rather, "the way I
don't work and push the work to others instead") with a limited amount of
time.

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index b0223c3..daf8d5d 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -836,6 +836,45 @@ sub patch_update_cmd {
>  	}
>  }
>
> +# Generate a one line summary of a hunk.
> +sub summarize_hunk {
> +	my $rhunk = shift;
> +	my $summary = $rhunk->{TEXT}[0];
> +
> +	# Keep the line numbers, discard extra context.
> +	$summary =~ s/(@@.*@@).*/$1 /s;

You would need to make the first glob less eager, i.e. /(@@.*?@@).*/,
otherwise you will be folled by a literal @@ in the contents that is
tacked after "@@ -j,k +l,m @@".

Do you really want the surrounding @@ in the result, by the way?

> +	# Add some user context. (Just take first changed line.)
> +	for my $line (@{$rhunk->{TEXT}}) {
> +		if ($line =~ m/^[+-]/) {

Even if it is a blank line?

> +			$summary .= $line;
> +			last;
> +		}
> +	}
> +
> +	return substr ($summary, 0, 80);

s/str /str/;

How well does substr() work with utf-8 and other multi-byte encodings
these days, I have to wonder...

> +}
> +
> +
> +# Print a one-line summary of each hunk in the array ref in
> +# the first argument, starting wih the index in the 2nd.
> +sub display_hunks {
> +	my ($hunks, $i) = @_;
> +	my $ctr = 0;
> +	$i = 0 if not $i;

I think "$i ||= 0" is more common.

> +			$status,
> +			$i + 1,
> +			summarize_hunk ($hunks->[$i]);

s/_hunk /_hunk/;
