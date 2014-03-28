From: Junio C Hamano <gitster@pobox.com>
Subject: Re: SSL_CTX leak?
Date: Fri, 28 Mar 2014 10:23:36 -0700
Message-ID: <xmqqr45mb5k7.fsf@gitster.dls.corp.google.com>
References: <CACnwZYdYYO2VXRnfyVD_uEeguYcBv-eFoYfawoCESDbcBVMhgA@mail.gmail.com>
	<20140327231156.GE32434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:23:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTaVM-0008LG-EY
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbaC1RXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:23:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36631 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbaC1RXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 13:23:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51D5877F2A;
	Fri, 28 Mar 2014 13:23:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=affKcVZb0ld4qgpzejLdr/fhN5U=; b=FAbbns
	RRziouN+9O6/rzC5Zo8mJErp3gvxIJA2n8OGA6TwPlrddZ0pLAlEghfXfuRfKcON
	mCU57O8XHuzWO1G6zv+moY3ibkWzhSPRGcZI4uxVSTDFDx3dUkWm7XrfHq/DITHQ
	4e8GILU3tKzUMKYSJkSUIg2TFfjQlRnPWepdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s7C5gVKbmxbV1JBh/C/RTod7DkQCPNap
	zdWgH0I9qY5+kFTfWZuBchuUf5+YikQchtrY8EpWIMKcHeWyI3Wrzwhg7E9rk12W
	9PRYuSBLiCvvnHFxTpltN/8lg7b60+6WeawqeaE91ic5tWeB4Yn31TGyYN2sM9Os
	BnLIxyfW42Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E0AE77F29;
	Fri, 28 Mar 2014 13:23:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9317D77F28;
	Fri, 28 Mar 2014 13:23:38 -0400 (EDT)
In-Reply-To: <20140327231156.GE32434@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 27 Mar 2014 19:11:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B355FBD0-B69D-11E3-B714-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245402>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 27, 2014 at 10:37:07AM -0300, Thiago Farina wrote:
>
>> Do we leak the context we allocate in imap-send.c:280 intentionally?
>
> It was never mentioned on the mailing list when the patches came
> originally, so I suspect is just an omission.
>
> Presumably the SSL_CTX is needed by the connection that survives after
> the function, but my reading of SSL_CTX_free implies that the data is
> reference-counted, and the library would presumably handle it fine.

Yes, I was reading the SSL_new() yesterday and found out that at
least in a recent code it increments the reference count on the ctx
it is fed.  So it would be the right thing to decrement the refcount
in the caller that created the context and used to call SSL_new(),
but I fully agree with the analysis below (with s/a huge/any/):

> OTOH, it is probably not causing a huge problem (since we wouldn't end
> up freeing it until the end of the program anyway), so I would not
> personally devote to many brain cycles to figuring out how OpenSSL
> handles it.

Heh.  So you are saying that I wasted 30 minutes yesterday? ;-)

Thanks.
