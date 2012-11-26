From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-send-email: remove invalid addresses earlier
Date: Mon, 26 Nov 2012 09:02:16 -0800
Message-ID: <7vsj7wti07.fsf@alter.siamese.dyndns.org>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
 <1353607932-10436-3-git-send-email-krzysiek@podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Mon Nov 26 19:15:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td3DT-0005z0-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 19:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465Ab2KZSPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 13:15:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756145Ab2KZRCU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 12:02:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25CA3952E;
	Mon, 26 Nov 2012 12:02:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=04DfNE8Zhad59ad3Jwd0NUFRxLA=; b=kIS9Xi
	CAMPXI6PXlGM7Q9tl7jdOUD1GQ+jrPlhDDUfcUffTPxncgRdFuBJlZEP5s1TL2t1
	BpFw6SmWJTzzu6uMufnvMTY/ZAPOf84WCpd/TzlZmBZJT71ptA8TuzcReOYxgNC7
	sEOSreW9t2KbbTgCVKv8ZXd6G/xLVAb2KQHu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H7Ovehxb5lBGaOthw/BpONugXpx2pQGy
	3pUK4SGGxEHhqhttEuoGe0/c3+ox7EWeHE7YfgONcpNoSdEnx2FoAxkyptiTnkuk
	govDaVc5MU+SnZFl+BnpNvGzqri69QDJa8/PAocqs7uKh2+YIk/fBh312AkZ4Pvy
	jBVkNq1eNUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B8B952D;
	Mon, 26 Nov 2012 12:02:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45AD6952B; Mon, 26 Nov 2012
 12:02:18 -0500 (EST)
In-Reply-To: <1353607932-10436-3-git-send-email-krzysiek@podlesie.net>
 (Krzysztof Mazur's message of "Thu, 22 Nov 2012 19:12:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0908BE56-37EB-11E2-ADDC-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210463>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> Some addresses are passed twice to unique_email_list() and invalid addresses
> may be reported twice per send_message. Now we warn about them earlier
> and we also remove invalid addresses.
>
> This also removes using of undefined values for string comparison
> for invalid addresses in cc list processing.
>
> Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
> ---

I think there are three kinds of address-looking things we deal
with:

 * Possibly invalid but meant for human consumption, e.g.

     Cc: Stable Kernel <stable@k.org> # for v3.5 and upwards

   in the commit log message trailer.

 * Meant to be fed to our MSA, without losing the human readable
   part, e.g.

     Cc: Stable Kernel <stable@k.org>

   in the header of the outgoing message.

 * Without the human-readable part, e.g.

     stable@k.org

   that is returned by extract_valid_address.

My understanding is that our input typically comes from the first
kind and sanitize_address() is meant to massage it into the second
kind.  The last kind is to be used to drive the underlying sendmail
machinery and meant to go in the envelope (this includes message-id
generation).

I do not think send-email adds the first kind (invalid ones) in its
output, even though it reads them from its input and copy them to
its output in the e-mail body part of the payload, but I think it
adds new addresses to the e-mail header part of the payload (that is
what $from, @initial_to, @initial_cc and @bcclist are all about).
We would want to feed them in the third form (i.e. output from
extract-valid-address on them) when driving the underlying sendmail
machinery to place them in the envelope part, but they should be in
the second form when we place them on e-mail header lines.  As far
as I can tell, the resulting code looks correct in this regard.  The
addresses are sanitized into the second form upfront and validated
before they are placed in @initial_to and friends, and we carry the
second form around most of the time, until we call unique_email_list
in send_message to pass them through extract_valid_address to turn
them into the third form to drive the underlying sendmail.

I however found it a bit confusing while reading the callers of
validate_address{,_list} functions, which not just validate (and
warns) but return the ones that pass the test.  Perhaps we would
want a brief comment before validate_address, validate_address_list,
and extract_valid_address{,_or_die} to clarify what they are doing
(especially what they return)?

The result still feels somewhat yucky (the yuckiness comes primarily
from the current code, not from the patch but I am mostly focused on
the result after applying the patch), in that extract-valid-address
that has problem with invalid email addresses will still die when
fed an address that is not "sanitized" first, so any future patch
that adds a new address source may still have to suffer the same
problem the part that dealt with the Cc list suffered (which your
1/5 fixed earlier), but I do not offhand think of a good way to
reorganize them.  We could of course make validate_address() call
sanitize_address(), but that would be mostly redundant since the new
code sanitizes the input upfront.

So overall, looks good to me.  Thanks.

>  git-send-email.perl | 52 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 356f99d..5056fdc 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -786,9 +786,11 @@ sub expand_one_alias {
>  }
>  
>  @initial_to = expand_aliases(@initial_to);
> -@initial_to = (map { sanitize_address($_) } @initial_to);
> +@initial_to = validate_address_list(sanitize_address_list(@initial_to));
>  @initial_cc = expand_aliases(@initial_cc);
> +@initial_cc = validate_address_list(sanitize_address_list(@initial_cc));
>  @bcclist = expand_aliases(@bcclist);
> +@bcclist = validate_address_list(sanitize_address_list(@bcclist));
