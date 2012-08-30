From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Thu, 30 Aug 2012 10:13:49 -0700
Message-ID: <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de>
 <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
 <002201cd86ce$285841b0$7908c510$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 19:14:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78Jb-0000tQ-QU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab2H3RNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 13:13:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546Ab2H3RNw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 13:13:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4ECB928E;
	Thu, 30 Aug 2012 13:13:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KgQ/QDqqTI/Bfh+DcSSzDVXLheU=; b=bXxnYt
	SxKBC1wJnS0ZeMbFux89jcG/2RdztZxLTc97crDJEZt6NRsZlIsscLphyqVvtTqs
	Bo3u7x8ETIy0Ivr/i/s16BFmQhEnVcD/26z3PYgubxda1izNgsMk16wvL6o7EjwV
	Auko5hR/IyUP8zq0bMHNSxmx4pq/7rd0BgJxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p8wiJuywg5F0IEpuMqri+FN4lWnAvrdU
	LPQiFUSR2kSVkbUSvrnptPqq/e2Osr83EvDv0UtZoC828sOQ+t+5KQk91xvn5tq6
	iYiqhswkiEKiHyZYYKXElKqNFRSPeJwKTHL+bVweruJMlkxW1l3vricdqzZYyum8
	zy0y56KFrOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B32C1928D;
	Thu, 30 Aug 2012 13:13:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12246928B; Thu, 30 Aug 2012
 13:13:50 -0400 (EDT)
In-Reply-To: <002201cd86ce$285841b0$7908c510$@schmitz-digital.de> (Joachim
 Schmitz's message of "Thu, 30 Aug 2012 18:40:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 119D8BB0-F2C6-11E1-87B6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204550>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> I see no existing code calls setitimer() with non-NULL ovalue, and I
>> do not think we would add a new caller that would do so in any time
>> soon, so it may not be a bad idea to drop support of returning the
>> remaining timer altogether from this emulation layer (just like
>> giving anything other than ITIMER_REAL gives us ENOTSUP).  That
>> would sidestep the whole "we cannot answer how many milliseconds are
>> still remaining on the timer when using emulation based on alarm()".
>
> Should we leave tv_usec untouched then? That was we round up on
> the next (and subsequent?) round(s). Or just set to ENOTSUP in
> setitimer if ovalue is !NULL?

I was alluding to the latter.

>> > +	switch (which) {
>> > +		case ITIMER_REAL:
>> > +			alarm(value->it_value.tv_sec +
>> > +				(value->it_value.tv_usec > 0) ? 1 : 0);
>> 
>> Why is this capped to 1 second?  Is this because no existing code
>> uses the timer for anything other than 1 second or shorter?  If that
>> is the case, that needs at least some documenting (or a possibly
>> support for longer expiration, if it is not too cumbersome to add).
>
> As you mention alarm() has only seconds resolution. It is tv_sec
> plus 1 if there are tv_usecs > 0, it is rounding up, so we don't
> cancel the alarm() if tv_sec is 0 but tv_usec is not. Looks OK to
> me?

Can a caller use setitimer to be notified in 5 seconds?
