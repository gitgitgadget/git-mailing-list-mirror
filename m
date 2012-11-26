From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] git-send-email: allow edit invalid email address
Date: Mon, 26 Nov 2012 09:08:34 -0800
Message-ID: <7vobikthpp.fsf@alter.siamese.dyndns.org>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
 <1353607932-10436-5-git-send-email-krzysiek@podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Mon Nov 26 18:50:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td2ox-0006ml-VY
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 18:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269Ab2KZRIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 12:08:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933143Ab2KZRIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 12:08:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DD179768;
	Mon, 26 Nov 2012 12:08:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VqmHnpdNiRJ7M94FKD6u77nRgXQ=; b=itejFk
	pvixMevT1eH/uwWAH1o9ZrY/Y8gPjyWwCXSoY04bq44tuZz+r5sUVsmV7srl0mMZ
	bjcWSZAEcstVP3Gt5m02yFEStZZqzekjEGFh6Vj8ikgrn8ofCwYijPmv/HCv7MwC
	mpqpkNlD2BoLm91ftaUGYYZAYBaI8ns4h3bTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=We5b3sTnC0DTs/VkOYfKYDmsSMeOQrVo
	8KhIOwzVEZwFWZzOnlrUHS1RYkClSkx5OFejuzvOpLnZDxxeSM0UW0yZ1hNPpDRn
	bwyPR6QdNIShUIwcZSEDUExS9ZJHF6IPiS8XbeRgfXFMndwqxTZIiaAghIy9V1ML
	Hh0Pketyy74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0754E9767;
	Mon, 26 Nov 2012 12:08:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FD1C9766; Mon, 26 Nov 2012
 12:08:35 -0500 (EST)
In-Reply-To: <1353607932-10436-5-git-send-email-krzysiek@podlesie.net>
 (Krzysztof Mazur's message of "Thu, 22 Nov 2012 19:12:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9DCD750-37EB-11E2-AD92-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210459>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> In some cases the user may want to send email with "Cc:" line with
> email address we cannot extract. Now we allow user to extract
> such email address for us.
>
> Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
> ---
>  git-send-email.perl | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index d42dca2..9996735 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -851,10 +851,10 @@ sub extract_valid_address_or_die {
>  
>  sub validate_address {
>  	my $address = shift;
> -	if (!extract_valid_address($address)) {
> +	while (!extract_valid_address($address)) {
>  		print STDERR "error: unable to extract a valid address from: $address\n";
> -		$_ = ask("What to do with this address? ([q]uit|[d]rop): ",
> -			valid_re => qr/^(?:quit|q|drop|d)/i,
> +		$_ = ask("What to do with this address? ([q]uit|[d]rop|[e]dit): ",
> +			valid_re => qr/^(?:quit|q|drop|d|edit|e)/i,
>  			default => 'q');
>  		if (/^d/i) {
>  			return undef;
> @@ -862,6 +862,9 @@ sub validate_address {
>  			cleanup_compose_files();
>  			exit(0);
>  		}
> +		$address = ask("Who should the email be sent to (if any)? ",
> +			default => "",
> +			valid_re => qr/\@.*\./, confirm_only => 1);

Not having this new code inside "elsif (/^e/) { }" feels somewhat
sloppy, even though it is not *too* bad.  Also do we know this
function will never be used for addresses other than recipients' (I
gave a cursory look to see what is done to the $sender and it does
not seem to go through this function, tho)?
