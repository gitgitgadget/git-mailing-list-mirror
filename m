From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between shorthand names and full refnames
Date: Mon, 13 May 2013 13:34:05 -0700
Message-ID: <7vwqr2liv6.fsf@alter.siamese.dyndns.org>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-4-git-send-email-johan@herland.net>
	<7vmwrzsck1.fsf@alter.siamese.dyndns.org>
	<CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
	<7v8v3jqsy7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 13 22:34:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbzRm-0002Zd-L9
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 22:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab3EMUeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 16:34:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab3EMUeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 16:34:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0F4D1E399;
	Mon, 13 May 2013 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JGLdL1GL7ENkcZ4zMW1uKWDAB0g=; b=S9s3wW
	8sb6IssMLs5XZ1eRiViHIcq4Sh8iqRKVBXU8siP4/gSjJjEXRvjrxAClVZAR8oz/
	JOKxzab6mQL1Mh7VEf8kibDwC46xuzFSdu89GHEDF7WgV4LNsXQ3g0dGxblZD6nM
	Rn1grI4k5ilx3htb9ULXwAboq6Cr1vO63a0kU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ethEyp+djZ2T3kxwCLiyc7zM8/E1QxHy
	yW2QG60MbOsOV4kCplI21A+8HJxn6LBWupzOgK1gf7DhVpkTeWkU5CCGmlENtj76
	lD1AbtueNhr8oPSFRlSIRmb0nXN44SWGjlz57r2awCCjWE1mCL76cjgxIzPcfD9e
	aZxRNAfXi9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6D601E397;
	Mon, 13 May 2013 20:34:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C1E01E396;
	Mon, 13 May 2013 20:34:06 +0000 (UTC)
In-Reply-To: <7v8v3jqsy7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 12 May 2013 23:45:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7572DD4C-BC0C-11E2-B6F7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224200>

Junio C Hamano <gitster@pobox.com> writes:

> Johan Herland <johan@herland.net> writes:
>
>> Obviously, I named it '%1' since it expands into the _first_ component
>> of the (slash-separated) shorthand.
>
> OK, I can buy something like
>
> 	%*
>         refs/%*
>         refs/heads/%*
>         ...
>         refs/remotes/%*/HEAD
>         refs/remotes/%1/%2
>         refs/peers/%1/heads/%2
>
> that is, for a pattern that has %*, we feed the end-user string as a
> whole, and for a pattern that has %1 thru %N, we find an appropriate
> way to chop the end-user string into N pieces (e.g. nick/name would
> be split into %1 = nick, %2 = name, while foo/bar/baz might have two
> possibilities, <%1, %2> = <foo, bar/baz> or <foo/bar, baz>).  The
> earlier ones on the above list can even be written with their %*
> substituted with %1 if we go that route.

Just to make sure.

Please do not let "two possibilities" stop you.  As I said in the
nearby thread, I do not necessarily insist that we must try all N
possibilities.  "We find an appropriate way" could be just "we
always chop at the first slash, and %1 is what comes before it, %2
is what comes after it".

That will close the possibility for us to use %1 thru %N (N is
limited to 2), but it still is "We have %1 and we have %2, both fall
into the same 'path components, numbered from left to right'
category", and justifies the use of %1 ("one", not "el").

So still no objection to %1 from me.

> And that makes perfect sense, and is exactly the kind of "you plan
> to have %2 and %3 that falls into the same category as %1" I was
> asking you about in the message.
>
> So, no more objection to %1 from me, if that is the direction you
> are taking us.
