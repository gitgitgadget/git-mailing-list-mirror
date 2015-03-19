From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] filter_ref: avoid overwriting ref->old_sha1 with garbage
Date: Thu, 19 Mar 2015 14:09:44 -0700
Message-ID: <xmqq7fucitif.fsf@gitster.dls.corp.google.com>
References: <20150319203126.GA31663@peff.net> <20150319203451.GA7666@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:09:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhhP-0000GA-Jh
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbbCSVJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:09:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750830AbbCSVJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:09:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 380524161E;
	Thu, 19 Mar 2015 17:09:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cKNpUENXRWR5zQvrqiY+uawVwMU=; b=O9Kz1n
	GnMW3RksoLL1moCRomIUV/UZKQx5MW0WlIiFRSUoplhgft2uEQcC7NI2dLLCjGbV
	gF1DIMKhyhF7xHMiZl/dV/dEcN0IJRwKVcmVRHyqMkX/rr2EqU3hrUauonhYxZCx
	VkUQFpIe5f1LUbMJMGiA/+ZCYHkLycJbOTbnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nWU/odOiGP7XCnIueTMReSKPeMlLQOu+
	S9M57oyV+3XjSHpc7+cVjgO8W3xLSvMCv8U0r2TBh8kYSUPYZVVeZJpqvAda7uwx
	9zIA9+nuw7/ozDDfRH6+mIYRfc3aTT2cBTFFZkd1nyrFRdJQx80A4/n1HcNT1cHS
	w6MqF0BDBOY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ECE84161C;
	Thu, 19 Mar 2015 17:09:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F1AE4161B;
	Thu, 19 Mar 2015 17:09:45 -0400 (EDT)
In-Reply-To: <20150319203451.GA7666@peff.net> (Jeff King's message of "Thu, 19
	Mar 2015 16:34:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44F2CAFE-CE7C-11E4-804E-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265833>

Jeff King <peff@peff.net> writes:

> I wonder if the thinking in the original was that it was our
> responsibility here to make sure that ref->old_sha1 was filled in.

I am reasonably sure that is the (perhaps mistaken) reasoning behind
the use of old_sha1 as the second parameter to get_sha1_hex().

> It is
> always filled in by the caller who gives us "sought", which makes sense
> to me (this matches the rest of the "sought" entries, which come from
> reading the remote's ref list, and of course must fill in old_sha1 from
> that list).

I see that sought is populated by reading the command line of "git
fetch-pack", and for a 40-hex request ref->old_sha1 is already
filled there, so I agree that it is redundant to try filling it in
filter_refs().

Thanks.

>  fetch-pack.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 655ee64..058c258 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -544,10 +544,14 @@ static void filter_refs(struct fetch_pack_args *args,
>  	/* Append unmatched requests to the list */
>  	if (allow_tip_sha1_in_want) {
>  		for (i = 0; i < nr_sought; i++) {
> +			unsigned char sha1[20];
> +
>  			ref = sought[i];
>  			if (ref->matched)
>  				continue;
> -			if (get_sha1_hex(ref->name, ref->old_sha1))
> +			if (get_sha1_hex(ref->name, sha1) ||
> +			    ref->name[40] != '\0' ||
> +			    hashcmp(sha1, ref->old_sha1))
>  				continue;
>  
>  			ref->matched = 1;
