From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Tue, 04 Mar 2014 12:52:18 -0800
Message-ID: <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 04 21:52:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKwKP-0000oz-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 21:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbaCDUwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 15:52:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932535AbaCDUwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 15:52:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8417671A58;
	Tue,  4 Mar 2014 15:52:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6RZOVS2egEu9HYc1QgS6L8UY+D8=; b=yVd2jD
	626pGxaUMfcbZBKIP0GjRuPxAu9gm2Derz2mKxm21NEpjL6O7rX9RubslKJe1ryn
	RpOTryQ915SaRGbwMkTUYDqHB4QNEgCKauEoXLE5l5n0xPoPTEYSaRzzuJmcUkXX
	Ya86CL63vviNlFCe1qR8a2iCEhp7QpDf875xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LGzvHHrrP3Ff5/37pGjkEgxXlEQATDUa
	04wVKqTvjcXdwvaAGRv93heuSRl4OW4YydK9H9Z0ds9xKTaQUz3xhfieum6pQedw
	vvhtw6Ev6mETaq/9JEiRS33UGtuvwJ0Nslr0SHVnnmswCI/zC9ElqibXMdd/U6It
	5Ly1HdFB44s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B8B71A4F;
	Tue,  4 Mar 2014 15:52:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B22F171A4B;
	Tue,  4 Mar 2014 15:52:20 -0500 (EST)
In-Reply-To: <20140304174806.GA11561@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Mar 2014 12:48:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E130C6C4-A3DE-11E3-925E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243389>

Jeff King <peff@peff.net> writes:

> When we are creating a pack to send to a remote, we should
> make sure that we are not respecting grafts or replace refs.
> Otherwise, we may end up sending a broken pack to the other
> side that does not contain all objects (either omitting them
> entirely, or using objects that the other side does not have
> as delta bases).
>
> We already make an attempt to do the right thing in several
> places by turning off read_replace_refs. However, we missed
> at least one case (during bundle creation), and we do
> nothing anywhere to handle grafts.

"Doing nothing for grafts" has been pretty much a deliberate
omission.  Because we have no way to transfer how histories are
grafted together, people cloning from a repository that grafts away
a commit that records a mistakenly committed sekrit will end up with
a disjoint history, instead of exposing the sekrit to them, and are
expected to join the history by recreating grafts (perhaps a README
of such a project instructs them to do so).  That was deemed far
better than exposing the hidden history, I think.

And "replace tries to do the right thing" was an attempt to rectify
that misfeature of grafts in that we now do have a way to transfer
how the history is grafted together, so that project README does not
have to instruct the fetcher of doing anything special.

It _might_ be a misfeature, however, for the object connectivity
layer to expose a part of the history replaced away to the party
that fetches from such a repository.  Ideally, the "right thing"
ought to be to include history that would be omitted if we did not
have the replacement (i.e. adding parents the underlying commit does
not record), while not following the history that replacement wants
to hide (i.e. excluding the commits replacement commits overlay).
