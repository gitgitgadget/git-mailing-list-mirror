From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 13:37:24 -0800
Message-ID: <xmqqd2kthmcr.fsf@gitster.dls.corp.google.com>
References: <20131218171446.GA19657@kitenet.net>
	<xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
	<20131218191702.GA9083@sigill.intra.peff.net>
	<xmqq61qmhrb3.fsf@gitster.dls.corp.google.com>
	<20131218212847.GA13685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 22:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtOoY-0003gB-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 22:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab3LRVhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 16:37:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755641Ab3LRVh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 16:37:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D53F25A080;
	Wed, 18 Dec 2013 16:37:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+EWpEaMdQi4SEQWI3+iveL3OLDc=; b=LS8z+B
	jVG8UI88BkpCU6L68F9UT392jsuet6aaN2Z8sctkVkha21GKYDogGlo+nZ/imKpv
	neTvU9Hgw27niW9rjP55a9/IG7ReeokXW5pZbuR3aY3mvcs03CmL0d/7a6iPCROi
	3tQM/gCO3M0ovKPnRvbMbYB+540TMy/eQuiyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KjZWoVFnkNH7rTkfHi+Crv7vU7RbRYgr
	kBJx1W+uruWMvZSVyPsYQvQawlRAK7VWL1DlrrrwQDxu7Mh45JYZbdvN4j7dt1TU
	QXIp8cRMruN5BztAibDovcnD4u9ypEZs46zbdRgG/QN/GRrWqVfRG7760tcs6R0g
	44bO5ZG+GaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C11555A07E;
	Wed, 18 Dec 2013 16:37:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1C045A07D;
	Wed, 18 Dec 2013 16:37:26 -0500 (EST)
In-Reply-To: <20131218212847.GA13685@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Dec 2013 16:28:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 96DA9322-682C-11E3-B777-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239490>

Jeff King <peff@peff.net> writes:

> According to the POSIX quote above, it sounds like we could do:
>
>   #if defined (_SC_OPEN_MAX)
>   {
>           long max;
>           errno = 0;
>           max = sysconf(_SC_OPEN_MAX);
>           if (0 < max) /* got the limit */
>                   return max;
>           else if (!errno) /* unlimited, cast to int-max */
>                   return max;
>           /* otherwise, fall through */
>   }
>   #endif
>
> Obviously you could collapse the two branches of the conditional, though
> I think it deserves at least a comment to explain what is going on.

Yes, that is locally OK, but depending on how the caller behaves, we
might need to have an extra saved_errno dance here, which I didn't
want to get into...
