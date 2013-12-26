From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_object_info_extended: provide delta base sha1s
Date: Thu, 26 Dec 2013 11:54:21 -0800
Message-ID: <xmqqa9fncrrm.fsf@gitster.dls.corp.google.com>
References: <20131221142336.GA28649@sigill.intra.peff.net>
	<20131221142419.GA29679@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 26 20:54:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwH0n-0002mO-2E
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 20:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab3LZTyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 14:54:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab3LZTyX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 14:54:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 779585C16E;
	Thu, 26 Dec 2013 14:54:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8KkrI0yuA199YIEf4Uz5vtFOFc8=; b=g8YuNU
	GoVVEO8sqgJZTVIVVNnUFkl8SRl/l9WMJYGyqWI7mRCe2ZNoFKZ978QeP+nYb6Vk
	XZ9MsXJ7eX1pRXflFXqHBGWlA0ruM294+dpVb1GYIoUK6eaZ/Jr26ojzv5oTpF5H
	nUuSLLZf525jUWxZkH3bluhSuaxXHGN8jb9B0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xt9mgfXVr24X8ZOsIlwIpJAbbO0i3Y5B
	B59rwm2i2sjNjh9oOGCi1z1b0q3HMxH0cHIj/oxDINtKDHkWbV2GXK2xDKxGZp4k
	nTfKC6nxxYOoSIvfwnA5kwv+wDAdSBM9WxcH493luUWLKcLz6UtFx3srF8CDDnXn
	T8o2CtSPf9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68F235C16D;
	Thu, 26 Dec 2013 14:54:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1D9A5C16C;
	Thu, 26 Dec 2013 14:54:22 -0500 (EST)
In-Reply-To: <20131221142419.GA29679@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 21 Dec 2013 09:24:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8420B036-6E67-11E3-8B72-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239709>

Jeff King <peff@peff.net> writes:

> @@ -1824,6 +1856,22 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
>  		}
>  	}
>  
> +	if (oi->delta_base_sha1) {
> +		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
> +			const unsigned char *base;
> +
> +			base = get_delta_base_sha1(p, &w_curs, curpos,
> +						   type, obj_offset);
> +			if (!base) {
> +				type = OBJ_BAD;
> +				goto out;
> +			}
> +
> +			hashcpy(oi->delta_base_sha1, base);
> +		} else
> +			hashclr(oi->delta_base_sha1);
> +	}
> +

Makes sense.
