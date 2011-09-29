From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs: Use binary search to lookup refs faster
Date: Thu, 29 Sep 2011 14:57:53 -0700
Message-ID: <7vzkhnqae6.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
 <201109281338.04378.mfick@codeaurora.org>
 <201109281610.49322.mfick@codeaurora.org>
 <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
 <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
 <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <4E84B89F.4060304@lsrfire.ath.cx> <7vy5x7rwq9.fsf@alter.siamese.dyndns.org>
 <20110929041811.5363.33396.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 29 23:58:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9OcD-0007np-IG
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 23:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab1I2V55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 17:57:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab1I2V54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 17:57:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A9772327;
	Thu, 29 Sep 2011 17:57:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IJto2yWmRIJ250SNZj2QC4sURgo=; b=IVpamJ
	AUXGG2BegLdo2T+6Y7v9CJgf+J4LM1OoCzwaEBQuNioBbMeo+d+Bfd4xuZEcbM/E
	tjp7QH7s5VzWGfB6jsBJr+aBS3VKGZCINA7d8rs27DjCPui2eaoNnQDNIQT+4gdu
	ZkieTF9acoI14ythdgXFlW9nWlqRRElF4fpC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lr0jPb2QkpjDZ3hMA6P1Nm9d8HTUTxJF
	5nc/cU+haHOG8gmMIfcI9eA9sLxY6tyctKBiE1/cJOVA3fuw91dly8Cw9PBbQuUp
	vxowqR105I75Ry6/37ROy5Uo4WSdb+ipOlQbdDdNPgp0ikn88ewMARRjHgfZb0Vu
	q3uci75bcjQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 122592326;
	Thu, 29 Sep 2011 17:57:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A3FB2325; Thu, 29 Sep 2011
 17:57:54 -0400 (EDT)
In-Reply-To: <20110929041811.5363.33396.julian@quantumfyre.co.uk> (Julian
 Phillips's message of "Thu, 29 Sep 2011 05:18:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1588F266-EAE6-11E0-B23E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182445>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> Currently we linearly search through lists of refs when we need to
> find a specific ref.  This can be very slow if we need to lookup a
> large number of refs.  By changing to a binary search we can make this
> faster.
>
> In order to be able to use a binary search we need to change from
> using linked lists to arrays, which we can manage using ALLOC_GROW.
>
> We can now also use the standard library qsort function to sort the
> refs arrays.
>
> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
> ---
>
> Something like this?
>
>  refs.c |  328 ++++++++++++++++++++++++++--------------------------------------
>  1 files changed, 131 insertions(+), 197 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index a49ff74..e411bea 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -8,14 +8,18 @@
>  #define REF_KNOWS_PEELED 04
>  #define REF_BROKEN 010
>  
> -struct ref_list {
> -	struct ref_list *next;
> +struct ref_entry {
>  	unsigned char flag; /* ISSYMREF? ISPACKED? */
>  	unsigned char sha1[20];
>  	unsigned char peeled[20];
>  	char name[FLEX_ARRAY];
>  };
>  
> +struct ref_array {
> +	int nr, alloc;
> +	struct ref_entry **refs;
> +};
> +

Yeah, I can say "something like that" without looking at the rest of the
patch ;-) The rest should naturally follow from the above data structures.
