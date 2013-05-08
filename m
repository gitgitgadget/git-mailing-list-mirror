From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/11] sha1_name: improvements
Date: Tue, 07 May 2013 22:56:07 -0700
Message-ID: <7v1u9igglk.fsf@alter.siamese.dyndns.org>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3-vVUB4VnZP4uBMLAbviV+BMTqDcbO_TxkX+5RE6cnSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 07:56:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZxMO-00021c-GS
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 07:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088Ab3EHF4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 01:56:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab3EHF4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 01:56:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648A614899;
	Wed,  8 May 2013 05:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=VeeasEe+xKixJJaX67toSOfCeqA=; b=Zh9Jk/4LSyeAMJfZou4M
	ygwYRpC1YlKdcd63DisIUkQizd3ImWpmUE06cMYAnTgy7+fQVGoOmaIKlTSrxTkt
	z/FxEMPIK2RA/XxaNBbWNVm5Kv7go4ldkCw/PkOMWX+WgUPmx7Y4EIBzOQGLQjhu
	sDZH4TmfkGoC46dc6VgvBrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=o/Qr3vSoymhIIVmGcTDfIN5XOOyaoHXPtkzNu/WyCNv+3d
	1mjSfr36HtwFa/7r+kzN7THWdGReOy37xBrLJD8lmDBPofnoRKr0zyYiSTx+TF0+
	OBvi0nWaeEAz9zf4/NhKVrdppfgd3/0pq8qVbymXbG4/nADTFkR0zuakrwizw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BD1914898;
	Wed,  8 May 2013 05:56:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA48814895;
	Wed,  8 May 2013 05:56:09 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB3BCD98-B7A3-11E2-BAB8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223642>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When merging this series to the @ shortcut one, there will be
> conflicts, this is how I propose fixing them:
>
>                 return len; /* syntax Ok, not enough switches */
> -       if (0 < len && len == namelen)
> +       if (len > 0 && len == namelen)
>                 return len; /* consumed all */
> -       else if (0 < len)
> ...
> ++      else if (len > 0)
>  +              return reinterpret(name, namelen, len, buf);
>
> - check "@" new-two
> - check "@@{u}" upstream-two
> ...
> ++check "@" ref refs/heads/new-branch
> ++check "@@{u}" ref refs/heads/upstream-branch

The resolution for the tests wrapper that acquired an extra
parameter matches what I did locally.  Thanks for a merge sanity
check.

I didn't see any conflicts on the sha1_name.c side, but I applied
the Yoda thing slightly differently to result in a slightly more
streamlined codeflow:

	if (!len) {
		return len;
	} else if (len > 0) {
		if (len == namelen)
                	return len;
		else
			return reinterpret(...);
	}

which I think shows the choices better.

Although I haven't looked at the largest one (10/11) carefully,
everything else looked quite straightforward and readable.

I am not very happy about how $<n> parameters are quoted in t1508,
but that suboptimal quoting were there before this series, and I'd
consider it outside of the scope for now.

Will queue.  Thanks.
