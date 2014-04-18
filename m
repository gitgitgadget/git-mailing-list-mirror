From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Project idea: strbuf allocation modes
Date: Fri, 18 Apr 2014 10:21:35 -0700
Message-ID: <xmqq8ur2d04g.fsf@gitster.dls.corp.google.com>
References: <vpqr457omgs.fsf@anie.imag.fr> <53512DB6.1070600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 18 19:21:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbCTz-0007AI-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 19:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbaDRRVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 13:21:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbaDRRVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 13:21:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A056D796F4;
	Fri, 18 Apr 2014 13:21:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y1BT1rh6CUD6BywaDN411bGxHFw=; b=dZMSZZ
	PlBe+PwQfVgoP38LHZsPNnp/cArFD9plu7ATqBl1W5WyZ9k8OhctZVXF6A/fgny5
	qZVL+W2ShDZyA0PXzh3E5dcRWBnsrO/6wcIjAl7taWIn5ToPcj+bXm/EvUMQJfy9
	QhBwlwqq3IlWSzQNGYdolTVIpMFvUzzVvpPUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gn/mRCj/2RlcFbFJX6QL7rH4ECOSkJH7
	dZ9Fo0unxhBqKh3yi1cuOE1xeNl4XGp2l5OnP0BO2ZBaub9NNNcXMmWvQQRvLwnH
	FGlUR4FmyTm3VjdWc4wuu7n0aGWdaNgQ9J87syyxSXIrFWtBkp2CmrYaftO2cE9L
	drSa6SxXjZ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EB9B796F3;
	Fri, 18 Apr 2014 13:21:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C61D1796F2;
	Fri, 18 Apr 2014 13:21:37 -0400 (EDT)
In-Reply-To: <53512DB6.1070600@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 18 Apr 2014 15:50:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6066E94-C71D-11E3-AAE9-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246476>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The Idea
> ========
>
> I would like to see strbuf enhanced to allow it to use memory that it
> doesn't own (for example, stack-allocated memory), while (optionally)
> allowing it to switch over to using allocated memory if the string grows
> past the size of the pre-allocated buffer.

I'd like to see these characteristics, but I would want to see that
this is done entirely internally inside the strbuf implementation
without any API impact, other than the initialisation.  I do not
think the current API contract is too rigid to allow us doing so.

 - The API users may peek strbuf.buf in-place until they perform an
   operation that makes it longer (at which point the .buf pointer
   may point at a new piece of memory).

 - The API users may strbuf_detach() to obtain a piece of memory
   that belongs to them (at which point the strbuf becomes empty),
   hence needs to be freed by the callers.

As long as the above two promises are kept intact, it is all
internal to the strbuf implementation, current iteration of which
does not have any initial (possibly static) allocation other than
the fixed "terminating NUL", but your updated one may take a caller
supplied piece of memory that is designed to outlive the strbuf
itself as its initial allocation and the memory ownership can be
left as an internal implementation detail to the strbuf without
bothering the callers.
