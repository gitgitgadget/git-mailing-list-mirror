From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 13:29:46 -0700
Message-ID: <xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 22:30:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKDWW-0003AY-Em
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 22:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab3ILU3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 16:29:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58041 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab3ILU3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 16:29:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7386641B5D;
	Thu, 12 Sep 2013 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bYs8bbmmXvYzrXNC0GfdkxG+BAw=; b=oxFPfF
	y7IgYTeBXmvQQdTkkc1GD+mMPCrClvEwW0OrR8tNLRu+4NI0BfeQc+7Cwq5lFqyN
	6P0TTAb/JNuXDFvJI4ljYeWwxsrKhm139rLGQWLv3rCC0d+2zHCVHbWUtigXUWq9
	hi+0gxkiKZZmNb5XIkbv+15z9wF2bLlyykbzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hTFBsxXpa+gblm/2afshzrsz2ZVg3H+L
	4vM5IfAoXK8SzU1t3ZuMrtyC2dYG7+/zcSwJVj8xVD5Q0TQ4Z+iK6f1Ftd0AYLRa
	VxxvkTl6EHOmfhH0JQoiI3KrnZUldlCtxAPM5cGDDcnI+vnjgQ7DskWpZPdN1I1D
	wCrTX0d6Rk0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 611CE41B5A;
	Thu, 12 Sep 2013 20:29:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3E0841B49;
	Thu, 12 Sep 2013 20:29:48 +0000 (UTC)
In-Reply-To: <20130912202246.GF32069@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 Sep 2013 16:22:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1227379A-1BEA-11E3-A58E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234692>

Jeff King <peff@peff.net> writes:

> I think there are basically three classes of solution:
>
>   1. Declare __NO_INLINE__ everywhere. I'd worry this might affect other
>      environments, who would then not inline and lose performance (but
>      since it's a non-standard macro, we don't really know what it will
>      do in other places; possibly nothing).
>
>   2. Declare __NO_INLINE__ on mingw. Similar to above, but we know it
>      only affects mingw, and we know the meaning of NO_INLINE there.
>
>   3. Try to impact only the uses as a function pointer (e.g., by using
>      a wrapper function as suggested in the thread).
>
> Your patch does (1), I believe. Junio's patch does (3), but is a
> maintenance burden in that any new callsites will need to remember to do
> the same trick.
>
> But your argument (and reading the mingw header, I agree) is that there
> is no performance difference at all between (2) and (3). And (2) does
> not have the maintenance burden. So it does seem like the right path to
> me.

Agreed.  If that #define __NO_INLINE__ does not appear in the common
part of our header files like git-compat-util.h but is limited to
somewhere in compat/, that would be the perfect outcome.

Thanks, both.
