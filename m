From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] pack-objects: don't traverse objects unnecessarily
Date: Thu, 27 Oct 2011 15:26:02 -0700
Message-ID: <7vk47qxe9x.fsf@alter.siamese.dyndns.org>
References: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
 <1318915284-6361-3-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 00:26:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJYOp-0000HH-1R
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 00:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400Ab1J0W0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 18:26:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163Ab1J0W0E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 18:26:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED7646731;
	Thu, 27 Oct 2011 18:26:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hz9jhvxdndlDw3vc9qjy3et0omI=; b=WTsHRF
	+Tzrv/NrhQP17YWO+sZSbtDROmTdNSV3tz6Xoi41Gorf1Y0wIVgPu+sN26KZtxS2
	6/vfrzPj2AcAyWebFCR+VrfcNDqeG7KI+zyCnD5NAR12IX/Td74KwQI2TZ0j3JV4
	Bl3WKgZ4Xtk2fniXUf2M5cCOrknIMHNBd4R8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wdOo34iUF9vBL6rJfXVg4uqJD/DCTgqp
	JAhMlIiSRhSnHPbsqcldKt8O/zCZrlCK1mDzWT0MRMAVdZFCApFpW71qgYDcmsNr
	2YxnZI9KViLXYFHIgQAP2C5mmtqCfOZaDH+Iu5h0IcvNkhAAVdiD0MOdR0wDRhH8
	MIwRvaRUyYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E33936730;
	Thu, 27 Oct 2011 18:26:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AAB0672F; Thu, 27 Oct 2011
 18:26:03 -0400 (EDT)
In-Reply-To: <1318915284-6361-3-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Tue, 18 Oct 2011 00:21:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7C8D7DA-00EA-11E1-AFA4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184325>

Dan McGee <dpmcgee@gmail.com> writes:

> Two optimizations take place here- we can start our objects array
> iteration from a known point where we left off before we started trying
> to find our tags,

This I would understand (but I am somewhat curious how much last_untagged
would advance relative to nr_objects for this half of the optimization to
be worth it), but...

> and we don't need to do the deep dives required by
> add_family_to_write_order() if the object has already been marked as
> filled.

I am not sure if this produces the identical result that was benchmarked
in the original series.

For example, if you have a tagged object that is not a commit (say a
blob), you would have written that blob in the second phase (write tagged
objects together), so the family of blobs that share same delta parent as
that blob will not be written in this "Finally all the rest" in the right
place in the original list, no?

I do not think this change would forget to fill an object that needs to be
filled, but it would affect the resulting ordering of the list, so...

> @@ -560,8 +561,13 @@ static struct object_entry **compute_write_order(void)
>  	/*
>  	 * Finally all the rest in really tight order
>  	 */
> -	for (i = 0; i < nr_objects; i++)
> -		add_family_to_write_order(wo, &wo_end, &objects[i]);
> +	for (i = last_untagged; i < nr_objects; i++) {
> +		if (!objects[i].filled)
> +			add_family_to_write_order(wo, &wo_end, &objects[i]);
> +	}
> +
> +	if(wo_end != nr_objects)
> +		die("ordered %u objects, expected %u", wo_end, nr_objects);
