From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add / command in add --patch (feature request)
Date: Wed, 26 Nov 2008 13:55:16 -0800
Message-ID: <7vljv6duez.fsf@gitster.siamese.dyndns.org>
References: <492DB6C8.7010205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:57:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5SNW-000497-BH
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 22:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbYKZVzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 16:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbYKZVzk
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 16:55:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbYKZVzk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 16:55:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EC8B7176F0;
	Wed, 26 Nov 2008 16:55:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 418C3178AF; Wed,
 26 Nov 2008 16:55:17 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F653E2E2-BC04-11DD-85BF-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101774>

William Pursell <bill.pursell@gmail.com> writes:

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index b0223c3..7ad4ee0 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -876,12 +876,14 @@ sub patch_update_file {
>
>  	$num = scalar @hunk;
>  	$ix = 0;
> +	my $search_s; # User entered string to match a hunk.
>
>  	while (1) {
>  		my ($prev, $next, $other, $undecided, $i);
>  		$other = '';
>
>  		if ($num <= $ix) {
> +			$search_s = 0;

People cannot look for string "0"?

Instead, set this to 'undef' and check with:

	if (defined $search_string) {
        	...

in the later part of the code.

> @@ -916,11 +918,24 @@ sub patch_update_file {
>  			$other .= '/s';
>  		}
>  		$other .= '/e';
> -		for (@{$hunk[$ix]{DISPLAY}}) {
> -			print;
> +
> +		my $line;
> +		if( $search_s ) {
> +			my $text = join( "", @{$hunk[$ix]{DISPLAY}} );
> +			if( $text !~ $search_s ) {

Style.

    (1) SP between language construct and open parenthesis, as opposed to
        no extra SP between function name and open parenthesis;

    (2) No extra SP around what is enclosed in parentheses.

No help text added to help people discover this new feature?

The interactive help prompt is hard to read because '/' is used to
separate choices.  I'd suggest to make this into two patches:

Patch 1/2 would change use of '/' to ',' so that this:

    Stage this hunk [y/n/a/d/j/J/e/?]?

becomes

    Stage this hunk [y,n,a,d,j,J,e,?]?

Patch 2/2 would be a fix-up of the patch you sent.

Thanks.
