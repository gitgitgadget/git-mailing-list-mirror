From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add persistent-https to contrib
Date: Thu, 24 May 2012 13:51:59 -0700
Message-ID: <7vlikhwbdc.fsf@alter.siamese.dyndns.org>
References: <1337792767-18914-1-git-send-email-cranger@google.com>
 <7v62blxx2m.fsf@alter.siamese.dyndns.org>
 <CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Colby Ranger <cranger@google.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 22:52:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXf10-0007oO-4e
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933458Ab2EXUwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:52:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932207Ab2EXUwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:52:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 597B39312;
	Thu, 24 May 2012 16:52:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=raPVf4TotWAtFFw19Hs7jAU4rr8=; b=wrxjw1
	XblvzF+Qic48V4e+lNO2usPnR4Rg9DNiOPMnPeRhjcbq8w5YfCYZi0e4VpniRf4K
	bIvxryTvKO1O59mn7CDWumEBE+zI6Jyl1ya4w0CEYUuuedQHIxg9IB0rLj9X/K9g
	oH+05zSEEHVazNDb8m1ncVK+iBIZ8VU+UcP4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rkwdU98FEAlVDngL3NFbBGD4ANfaj7gL
	9N1wn4nPX5cp+dFgWx5IYbNy48wkyUkPeyXiNNvqPi4/XsAd1dGwDgMFt872veyo
	JUNjfM1659WUtGRr2EOiI7UshhzAwhURo1ccXljcuilpUlTFY7GyUGG6vHLJDfQS
	/l5ov4QcdEY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 432CF9310;
	Thu, 24 May 2012 16:52:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C08A5930F; Thu, 24 May 2012
 16:52:01 -0400 (EDT)
In-Reply-To: <CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com> (Shawn
 Pearce's message of "Thu, 24 May 2012 12:33:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FCF8E82-A5E2-11E1-8212-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198427>

Shawn Pearce <spearce@spearce.org> writes:

> The persistent-https code tells the git credential helper the
> connection is "secure" (that is the proxy will use SSL as it exits the
> local machine) by setting GIT_GOOGLE_CREDENTIAL_CORPSSO_ENABLE=1 in
> the environment. This leaked from our internal version of the proxy,
> Colby was supposed to scrub this string before open sourcing. :-)
>
> So now everyone knows $DAYJOB = Google, we have a credential helper,
> and it supports some sort of corporate single sign on. Whee.

It is obviously needed to drop that bit from the public version (and have
you guys keep an internal fork to add it back), but I have to wonder if
this is an indication that something like that is useful in general.

More specifically, this environment variable is a way to tell the wrapped
helper who is wrapping it.  Users outside Google's environment of the
persistent-https helper obviously would not care about the corporate
sanitary sewer overflow mechanism, but they may have a similar need to
tweak what happens inside the git-remote-http that is driven by the
persistent helper. They would not care about "we can enable corpsso", but
they would benefit from knowing that either:

 (1) the connection is "secure" (by the definition above); or
 (2) the connection is going to this particular helper.

Conceptually, an approach to allow chain of helpers tell which one(s) of
defined set of attributes (e.g. "secure") are in effect, e.g. (1), might
be cleaner, but it probably is a bit too early overengineering (I do not
think we know if there is a good set of common attributes various helpers
might want to implement upstream and pay attention downstream) at this
point.  But at least it might not hurt to give the downstream to find out
what upstream is driving them.

Hrm?
