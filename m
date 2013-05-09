From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name.c: signal if @{-N} was a true branch nameor a detached head
Date: Thu, 09 May 2013 10:08:24 -0700
Message-ID: <7vhaicaxo7.fsf@alter.siamese.dyndns.org>
References: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org>
	<20130509064607.GA11985@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 09 19:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUKZ-000410-71
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab3EIRIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:08:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab3EIRI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:08:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4B1E1D361;
	Thu,  9 May 2013 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HMcyQ1iw/BvCaHDBy9yf7ue4pHU=; b=xkQbnz
	fKKCaMKsywJ6QVco5xmIWzrqnxcCA5ZW00r80dZ+FhF2G2sInvTzZ6KNT97qA7Cs
	v+RKI9fKhZJRg8OkgsP6npuML4lDPdV4+e6F27KgZxZ6UTSnrv4b56TAD1DY1OoJ
	a6G8L+if+XYIAf+RWhD4+wYzKuS0Hloq7spjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u8OdTCFLN6Bq0VQPbVEh/s4VMDkxMutm
	CQeDbEhMr37gaXHfsfuWRKrt7iZ00qe8iqgOVtX2UAdu3foRf2cCHYbAX2cNZ7mu
	BSI2dzR3523rRBKjynxRuUCWV7THeLRjSH6mf9qnpI7wTrZir6sfXSxXaytljz4N
	+d4EgqFBo4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 989941D360;
	Thu,  9 May 2013 17:08:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E36FB1D35D;
	Thu,  9 May 2013 17:08:27 +0000 (UTC)
In-Reply-To: <20130509064607.GA11985@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 9 May 2013 08:46:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 111B33A6-B8CB-11E2-8C22-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223748>

Jeff King <peff@peff.net> writes:

> Since the point of marking the detached HEAD is to turn off things like
> "@{-1}@{u}", we would want to be generous and err on the side of
> assuming it is a branch if it _might_ be one.

I am not sure X and Y mesh well in your "Since X, we would want Y".
It seems to argue for erring on the side of detached HEAD to me.

Checking the "from" name $HEX against old_sha1 is a local and cheap
measure I added there for the first level of disambiguation.  If
they do not match, we _know_ we didn't come back from a detached
HEAD state.

In order to err on the "favor branch when it could have been one",
you could additionally look for the reflog .git/logs/refs/heads/$HEX
when the "from" name $HEX matches old_sha1 (which is likely to be
detached, but it is possible that we were on the $HEX branch when
its tip was at $HEX) and making sure the tip of that $HEX branch
once used to be at $HEX at the time recorded for @{-N} in the HEAD
reflog in question.

That is far more expensive, though; I doubt it is worth doing.
