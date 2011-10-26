From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] replace sha1 with another algorithm
Date: Wed, 26 Oct 2011 12:44:15 -0700
Message-ID: <7vaa8n35dc.fsf@alter.siamese.dyndns.org>
References: <20111026001237.GA22195@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 26 21:44:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ9Oh-0008Oi-Oo
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 21:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944Ab1JZToT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 15:44:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47830 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394Ab1JZToS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 15:44:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67F086779;
	Wed, 26 Oct 2011 15:44:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+q7nNEKT4haBe2yRoETbkph1lIE=; b=Bz8ttr
	D8r6Ue0vebGKYYFZrx5muMEDuLoLnepIl/5nJg8SCdqB956KP7OeqzRjSCoy31M2
	fjKlW221rV5cZ6uVEbadWVZ7y+ZiocUxEtyPtTmItwqg0I5HM8ikDOotQmB4wWpU
	akdQ0aSpTmHF18qYP/vRGqtInlyUCszQXNCA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ar/7DYD03NayzKPAQFh0/kO66j61z7wN
	IxrA62r+mD/1rjYb46rcX7GQFr7QQKwSIM3/wJ5OdcIvCJ8Q49MmlWVYUi9Buyv4
	eIleAK8Ik4xyGMk0zE546wmrpQK8f5vms/VC0QHldXHN/6Dq8PVsOFNUIaQHz0En
	IJjC/EdjYnI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B1B6778;
	Wed, 26 Oct 2011 15:44:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC9246777; Wed, 26 Oct 2011
 15:44:16 -0400 (EDT)
In-Reply-To: <20111026001237.GA22195@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 25 Oct 2011 17:12:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3B596CE-000A-11E1-A5A6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184273>

Jeff King <peff@peff.net> writes:

> +static void xor_bytes(unsigned char *out, unsigned char *a, unsigned char *b,
> +		      unsigned n)
> +{
> +	unsigned i;
> +	for (i = 0; i < n; i++)
> +		out[i] = a[i] ^ b[i];
> +}
> +
> +static void mix_hash(unsigned char *h, unsigned n)
> +{
> +	unsigned char out[20];
> +	unsigned mid = n / 2;
> +
> +	if (2*mid < n)
> +		return;
> +
> +	xor_bytes(out, h, h + mid, mid);
> +	xor_bytes(out + mid, h + mid, h, mid);
> +	memcpy(h, out, n);
> +
> +	/* If a little bit of mixing is good, then a lot must be GREAT! */
> +	mix_hash(h, mid);
> +	mix_hash(h + mid, mid);
> +}

You seem to want to reduce the hash down to 5-bytes by duplicating the
same value on the left and right half, and duplicate that four times to
fill 20-byte buffer, but doesn't this look unnecessarily inefficient way
to achieve that?
