From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Thu, 08 Sep 2011 13:48:07 -0700
Message-ID: <7vy5xywyk8.fsf@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <20110908193555.GC16064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1ngF-0000qX-9f
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab1IHXGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:06:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157Ab1IHXGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:06:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 363F24FCF;
	Thu,  8 Sep 2011 16:48:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u4YMoT9TRdps66bbHFkbEJT+JZ4=; b=Ple5ml
	yE4lOntZRBePpbtiP8AFU3zPaxQvF8O5mxb+HQgg3eoj8T+76mJE6+JvSWD7RZar
	FxkGBI1ttF85M89IhGQO5f3ECnnqHaLQmLxYv7wK9GtMxPryFZjTeAByptcDs0RD
	SucpjAR2kzxXpWNolSArTzNe1MQHkEGY6sC+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5VBqUg8yIjICrqknDnN90gtPYVq+GgV
	BgPk+DNAOgBSth0zH35VNOpj8l7m0kMmGNnURYytfazdjo7xPk318L77aed7AvvN
	sg0OxXRH8UF6oILe/D4G1XwnZkmzDYlXtatQIXIzclyr98TJtsN9PAyp7VgI/u6v
	Pyj3DFuRHEU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC9E4FCE;
	Thu,  8 Sep 2011 16:48:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B28594FCD; Thu,  8 Sep 2011
 16:48:08 -0400 (EDT)
In-Reply-To: <20110908193555.GC16064@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 8 Sep 2011 15:35:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBE827C4-DA5B-11E0-990B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180995>

Jeff King <peff@peff.net> writes:

> I think (1) is actually not all that interesting. The server already has
> credentials for each user via ssh or http. So it knows who each pusher
> is already. It can't relay that information cryptographically to a
> client who fetches later, of course, but we are just talking about
> whether or not to accept the push at this moment.
>
> But if you really did want to do that, it seems like a pre-receive hook
> would be sufficient.

I see two flaws in that reasoning. The server's authentication may be
found not trustworthy for some reason long after commits hit the tree, and
GPG signature made by the _pusher_ would assert the integrity. Also this
will open the door to accept push over an unauthenticated connection and
allowing only signed pushes.

> For (2), you don't want to trust the server, so the user's
> authentication to the server isn't enough. You want a cryptographic
> chain leading back to the original pusher. But the server doesn't
> actually need to see or understand that cryptographic chain for this
> purpose.

Exactly. That is why the signed push certificate is stored without the
server doing anything funky, only to annotate the pushed commits in the
notes tree---the fetchers can peek the notes and verify the GPG signature.
But not _forcing_ that the push certificate be placed in a notes tree on
the client side allows different server hosting sites to additionally do
different things using that data.

> The only issue I foresee is one of atomicity.

The very initial thinking was to create a notes tree commit on the client
side and push that along with what is pushed, but that approach has an
inherent flaw of causing unnecessary collisions between two people who are
pushing to unrelated branches, and that is why I decided to let the server
side handle it.
