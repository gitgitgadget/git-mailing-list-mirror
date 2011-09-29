From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs: Use binary search to lookup refs faster
Date: Thu, 29 Sep 2011 15:06:03 -0700
Message-ID: <7vvcsbqa0k.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Fri Sep 30 00:06:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Ok9-0002FC-Sw
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 00:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab1I2WGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 18:06:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab1I2WGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 18:06:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7CDB257F;
	Thu, 29 Sep 2011 18:06:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xSAIHi3fes5hkUN5Fl/sixc15t0=; b=JXpzz6
	pVhYZ4J4puzUKWaZyQ0RdnBlF1eX2xmkOdG+HMrUACwyFg3phfHk18Mz5UbCAFnb
	FCdjo4DXqkBTdSnnA4oRfbS64HrPSniq+E76VM0NSGcAV58ePKagZn3YdrgqmEOS
	zS9gQGBB91Wr8ZWw+p9+v92dfzq3/yp8bWpXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P26QuNnmEY7vSUQ6Cf443JWuh0buV7Ob
	X7lhPsDsLvjSOt3bA26bKIQgTNoa+u8UHMY3YG4oNwVI8MYpSgX7B738Wd1J4VrZ
	4t9JVh+E+wTeKqp2W2RjKnbckp1zLQDKBx/iKsatFBgMilNFQsdUPPsmYPoaD3wD
	evM/T6k47Yo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEC79257E;
	Thu, 29 Sep 2011 18:06:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 737B7257D; Thu, 29 Sep 2011
 18:06:04 -0400 (EDT)
In-Reply-To: <20110929041811.5363.33396.julian@quantumfyre.co.uk> (Julian
 Phillips's message of "Thu, 29 Sep 2011 05:18:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 398ABAFE-EAE7-11E0-8B52-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182447>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> +static void add_ref(const char *name, const unsigned char *sha1,
> +		    int flag, struct ref_array *refs,
> +		    struct ref_entry **new_entry)
>  {
>  	int len;
> -	struct ref_list *entry;
> +	struct ref_entry *entry;
>  
>  	/* Allocate it and add it in.. */
>  	len = strlen(name) + 1;
> -	entry = xmalloc(sizeof(struct ref_list) + len);
> +	entry = xmalloc(sizeof(struct ref) + len);

This should be sizeof(struct ref_entry), no?  There is another such
misallocation in search_ref_array() where it prepares a temporary.
