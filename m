From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add-interactive: fix bogus diff header line ordering
Date: Mon, 22 Feb 2010 14:25:19 -0800
Message-ID: <7vbpfg6h80.fsf@alter.siamese.dyndns.org>
References: <20100222103256.GA10557@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njgif-0005rz-0f
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab0BVWZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:25:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab0BVWZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:25:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 530789CA92;
	Mon, 22 Feb 2010 17:25:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sNcdW5Q8CDdL0BLrpUNUATQ3kuM=; b=SS/PlD
	VthxROgGdha20v37GCfyaheog92FoAGxtBZBF0pJVxqSCxIAX5FoSMNsChhpYuuM
	GYx3+PI4KN4bp+5j3WYIIB8XKsk6QKK5bx8nLq3AM3Ss74q0n2DPMKXUPw6Klt9T
	YEe7+V+KevGZ1tgTWkB2T60DnY2T9xxHF2S6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=etIkfONXYgGgGnqr8+OQeSY+G9P/sXEU
	dDf9/n2T6wIn0gbSw6Q1HXmkHblkYY9iGlIpSmm4G9OgL75gLdxA4A+q0puzkIel
	sLyasW3i99wRbC4I06JA1vhqwOVLWskSIu3DueWNdGcGf56hU81dCCRncHDdVwr+
	jUntk+MtYNs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1302C9CA8D;
	Mon, 22 Feb 2010 17:25:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 254539CA85; Mon, 22 Feb
 2010 17:25:20 -0500 (EST)
In-Reply-To: <20100222103256.GA10557@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 22 Feb 2010 05\:32\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CA42A1C-2001-11DF-83FD-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140722>

Jeff King <peff@peff.net> writes:

>  git-add--interactive.perl |   17 ++++++++++++++++-
>  t/t2016-checkout-patch.sh |    8 ++++++++
>  2 files changed, 24 insertions(+), 1 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index bfd1003..4173200 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -979,6 +979,21 @@ sub coalesce_overlapping_hunks {
>  	return @out;
>  }
>  
> +sub reassemble_patch {
> +	my $head = shift;
> +	return (
> +		# Include everything in the header except the beginning of the
> +		# diff.
> +		(grep { !/^[-+]{3}/ } @$head),
> +		# Then include any other non-diff header lines from the hunks.
> +		(grep { !/^[@ +-]/ } @_),
> +		# Then begin the diff.
> +		(grep { /^[-+]{3}/ } @$head),
> +		# And then the hunk diff lines.
> +		(grep { /^[@ +-]/ } @_)

Hmm.  Are you handling "\No newline at the end of the file" correctly?
